from asm import *
from allocate_registers import *

spilled_register_address = {}

def asm_gen(blocks, coloring, spilled_registers):
	global spilled_register_address

	asm = []

	# Base/stack pointer setup
	asm_append(pushq('%rbp'))
	asm_append(movq('%rsp', '%rbp'))

	# Setup mapping between spilled registers and their memory addresses wrt rbp
	for i, register in enumerate(spilled_registers):
		spilled_register_address[register] = str(-4 * (i + 1)) + '(%rbp)'

	# Allocate space for spilled registers on stack
	spill_space = 4 * len(spilled_registers)
	if spill_space: asm_append(subq('$' + str(spill_space), '%rsp'))

	spill_count = 0

	for block in blocks:
		for inst in block.insts:
			if isinstance(inst, TACAssign):	
				asm_assign(inst)
			elif isinstance(inst, TACPlus):
				asm_plus(inst)
			elif isinstance(inst, TACMinus):
				asm_minus(inst)
			elif isinstance(inst, TACMultiply):
				asm_multiply(inst)
			elif isinstance(inst, TACDivide):
				asm_divide(inst)
			elif isinstance(inst, TACLT):
				asm_lt(inst)
			elif isinstance(inst, TACLEQ):
				asm_leq(inst)
			elif isinstance(inst, TACEqual):
				asm_equal(inst)
			elif isinstance(inst, TACInt):
				asm_int(inst)
			elif isinstance(inst, TACBool):
				asm_bool(inst)
			elif isinstance(inst, TACNot):
				asm_not(inst)
			elif isinstance(inst, TACNeg):
				asm_neg(inst)
			elif isinstance(inst, TACDefault):
				asm_default(inst)
			elif isinstance(inst, TACOutInt):
				asm_out_int(inst)
			elif isinstance(inst, TACInInt):
				asm_in_int(inst)
			elif isinstance(inst, TACJmp):
				asm_jmp(inst)
			elif isinstance(inst, TACLabel):
				asm_label(inst)
			elif isinstance(inst, TACBt):
				asm_bt(inst)
			elif isinstance(inst, TACStore):
				asm_store(inst)
			elif isinstance(inst, TACLoad):
				asm_load(inst)
			elif isinstance(inst, TACReturn):
				asm_return(inst)
			elif isinstance(inst, TACBox):
				asm_box(inst)

	return asm

def asm_append(inst):
	global asm
	asm += [inst]

