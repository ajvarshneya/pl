import sys
from ast import *
from ast_gen import *
from tacs import *
from tacs_gen import *
from basic_blocks import *
from asm import *
from asm_gen import *
from allocate_registers import *

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

type_tags = {}
c_map = {}
i_map = {}
p_map = {}

def asm_vtables_gen(i_map):
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

def asm_constructors_gen(c_map):
	constructors = "\n###############################################################################\n"
	constructors += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CONSTRUCTORS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	constructors += "###############################################################################\n"

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

		object_type_tag = "$" + str(type_tags[cool_type])
		# TODO, size for in_string
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
				constructors += str(movq("empty.string", "%rax"))
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
		asm_list = asm_gen(blocks, spilled_registers, attributes)
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

def asm_method_definitions_gen(c_map, i_map):
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

				# Skip built in methods, these will be hard coded
				if method.associated_class in ["Bool", "Int", "IO", "Object", "String"]:
					if method.name in ["abort", "type_name", "copy", "out_string", "in_string", "out_int", "in_int", "length", "concat", "substr"]:
						continue

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
				asm_list = asm_gen(blocks, spilled_registers, attributes)

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

def asm_string_constants_gen(type_names, string_list):
	strings = "\n###############################################################################\n"
	strings += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;; STRING CONSTANTS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	strings += "###############################################################################\n"	

	# Type names
	for cool_type in type_names:
		strings += ".globl " + "string_constant.." + cool_type + "\n"
		strings += "string_constant.." + cool_type + ":\n"
		strings += "\t\t\t.string \"" + cool_type + "\"\n\n"

	# Static string constants
	for string in string_list:
		strings += ".globl " + "string_constant.." + string + "\n"
		strings += "string_constant.." + string + ":\n"
		strings += "\t\t\t.string \"" + string + "\"\n\n"

	# TODO dynamically allocated strings?

	# Handle empty string explicitly
	strings += ".global empty.string\n"
	strings += "empty.string:\n"
	strings += "\t\t\t.string \"\" \n\n"

	return strings

def asm_comparison_handlers_gen():
	comparison_handlers = "\n###############################################################################\n"
	comparison_handlers += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPARISON HANDLERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	comparison_handlers += "###############################################################################\n"	

	comparison_handlers += str(label("comparison_handlers"))

	comparison_handlers += str(label("lt_int_cmp"))
	comparison_handlers += str(label("lt_bool_cmp"))
	comparison_handlers += str(label("lt_string_cmp"))
	comparison_handlers += str(label("lt_other_cmp"))

	comparison_handlers += str(label("le_int_cmp"))
	comparison_handlers += str(label("le_bool_cmp"))
	comparison_handlers += str(label("le_string_cmp"))
	comparison_handlers += str(label("le_other_cmp"))

	comparison_handlers += str(label("eq_int_cmp"))
	comparison_handlers += str(label("eq_bool_cmp"))
	comparison_handlers += str(label("eq_string_cmp"))
	comparison_handlers += str(label("eq_other_cmp"))

	return comparison_handlers

def asm_start():
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

def get_type_tags(c_map):
	global type_tags
	tag_idx = 0

	basic_types = ["Bool", "Int", "IO", "Object", "String", "Main"]
	custom_types = [x for x in c_map.keys() if x not in basic_types]

	for cool_type in basic_types + custom_types:
		type_tags[cool_type] = tag_idx
		tag_idx += 1

def main():
	# Deserialize AST
	filename = sys.argv[1] 	# .cl-type file
	raw_aast = read_input(filename) # Read AST from file
	iterator = iter(raw_aast) # Get iterator to traverse raw annotated AST

	# Deserialize input into maps, ast
	global c_map
	global i_map
	global p_map
	
	c_map = class_map_gen(iterator) # Generate class map dictionary
	i_map = implementation_map_gen(iterator) # Generate implementation map dictionary
	p_map = parent_map_gen(iterator) # Generate parent map dictionary
	ast = ast_gen(iterator) # Generate AST object

	# Generate a list of type tags
	get_type_tags(c_map)

	# Generate code to emit
	vtables = asm_vtables_gen(i_map)
	constructors = asm_constructors_gen(c_map)
	method_definitions = asm_method_definitions_gen(c_map, i_map)

	global string_list
	type_names = sorted(c_map.keys())
	string_constants = asm_string_constants_gen(type_names, string_list)

	comparison_handlers = asm_comparison_handlers_gen()
	start = asm_start()

	# Build output string
	output = vtables
	output += constructors
	output += method_definitions
	output += string_constants
	output += comparison_handlers
	output += start

	# Write to output
	write_output(filename, output)

if __name__ == '__main__':
	main()
