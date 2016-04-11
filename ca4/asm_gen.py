from asm import *
from allocate_registers import *

spilled_register_address = {}

CALLER_SAVED_REGISTERS = ['%rbx','%rcx','%rdx','%rsi','%rdi','%r8','%r9','%r10','%r11']
CALLEE_SAVED_REGISTERS = ['%r12','%r13','%r14','%r15']

def asm_gen(blocks, spilled_registers, cool_type, c_map, i_map):
	global spilled_register_address

	attributes = c_map[cool_type]

	asm = []

	# Setup mapping between spilled registers and their memory addresses wrt rbp
	for i, register in enumerate(spilled_registers):
		spilled_register_address[register] = str(-8 * (i + 1)) + '(%rbp)'

	# Allocate space for spilled registers on stack
	spill_space = 8 * len(spilled_registers)
	if spill_space: asm += [subq('$' + str(spill_space), '%rsp')]

	spill_count = 0

	for block in blocks:
		for inst in block.insts:
			if isinstance(inst, TACAssign):	
				asm_assign(inst, asm)
			elif isinstance(inst, TACDynamicDispatch):
				asm_dynamic_dispatch(inst, cool_type, i_map, asm)
			elif isinstance(inst, TACStaticDispatch):
				asm_static_dispatch(inst, cool_type, i_map, asm)
			elif isinstance(inst, TACSelfDispatch):
				asm_self_dispatch(inst, cool_type, i_map, asm)
			elif isinstance(inst, TACLoadParam):
				asm_load_param(inst, asm)
			elif isinstance(inst, TACStoreParam):
				asm_store_param(inst, asm)
			elif isinstance(inst, TACPlus):
				asm_plus(inst, asm)
			elif isinstance(inst, TACMinus):
				asm_minus(inst, asm)
			elif isinstance(inst, TACMultiply):
				asm_multiply(inst, asm)
			elif isinstance(inst, TACDivide):
				asm_divide(inst, asm)
			elif isinstance(inst, TACInt):
				asm_int_constant(inst, asm)
			elif isinstance(inst, TACBool):
				asm_bool_constant(inst, asm)
			elif isinstance(inst, TACString):
				asm_string_constant(inst, asm)
			elif isinstance(inst, TACNot):
				asm_not(inst, asm)
			elif isinstance(inst, TACNeg):
				asm_neg(inst, asm)
			elif isinstance(inst, TACNew):
				asm_new(inst, asm)
			elif isinstance(inst, TACDefault):
				asm_default(inst, asm)
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
			elif isinstance(inst, TACSelf):
				asm_self(inst, asm)
			elif isinstance(inst, TACComment):
				asm_comment(inst, asm)

	if spill_space: asm += [addq('$' + str(spill_space), '%rsp')]

	return asm

def asm_assign(inst, asm):
	assignee = get_color(inst.assignee)
	op1 = get_color(inst.op1)
	asm += [comment('assign')] # debugging label
	asm += [movq(op1, assignee)]

def asm_dynamic_dispatch(inst, cool_type, i_map, asm):
	assignee = get_color(inst.assignee)
	receiver = get_color(inst.receiver)

	# Calling convention
	asm_push_caller(asm)

	# Make space on stack for parameters
	asm += [comment("Push parameters on in reverse")]
	asm += [subq("$" + str(8 * len(inst.params)), "%rsp")]

	# Push parameters on stack in reverse
	for idx, param in enumerate(inst.params):
		offset1 = 8 * (2 * len(inst.params) + len(CALLER_SAVED_REGISTERS) - 1 - idx)
		offset2 = 8 * idx
		asm += [movq(str(offset1) + '(%rsp)', '%rax')]
		asm += [movq('%rax', str(offset2) + '(%rsp)')]

	# Move receiver object into self and call fxn
	asm += [comment("Move receiver object into self, call function " + inst.method_name)]
	asm += [movq(receiver, "%rbx")]

	# Find method with the method name
	if inst.static_type == "SELF_TYPE":
		for idx, method in enumerate(i_map[cool_type]):
			if method.name == inst.method_name:
				break
	else:
		for idx, method in enumerate(i_map[inst.static_type]):
			if method.name == inst.method_name:
				break

	vtable_offset = str(8 * (idx + 2))

	asm += [comment("Move vtable pointer into rax")]
	asm += [movq('16(' + receiver + ')', '%rax')]
	asm += [comment("Move vtable pointer + offset into rax")]
	asm += [movq(vtable_offset + '(%rax)', '%rax')]
	asm += [call('*%rax')]

	asm += [addq("$" + str(8 * len(inst.params)), "%rsp")]

	# Calling convention
	asm_pop_caller(asm)

	asm += [addq("$" + str(8 * len(inst.params)), "%rsp")]

	# Return
	asm += [movq("%rax", assignee)]

