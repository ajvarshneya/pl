import sys
from allocate_registers import *

from asm import *
from asm_gen import *
from asm_internals import *

from ast import *
from read_ast import *

from tacs import *
from tacs_gen import *

from basic_blocks import *

# Reads in raw input
def read_input(filename):
    f = open(filename)
    lines = []
    for line in f:
        lines.append(line.rstrip('\n').rstrip('\r'))
    f.close()
    return lines

# Writes to output
def write_output(filename, output):
	f = open(filename[:-8] + ".s", 'w')
	f.write(output)
	f.close()

def make_vtables(i_map):
	vtables = "###############################################################################\n"
	vtables += "#;;;;;;;;;;;;;;;;;;;;;;;;;; VIRTUAL METHOD TABLES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	vtables += "###############################################################################\n"

	for cool_type in sorted(i_map):
		# Label
		vtables += ".globl " + cool_type + "..vtable\n"
		vtables += cool_type + "..vtable:\n"
		vtables += "\t\t\t# Virtual function table for " + cool_type + "\n"

		# Type name
		vtables += "\t\t\t.quad " + "string_constant.." + cool_type + "\n"

		# Constructor label
		vtables += "\t\t\t.quad " + cool_type + "..new\n"
		for method in i_map[cool_type]:
			# Method labels
			vtables += "\t\t\t.quad " + method.associated_class + "." + method.name + "\n"

	return vtables

def make_constructors(c_map, i_map):
	constructors = "\n###############################################################################\n"
	constructors += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CONSTRUCTORS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	constructors += "###############################################################################\n"

	type_tags = get_type_tags(c_map)

	for cool_type in sorted(c_map):
		# New scope
		push_table()

		# Get attributes
		attributes = c_map[cool_type]

		# Label
		constructors += ".globl " + cool_type + "..new\n"
		constructors += cool_type + "..new:\n"
		constructors += str(comment("Constructor for " + cool_type))

		# Calling conventions
		constructors += str(pushq("%rbp"))
		constructors += str(movq("%rsp", "%rbp"))
		constructors += asm_push_callee_str()

		# Object parameters (type tag, object size, vtable pointer)
		object_type_tag = "$" + str(type_tags[cool_type])
		object_size = "$" + str(3 + len(attributes))
		object_vtable_ptr = "$" + cool_type + "..vtable"

		# Allocate space on the heap (calloc), get object pointer
		constructors += str(comment("Allocate " + object_size + " bytes on heap"))
		constructors += asm_push_caller_str()
		constructors += str(movq(object_size, "%rdi")) # Num fields -> %rdi
		constructors += str(movq("$8", "%rsi")) # Size (always 8) -> %rsi
		constructors += str(call("calloc")) # Allocate space, ptr -> %rax
		constructors += asm_pop_caller_str()

		# Save object pointer
		constructors += str(movq("%rax", "%rbx"))

		# Setup type tag, size, vtable pointer
		constructors += str(comment("Store type tag, size, vtable ptr"))
		constructors += str(movq(object_type_tag, "%rax")) 
		constructors += str(movq("%rax", "0(%rbx)"))
		constructors += str(movq(object_size, "%rax")) 
		constructors += str(movq("%rax", "8(%rbx)"))
		constructors += str(movq(object_vtable_ptr, "%rax")) 
		constructors += str(movq("%rax", "16(%rbx)"))

		# Call default constructors
		for idx, attribute in enumerate(attributes):
			offset = (3 + idx) * 8
			if attribute.typ == "raw.Int":
				constructors += str(movl("$0", "24(%rbx)"))
			elif attribute.typ == "raw.String":
				constructors += str(movq("$empty.string", "%rax"))
				constructors += str(movq("%rax", "24(%rbx)"))
			else:
				constructors += asm_push_caller_str()
				constructors += str(call(attribute.typ + "..new"))
				constructors += asm_pop_caller_str()
				constructors += str(movq("%rax", str(offset) + "(%rbx)"))

		# TAC GENERATION for attribute initialization
		tac = []
		tac += [TACLabel(cool_type + "_attr_init")]
		tac += [TACComment("Attribute initializations for " + cool_type)]

		# Generate TAC to assign attributes with initialization
		for attribute in attributes:
			if attribute.kind == "attribute_init":
				tac += tac_attribute_init(cool_type, attribute)

		blocks = bbs_gen(tac) # Generate basic blocks from TAC instructions
		blocks = liveness(blocks) # Generate liveness information
		allocate_registers(blocks) # Get coloring

		# ASSEMBLY GENERATION
		asm_list = asm_gen(blocks, spilled_registers, cool_type, c_map, i_map)
		for inst in asm_list:
			constructors += str(inst)

		# Reset globals
		global spilled_register_address
		spilled_registers_address = {}

		# Calling conventions
		constructors += str(movq("%rbx", "%rax"))
		constructors += asm_pop_callee_str()
		constructors += str(leave())
		constructors += str(ret())

		# End scope
		pop_table()

	return constructors

