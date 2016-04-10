from asm import *
from allocate_registers import *

spilled_register_address = {}

def asm_gen(blocks, spilled_registers, attributes):
	global spilled_register_address

	asm = []

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
				asm_assign(inst, asm)
			elif isinstance(inst, TACPlus):
				asm_plus(inst, asm)
			elif isinstance(inst, TACMinus):
				asm_minus(inst, asm)
			elif isinstance(inst, TACMultiply):
				asm_multiply(inst, asm)
			elif isinstance(inst, TACDivide):
				asm_divide(inst, asm)
			# elif isinstance(inst, TACLT):
			# 	asm_lt(inst, asm)
			# elif isinstance(inst, TACLEQ):
			# 	asm_leq(inst, asm)
			# elif isinstance(inst, TACEqual):
			# 	asm_equal(inst, asm)
			elif isinstance(inst, TACInt):
				asm_int(inst, asm)
			elif isinstance(inst, TACBool):
				asm_bool(inst, asm)
			elif isinstance(inst, TACNot):
				asm_not(inst, asm)
			elif isinstance(inst, TACNeg):
				asm_neg(inst, asm)
			elif isinstance(inst, TACDefault):
				asm_default(inst, asm)
			# elif isinstance(inst, TACOutInt):
			# 	asm_out_int(inst, asm)
			# elif isinstance(inst, TACInInt):
			# 	asm_in_int(inst, asm)
			elif isinstance(inst, TACJmp):
				asm_jmp(inst, asm)
			elif isinstance(inst, TACLabel):
				asm_label(inst, asm)
			elif isinstance(inst, TACBt):
				asm_bt(inst, asm)
			elif isinstance(inst, TACStore):
				asm_store(inst, spilled_register_address, asm)
			elif isinstance(inst, TACLoad):
				asm_load(inst, spilled_register_address, asm)
			elif isinstance(inst, TACReturn):
				asm_return(inst, asm)
			elif isinstance(inst, TACBox):
				asm_box(inst, asm)
			elif isinstance(inst, TACUnbox):
				asm_unbox(inst, asm)
			elif isinstance(inst, TACLoadAttribute):
				asm_load_attribute(inst, asm, attributes)
			elif isinstance(inst, TACStoreAttribute):
				asm_store_attribute(inst, asm, attributes)		

	return asm

def asm_assign(inst, asm):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	asm += [comment('assign')] # debugging label
	asm += [movq(op1, assignee)]

def asm_plus(inst, asm):
	assignee = get_color(inst.assignee, 32)
	op1 = get_color(inst.op1, 32)
	op2 = get_color(inst.op2, 32)

	asm += [comment('addition')] # debugging label
	if op2 == assignee:
		asm += [addl(op1, assignee)]
	else:
		asm += [movl(op1, assignee)]
		asm += [addl(op2, assignee)]

def asm_minus(inst, asm):
	assignee = get_color(inst.assignee, 32)
	op1 = get_color(inst.op1, 32)
	op2 = get_color(inst.op2, 32)

	asm += [comment('subtraction')] # debugging label
	if op2 == assignee:
		asm += [subl(op1, assignee)]
		asm += [negl(assignee)]
	else:
		asm += [movl(op1, assignee)]
		asm += [subl(op2, assignee)]

def asm_multiply(inst, asm):
	assignee = get_color(inst.assignee, 32)
	op1 = get_color(inst.op1, 32)
	op2 = get_color(inst.op2, 32)

	asm += [comment('multiplication')] # debugging label
	if op2 == assignee:
		asm += [imull(op1, assignee)]
	else:
		asm += [movl(op1, assignee)]
		asm += [imull(op2, assignee)]

def asm_divide(inst, asm):
	assignee = get_color(inst.assignee, 32) # rX
	op1 = get_color(inst.op1, 32) # rY
	op2 = get_color(inst.op2, 32) # rZ

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

# def asm_lt(inst, asm):
# 	assignee = get_color(inst.assignee)
# 	op1 = get_color(inst.op1)
# 	op2 = get_color(inst.op2)
# 	true_label = 'asm_label_' + nl()

# 	 += [end(comment('less than'))] # debugging label
# 	 += [end(cmpl(op1, op2))]
# 	 += [end(movl('$1', assignee))]
# 	 += [end(jl(true_label))]
# 	 += [end(movl('$0', assignee))]
# 	 += [end(label(true_label))]

# def asm_leq(inst, asm):
# 	assignee = get_color(inst.assignee)
# 	op1 = get_color(inst.op1)
# 	op2 = get_color(inst.op2)
# 	true_label = 'asm_label_' + nl()

# 	 += [end(comment('less than equals'))] # debugging label
# 	 += [end(cmpl(op1, op2))]
# 	 += [end(movl('$1', assignee))]
# 	 += [end(jle(true_label))]
# 	 += [end(movl('$0', assignee))]
# 	 += [end(label(true_label))]

# def asm_equal(inst, asm):
# 	assignee = get_color(inst.assignee)
# 	op1 = get_color(inst.op1)
# 	op2 = get_color(inst.op2)
# 	true_label = 'asm_label_' + nl()
	
