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
		vtables += "\t\t\t.quad " + cool_type + "..string\n"

		# Constructor label
		vtables += "\t\t\t.quad " + cool_type + "..new\n"
		for method in i_map[cool_type]:
			# Method labels
			vtables += "\t\t\t.quad " + method.associated_class + "." + method.name + "\n"
	return vtables

def asm_constructors_gen(c_map, idx_c_map):
	constructors = "\n###############################################################################\n"
	constructors += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CONSTRUCTORS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	constructors += "###############################################################################\n"

	for cool_type in sorted(c_map):
		# New scope
		push_table()

		# Label
		constructors += ".globl " + cool_type + "..new\n"
		constructors += cool_type + "..new:\n"
		constructors += str(comment("Constructor for " + cool_type))

		# Handle calling convention
		constructors += str(pushq("%rbp"))
		constructors += str(movq("%rsp", "%rbp")) + "\n"

		# Push callee saved registers
		asm_list = []
		asm_push_callee(asm_list)
		for asm in asm_list:
			constructors += str(asm)

		object_type_tag = "$" + str(type_tags[cool_type])
		object_size = "$" + str(3 + len(c_map[cool_type]))
		object_vtable_ptr = "$" + cool_type + "..vtable"

		# Allocate space on the heap (calloc)
		constructors += str(comment("Allocate heap space, get self ptr"))
		constructors += str(movq(object_size, "%rdi")) # Num fields -> %rdi
		constructors += str(movq("$8", "%rsi")) # Size (always 8) -> %rsi
		constructors += str(call("calloc")) # Allocate space, ptr -> %rax

		# Set self pointer
		constructors += str(movq("%rax", "%rbx")) + "\n"

		constructors += str(comment("Store type tag, size, vtable ptr"))
		# Store type tag
		constructors += str(movq(object_type_tag, "%rax")) 
		constructors += str(movq("%rax", "0(%rbx)"))
		# Store object size
		constructors += str(movq(object_size, "%rax")) 
		constructors += str(movq("%rax", "8(%rbx)"))
		# Store vtable ptr
		constructors += str(movq(object_vtable_ptr, "%rax")) 
		constructors += str(movq("%rax", "16(%rbx)"))

		constructors += str(movq("%rbx", "%rax"))

		constructors += "\n"

		# TAC Generation for attributes
		tac = []

		tac += [TACLabel(cool_type + "_attributes")]

		# Generate TAC to initialize the attributes
		tac += [TACComment("Attribute initializations for " + cool_type)]
		for attribute in c_map[cool_type]:
			assignee = get_symbol(attribute.name)
			tac += [TACDefault(assignee, attribute.typ)]

		# Generate TAC to assign attributes with initialization
		for attribute in c_map[cool_type]:
			if attribute.kind == "attribute_init":
				tac += tac_attribute_init(cool_type, attribute)

		# Generate TAC to store attributes at the correct offsets
		for attribute in c_map[cool_type]:
			tac += [TACStoreAttribute()]

		blocks = bbs_gen(tac) # Generate basic blocks from TAC instructions
		blocks = liveness(blocks) # Generate liveness information
		allocate_registers(blocks) # Get coloring

		# Generate assembly
		asm_list = asm_gen(blocks, spilled_registers)
		for inst in asm_list:
			constructors += str(inst)

		# Reset globals
		global spilled_register_address
		spilled_registers_address = {}

		constructors += "\n"

		# Pop callee saved registers
		asm_list = []
		asm_pop_callee(asm_list)
		for asm in asm_list:
			constructors += str(asm)

		constructors += str(leave())
		constructors += str(ret()) + "\n"

		# End scope
		pop_table()

	return constructors

def asm_method_definitions_gen(i_map, asm):
	method_definitions = "\n###############################################################################\n"
	method_definitions += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;; METHOD DEFINITIONS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	method_definitions += "###############################################################################\n"	

	for cool_type in sorted(i_map):
		for method in i_map[cool_type]:
			if method.associated_class == cool_type:
				# Method labels
				method_definitions += ".globl " + method.associated_class + "." + method.name + "\n"
				method_definitions += method.associated_class + "." + method.name + ":\n"
				method_definitions += "\t\t\t# Method definition for " + method.associated_class + "." + method.name + "\n"
				if cool_type == "Main" and method.name == "main":
					method_definitions += asm
				else:
					method_definitions += str(ret())
	return method_definitions

def asm_string_constants_gen(type_names, string_list):
	strings = "\n###############################################################################\n"
	strings += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;; STRING CONSTANTS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	strings += "###############################################################################\n"	

	# Type names
	for cool_type in type_names:
		strings += ".globl " + cool_type + "..string\n"
		strings += cool_type + "..string:\n"
		strings += "\t\t\t.string \"" + cool_type + "\"\n\n"

	# Handle empty string explicitly
	strings += ".global empty.string\n"
	strings += "empty.string:\n"
	strings += "\t\t\t.string \"\" \n\n"
	# TODO: all other string constants

	return strings

def asm_comparison_handlers_gen():
	comparison_handlers = "\n###############################################################################\n"
	comparison_handlers += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPARISON HANDLERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	comparison_handlers += "###############################################################################\n"	

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
	c_map = class_map_gen(iterator) # Generate class map dictionary
	i_map = implementation_map_gen(iterator) # Generate implementation map dictionary
	p_map = parent_map_gen(iterator) # Generate parent map dictionary
	ast = ast_gen(iterator) # Generate AST object

	# Construct dictionary of dictionaries, mapping class to a mapping of attributes to indices
	idx_c_map = {}
	for ast_class in c_map:
		idx_c_map[ast_class] = {}
		i = 0
		for attribute in c_map[ast_class]:
			idx_c_map[ast_class][attribute.name] = i
			i += 1

	# Find main method
	main_class_methods = i_map["Main"]
	main_method = None
	for method in main_class_methods:
		if method.name == "main":
			main_method = method

	if main_method == None:
		raise StandardError("Main not found.")

	tac = tac_method("Main", main_method) # Generate TAC instructions from AST object	

	blocks = bbs_gen(tac) # Generate basic blocks from TAC instructions
	blocks = liveness(blocks) # Generate liveness information
	allocate_registers(blocks) # Get coloring

	# Generate assembly
	asm_list = asm_gen(blocks, spilled_registers)
	asm = ""
	for inst in asm_list:
		asm += str(inst)

	# Generate a list of type tags
	get_type_tags(c_map)

	# Generate code to emit
	vtables = asm_vtables_gen(i_map)
	constructors = asm_constructors_gen(c_map, idx_c_map)
	method_definitions = asm_method_definitions_gen(i_map, asm)

	type_names = sorted(c_map.keys())
	strings = []

	string_constants = asm_string_constants_gen(type_names, strings)
	comparison_handlers = asm_comparison_handlers_gen()
	start = asm_start()

	# Build output string
	output = vtables
	output += constructors
	output += method_definitions
	output += string_constants
	output += comparison_handlers
	output += start

	# for tac in tacs:
	# 	print tac

	# Write to output
	write_output(filename, output)

if __name__ == '__main__':
	main()
