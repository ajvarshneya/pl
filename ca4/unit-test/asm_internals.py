from asm import *
from asm_gen import *

def internal_abort_definition():
	method = str(comment("abort"))

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

def internal_type_name_definition():
	method = str(comment("type_name"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	method += str(comment("Make new string object"))
	method += asm_push_caller_str()
	method += str(call("String..new"))
	method += asm_pop_caller_str()

	method += str(comment("Move type name from vtable[0] to String object (currently in %rax)"))
	method += str(movq("16(%rbx)", "%r8")) # r8 is arbitrary, could choose any saved register
	method += str(movq("0(%r8)", "%r8"))
	method += str(movq("%r8", "24(%rax)"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_copy_definition():
	method = str(comment("copy"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Allocate space for new object
	method += str(comment("Make space for new object with malloc using object size"))
	method += str(movq("8(%rbx)", "%rdi"))
	method += str(leaq("0(,%rdi,8)", "%rdi"))
	method += str(movq("%rdi", "%r12"))
	method += str(call("malloc"))

	# Use memcpy to copy the object
	method += str(comment("Use memcpy to copy object using object size"))
	method += str(movq("%r12", "%rdx"))
	method += str(movq("%rbx", "%rsi"))
	method += str(movq("%rax", "%rdi"))
	method += str(call("memcpy"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_out_string_definition():
	method = str(comment("out_string"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Load boxed string into rax, unbox its pointer into %rax, move that into esi
	method += str(comment("Load formal parameter into %rax"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(comment("Unbox string into %rdi"))
	method += str(movq("24(%rax)", "%rdi"))

	# Call built in out_string
	method += str(comment("Call raw_out_string"))
	method += asm_push_caller_str()
	method += str(call('raw_out_string'))
	method += asm_pop_caller_str()

	# Move self pointer into %rax to return it
	method += str(comment("Return self"))
	method += str(movq("%rbx", "%rax"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_out_string_helper():
	result = ".globl raw_out_string\n"
	result += ".type raw_out_string, @function\n"
	result += "raw_out_string:\n"
	result += ".raw_out_LFB0:\n"
	result += "\t\t\tpushq %rbp\n"
	result += "\t\t\tmovq %rsp, %rbp\n"
	result += "\t\t\tsubq $32, %rsp\n"
	result += "\t\t\tmovq %rdi, -24(%rbp)\n"
	result += "\t\t\tmovl $0, -4(%rbp)\n"
	result += "\t\t\tjmp .raw_out_string_L2\n"
	result += ".raw_out_string_L5:\n"
	result += "\t\t\tcmpb $92, -6(%rbp)\n"
	result += "\t\t\tjne .raw_out_string_L3\n"
	result += "\t\t\tmovl -4(%rbp), %eax\n"
	result += "\t\t\tcltq\n"
	result += "\t\t\tleaq 1(%rax), %rdx\n"
	result += "\t\t\tmovq -24(%rbp), %rax\n"
	result += "\t\t\taddq %rdx, %rax\n"
	result += "\t\t\tmovzbl (%rax), %eax\n"
	result += "\t\t\tmovb %al, -5(%rbp)\n"
	result += "\t\t\tcmpb $110, -5(%rbp)\n"
	result += "\t\t\tjne .raw_out_string_L4\n"
	result += "\t\t\tmovb $10, -6(%rbp)\n"
	result += "\t\t\taddl $1, -4(%rbp)\n"
	result += "\t\t\tjmp .raw_out_string_L3\n"
	result += ".raw_out_string_L4:\n"
	result += "\t\t\tcmpb $116, -5(%rbp)\n"
	result += "\t\t\tjne .raw_out_string_L3\n"
	result += "\t\t\tmovb $9, -6(%rbp)\n"
	result += "\t\t\taddl $1, -4(%rbp)\n"
	result += ".raw_out_string_L3:\n"
	result += "\t\t\tmovsbl -6(%rbp), %eax\n"
	result += "\t\t\tmovl %eax, %edi\n"
	result += "\t\t\tcall putchar\n"
	result += "\t\t\taddl $1, -4(%rbp)\n"
	result += ".raw_out_string_L2:\n"
	result += "\t\t\tmovl -4(%rbp), %eax\n"
	result += "\t\t\tmovslq %eax, %rdx\n"
	result += "\t\t\tmovq -24(%rbp), %rax\n"
	result += "\t\t\taddq %rdx, %rax\n"
	result += "\t\t\tmovzbl (%rax), %eax\n"
	result += "\t\t\tmovb %al, -6(%rbp)\n"
	result += "\t\t\tcmpb $0, -6(%rbp)\n"
	result += "\t\t\tjne .raw_out_string_L5\n"
	result += "\t\t\tleave\n"
	result += "\t\t\tret\n"
	result += "\n"
	return result