# 	 += [end(comment('equals'))] # debugging label
# 	 += [end(cmpl(op1, op2))]
# 	 += [end(movl('$1', assignee))]
# 	 += [end(je(true_label))]
# 	 += [end(movl('$0', assignee))]
# 	 += [end(label(true_label))]

def asm_int(inst, asm):
	asm += [comment("Initialize integer, " + inst.val)]
	# Push caller saved registers for fxn call
	asm_push_caller(asm)

	# Create new int object, object address in %rax
	asm += [call("Int..new")]

	# Pop caller saved registers for fxn call
	asm_pop_caller(asm)

	# Get value register and move its value into the box
	value = "$" + inst.val

	# Get box register
	box = get_color(inst.assignee)

	# Move pointer to object (rax) into box addr register
	asm += [movq('%rax', box)]

	asm += [comment("Move " + inst.val + " into box")]
	asm += [movl(value, '24(' + box + ')')]


def asm_bool(inst, asm):
	asm += [comment("Initialize boolean, " + inst.val)]

	# Push caller saved registers for fxn call
	asm_push_caller(asm)

	# Create new int object, object address in %rax
	asm += [call("Bool..new")]

	# Pop caller saved registers for fxn call
	asm_pop_caller(asm)

	# Set to 1 if true, 0 if false
	value = inst.val
	if value == 'true':
		value = '$1'
	else:
		value = '$0'

	# Get box register
	box = get_color(inst.assignee)

	# Move pointer to object (rax) into box addr register
	asm += [movq('%rax', box)]

	asm += [comment("Move value into box, save object pointer")]
	asm += [movl(value, '24(' + box + ')')]

def asm_not(inst, asm):
	assignee = get_color(inst.assignee, 32)
	op1 = get_color(inst.op1, 32)
	asm += [comment('not')] # debugging label
	asm += [movl(op1, assignee)]
	asm += [xorl('$1', assignee)]

def asm_neg(inst, asm):
	assignee = get_color(inst.assignee, 32)
	op1 = get_color(inst.op1, 32)
	asm += [comment('negate')] # debugging label
	asm += [movl(op1, assignee)]
	asm += [negl(assignee)]

def asm_default(inst, asm):
	# Call constructor
	asm_push_caller(asm)
	asm += [call(inst.c_type + "..new")]
	asm_pop_caller(asm)

	# Get box register
	box = get_color(inst.assignee)

	# Move pointer to object (rax) into box addr register
	asm += [movq('%rax', box)]

# def asm_out_int(inst, asm):
# 	op1 = get_color(inst.op1)
# 	 += [end(comment('out_int'))] # debugging label

# 	 += [end(pushq('%rax'))] # save registers
# 	 += [end(pushq('%rcx'))]
# 	 += [end(pushq('%rdx'))]
# 	 += [end(pushq('%rsi'))]
# 	 += [end(pushq('%rdi'))]
# 	 += [end(pushq('%r8'))]
# 	 += [end(pushq('%r9'))]
# 	 += [end(pushq('%r10'))]
# 	 += [end(pushq('%r11'))]

# 	 += [end(movl(op1, '%esi'))] # put op1 in esi
# 	 += [end(movl('$.int_fmt_string', '%edi'))] # string format into edi
# 	 += [end(movl('$0', '%eax'))] # 0 into eax
# 	 += [end(call('printf'))] # print

# 	 += [end(popq('%r11'))] # restore registers
# 	 += [end(popq('%r10'))]
# 	 += [end(popq('%r9'))]
# 	 += [end(popq('%r8'))]
# 	 += [end(popq('%rdi'))]
# 	 += [end(popq('%rsi'))]
# 	 += [end(popq('%rdx'))]
# 	 += [end(popq('%rcx'))]
# 	 += [end(popq('%rax'))]

# def asm_in_int(inst, asm):
# 	assignee = get_color(inst.assignee)
	
# 	 += [end(comment('in_int'))] # debugging label

# 	 += [end(subq('$4', '%rsp'))]

# 	 += [end(pushq('%rax'))] # save registers
# 	 += [end(pushq('%rcx'))]
# 	 += [end(pushq('%rdx'))]
# 	 += [end(pushq('%rsi'))]
# 	 += [end(pushq('%rdi'))]
# 	 += [end(pushq('%r8'))]
# 	 += [end(pushq('%r9'))]
# 	 += [end(pushq('%r10'))]
# 	 += [end(pushq('%r11'))]

# 	# 76 = 4 + 8*9
# 	 += [end(leaq('72(%rsp)', '%rsi'))]
# 	 += [end(movl('$.int_fmt_string', '%edi'))]
# 	 += [end(movl('$0', '%eax'))]

# 	 += [end(call('__isoc99_scanf'))]
	
# 	 += [end(popq('%r11'))] # restore registers
# 	 += [end(popq('%r10'))]
# 	 += [end(popq('%r9'))]
# 	 += [end(popq('%r8'))]
# 	 += [end(popq('%rdi'))]
# 	 += [end(popq('%rsi'))]
# 	 += [end(popq('%rdx'))]
# 	 += [end(popq('%rcx'))]
# 	 += [end(popq('%rax'))]

