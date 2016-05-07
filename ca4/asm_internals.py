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

	# Load boxed string into %rax, unbox its pointer into %rdi
	method += str(comment("Load formal parameter into %rax"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(comment("Unbox string into %rdi"))
	method += str(movq("24(%rax)", "%rdi"))

	# Call out_string helper
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
	method = ".globl raw_out_string\n"
	method += ".type raw_out_string, @function\n"
	method += "raw_out_string:\n"
	method += ".raw_out_LFB0:\n"
	method += "\t\t\tpushq %rbp\n"
	method += "\t\t\tmovq %rsp, %rbp\n"
	method += "\t\t\tsubq $32, %rsp\n"
	method += "\t\t\tmovq %rdi, -24(%rbp)\n"
	method += "\t\t\tmovl $0, -4(%rbp)\n"
	method += "\t\t\tjmp .raw_out_string_L2\n"
	method += ".raw_out_string_L5:\n"
	method += "\t\t\tcmpb $92, -6(%rbp)\n"
	method += "\t\t\tjne .raw_out_string_L3\n"
	method += "\t\t\tmovl -4(%rbp), %eax\n"
	method += "\t\t\tcltq\n"
	method += "\t\t\tleaq 1(%rax), %rdx\n"
	method += "\t\t\tmovq -24(%rbp), %rax\n"
	method += "\t\t\taddq %rdx, %rax\n"
	method += "\t\t\tmovzbl (%rax), %eax\n"
	method += "\t\t\tmovb %al, -5(%rbp)\n"
	method += "\t\t\tcmpb $110, -5(%rbp)\n"
	method += "\t\t\tjne .raw_out_string_L4\n"
	method += "\t\t\tmovb $10, -6(%rbp)\n"
	method += "\t\t\taddl $1, -4(%rbp)\n"
	method += "\t\t\tjmp .raw_out_string_L3\n"
	method += ".raw_out_string_L4:\n"
	method += "\t\t\tcmpb $116, -5(%rbp)\n"
	method += "\t\t\tjne .raw_out_string_L3\n"
	method += "\t\t\tmovb $9, -6(%rbp)\n"
	method += "\t\t\taddl $1, -4(%rbp)\n"
	method += ".raw_out_string_L3:\n"
	method += "\t\t\tmovsbl -6(%rbp), %eax\n"
	method += "\t\t\tmovl %eax, %edi\n"
	method += "\t\t\tcall putchar\n"
	method += "\t\t\taddl $1, -4(%rbp)\n"
	method += ".raw_out_string_L2:\n"
	method += "\t\t\tmovl -4(%rbp), %eax\n"
	method += "\t\t\tmovslq %eax, %rdx\n"
	method += "\t\t\tmovq -24(%rbp), %rax\n"
	method += "\t\t\taddq %rdx, %rax\n"
	method += "\t\t\tmovzbl (%rax), %eax\n"
	method += "\t\t\tmovb %al, -6(%rbp)\n"
	method += "\t\t\tcmpb $0, -6(%rbp)\n"
	method += "\t\t\tjne .raw_out_string_L5\n"
	method += "\t\t\tleave\n"
	method += "\t\t\tret\n"
	method += "\n"
	return method

def internal_in_string_definition():
	method = str(comment("in_string"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Call in_string helper
	method += str(comment("Call raw_in_string"))
	method += asm_push_caller_str()
	method += str(call('raw_in_string'))
	method += asm_pop_caller_str()

	# Box the result in a new string
	method += str(comment("Box result in a String object"))
	method += str(movq("%rax", "%r8"))

	method += str(comment("Make new String object"))
	method += asm_push_caller_str()
	method += str(call("String..new"))
	method += asm_pop_caller_str()

	method += str(comment("Move raw string into string object"))
	method += str(movq("%r8", "24(%rax)"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_in_string_helper():
	method = "raw_in_string:\n"
	method += "\t\t\tpushq\t%rbp\n"
	method += "\t\t\tmovq\t%rsp, %rbp\n"
	method += "\t\t\tsubq\t$32, %rsp\n"
	method += "\t\t\tmovl\t$20, -16(%rbp)\n"
	method += "\t\t\tmovl\t$0, -12(%rbp)\n"
	method += "\t\t\tmovl\t-16(%rbp), %eax\n"
	method += "\t\t\tcltq\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tmalloc\n"
	method += "\t\t\tmovq\t%rax, -8(%rbp)\n"
	method += ".in_str_L8:\n"
	method += "\t\t\tcall\tgetchar\n"
	method += "\t\t\tmovb\t%al, -17(%rbp)\n"
	method += "\t\t\tcmpb\t$10, -17(%rbp)\n"
	method += "\t\t\tje\t.in_str_L2\n"
	method += "\t\t\tcmpb\t$-1, -17(%rbp)\n"
	method += "\t\t\tje\t.in_str_L2\n"
	method += "\t\t\tmovl\t-12(%rbp), %eax\n"
	method += "\t\t\tmovslq\t%eax, %rdx\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\taddq\t%rax, %rdx\n"
	method += "\t\t\tmovzbl\t-17(%rbp), %eax\n"
	method += "\t\t\tmovb\t%al, (%rdx)\n"
	method += "\t\t\taddl\t$1, -12(%rbp)\n"
	method += "\t\t\tcmpb\t$0, -17(%rbp)\n"
	method += "\t\t\tjne\t.in_str_L3\n"
	method += "\t\t\tmovl\t$0, -12(%rbp)\n"
	method += "\t\t\tjmp\t.in_str_L4\n"
	method += ".in_str_L6:\n"
	method += "\t\t\tcall\tgetchar\n"
	method += "\t\t\tmovb\t%al, -17(%rbp)\n"
	method += ".in_str_L4:\n"
	method += "\t\t\tcmpb\t$10, -17(%rbp)\n"
	method += "\t\t\tje\t.L5\n"
	method += "\t\t\tcmpb\t$-1, -17(%rbp)\n"
	method += "\t\t\tjne\t.in_str_L6\n"
	method += ".L5:\n"
	method += "\t\t\tjmp\t.in_str_L2\n"
	method += ".in_str_L3:\n"
	method += "\t\t\tmovl\t-12(%rbp), %eax\n"
	method += "\t\t\tcmpl\t-16(%rbp), %eax\n"
	method += "\t\t\tjne\t.in_str_L7\n"
	method += "\t\t\taddl\t$20, -16(%rbp)\n"
	method += "\t\t\tmovl\t-16(%rbp), %eax\n"
	method += "\t\t\tmovslq\t%eax, %rdx\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rdx, %rsi\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\trealloc\n"
	method += "\t\t\tmovq\t%rax, -8(%rbp)\n"
	method += "\t\t\tjmp\t.in_str_L8\n"
	method += ".in_str_L7:\n"
	method += "\t\t\tjmp\t.in_str_L8\n"
	method += ".in_str_L2:\n"
	method += "\t\t\tmovl\t-12(%rbp), %eax\n"
	method += "\t\t\tmovslq\t%eax, %rdx\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rdx, %rsi\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tstrndup\n"
	method += "\t\t\tleave\n"
	method += "\t\t\tret\n"
	method += "\n"
	return method

def internal_out_int_definition():
	method = str(comment("out_int"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Load boxed int parameter into %rax, unbox its pointer into %esi
	method += str(comment("Load formal parameter into %rax"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(comment("Unbox int into %esi"))
	method += str(movl("24(%rax)", "%esi"))

	method += str(comment("Move string format into %rdi"))
	method += str(movq("$out_int_format", "%rdi"))
	method += str(movl("$0", "%eax"))

	# Call printf
	method += str(comment("Call printf"))
	method += asm_push_caller_str()
	method += str(call('printf'))
	method += asm_pop_caller_str()

	# Move self pointer into %rax to return it
	method += str(comment("Return self"))
	method += str(movq("%rbx", "%rax"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_in_int_definition():
	method = str(comment("in_int"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Call in_int helper
	method += str(comment("Call raw_in_int"))
	method += asm_push_caller_str()
	method += str(call('raw_in_int'))
	method += asm_pop_caller_str()

	# Box the result in a new string
	method += str(comment("Box result in a Int object"))
	method += str(movq("%rax", "%r8"))

	method += str(comment("Make new Int object"))
	method += asm_push_caller_str()
	method += str(call("Int..new"))
	method += asm_pop_caller_str()

	method += str(comment("Move raw int into Int object"))
	method += str(movq("%r8", "24(%rax)"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_in_int_helper():
	method = "raw_in_int:\n"
	method += "\t\t\tpushq\t%rbp\n"
	method += "\t\t\tmovq\t%rsp, %rbp\n"
	method += "\t\t\tsubq\t$32, %rsp\n"
	method += "\t\t\tmovl\t$32, -24(%rbp)\n"
	method += "\t\t\tmovl\t$0, -20(%rbp)\n"
	method += "\t\t\tmovl\t-24(%rbp), %eax\n"
	method += "\t\t\tcltq\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tmalloc\n"
	method += "\t\t\tmovq\t%rax, -8(%rbp)\n"
	method += ".in_int_5:\n"
	method += "\t\t\tcall\tgetchar\n"
	method += "\t\t\tmovb\t%al, -25(%rbp)\n"
	method += "\t\t\tcmpb\t$10, -25(%rbp)\n"
	method += "\t\t\tje\t.in_int_2\n"
	method += "\t\t\tcmpb\t$-1, -25(%rbp)\n"
	method += "\t\t\tje\t.in_int_2\n"
	method += "\t\t\tmovl\t-20(%rbp), %eax\n"
	method += "\t\t\tmovslq\t%eax, %rdx\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\taddq\t%rax, %rdx\n"
	method += "\t\t\tmovzbl\t-25(%rbp), %eax\n"
	method += "\t\t\tmovb\t%al, (%rdx)\n"
	method += "\t\t\taddl\t$1, -20(%rbp)\n"
	method += "\t\t\tcmpb\t$0, -25(%rbp)\n"
	method += "\t\t\tjne\t.in_int_3\n"
	method += "\t\t\tmovl\t$0, -20(%rbp)\n"
	method += "\t\t\tjmp\t.in_int_2\n"
	method += ".in_int_3:\n"
	method += "\t\t\tmovl\t-20(%rbp), %eax\n"
	method += "\t\t\tcmpl\t-24(%rbp), %eax\n"
	method += "\t\t\tjne\t.in_int_4\n"
	method += "\t\t\taddl\t$20, -24(%rbp)\n"
	method += "\t\t\tmovl\t-24(%rbp), %eax\n"
	method += "\t\t\tmovslq\t%eax, %rdx\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rdx, %rsi\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\trealloc\n"
	method += "\t\t\tmovq\t%rax, -8(%rbp)\n"
	method += "\t\t\tjmp\t.in_int_5\n"
	method += ".in_int_4:\n"
	method += "\t\t\tjmp\t.in_int_5\n"
	method += ".in_int_2:\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tatol\n"
	method += "\t\t\tmovq\t%rax, -16(%rbp)\n"
	method += "\t\t\tcmpq\t$2147483647, -16(%rbp)\n"
	method += "\t\t\tjle\t.in_int_6\n"
	method += "\t\t\tmovq\t$0, -16(%rbp)\n"
	method += "\t\t\tjmp\t.in_int_7\n"
	method += ".in_int_6:\n"
	method += "\t\t\tcmpq\t$-2147483648, -16(%rbp)\n"
	method += "\t\t\tjge\t.in_int_7\n"
	method += "\t\t\tmovq\t$0, -16(%rbp)\n"
	method += ".in_int_7:\n"
	method += "\t\t\tmovq\t-16(%rbp), %rax\n"
	method += "\t\t\tleave\n"
	method += "\t\t\tret\n"
	method += "\n"
	return method

def internal_length_definition():
	method = str(comment("length"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Call strlen on unboxed string from self object (should be a string)
	method += str(comment("call strlen on the string"))
	method += str(movq("24(%rbx)", "%rdi"))
	method += str(call("strlen"))

	# Box the result
	method += str(comment("box the result"))
	method += str(movq("%rax", "%r8"))

	method += str(comment("Make new Int object"))
	method += asm_push_caller_str()
	method += str(call("Int..new"))
	method += asm_pop_caller_str()

	# Move raw int into int object
	method += str(movq("%r8", "24(%rax)"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_concat_definition():
	method = str(comment("concat"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Unbox self object amd param into rdi/si, call helper
	method += str(movq("24(%rbx)", "%rdi"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(movq("24(%rax)", "%rsi"))

	method += str(call("cool_str_concat"))

	# Box the new string
	method += str(movq("%rax", "%r8"))

	method += str(comment("Make new String object"))
	method += asm_push_caller_str()
	method += str(call("String..new"))
	method += asm_pop_caller_str()

	method += str(movq("%r8", "24(%rax)"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_concat_helper():
	method = "cool_str_concat:\n"
	method += "\t\t\tpushq\t%rbp\n"
	method += "\t\t\tmovq\t%rsp, %rbp\n"
	method += "\t\t\tsubq\t$32, %rsp\n"
	method += "\t\t\tmovq\t%rdi, -24(%rbp)\n"
	method += "\t\t\tmovq\t%rsi, -32(%rbp)\n"
	method += "\t\t\tmovq\t-24(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tstrlen\n"
	method += "\t\t\tmovl\t%eax, -16(%rbp)\n"
	method += "\t\t\tmovq\t-32(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tstrlen\n"
	method += "\t\t\tmovl\t%eax, -12(%rbp)\n"
	method += "\t\t\tmovl\t-12(%rbp), %eax\n"
	method += "\t\t\tmovl\t-16(%rbp), %edx\n"
	method += "\t\t\taddl\t%edx, %eax\n"
	method += "\t\t\taddl\t$1, %eax\n"
	method += "\t\t\tcltq\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tmalloc\n"
	method += "\t\t\tmovq\t%rax, -8(%rbp)\n"
	method += "\t\t\tmovq\t-24(%rbp), %rdx\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rdx, %rsi\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tstrcpy\n"
	method += "\t\t\tmovq\t-32(%rbp), %rdx\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rdx, %rsi\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tstrcat\n"
	method += "\t\t\tmovq\t-8(%rbp), %rax\n"
	method += "\t\t\tleave\n"
	method += "\t\t\tret\n"
	method += "\n"
	return method

def internal_substr_definition():
	method = str(comment("substr"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	# Unbox self and two params into rdi/rsi/rdx
	method += str(comment("Unbox self and two params"))
	method += str(movq("24(%rbx)", "%rdi"))
	method += str(movq("16(%rbp)", "%rax"))
	method += str(movq("24(%rax)", "%rsi"))
	method += str(movq("24(%rbp)", "%rax"))
	method += str(movq("24(%rax)", "%rdx"))

	# Call helper function
	method += str(call("cool_str_substr"))

	# Box result
	method += str(comment("Box result into String object"))
	method += str(movq("%rax", "%r8"))

	method += str(comment("Make new String object"))
	method += asm_push_caller_str()
	method += str(call("String..new"))
	method += asm_pop_caller_str()

	method += str(movq("%r8", "24(%rax)"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def internal_substr_helper():
	method = "cool_str_substr:\n"
	method += "\t\t\tpushq\t%rbp\n"
	method += "\t\t\tmovq\t%rsp, %rbp\n"
	method += "\t\t\tpushq\t%rbx\n"
	method += "\t\t\tsubq\t$24, %rsp\n"
	method += "\t\t\tmovq\t%rdi, -24(%rbp)\n"
	method += "\t\t\tmovl\t%esi, -28(%rbp)\n"
	method += "\t\t\tmovl\t%edx, -32(%rbp)\n"
	method += "\t\t\tcmpl\t$0, -28(%rbp)\n"
	method += "\t\t\tjs\t.substr_L4\n"
	method += "\t\t\tmovl\t-32(%rbp), %eax\n"
	method += "\t\t\tmovl\t-28(%rbp), %edx\n"
	method += "\t\t\taddl\t%edx, %eax\n"
	method += "\t\t\tmovslq\t%eax, %rbx\n"
	method += "\t\t\tmovq\t-24(%rbp), %rax\n"
	method += "\t\t\tmovq\t%rax, %rdi\n"
	method += "\t\t\tcall\tstrlen\n"
	method += "\t\t\tcmpq\t%rax, %rbx\n"
	method += "\t\t\tjbe\t.substr_L5\n"
	method += ".substr_L4:\n"
	method += "\t\t\tmovq\t$error.substr_range, %rdi\n"
	method += "\t\t\tcall\traw_out_string\n"
	method += "\t\t\tmovq\t$0, %rax\n"
	method += "\t\t\tcall\texit\n"
	method += ".substr_L5:\n"
	method += "\t\t\tmovl\t-32(%rbp), %eax\n"
	method += "\t\t\tcltq\n"
	method += "\t\t\tmovl\t-28(%rbp), %edx\n"
	method += "\t\t\tmovslq\t%edx, %rcx\n"
	method += "\t\t\tmovq\t-24(%rbp), %rdx\n"
	method += "\t\t\taddq\t%rcx, %rdx\n"
	method += "\t\t\tmovq\t%rax, %rsi\n"
	method += "\t\t\tmovq\t%rdx, %rdi\n"
	method += "\t\t\tcall\tstrndup\n"
	method += "\t\t\taddq\t$24, %rsp\n"
	method += "\t\t\tpopq\t%rbx\n"
	method += "\t\t\tpopq\t%rbp\n"
	method += "\t\t\tret\n"
	method += "\n"
	return method

def less_than_handler():
	method = str(comment("lt_handler"))
	method += str(label("lt_handler"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	method += str(comment("get operands from stack"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))

	method += str(comment("check for void ptrs"))
	method += str(cmpq("$0", "%r8"))
	method += str(je("cmp_lt_false"))
	method += str(cmpq("$0", "%r9"))
	method += str(je("cmp_lt_false"))

	method += str(comment("retrieve/compare type tags"))
	method += str(movq("0(%r8)", "%r8"))
	method += str(movq("0(%r9)", "%r9"))
	method += str(cmpq("%r9", "%r8"))
	method += str(jne("cmp_lt_false"))

	method += str(comment("check if operands are of a primitive type"))
	method += str(cmpq("$1", "%r8")) # Int has type tag 1
	method += str(je("cmp_lt_int"))
	method += str(cmpq("$0", "%r8")) # Bool has type tag 0
	method += str(je("cmp_lt_bool"))
	method += str(cmpq("$4", "%r8")) # String has type tag 4
	method += str(je("cmp_lt_string"))

	# Return false
	method += str(jmp("cmp_lt_false"))
	method += "\n"

	# Int/bool comparison
	method += str(label("cmp_lt_bool"))
	method += str(label("cmp_lt_int"))

	# Unbox operands and compare/jump
	method += str(comment("int/bool comparison"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))
	method += str(movl("24(%r8)", "%r8d"))
	method += str(movl("24(%r9)", "%r9d"))
	method += str(cmpl("%r9d", "%r8d"))

	method += str(jl("cmp_lt_true"))
	method += str(jmp("cmp_lt_false"))
	method += "\n"

	# string comparison, call strcmp
	method += str(label("cmp_lt_string"))
	method += str(comment("string comparison"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))
	method += str(movq("24(%r8)", "%rdi"))
	method += str(movq("24(%r9)", "%rsi"))
	method += str(call("strcmp"))

	# jump depending on result
	method += str(cmpl("$0", "%eax"))
	method += str(jl("cmp_lt_true"))
	method += str(jmp("cmp_lt_false"))
	method += "\n"

	method += str(comment("Make new Bool object with true value"))
	method += str(label("cmp_lt_true"))

	method += str(comment("Make new Bool object"))
	method += asm_push_caller_str()
	method += str(call("Bool..new"))
	method += asm_pop_caller_str()

	method += str(movq("$1", "24(%rax)"))
	method += str(jmp("cmp_lt_end"))
	method += "\n"

	method += str(comment("Make new Bool object with false value"))
	method += str(label("cmp_lt_false"))

	method += str(comment("Make new Bool object"))
	method += asm_push_caller_str()
	method += str(call("Bool..new"))
	method += asm_pop_caller_str()

	method += str(jmp("cmp_lt_end"))
	method += "\n"

	method += str(label("cmp_lt_end"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def less_equals_handler():
	method = str(comment("le_handler"))
	method += str(label("le_handler"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	method += str(comment("get operands from stack"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))

	method += str(comment("check for equal ptrs"))
	method += str(cmpq("%r9", "%r8"))
	method += str(je("cmp_le_true"))

	method += str(comment("check for void ptrs"))
	method += str(cmpq("$0", "%r8"))
	method += str(je("cmp_le_false"))
	method += str(cmpq("$0", "%r9"))
	method += str(je("cmp_le_false"))

	method += str(comment("retrieve/compare type tags"))
	method += str(movq("0(%r8)", "%r8"))
	method += str(movq("0(%r9)", "%r9"))
	method += str(cmpq("%r9", "%r8"))
	method += str(jne("cmp_le_false"))

	method += str(comment("check if operands are of a primitive type"))
	method += str(cmpq("$1", "%r8")) # Int has type tag 1
	method += str(je("cmp_le_int"))
	method += str(cmpq("$0", "%r8")) # Bool has type tag 0
	method += str(je("cmp_le_bool"))
	method += str(cmpq("$4", "%r8")) # String has type tag 4
	method += str(je("cmp_le_string"))

	# Return false
	method += str(jmp("cmp_le_false"))
	method += "\n"

	# Int/bool comparison
	method += str(label("cmp_le_bool"))
	method += str(label("cmp_le_int"))

	# Unbox operands and compare/jump
	method += str(comment("int/bool comparison"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))
	method += str(movl("24(%r8)", "%r8d"))
	method += str(movl("24(%r9)", "%r9d"))
	method += str(cmpl("%r9d", "%r8d"))

	method += str(jle("cmp_le_true"))
	method += str(jmp("cmp_le_false"))
	method += "\n"

	# string comparison, call strcmp
	method += str(label("cmp_le_string"))
	method += str(comment("string comparison"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))
	method += str(movq("24(%r8)", "%rdi"))
	method += str(movq("24(%r9)", "%rsi"))
	method += str(call("strcmp"))

	# jump depending on result
	method += str(cmpl("$0", "%eax"))
	method += str(jl("cmp_le_true"))
	method += str(jmp("cmp_le_false"))
	method += "\n"

	method += str(comment("Make new Bool object with true value"))
	method += str(label("cmp_le_true"))

	method += str(comment("Make new Bool object"))
	method += asm_push_caller_str()
	method += str(call("Bool..new"))
	method += asm_pop_caller_str()

	method += str(movq("$1", "24(%rax)"))
	method += str(jmp("cmp_le_end"))
	method += "\n"

	method += str(comment("Make new Bool object with false value"))
	method += str(label("cmp_le_false"))

	method += str(comment("Make new Bool object"))
	method += asm_push_caller_str()
	method += str(call("Bool..new"))
	method += asm_pop_caller_str()

	method += str(jmp("cmp_le_end"))
	method += "\n"

	method += str(label("cmp_le_end"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method

def equals_handler():
	method = str(comment("eq_handler"))
	method += str(label("eq_handler"))

	# Calling convention
	method += str(pushq("%rbp"))
	method += str(movq("%rsp", "%rbp"))
	method += asm_push_callee_str()

	method += str(comment("get operands from stack"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))

	method += str(comment("check for equal ptrs"))
	method += str(cmpq("%r9", "%r8"))
	method += str(je("cmp_eq_true"))

	method += str(comment("check for void ptrs"))
	method += str(cmpq("$0", "%r8"))
	method += str(je("cmp_eq_false"))
	method += str(cmpq("$0", "%r9"))
	method += str(je("cmp_eq_false"))


	method += str(comment("retrieve/compare type tags"))
	method += str(movq("0(%r8)", "%r8"))
	method += str(movq("0(%r9)", "%r9"))
	method += str(cmpq("%r9", "%r8"))
	method += str(jne("cmp_eq_false"))

	method += str(comment("check if operands are of a primitive type"))
	method += str(cmpq("$1", "%r8")) # Int has type tag 1
	method += str(je("cmp_eq_int"))
	method += str(cmpq("$0", "%r8")) # Bool has type tag 0
	method += str(je("cmp_eq_bool"))
	method += str(cmpq("$4", "%r8")) # String has type tag 4
	method += str(je("cmp_eq_string"))

	# Return false
	method += str(jmp("cmp_eq_false"))
	method += "\n"

	# Int/bool comparison
	method += str(label("cmp_eq_bool"))
	method += str(label("cmp_eq_int"))

	# Unbox operands and compare/jump
	method += str(comment("int/bool comparison"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))
	method += str(movl("24(%r8)", "%r8d"))
	method += str(movl("24(%r9)", "%r9d"))
	method += str(cmpl("%r9d", "%r8d"))

	method += str(jle("cmp_eq_true"))
	method += str(jmp("cmp_eq_false"))
	method += "\n"

	# string comparison, call strcmp
	method += str(label("cmp_eq_string"))
	method += str(comment("string comparison"))
	method += str(movq("16(%rbp)", "%r8"))
	method += str(movq("24(%rbp)", "%r9"))
	method += str(movq("24(%r8)", "%rdi"))
	method += str(movq("24(%r9)", "%rsi"))
	method += str(call("strcmp"))

	# jump depending on result
	method += str(cmpl("$0", "%eax"))
	method += str(jl("cmp_eq_true"))
	method += str(jmp("cmp_eq_false"))
	method += "\n"

	method += str(comment("Make new Bool object with true value"))
	method += str(label("cmp_eq_true"))

	method += str(comment("Make new Bool object"))
	method += asm_push_caller_str()
	method += str(call("Bool..new"))
	method += asm_pop_caller_str()

	method += str(movq("$1", "24(%rax)"))
	method += str(jmp("cmp_eq_end"))
	method += "\n"

	method += str(comment("Make new Bool object with false value"))
	method += str(label("cmp_le_false"))

	method += str(comment("Make new Bool object"))
	method += asm_push_caller_str()
	method += str(call("Bool..new"))
	method += asm_pop_caller_str()

	method += str(jmp("cmp_eq_end"))
	method += "\n"

	method += str(label("cmp_eq_end"))

	# Calling convention
	method += asm_pop_callee_str()
	method += str(leave())
	method += str(ret())
	return method