def asm_static_dispatch(inst, cool_type, i_map, asm):
	assignee = get_color(inst.assignee)
	receiver = get_color(inst.receiver)
	
	# Calling convention
	asm_push_caller(asm)

	# Make space on stack for parameters
	asm += [comment("Push parameters on in reverse")]
	asm += [subq("$" + str(8 * len(inst.params)), "%rsp")]

	# Push parameters on stack in reverse
	for idx, param in enumerate(inst.params):
		offset1 = 8 * (2 * len(inst.params) + len(CALLER_SAVED_REGISTERS) - 1 - idx)
		offset2 = 8 * idx
		asm += [(movq(str(offset1) + '(%rsp)', '%rax'))]
		asm += [(movq('%rax', str(offset2) + '(%rsp)'))]

	# Move recevier object into self and call fxn
	asm += [comment("Move receiver object into self, call function " + inst.method_name)]
	asm += [movq(receiver, "%rbx")]
	if inst.static_type == "SELF_TYPE":
		asm += [call(cool_type + "." + inst.method_name)]
	else:
		asm += [call(inst.static_type + "." + inst.method_name)]

	asm += [addq("$" + str(8 * len(inst.params)), "%rsp")]

	# Calling convention
	asm_pop_caller(asm)

	asm += [addq("$" + str(8 * len(inst.params)), "%rsp")]

	# Return
	asm += [movq("%rax", assignee)]

def asm_self_dispatch(inst, cool_type, i_map, asm):
	assignee = get_color(inst.assignee)

	# Calling convention
	asm_push_caller(asm)

	# Make space on stack for parameters
	asm += [comment("Push parameters on in reverse")]
	asm += [subq("$" + str(8 * len(inst.params)), "%rsp")]

	# Push parameters on stack in reverse
	for idx, param in enumerate(inst.params):
		offset1 = 8 * (2 * len(inst.params) + len(CALLER_SAVED_REGISTERS) - 1 - idx)
		offset2 = 8 * idx
		asm += [movq(str(offset1) + '(%rsp)', '%rax')]
		asm += [movq('%rax', str(offset2) + '(%rsp)')]

	# Move receiver object into self and call fxn
	asm += [comment("Call function " + inst.method_name)]

	# Find method with the method name
	for idx, method in enumerate(i_map[cool_type]):
		if method.name == inst.method_name:
			break

	vtable_offset = str(8 * (idx + 2))

	asm += [comment("Move vtable pointer into rax")]
	asm += [movq('16(%rbx)', '%rax')]
	asm += [comment("Move vtable pointer + offset into rax")]
	asm += [movq(vtable_offset + '(%rax)', '%rax')]
	asm += [call('*%rax')]

	asm += [addq("$" + str(8 * len(inst.params)), "%rsp")]

	# Calling convention
	asm_pop_caller(asm)

	asm += [addq("$" + str(8 * len(inst.params)), "%rsp")]

	# Return
	asm += [movq("%rax", assignee)]

def asm_load_param(inst, asm):
	offset = 8 * (inst.offset + 2)
	asm += [comment("Loading parameter from function call")]
	asm += [movq(str(offset) + '(%rbp)', get_color(inst.assignee))]