def asm_assign(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	asm_append(comment('assign')) # debugging label
	asm_append(movl(op1, assignee))

def asm_plus(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	op2 = get_color(inst.op2)

	asm_append(comment('addition')) # debugging label
	if op2 == assignee:
		asm_append(addl(op1, assignee))
	else:
		asm_append(movl(op1, assignee))
		asm_append(addl(op2, assignee))

def asm_minus(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	op2 = get_color(inst.op2)

	asm_append(comment('subtraction')) # debugging label
	if op2 == assignee:
		asm_append(subl(op1, assignee))
		asm_append(negl(assignee))
	else:
		asm_append(movl(op1, assignee))
		asm_append(subl(op2, assignee))


def asm_multiply(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	op2 = get_color(inst.op2)

	asm_append(comment('multiplication')) # debugging label
	if op2 == assignee:
		asm_append(imull(op1, assignee))
	else:
		asm_append(movl(op1, assignee))
		asm_append(imull(op2, assignee))

def asm_divide(inst):
	assignee = get_color(inst.assignee) # rX
	op1 = get_color(inst.op1) # rY
	op2 = get_color(inst.op2) # rZ

	asm_append(comment('division')) # debugging label

	# Make room for temps on stack
	asm_append(subq('$8', '%rsp'))

	# Save registers we will use
	asm_append(pushq('%rdx'))
	asm_append(pushq('%rax'))
	asm_append(pushq('%rcx'))

	# Compute quotient rX = rY / rZ
	asm_append(movl(op2, '24(%rsp)')) # rZ -> stack (in case its in eax)
	asm_append(movl(op1, '%eax')) # rY -> eax
	asm_append(cltd()) # zero extend eax into edx
	asm_append(movl('24(%rsp)', '%ecx')) # rZ -> ecx
	asm_append(idivl('%ecx')) # divide rY by rZ
	asm_append(movl('%eax', '28(%rsp)')) # result -> stack

	# Restore registers
	asm_append(popq('%rcx'))
	asm_append(popq('%rax'))
	asm_append(popq('%rdx'))

	# Save result, remove temp space
	asm_append(movl('4(%rsp)', assignee)) # result -> rX
	asm_append(addq('$8', '%rsp'))

def asm_lt(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	op2 = get_color(inst.op2)
	true_label = 'asm_label_' + nl()

	asm_append(comment('less than')) # debugging label
	asm_append(cmpl(op1, op2))
	asm_append(movl('$1', assignee))
	asm_append(jl(true_label))
	asm_append(movl('$0', assignee))
	asm_append(label(true_label))

def asm_leq(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	op2 = get_color(inst.op2)
	true_label = 'asm_label_' + nl()

	asm_append(comment('less than equals')) # debugging label
	asm_append(cmpl(op1, op2))
	asm_append(movl('$1', assignee))
	asm_append(jle(true_label))
	asm_append(movl('$0', assignee))
	asm_append(label(true_label))

def asm_equal(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	op2 = get_color(inst.op2)
	true_label = 'asm_label_' + nl()
	
	asm_append(comment('equals')) # debugging label
	asm_append(cmpl(op1, op2))
	asm_append(movl('$1', assignee))
	asm_append(je(true_label))
	asm_append(movl('$0', assignee))
	asm_append(label(true_label))

def asm_int(inst):
	assignee = get_color(inst.assignee)
	value = '$' + str(inst.val)
	asm_append(comment('int init')) # debugging label
	asm_append(movl(value, assignee))

def asm_bool(inst):
	assignee = get_color(inst.assignee)
	value = str(inst.val)
	if value == 'true':
		value = '$1'
	else:
		value = '$0'
	asm_append(comment('bool init')) # debugging label
	asm_append(movl(value, assignee))

def asm_not(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	asm_append(comment('not')) # debugging label
	asm_append(movl(op1, assignee))
	asm_append(xorl('$1', assignee))

def asm_neg(inst):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	asm_append(comment('negate')) # debugging label
	asm_append(movl(op1, assignee))
	asm_append(negl(assignee))



def asm_default(inst):
	assignee = get_color(inst.assignee)
	asm_append(comment('default')) # debugging label
	asm_append(movl('$0', assignee))


def asm_out_int(inst):
	op1 = get_color(inst.op1)
	asm_append(comment('out_int')) # debugging label

	asm_append(pushq('%rax')) # save registers
	asm_append(pushq('%rcx'))
	asm_append(pushq('%rdx'))
	asm_append(pushq('%rsi'))
	asm_append(pushq('%rdi'))
	asm_append(pushq('%r8'))
	asm_append(pushq('%r9'))
	asm_append(pushq('%r10'))
	asm_append(pushq('%r11'))

	asm_append(movl(op1, '%esi')) # put op1 in esi
	asm_append(movl('$.int_fmt_string', '%edi')) # string format into edi
	asm_append(movl('$0', '%eax')) # 0 into eax
	asm_append(call('printf')) # print

	asm_append(popq('%r11')) # restore registers
	asm_append(popq('%r10'))
	asm_append(popq('%r9'))
	asm_append(popq('%r8'))
	asm_append(popq('%rdi'))
	asm_append(popq('%rsi'))
	asm_append(popq('%rdx'))
	asm_append(popq('%rcx'))
	asm_append(popq('%rax'))


def asm_in_int(inst):
	assignee = get_color(inst.assignee)
	
	asm_append(comment('in_int')) # debugging label

	asm_append(subq('$4', '%rsp'))

	asm_append(pushq('%rax')) # save registers
	asm_append(pushq('%rcx'))
	asm_append(pushq('%rdx'))
	asm_append(pushq('%rsi'))
	asm_append(pushq('%rdi'))
	asm_append(pushq('%r8'))
	asm_append(pushq('%r9'))
	asm_append(pushq('%r10'))
	asm_append(pushq('%r11'))

	# 76 = 4 + 8*9
	asm_append(leaq('72(%rsp)', '%rsi'))
	asm_append(movl('$.int_fmt_string', '%edi'))
	asm_append(movl('$0', '%eax'))

	asm_append(call('__isoc99_scanf'))
	
	asm_append(popq('%r11')) # restore registers
	asm_append(popq('%r10'))
	asm_append(popq('%r9'))
	asm_append(popq('%r8'))
	asm_append(popq('%rdi'))
	asm_append(popq('%rsi'))
	asm_append(popq('%rdx'))
	asm_append(popq('%rcx'))
	asm_append(popq('%rax'))

	asm_append(movl('(%rsp)', assignee))
	asm_append(addq('$4', '%rsp'))

def asm_jmp(inst):
	asm_append(jmp(str(inst.label)))

def asm_label(inst):
	asm_append(label(str(inst.label)))


def asm_bt(inst):
	predicate = get_color(inst.op1)

	asm_append(comment('branch')) # debugging label
	asm_append(cmpl(predicate, '$1'))
	asm_append(je(inst.label))

def asm_store(inst):
	asm_append(comment('store')) # debugging label
	register = get_color(inst.op1)

	stack_address = spilled_register_address[inst.op1]
	asm_append(movl(register, stack_address))

def asm_load(inst):
	asm_append(comment('load')) # debugging label
	register = get_color(inst.assignee)

	stack_address = spilled_register_address[inst.assignee]
	asm_append(movl(stack_address, register))

def asm_return(inst):
	value = get_color(inst.op1)
	asm_append(movl(value, '%eax'))
	asm_append(leave())
	asm_append(ret())

def asm_box(inst):

def asm_unbox(inst):