# 	 += [end(movl('(%rsp)', assignee))]
# 	 += [end(addq('$4', '%rsp'))]

def asm_jmp(inst, asm):
	asm += [jmp(str(inst.label))]

def asm_label(inst, asm):
	asm += [label(str(inst.label))]

# def asm_bt(inst, asm):
# 	predicate = get_color(inst.op1)

# 	 += [end(comment('branch'))] # debugging label
# 	 += [end(cmpl(predicate, '$1'))]
# 	 += [end(je(inst.label))]

def asm_store(inst, spilled_register_address, asm):
	asm += [comment('store')] # debugging label
	register = get_color(inst.op1)

	stack_address = spilled_register_address[inst.op1]
	asm += [movq(register, stack_address)]

def asm_load(inst, spilled_register_address, asm):
	asm += [comment('load')] # debugging label
	register = get_color(inst.assignee)

	stack_address = spilled_register_address[inst.assignee]
	asm += [movq(stack_address, register)]

def asm_return(inst, asm):
	value = get_color(inst.op1)
	asm += [movq(value, '%rax')]
	asm += [leave()]
	asm += [ret()]

def asm_box(inst, asm):
	# Push caller saved registers for fxn call
	asm_push_caller(asm)

	# Call the correct constructor to make a new boxed object
	if inst.box_type == "Int":
		asm += [call("Int..new")]
	elif inst.box_type == "Bool":
		asm += [call("Bool..new")]
	else:
		raise ValueError("Box_type is neither Int nor Bool")

	# Pop caller saved registers for fxn call
	asm_pop_caller(asm)

	# Get value register and move its value into the box
	value = get_color(inst.op1, 32)

	asm += [comment("Boxing " + inst.op1)]
	asm += [movl(value, '24(%rax)')]

	# Get box register
	box = get_color(inst.assignee)

	# Move pointer to object (rax) into box addr register
	asm += [movq('%rax', box)]

def asm_unbox(inst, asm):
	# Get box address, assignee registers
	box = get_color(inst.op1)
	value = get_color(inst.assignee)

	# Move box value into value
	asm += [comment("Unboxing " + inst.assignee)]
	asm += [movq('24(' + box + ')', value)]

def asm_load_attribute(inst, asm, attributes):
	asm += [comment("Loading " + inst.identifier)]
	for i, x in enumerate(attributes):
		if x.name == inst.identifier: 
			break

	offset = (3 + i) * 8

	assignee = get_color(inst.assignee)
	asm += [movq(str(offset) + '(%rbx)', assignee)]

def asm_store_attribute(inst, asm, attributes):
	# Have: object to store in attribute, identifier of attribute
	# Want to update this class's attribute to be that identifier
	# Need to use self register (rbx) and offset from it by an amount according to class map index
	asm += [comment("Storing " + inst.identifier)]
	for i, x in enumerate(attributes):
		if x.name == inst.identifier: 
			break

	offset = (3 + i) * 8

	asm += [movq(get_color(inst.op1), str(offset) + '(%rbx)')]

def asm_push_caller_str():
	s = ""
	asm_list = []
	asm_push_caller(asm_list)
	for asm in asm_list:
		s += str(asm)
	return s

def asm_pop_caller_str():
	s = ""
	asm_list = []
	asm_pop_caller(asm_list)
	for asm in asm_list:
		s += str(asm)
	return s

def asm_push_callee_str():
	s = ""
	asm_list = []
	asm_push_callee(asm_list)
	for asm in asm_list:
		s += str(asm)
	return s

def asm_pop_callee_str():
	s = ""
	asm_list = []
	asm_pop_callee(asm_list)
	for asm in asm_list:
		s += str(asm)
	return s

def asm_push_caller(asm):
	asm += [comment('Push caller saved registers')]
	asm += [pushq('%rbx')]
	asm += [pushq('%rcx')]
	asm += [pushq('%rdx')]
	asm += [pushq('%rsi')]
	asm += [pushq('%rdi')]
	asm += [pushq('%r8')]
	asm += [pushq('%r9')]
	asm += [pushq('%r10')]
	asm += [pushq('%r11')]

def asm_pop_caller(asm):
	asm += [comment('Pop caller saved registers')]
	asm += [popq('%r11')]
	asm += [popq('%r10')]
	asm += [popq('%r9')]
	asm += [popq('%r8')]
	asm += [popq('%rdi')]
	asm += [popq('%rsi')]
	asm += [popq('%rdx')]
	asm += [popq('%rcx')]
	asm += [popq('%rbx')]

def asm_push_callee(asm):
	asm += [comment('Push callee saved registers')]
	asm += [pushq('%r15')]
	asm += [pushq('%r14')]
	asm += [pushq('%r13')]
	asm += [pushq('%r12')]

def asm_pop_callee(asm):
	asm += [comment('Pop callee saved registers')]
	asm += [popq('%r12')]
	asm += [popq('%r13')]
	asm += [popq('%r14')]
	asm += [popq('%r15')]