def asm_store_param(inst, asm):
	asm += [comment("Storing parameter for function call")]
	asm += [pushq(get_color(inst.op1))]

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

def asm_int_constant(inst, asm):
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


def asm_bool_constant(inst, asm):
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

def asm_string_constant(inst, asm):
	asm += [comment("Initialize string, " + str(inst.val))]

	# Create new string object, object address in %rax
	asm_push_caller(asm)
	asm += [call("String..new")]
	asm_pop_caller(asm)

	# Get box register
	box = get_color(inst.assignee)

	# Move pointer to object (rax) into box addr register
	asm += [movq('%rax', box)]

	# Move string constant label into rax, then into the box
	asm += [comment("Move value into %rax, then box")]
	asm += [movq('$string_constant..' + str(inst.index), '%rax')]
	asm += [movq('%rax', '24(' + box + ')')]

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

def asm_new(inst, asm):
	assignee = get_color(inst.assignee)

	asm += [comment("Initialize " + inst.static_type)]

	if inst.static_type == "SELF_TYPE":
		# Calling convention
		asm_push_caller(asm)

		asm += [comment("Move vtable pointer into rax")]
		asm += [movq('16(%rbx)', '%rax')]
		asm += [comment("Move vtable pointer + constructor offset into rax")]
		asm += [movq('8(%rax)', '%rax')]

		asm += [call('*%rax')]

		# Calling convention
		asm_pop_caller(asm)

		box = get_color(inst.assignee)
		asm += [movq('%rax', box)]		
	else:
		asm_push_caller(asm)
		asm += [call(inst.static_type + "..new")]
		asm_pop_caller(asm)

		asm += [comment("Move result into assignee")]
		asm += [movq('%rax', assignee)]

def asm_default(inst, asm):
	if inst.static_type == "SELF_TYPE":
		# Calling convention
		asm_push_caller(asm)

		asm += [comment("Move vtable pointer into rax")]
		asm += [movq('16(%rbx)', '%rax')]
		asm += [comment("Move vtable pointer + constructor offset into rax")]
		asm += [movq('8(%rax)', '%rax')]

		asm += [call('*%rax')]

		# Calling convention
		asm_pop_caller(asm)

		box = get_color(inst.assignee)
		asm += [movq('%rax', box)]

	else:
		# Call constructor
		asm_push_caller(asm)
		asm += [call(inst.static_type + "..new")]
		asm_pop_caller(asm)

		# Get box register
		box = get_color(inst.assignee)

		# Move pointer to object (rax) into box addr register
		asm += [movq('%rax', box)]

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
	asm += [comment("Loading attribute " + inst.identifier)]
	i = 0
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
	asm += [comment("Storing attribute " + inst.identifier)]
	for i, x in enumerate(attributes):
		if x.name == inst.identifier: 
			break

	offset = (3 + i) * 8

	asm += [movq(get_color(inst.op1), str(offset) + '(%rbx)')]

def asm_self(inst, asm):
	assignee = get_color(inst.assignee)
	asm += [comment("Storing self in assignee")]
	asm += [movq("%rbx", assignee)]

def asm_comment(inst, asm):
	asm += [comment(inst.text)]

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
	global CALLER_SAVED_REGISTERS
	asm += [comment('Push caller saved registers')]
	for reg in CALLER_SAVED_REGISTERS:
		asm += [pushq(reg)]

def asm_pop_caller(asm):
	asm += [comment('Pop caller saved registers')]
	for reg in reversed(CALLER_SAVED_REGISTERS):
		asm += [popq(reg)]

def asm_push_callee(asm):
	asm += [comment('Push callee saved registers')]
	for reg in CALLEE_SAVED_REGISTERS:
		asm += [pushq(reg)]

def asm_pop_callee(asm):
	asm += [comment('Pop callee saved registers')]
	for reg in reversed(CALLEE_SAVED_REGISTERS):
		asm += [popq(reg)]