def make_method_definitions(c_map, i_map):
	method_definitions = "\n###############################################################################\n"
	method_definitions += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;; METHOD DEFINITIONS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	method_definitions += "###############################################################################\n"	

	global spilled_registers
	global coloring

	for cool_type in sorted(i_map):
		methods = i_map[cool_type]
		attributes = c_map[cool_type]

		for method in methods:
			if method.associated_class == cool_type:

				spilled_registers = []
				coloring = {}

				# Method header
				method_definitions += ".globl " + method.associated_class + "." + method.name + "\n"
				method_definitions += method.associated_class + "." + method.name + ":\n"
				method_definitions += "\t\t\t# Method definition for " + method.associated_class + "." + method.name + "\n"

				# Hardcode the internal methods, skip TAC/ASM generation for them
				if method.associated_class in ["Bool", "Int", "IO", "Object", "String"]:
					if method.name in ["abort", "type_name", "copy", "out_string", "in_string", "out_int", "in_int", "length", "concat", "substr"]:
						if method.name == "abort":
							method_definitions += internal_abort_definition()
						if method.name == "type_name":
							method_definitions += internal_type_name_definition()
						if method.name == "copy":
							method_definitions += internal_copy_definition()
						if method.name == "out_string":
							method_definitions += internal_out_string_definition()
						if method.name == "in_string":
							method_definitions += internal_in_string_definition()
						if method.name == "out_int":
							method_definitions += internal_out_int_definition()
						if method.name == "in_int":
							method_definitions += internal_in_int_definition()
						if method.name == "length":
							method_definitions += internal_length_definition()
						if method.name == "concat":
							method_definitions += internal_concat_definition()
						if method.name == "substr":
							method_definitions += internal_substr_definition()
						continue # skip TAC/ASM generation

				# TAC GENERATION
				if method.kind == "method":
					tac = tac_method(cool_type, method)
				if method.kind == "method_formals":
					tac = tac_method_formals(cool_type, method)

				# Register allocation
				blocks = bbs_gen(tac)
				blocks = liveness(blocks)
				allocate_registers(blocks)

				# ASSEMBLY GENERATION
				asm_list = asm_gen(blocks, spilled_registers, cool_type, c_map, i_map)

				# Create new stack frame
				method_definitions += str(pushq("%rbp"))
				method_definitions += str(movq("%rsp", "%rbp"))

				# Calling convention
				method_definitions += asm_push_callee_str()

				# Generate assembly from TAC
				for asm in asm_list:
					method_definitions += str(asm)

				# Calling convention
				method_definitions += asm_pop_callee_str()
				method_definitions += str(leave())
				method_definitions += str(ret())

	return method_definitions

