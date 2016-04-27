import sys
from ast import *
from ast_gen import *
from tacs import *
from tacs_gen import *
from basic_blocks import *
from asm import *
from asm_gen import *
from allocate_registers import *

type_tags = {}

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

def asm_constructors_gen(c_map, i_map):
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
						if method.name == "abort":
							method_definitions += asm_abort_definition()
						if method.name == "type_name":
							method_definitions += str(call("exit"))
						if method.name == "copy":
							method_definitions += str(call("exit"))
						if method.name == "out_string":
							method_definitions += asm_out_string_definition()
						if method.name == "in_string":
							method_definitions += asm_in_string_definition()
						if method.name == "out_int":
							method_definitions += asm_out_int_definition()
						if method.name == "in_int":
							method_definitions += asm_in_int_definition()
						if method.name == "length":
							method_definitions += str(call("exit"))
						if method.name == "concat":
							method_definitions += str(call("exit"))
						if method.name == "substr":
							method_definitions += asm_substr_definition()
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

				for block in blocks:
					print block

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

def asm_abort_definition():
	method = str(comment("out_string"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Load boxed string into rax, unbox its pointer into %rax, move that into esi
	method += str(comment("Move abort\\n into %rdi"))
	method += str(movq("$abort.string", "%rdi"))
	method += str(movq("$0", "%rax"))

	# Call printf
	method += str(comment("Call printf"))
	method += asm_push_caller_str()
	method += str(call('printf'))
	method += asm_pop_caller_str()

	# Calling convention
	method += asm_pop_callee_str()

	method += str(call('exit'))

	method += str(leave())
	method += str(ret())
	return method

def asm_out_string_definition():
	method = str(comment("out_string"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Load boxed string into rax, unbox its pointer into %rax, move that into esi
	method += str(comment("Load formal parameter into %rax"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(comment("Unbox string into %rax"))
	method += str(movq("24(%rax)", "%rax"))
	method += str(comment("Move unboxed string into %rdi"))
	method += str(movq("%rax", "%rdi"))
	method += str(movq("$0", "%rax"))

	# Call printf
	method += str(comment("Call printf"))
	method += asm_push_caller_str()
	method += str(call('printf'))
	method += asm_pop_caller_str()

	# Calling convention
	method += asm_pop_callee_str()

	method += str(leave())
	method += str(ret())
	return method

def asm_in_string_definition():
	method = str(comment("in_string"))

	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))

	method += asm_push_callee_str()

	# Call the helper function
	method += asm_push_caller_str()
	method += str(call("cool_in_string"))
	method += asm_pop_caller_str()

	# Save in_string value in rbx
	method += str(movq('%rax', '%rbx'))

	# Create new string object, object address in %rax
	method += asm_push_caller_str()
	method += str(call("String..new"))
	method += asm_pop_caller_str()

	# Put in_string value in box, %rax has the boxed string
	method += str(movq('%rbx', '24(%rax)'))

	method += asm_pop_callee_str()

	method += str(leave())
	method += str(ret())
	return method

def asm_out_int_definition():
	method = str(comment("out_int"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Load formal parameter into %rax, unbox it into %eax, move that into esi
	method += str(comment("Load formal parameter into %rax"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(comment("Unbox parameter into %eax"))
	method += str(movl("24(%rax)", "%eax"))
	method += str(comment("Move unboxed parameter into %esi"))
	method += str(movl("%eax", "%esi"))
	method += str(comment("Put string format in %edi"))
	method += str(movl("$.int_fmt_string", "%edi"))
	method += str(movl("$0", "%eax"))

	# Call printf
	method += str(comment("Call printf"))

	method += asm_push_caller_str()
	method += str(call('printf'))
	method += asm_pop_caller_str()

	# Calling convention
	method += asm_pop_callee_str()

	method += str(leave())
	method += str(ret())

	return method

def asm_in_int_definition():
	method = str(comment("in_int"))

	# Create new stack frame
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))

	method += asm_push_callee_str()

	# # No formal parameters
	method += str(subq('$4', '%rsp'))

	# Calling convention
	method += asm_push_caller_str()

	# Setup
	offset = len(CALLER_SAVED_REGISTERS) * 8
	method += str(leaq(str(offset) + '(%rsp)', '%rsi'))
	method += str(movl('$.int_fmt_string', '%edi'))
	method += str(movl('$0', '%eax'))

	method += str(call('__isoc99_scanf'))

	# Calling convention
	method += asm_pop_caller_str()

	method += str(movl('(%rsp)', '%eax'))
	method += str(addq('$4', '%rsp'))

	# Save in_int value in ebx
	method += str(movl('%eax', '%ebx'))

	# Create new int object, object address in %rax
	method += asm_push_caller_str()
	method += str(call("Int..new"))
	method += asm_pop_caller_str()

	# Put in_int value in box, %rax has the boxed integer
	method += str(movl('%ebx', '24(%rax)'))

	method += asm_pop_callee_str()

	method += str(leave())
	method += str(ret())
	return method

def asm_substr_definition():
	method = str(comment("substring"))

	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))

	method += asm_push_callee_str()

	# Load self into %rax, unbox it into %rax, then move it into r11
	method += str(comment("Unbox string into %rax"))
	method += str(movq("24(%rbx)", "%rax"))
	method += str(comment("Move unboxed string into r11"))
	method += str(movq("%rax", "%r11"))

	method += str(comment("Load int1 into %rax"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(comment("Unbox int into %eax"))
	method += str(movl("24(%rax)", "%eax"))
	method += str(comment("Move unboxed int into r12d"))
	method += str(movl("%eax", "%r12d"))

	method += str(comment("Load int2 into %rax"))
	method += str(movq("24(%rbp)", "%rax"))
	method += str(comment("Unbox int into %eax"))
	method += str(movl("24(%rax)", "%eax"))
	method += str(comment("Move unboxed int into r13d"))
	method += str(movl("%eax", "%r13d"))
	method += str(movq("$0", "%rax"))

	# Call the helper function
	method += asm_push_caller_str()

	# Put parameters on stack
	method += str(subq("$16", "%rsp"))
	method += str(movq("%r11", "-8(%rbp)"))
	method += str(movl("%r12d", "-16(%rbp)"))
	method += str(movl("%r13d", "-12(%rbp)"))

	method += str(movl("-12(%rbp)", "%edx"))
	method += str(movl("-16(%rbp)", "%ecx"))
	method += str(movq("-8(%rbp)", "%rax"))
	method += str(movl("%ecx", "%esi"))
	method += str(movq("%rax", "%rdi"))

	method += str(call("cool_substr"))

	method += asm_pop_caller_str()

	# Save substr value in rbx
	method += str(movq('%rax', '%rbx'))

	# Create new string object, object address in %rax
	method += asm_push_caller_str()
	method += str(call("String..new"))
	method += asm_pop_caller_str()

	# Put substr value in box, %rax has the boxed string
	method += str(movq('%rbx', '24(%rax)'))

	method += asm_pop_callee_str()

	method += str(leave())
	method += str(ret())
	return method


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
	for idx, string in enumerate(string_list):
		strings += ".globl " + "string_constant.." + str(idx) + "\n"
		strings += "string_constant.." + str(idx) + ":\n"
		strings += "\t\t\t.string \"" + string + "\"\n\n"

	# TODO dynamically allocated strings?

	# Hardcoded strings
	strings += ".globl " + "abort.string" + "\n"
	strings += "abort.string" + ":\n"
	strings += "\t\t\t.string \"" + "abort\\n" + "\"\n\n"

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

	start_definition += ".int_fmt_string:\n"
	start_definition += "\t.string \"%d\"\n"
	start_definition += "\t.text\n"

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

def in_string_built_in():
	method = ".globl cool_in_string\n"
	method += "cool_in_string:\n"
	method += "\t\t\tpushq %rbp\n"
	method += "\t\t\tmovq %rsp, %rbp\n"
	method += "\t\t\tsubq $32, %rsp\n"
	method += "\t\t\tmovl $20, -16(%rbp)\n"
	method += "\t\t\tmovl $0, -12(%rbp)\n"
	method += "\t\t\tmovl -16(%rbp), %eax\n"
	method += "\t\t\tcltq\n"
	method += "\t\t\tmovq %rax, %rdi\n"
	method += "\t\t\tcall malloc\n"
	method += "\t\t\tmovq %rax, -8(%rbp)\n"

	method += "\nin_string_1:\n"
	method += "\t\t\tcall getchar\n"
	method += "\t\t\tmovb %al, -17(%rbp)\n"
	method += "\t\t\tcmpb $10, -17(%rbp)\n"
	method += "\t\t\tje in_string_2\n"
	method += "\t\t\tcmpb $-1, -17(%rbp)\n"
	method += "\t\t\tje in_string_2\n"
	method += "\t\t\tmovl -12(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"
	method += "\t\t\taddq %rax, %rdx\n"
	method += "\t\t\tmovzbl -17(%rbp), %eax\n"
	method += "\t\t\tmovb %al, (%rdx)\n"
	method += "\t\t\taddl $1, -12(%rbp)\n"
	method += "\t\t\tcmpb $0, -17(%rbp)\n"
	method += "\t\t\tjne in_string_3\n"
	method += "\t\t\tmovl $0, -12(%rbp)\n"
	method += "\t\t\tjmp in_string_2\n"

	method += "\nin_string_3:\n"
	method += "\t\t\tmovl -12(%rbp), %eax\n"
	method += "\t\t\tcmpl -16(%rbp), %eax\n"
	method += "\t\t\tjne in_string_1\n"
	method += "\t\t\taddl $20, -16(%rbp)\n"
	method += "\t\t\tmovl -16(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"
	method += "\t\t\tmovq %rdx, %rsi\n"
	method += "\t\t\tmovq %rax, %rdi\n"
	method += "\t\t\tcall realloc\n"
	method += "\t\t\tmovq %rax, -8(%rbp)\n"
	method += "\t\t\tjmp in_string_1\n"

	method += "\nin_string_2:\n"
	method += "\t\t\tmovl -12(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"
	method += "\t\t\tmovq %rdx, %rsi\n"
	method += "\t\t\tmovq %rax, %rdi\n"
	method += "\t\t\tcall strndup\n"
	method += "\t\t\tmovq %rax, -8(%rbp)\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"

	method += "\t\t\tleave\n"
	method += "\t\t\tret\n"

	return method

def substr_built_in():
	method = ".globl cool_substr\n"
	method += "cool_substr:\n"
	method += "\t\t\tpushq %rbp\n"
	method += "\t\t\tmovq %rsp, %rbp\n"
	method += "\t\t\tsubq $48, %rsp\n"
	method += "\t\t\tmovq %rdi, -40(%rbp)\n"
	method += "\t\t\tmovl %esi, -44(%rbp)\n"
	method += "\t\t\tmovl %edx, -48(%rbp)\n"
	method += "\t\t\tmovl $20, -16(%rbp)\n"
	method += "\t\t\tmovl $0, -12(%rbp)\n"
	method += "\t\t\tmovl -16(%rbp), %eax\n"
	method += "\t\t\tcltq\n"
	method += "\t\t\tmovq %rax, %rdi\n"
	method += "\t\t\tcall malloc\n"
	method += "\t\t\tmovq %rax, -8(%rbp)\n"
	method += "\t\t\tjmp substr_l4\n"

	method += "substr_l1:\n"
	method += "\t\t\tmovl -48(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -40(%rbp), %rax\n"
	method += "\t\t\taddq %rdx, %rax\n"
	method += "\t\t\tmovzbl (%rax), %eax\n"
	method += "\t\t\tmovb %al, -17(%rbp)\n"
	method += "\t\t\tcmpb $-1, -17(%rbp)\n"
	method += "\t\t\tje substr_l5\n"
	method += "\t\t\tmovl -12(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"
	method += "\t\t\taddq %rax, %rdx\n"
	method += "\t\t\tmovzbl -17(%rbp), %eax\n"
	method += "\t\t\tmovb %al, (%rdx)\n"
	method += "\t\t\taddl $1, -12(%rbp)\n"
	method += "\t\t\tcmpb $0, -17(%rbp)\n"
	method += "\t\t\tjne substr_l2\n"
	method += "\t\t\tmovl $0, -12(%rbp)\n"
	method += "\t\t\tjmp substr_l6\n"

	method += "substr_l2:\n"
	method += "\t\t\tmovl -12(%rbp), %eax\n"
	method += "\t\t\tcmpl -16(%rbp), %eax\n"
	method += "\t\t\tjne substr_l3\n"
	method += "\t\t\taddl $20, -16(%rbp)\n"
	method += "\t\t\tmovl -16(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"
	method += "\t\t\tmovq %rdx, %rsi\n"
	method += "\t\t\tmovq %rax, %rdi\n"
	method += "\t\t\tcall realloc\n"
	method += "\t\t\tmovq %rax, -8(%rbp)\n"

	method += "substr_l3:\n"
	method += "\t\t\taddl $1, -48(%rbp)\n"

	method += "substr_l4:\n"
	method += "\t\t\tmovl -48(%rbp), %eax\n"
	method += "\t\t\tcmpl -44(%rbp), %eax\n"
	method += "\t\t\tjl substr_l1\n"
	method += "\t\t\tjmp substr_l6\n"

	method += "substr_l5:\n"
	method += "\t\t\tnop\n"

	method += "substr_l6:\n"
	method += "\t\t\tmovl -12(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"
	method += "\t\t\tmovq %rdx, %rsi\n"
	method += "\t\t\tmovq %rax, %rdi\n"
	method += "\t\t\tcall strndup\n"
	method += "\t\t\tmovq %rax, -8(%rbp)\n"
	method += "\t\t\tmovq -8(%rbp), %rax\n"
	method += "\t\t\tleave\n"
	method += "\t\t\tret\n"

	return method

def asm_built_ins():
	built_ins = "\n###############################################################################\n"
	built_ins += "#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BUILT INS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#\n"
	built_ins += "###############################################################################\n"	

	built_ins += in_string_built_in()
	built_ins += substr_built_in()

	return built_ins


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

	# Generate a list of type tags
	get_type_tags(c_map)

	# Generate code to emit
	vtables = asm_vtables_gen(i_map)
	constructors = asm_constructors_gen(c_map, i_map)
	method_definitions = asm_method_definitions_gen(c_map, i_map)

	global string_list
	type_names = sorted(c_map.keys())

	string_constants = asm_string_constants_gen(type_names, string_list)

	comparison_handlers = asm_comparison_handlers_gen()
	start = asm_start()
	built_ins = asm_built_ins()

	# Build output string
	output = vtables
	output += constructors
	output += method_definitions
	output += string_constants
	output += comparison_handlers
	output += start
	output += built_ins

	# Write to output
	write_output(filename, output)

if __name__ == '__main__':
	main()
