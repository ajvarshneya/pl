from tacs_gen import *
from asm import *

spilled_register_address = {}

def get_color(register, coloring):
	colors = ['%r8d', '%r9d', '%r10d', '%r11d', '%r12d', '%r13d', '%r14d', '%r15d', '%eax', '%ebx', '%ecx', '%edx', '%esi', '%edi']
	return str(colors[int(coloring[register])])

def asm_gen(blocks, coloring, spilled_registers):
	global spilled_register_address

	asm = []

	# Base/stack pointer setup
	asm += [pushq('%rbp')]
	asm += [movq('%rsp', '%rbp')]

	# Setup mapping between spilled registers and their memory addresses wrt rbp
	for i, register in enumerate(spilled_registers):
		spilled_register_address[register] = str(-4 * (i + 1)) + '(%rbp)'

	# Allocate space for spilled registers on stack
	spill_space = 4 * len(spilled_registers)
	if spill_space: asm += [subq('$' + str(spill_space), '%rsp')]

	spill_count = 0

	for block in blocks:
		for inst in block.insts:
			if isinstance(inst, TACAssign):		
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				asm += [comment('assign')] # debugging label
				asm += [movl(op1, assignee)]

			elif isinstance(inst, TACPlus):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				op2 = get_color(inst.op2, coloring)

				asm += [comment('addition')] # debugging label
				if op2 == assignee:
					asm += [addl(op1, assignee)]
				else:
					asm += [movl(op1, assignee)]
					asm += [addl(op2, assignee)]

			elif isinstance(inst, TACMinus):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				op2 = get_color(inst.op2, coloring)

				asm += [comment('subtraction')] # debugging label
				if op2 == assignee:
					asm += [subl(op1, assignee)]
					asm += [negl(assignee)]
				else:
					asm += [movl(op1, assignee)]
					asm += [subl(op2, assignee)]

			elif isinstance(inst, TACMultiply):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				op2 = get_color(inst.op2, coloring)

				asm += [comment('multiplication')] # debugging label
				if op2 == assignee:
					asm += [imull(op1, assignee)]
				else:
					asm += [movl(op1, assignee)]
					asm += [imull(op2, assignee)]

			elif isinstance(inst, TACDivide):
				assignee = get_color(inst.assignee, coloring) # rX
				op1 = get_color(inst.op1, coloring) # rY
				op2 = get_color(inst.op2, coloring) # rZ

				asm += [comment('division')] # debugging label

				# Make room for temps on stack
				asm += [subq('$8', '%rsp')]

				# Save registers we will use
				asm += [pushq('%rdx')]
				asm += [pushq('%rax')]
				asm += [pushq('%rcx')]

				# Compute quotient rX = rY / rZ
				asm += [movl(op2, '24(%rsp)')] # rZ -> stack (in case its in eax)
				asm += [movl(op1, '%eax')] # rY -> eax
				asm += [cltd()] # zero extend eax into edx
				asm += [movl('24(%rsp)', '%ecx')] # rZ -> ecx
				asm += [idivl('%ecx')] # divide rY by rZ
				asm += [movl('%eax', '28(%rsp)')] # result -> stack

				# Restore registers
				asm += [popq('%rcx')]
				asm += [popq('%rax')]
				asm += [popq('%rdx')]

				# Save result, remove temp space
				asm += [movl('4(%rsp)', assignee)] # result -> rX
				asm += [addq('$8', '%rsp')]

			elif isinstance(inst, TACLT):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				op2 = get_color(inst.op2, coloring)
				true_label = 'asm_label_' + nl()

				asm += [comment('less than')] # debugging label
				asm += [cmpl(op1, op2)]
				asm += [movl('$1', assignee)]
				asm += [jl(true_label)]
				asm += [movl('$0', assignee)]
				asm += [label(true_label)]

			elif isinstance(inst, TACLEQ):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				op2 = get_color(inst.op2, coloring)
				true_label = 'asm_label_' + nl()

				asm += [comment('less than equals')] # debugging label
				asm += [cmpl(op1, op2)]
				asm += [movl('$1', assignee)]
				asm += [jle(true_label)]
				asm += [movl('$0', assignee)]
				asm += [label(true_label)]

			elif isinstance(inst, TACEqual):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				op2 = get_color(inst.op2, coloring)
				true_label = 'asm_label_' + nl()
				
				asm += [comment('equals')] # debugging label
				asm += [cmpl(op1, op2)]
				asm += [movl('$1', assignee)]
				asm += [je(true_label)]
				asm += [movl('$0', assignee)]
				asm += [label(true_label)]

			elif isinstance(inst, TACInt):
				assignee = get_color(inst.assignee, coloring)
				value = '$' + str(inst.val)
				asm += [comment('int init')] # debugging label
				asm += [movl(value, assignee)]

			elif isinstance(inst, TACBool):
				assignee = get_color(inst.assignee, coloring)
				value = str(inst.val)
				if value == 'true':
					value = '$1'
				else:
					value = '$0'
				asm += [comment('bool init')] # debugging label
				asm += [movl(value, assignee)]

			elif isinstance(inst, TACNot):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				asm += [comment('not')] # debugging label
				asm += [movl(op1, assignee)]
				asm += [xorl('$1', assignee)]

			elif isinstance(inst, TACNeg):
				assignee = get_color(inst.assignee, coloring)
				op1 = get_color(inst.op1, coloring)
				asm += [comment('negate')] # debugging label
				asm += [movl(op1, assignee)]
				asm += [negl(assignee)]			

			elif isinstance(inst, TACDefault):
				assignee = get_color(inst.assignee, coloring)
				asm += [comment('default')] # debugging label
				asm += [movl('$0', assignee)]

			elif isinstance(inst, TACOutInt):
				op1 = get_color(inst.op1, coloring)
				asm += [comment('out_int')] # debugging label

				asm += [pushq('%rax')] # save registers
				asm += [pushq('%rcx')]
				asm += [pushq('%rdx')]
				asm += [pushq('%rsi')]
				asm += [pushq('%rdi')]
				asm += [pushq('%r8')]
				asm += [pushq('%r9')]
				asm += [pushq('%r10')]
				asm += [pushq('%r11')]

				asm += [movl(op1, '%esi')] # put op1 in esi
				asm += [movl('$.int_fmt_string', '%edi')] # string format into edi
				asm += [movl('$0', '%eax')] # 0 into eax
				asm += [call('printf')] # print

				asm += [popq('%r11')] # restore registers
				asm += [popq('%r10')]
				asm += [popq('%r9')]
				asm += [popq('%r8')]
				asm += [popq('%rdi')]
				asm += [popq('%rsi')]
				asm += [popq('%rdx')]
				asm += [popq('%rcx')]
				asm += [popq('%rax')]

			elif isinstance(inst, TACInInt):
				assignee = get_color(inst.assignee, coloring)
				
				asm += [comment('in_int')] # debugging label

				asm += [subq('$4', '%rsp')]

				asm += [pushq('%rax')] # save registers
				asm += [pushq('%rcx')]
				asm += [pushq('%rdx')]
				asm += [pushq('%rsi')]
				asm += [pushq('%rdi')]
				asm += [pushq('%r8')]
				asm += [pushq('%r9')]
				asm += [pushq('%r10')]
				asm += [pushq('%r11')]

				# 76 = 4 + 8*9
				asm += [leaq('72(%rsp)', '%rsi')]
				asm += [movl('$.int_fmt_string', '%edi')]
				asm += [movl('$0', '%eax')]

				asm += [call('__isoc99_scanf')]
				
				asm += [popq('%r11')] # restore registers
				asm += [popq('%r10')]
				asm += [popq('%r9')]
				asm += [popq('%r8')]
				asm += [popq('%rdi')]
				asm += [popq('%rsi')]
				asm += [popq('%rdx')]
				asm += [popq('%rcx')]
				asm += [popq('%rax')]

				asm += [movl('(%rsp)', assignee)]
				asm += [addq('$4', '%rsp')]

			elif isinstance(inst, TACJmp):
				asm += [jmp(str(inst.label))]

			elif isinstance(inst, TACLabel):
				asm += [label(str(inst.label))]

			elif isinstance(inst, TACBt):
				predicate = get_color(inst.op1, coloring)

				asm += [comment('branch')] # debugging label
				asm += [cmpl(predicate, '$1')]
				asm += [je(inst.label)]

			elif isinstance(inst, TACStore):
				asm += [comment('store')] # debugging label
				register = get_color(inst.op1, coloring)
				stack_address = spilled_register_address[inst.op1]
				asm += [movl(register, stack_address)]

			elif isinstance(inst, TACLoad):
				asm += [comment('load')] # debugging label
				register = get_color(inst.assignee, coloring)
				stack_address = spilled_register_address[inst.assignee]
				asm += [movl(stack_address, register)]

			elif isinstance(inst, TACReturn):
				value = get_color(inst.op1, coloring)
				asm += [movl(value, '%eax')]
				asm += [leave()]
				asm += [ret()]
	return asm