def make_string_constants(c_map):
	strings = "\n###############################################################################\n"
	strings += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;; STRING CONSTANTS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	strings += "###############################################################################\n"	

	global string_list
	type_names = sorted(c_map.keys())

	# Type names
	for cool_type in type_names:
		strings += ".globl " + "string_constant.." + cool_type + "\n"
		strings += "string_constant.." + cool_type + ":\n"
		strings += "\t\t\t.string \"" + cool_type + "\"\n\n"

	# Static string constants
	for idx, string in enumerate(string_list):
		strings += ".globl " + "string_constant.." + str(idx) + "\n"
		strings += "string_constant.." + str(idx) + ":\n"
		strings += "\t\t\t.string \"" + string + "\"\n\n"

	# Hardcoded strings
	strings += ".globl " + "abort.string" + "\n"
	strings += "abort.string" + ":\n"
	strings += "\t\t\t.string \"" + "abort\\n" + "\"\n\n"

	# Handle empty string explicitly
	strings += ".global empty.string\n"
	strings += "empty.string:\n"
	strings += "\t\t\t.string \"\" \n\n"

	# String formatting strings

	# in_int format string
	strings += ".globl in_int_format\n"
	strings += "in_int_format:\n"
	strings += "\t\t\t.string \"%ld\"\n\n"

	# out_int format string
	strings += ".globl out_int_format\n"
	strings += "out_int_format:\n"
	strings += "\t\t\t.string \"%d\"\n\n"

	# error strings

	# substring bounds
	strings += ".globl error.substr_range\n"
	strings += "error.substr_range:\t\t## error string for String.substr\n"
	strings += "\t\t\t.string \"ERROR: 0: Exception: String.substr out of range\\n\"\n\n"

	return strings

def make_comparison_handlers():
	comparison_handlers = "\n###############################################################################\n"
	comparison_handlers += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPARISON HANDLERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	comparison_handlers += "###############################################################################\n"	

	comparison_handlers += str(label("comparison_handlers"))
	comparison_handlers += less_than_handler()
	comparison_handlers += less_equals_handler()
	comparison_handlers += equals_handler()

	return comparison_handlers

def make_start():
	start_definition = "\n###############################################################################\n"
	start_definition += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; START ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	start_definition += "###############################################################################\n"	

	start_definition += ".globl start\n"
	start_definition += "start:\n"
	start_definition += str(comment("Program begins here"))
	start_definition += "\t\t\t.globl main\n"
	start_definition += "\t\t\t.type main, @function\n"
	start_definition += "main:\n"
	start_definition += str(call("Main..new"))
	start_definition += str(movq("%rax", "%rbx"))
	start_definition += str(call("Main.main"))
	start_definition += str(call("exit"))

	return start_definition

def make_built_ins():
	built_ins = "\n###############################################################################\n"
	built_ins += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BUILT INS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	built_ins += "###############################################################################\n"	

	built_ins += internal_out_string_helper()
	built_ins += internal_in_string_helper()
	built_ins += internal_in_int_helper()
	built_ins += internal_concat_helper()
	built_ins += internal_substr_helper()

	return built_ins


def get_type_tags(c_map):
	type_tags = {}
	tag_idx = 0

	basic_types = ["Bool", "Int", "IO", "Object", "String", "Main"]
	custom_types = [x for x in c_map.keys() if x not in basic_types]

	for cool_type in basic_types + custom_types:
		type_tags[cool_type] = tag_idx
		tag_idx += 1

	return type_tags

def main():
	# Deserialize AST
	filename = sys.argv[1] 	# .cl-type file
	raw_aast = read_input(filename) # Read AST from file
	iterator = iter(raw_aast) # Get iterator to traverse raw annotated AST

	# Deserialize input into maps, ast
	c_map = read_class_map(iterator) # Generate class map dictionary
	i_map = read_imp_map(iterator) # Generate implementation map dictionary
	p_map = read_parent_map(iterator) # Generate parent map dictionary
	ast = read_ast(iterator) # Generate AST object

	# Generate code to emit
	vtables = make_vtables(i_map)
	constructors = make_constructors(c_map, i_map)

	method_definitions = make_method_definitions(c_map, i_map)
	string_constants = make_string_constants(c_map)

	# comparison_handlers = make_comparison_handlers()
	start = make_start()
	built_ins = make_built_ins()

	# # Build output string
	output = vtables
	output += constructors
	output += method_definitions
	output += string_constants
	# output += comparison_handlers
	output += start
	output += built_ins

	# Write to output
	write_output(filename, output)

if __name__ == '__main__':
	main()
