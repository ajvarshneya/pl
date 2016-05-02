			## ::::::::::::::::::::::::::::::::::::::::
			##  VTABLES
			## ::::::::::::::::::::::::::::::::::::::::

.globl Bool..vtable
Bool..vtable:		## vtable for Bool
			.quad type_name_Bool
			.quad Bool..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name

.globl IO..vtable
IO..vtable:		## vtable for IO
			.quad type_name_IO
			.quad IO..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
			.quad IO.in_int
			.quad IO.in_string
			.quad IO.out_int
			.quad IO.out_string

.globl Int..vtable
Int..vtable:		## vtable for Int
			.quad type_name_Int
			.quad Int..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name

.globl Main..vtable
Main..vtable:		## vtable for Main
			.quad type_name_Main
			.quad Main..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
			.quad IO.in_int
			.quad IO.in_string
			.quad IO.out_int
			.quad IO.out_string
			.quad Main.main

.globl Object..vtable
Object..vtable:		## vtable for Object
			.quad type_name_Object
			.quad Object..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name

.globl String..vtable
String..vtable:		## vtable for String
			.quad type_name_String
			.quad String..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
			.quad String.concat
			.quad String.length
			.quad String.substr

			## ::::::::::::::::::::::::::::::::::::::::
			##  CONSTRUCTORS
			## ::::::::::::::::::::::::::::::::::::::::

.globl Bool..new
Bool..new:		## Constructor for Bool
			pushq	%rbp
			movq	%rsp, %rbp
			## allocate space to store 0 spilled regs
			subq	$0, %rsp
			## push callee-saved regs
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
			## allocate space for Bool (size: 4)
			movq	$8, %rsi
			movq	$4, %rdi
			call	calloc
			movq	%rax, %rbx
			## store type_tag, obj_size, vtable in %rbx
			movq	$0, %rax
			movq	%rax, 0(%rbx)
			movq	$4, %rax
			movq	%rax, 8(%rbx)
			movq	$Bool..vtable, %rax
			movq	%rax, 16(%rbx)
			## default raw.Int
			movq	$0, %r8
			## store %r8 in self[3] (val)
			movq	%r8, 24(%rbx)
			## pop callee-saved regs
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			## remove temporary stack space for 0 spilled regs
			addq	$0, %rsp
			## assign self register to %rax for return
			movq	%rbx, %rax
			leave
			ret

.globl IO..new
IO..new:		## Constructor for IO
			pushq	%rbp
			movq	%rsp, %rbp
			## allocate space to store 0 spilled regs
			subq	$0, %rsp
			## push callee-saved regs
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
			## allocate space for IO (size: 3)
			movq	$8, %rsi
			movq	$3, %rdi
			call	calloc
			movq	%rax, %rbx
			## store type_tag, obj_size, vtable in %rbx
			movq	$2, %rax
			movq	%rax, 0(%rbx)
			movq	$3, %rax
			movq	%rax, 8(%rbx)
			movq	$IO..vtable, %rax
			movq	%rax, 16(%rbx)
			## pop callee-saved regs
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			## remove temporary stack space for 0 spilled regs
			addq	$0, %rsp
			## assign self register to %rax for return
			movq	%rbx, %rax
			leave
			ret

.globl Int..new
Int..new:		## Constructor for Int
			pushq	%rbp
			movq	%rsp, %rbp
			## allocate space to store 0 spilled regs
			subq	$0, %rsp
			## push callee-saved regs
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
			## allocate space for Int (size: 4)
			movq	$8, %rsi
			movq	$4, %rdi
			call	calloc
			movq	%rax, %rbx
			## store type_tag, obj_size, vtable in %rbx
			movq	$1, %rax
			movq	%rax, 0(%rbx)
			movq	$4, %rax
			movq	%rax, 8(%rbx)
			movq	$Int..vtable, %rax
			movq	%rax, 16(%rbx)
			## default raw.Int
			movq	$0, %r8
			## store %r8 in self[3] (val)
			movq	%r8, 24(%rbx)
			## pop callee-saved regs
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			## remove temporary stack space for 0 spilled regs
			addq	$0, %rsp
			## assign self register to %rax for return
			movq	%rbx, %rax
			leave
			ret

.globl Main..new
Main..new:		## Constructor for Main
			pushq	%rbp
			movq	%rsp, %rbp
			## allocate space to store 0 spilled regs
			subq	$0, %rsp
			## push callee-saved regs
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
			## allocate space for Main (size: 3)
			movq	$8, %rsi
			movq	$3, %rdi
			call	calloc
			movq	%rax, %rbx
			## store type_tag, obj_size, vtable in %rbx
			movq	$5, %rax
			movq	%rax, 0(%rbx)
			movq	$3, %rax
			movq	%rax, 8(%rbx)
			movq	$Main..vtable, %rax
			movq	%rax, 16(%rbx)
			## pop callee-saved regs
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			## remove temporary stack space for 0 spilled regs
			addq	$0, %rsp
			## assign self register to %rax for return
			movq	%rbx, %rax
			leave
			ret

.globl Object..new
Object..new:		## Constructor for Object
			pushq	%rbp
			movq	%rsp, %rbp
			## allocate space to store 0 spilled regs
			subq	$0, %rsp
			## push callee-saved regs
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
			## allocate space for Object (size: 3)
			movq	$8, %rsi
			movq	$3, %rdi
			call	calloc
			movq	%rax, %rbx
			## store type_tag, obj_size, vtable in %rbx
			movq	$3, %rax
			movq	%rax, 0(%rbx)
			movq	$3, %rax
			movq	%rax, 8(%rbx)
			movq	$Object..vtable, %rax
			movq	%rax, 16(%rbx)
			## pop callee-saved regs
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			## remove temporary stack space for 0 spilled regs
			addq	$0, %rsp
			## assign self register to %rax for return
			movq	%rbx, %rax
			leave
			ret

.globl String..new
String..new:		## Constructor for String
			pushq	%rbp
			movq	%rsp, %rbp
			## allocate space to store 0 spilled regs
			subq	$0, %rsp
			## push callee-saved regs
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
			## allocate space for String (size: 4)
			movq	$8, %rsi
			movq	$4, %rdi
			call	calloc
			movq	%rax, %rbx
			## store type_tag, obj_size, vtable in %rbx
			movq	$4, %rax
			movq	%rax, 0(%rbx)
			movq	$4, %rax
			movq	%rax, 8(%rbx)
			movq	$String..vtable, %rax
			movq	%rax, 16(%rbx)
			## default raw.String
			movq	$empty.string, %r8
			## store %r8 in self[3] (val)
			movq	%r8, 24(%rbx)
			## pop callee-saved regs
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			## remove temporary stack space for 0 spilled regs
			addq	$0, %rsp
			## assign self register to %rax for return
			movq	%rbx, %rax
			leave
			ret

			## ::::::::::::::::::::::::::::::::::::::::
			##  METHOD IMPLEMENTATIONS
			## ::::::::::::::::::::::::::::::::::::::::

.globl IO.in_int
IO.in_int:
			pushq	%rbp
			movq	%rsp, %rbp
			## use generated function to read int
			subq	$32, %rsp
			movl	$32, -24(%rbp)
			movl	$0, -20(%rbp)
			movl	-24(%rbp), %eax
			cltq
			movq	%rax, %rdi
			call	malloc
			movq	%rax, -8(%rbp)
.in_int_5:
			call	getchar
			movb	%al, -25(%rbp)
			cmpb	$10, -25(%rbp)
			je	.in_int_2
			cmpb	$-1, -25(%rbp)
			je	.in_int_2
			movl	-20(%rbp), %eax
			movslq	%eax, %rdx
			movq	-8(%rbp), %rax
			addq	%rax, %rdx
			movzbl	-25(%rbp), %eax
			movb	%al, (%rdx)
			addl	$1, -20(%rbp)
			cmpb	$0, -25(%rbp)
			jne	.in_int_3
			movl	$0, -20(%rbp)
			jmp	.in_int_2
.in_int_3:
			movl	-20(%rbp), %eax
			cmpl	-24(%rbp), %eax
			jne	.in_int_4
			addl	$20, -24(%rbp)
			movl	-24(%rbp), %eax
			movslq	%eax, %rdx
			movq	-8(%rbp), %rax
			movq	%rdx, %rsi
			movq	%rax, %rdi
			call	realloc
			movq	%rax, -8(%rbp)
			jmp	.in_int_5
.in_int_4:
			jmp	.in_int_5
.in_int_2:
			movq	-8(%rbp), %rax
			movq	%rax, %rdi
			call	atol
			movq	%rax, -16(%rbp)
			cmpq	$2147483647, -16(%rbp)
			jle	.in_int_6
			movq	$0, -16(%rbp)
			jmp	.in_int_7
.in_int_6:
			cmpq	$-2147483648, -16(%rbp)
			jge	.in_int_7
			movq	$0, -16(%rbp)
.in_int_7:
			movq	-16(%rbp), %r8

			## push caller-saved regs
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## push self ptr
			pushq	%rbx
			call	Int..new
			## restore self ptr
			popq	%rbx
			## pop caller-saved regs
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	%rax, %rax
			## move result into boxed Int
			movq	%r8, 24(%rax)
			leave
			ret

.globl IO.in_string
IO.in_string:
			pushq	%rbp
			movq	%rsp, %rbp
			## use generated code to get string
			subq	$32, %rsp
			movl	$20, -16(%rbp)
			movl	$0, -12(%rbp)
			movl	-16(%rbp), %eax
			cltq
			movq	%rax, %rdi
			call	malloc
			movq	%rax, -8(%rbp)
.in_string_L5:
			call	getchar
			movb	%al, -17(%rbp)
			cmpb	$10, -17(%rbp)
			je	.in_string_L2
			cmpb	$-1, -17(%rbp)
			je	.in_string_L2
			movl	-12(%rbp), %eax
			movslq	%eax, %rdx
			movq	-8(%rbp), %rax
			addq	%rax, %rdx
			movzbl	-17(%rbp), %eax
			movb	%al, (%rdx)
			addl	$1, -12(%rbp)
			cmpb	$0, -17(%rbp)
			jne	.in_string_L3
			movl	$0, -12(%rbp)
			jmp	.in_string_L2
.in_string_L3:
			movl	-12(%rbp), %eax
			cmpl	-16(%rbp), %eax
			jne	.in_string_L4
			addl	$20, -16(%rbp)
			movl	-16(%rbp), %eax
			movslq	%eax, %rdx
			movq	-8(%rbp), %rax
			movq	%rdx, %rsi
			movq	%rax, %rdi
			call	realloc
			movq	%rax, -8(%rbp)
			jmp	.in_string_L5
.in_string_L4:
			jmp	.in_string_L5
.in_string_L2:
			movl	-12(%rbp), %eax
			movslq	%eax, %rdx
			movq	-8(%rbp), %rax
			movq	%rdx, %rsi
			movq	%rax, %rdi
			call	strndup
			movq	%rax, -8(%rbp)

			## result is now stored at -8(%rbp)
			## make new box in %rax to hold the str val
			## push caller-saved regs
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## push self ptr
			pushq	%rbx
			call	String..new
			## restore self ptr
			popq	%rbx
			## pop caller-saved regs
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	%rax, %rax
			## use %r8 to move value of str into box
			pushq	%r8
			movq	-8(%rbp), %r8
			movq	%r8, 24(%rax)
			popq	%r8
			leave
			ret

.globl IO.out_int
IO.out_int:
			pushq	%rbp
			movq	%rsp, %rbp
			## loading param [0] into %rax
			movq	16(%rbp), %rax
			## setup and call printf
			movl	24(%rax), %esi
			movq	$out_int_format_str, %rdi
			movl	$0, %eax
			call	printf
			## set self ptr as return type
			movq	%rbx, %rax
			leave
			ret

.globl IO.out_string
IO.out_string:
			pushq	%rbp
			movq	%rsp, %rbp
			## loading param [0] into %rax
			movq	16(%rbp), %rax
			## unboxing param [0] (in %rax) into %rdi for call to raw_out_string
			movq	24(%rax), %rdi
			call	raw_out_string
			## move self ptr into %rax for return
			movq	%rbx, %rax
			leave
			ret

.globl Main.main
Main.main:
			pushq	%rbp
			movq	%rsp, %rbp
			## allocate space to store 0 spilled regs
			subq	$0, %rsp
			## push callee-saved regs
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
.Main_main_1:
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self ptr (%rbx)
			pushq	%rbx
			## pushing 0 params to the stack
			subq	$0, %rsp
			## self: lookup method in vtable
			## get ptr to vtable from self
			movq	16(%rbx), %rax
			## find method in_string in vtable[6]
			movq	48(%rax), %rax
			## call method dynamically
			call	*%rax
			## removing 0 params from stack with subq
			addq	$0, %rsp
			## restore self ptr (%rbx)
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			## removing 0 stored params from stack (2nd time)
			addq	$0, %rsp
			## storing method result in %r9
			movq	%rax, %r9
			## assign
			movq	%r9, %r8
			## assign
			movq	%r8, %r9
			## storing param [0]
			pushq	%r9
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self ptr (%rbx)
			pushq	%rbx
			## pushing 1 params to the stack
			subq	$8, %rsp
			## moving rsp[80] to rsp[0]
			movq	80(%rsp), %rax
			movq	%rax, 0(%rsp)
			## self: lookup method in vtable
			## get ptr to vtable from self
			movq	16(%rbx), %rax
			## find method out_string in vtable[8]
			movq	64(%rax), %rax
			## call method dynamically
			call	*%rax
			## removing 1 params from stack with subq
			addq	$8, %rsp
			## restore self ptr (%rbx)
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			## removing 1 stored params from stack (2nd time)
			addq	$8, %rsp
			## storing method result in %r9
			movq	%rax, %r9
			## assign
			movq	%r9, %r8
			## move ret val %r8 into %rax
			movq	%r8, %rax
			## pop callee-saved regs
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			## remove temporary stack space for 0 spilled regs
			addq	$0, %rsp
			leave
			ret

.globl Object.abort
Object.abort:
			pushq	%rbp
			movq	%rsp, %rbp
			movq $abort.string, %rdi
			call raw_out_string
			movq $0, %rdi
			call exit

			leave
			ret

.globl Object.copy
Object.copy:
			pushq	%rbp
			movq	%rsp, %rbp
			## save self reg
			pushq	%rbx
			## make new obj to store result (same as doing SELF_TYPE..new)
			movq	16(%rbx), %rax
			movq	8(%rax), %rax
			call	*%rax
			## restore self reg
			popq	%rbx
			## call memcpy to copy %rbx into %rax
			## use leaq to multiply the size by 8
			movq	8(%rbx), %rdx
			leaq	0(,%rdx,8), %rdx
			movq	%rbx, %rsi
			movq	%rax, %rdi
			call	memcpy
			## result of mempy in %rax, so good to return
			leave
			ret

.globl Object.type_name
Object.type_name:
			pushq	%rbp
			movq	%rsp, %rbp
			## make new String to hold the result
			## push caller-saved regs
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## push self ptr
			pushq	%rbx
			call	String..new
			## restore self ptr
			popq	%rbx
			## pop caller-saved regs
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	%rax, %rax
			## move type_name from vtable[0] into String in %rax
			movq	16(%rbx), %r8
			movq	0(%r8), %r8
			movq	%r8, 24(%rax)
			leave
			ret

.globl String.concat
String.concat:
			pushq	%rbp
			movq	%rsp, %rbp
			## unbox self into rdi
			movq	24(%rbx), %rdi
			## unbox param[0] into rsi
			movq	16(%rbp), %rax
			movq	24(%rax), %rsi
			call	cool_str_concat
			## make new box in rax to store result (moved into r8 temporarily)
			movq	%rax, %r8
			## push caller-saved regs
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## push self ptr
			pushq	%rbx
			call	String..new
			## restore self ptr
			popq	%rbx
			## pop caller-saved regs
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	%rax, %rax
			movq	%r8, 24(%rax)
			leave
			ret

.globl String.length
String.length:
			pushq	%rbp
			movq	%rsp, %rbp
			pushq	%r12
			pushq	%r13
			pushq	%r14
			pushq	%r15
			## call strlen to compute length
			movq	24(%rbx), %rdi
			call	strlen
			movq	%rax, %r8
			## box final result
			## push caller-saved regs
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## push self ptr
			pushq	%rbx
			call	Int..new
			## restore self ptr
			popq	%rbx
			## pop caller-saved regs
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	%rax, %r9
			movq	%r8, 24(%r9)
			## move result into rax
			movq	%r9, %rax
			popq	%r15
			popq	%r14
			popq	%r13
			popq	%r12
			leave
			ret

.globl String.substr
String.substr:
			pushq	%rbp
			movq	%rsp, %rbp
			## unbox self into rdi
			movq	24(%rbx), %rdi
			## unbox param[0] into rsi
			movq	16(%rbp), %rax
			movq	24(%rax), %rsi
			## unbox param[1] into rdx
			movq	24(%rbp), %rax
			movq	24(%rax), %rdx
			call	cool_str_substr
			## make new box to store result (moved into r8 temporarily)
			movq	%rax, %r8
			## push caller-saved regs
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## push self ptr
			pushq	%rbx
			call	String..new
			## restore self ptr
			popq	%rbx
			## pop caller-saved regs
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	%rax, %rax
			movq	%r8, 24(%rax)
			leave
			ret

			## ::::::::::::::::::::::::::::::::::::::::
			##  PROGRAM START
			## ::::::::::::::::::::::::::::::::::::::::

			.globl main
			.type main, @function
main:
			call	Main..new
			movq	%rax, %rbx
			call	Main.main
			movq	$0, %rax
			call	exit
			## ::::::::::::::::::::::::::::::::::::::::
			##  CONSTANT STRINGS
			## ::::::::::::::::::::::::::::::::::::::::

.globl type_name_Bool 
type_name_Bool:			## type_name string for Bool
			.string "Bool"

.globl type_name_IO 
type_name_IO:			## type_name string for IO
			.string "IO"

.globl type_name_Int 
type_name_Int:			## type_name string for Int
			.string "Int"

.globl type_name_Main 
type_name_Main:			## type_name string for Main
			.string "Main"

.globl type_name_Object 
type_name_Object:			## type_name string for Object
			.string "Object"

.globl type_name_String 
type_name_String:			## type_name string for String
			.string "String"

.globl empty.string
empty.string:			## empty string for default Strings
			.string ""

.globl abort.string
abort.string:			## abort string for Object.abort
			.string "abort\n"

.globl error.substr_range
error.substr_range:		## error string for String.substr
			.string "ERROR: 0: Exception: String.substr out of range\n"

.globl in_int_format_str
in_int_format_str:
			.string "%ld"

.globl out_int_format_str
out_int_format_str:
			.string "%d"

	.globl	raw_out_string
	.type	raw_out_string, @function
raw_out_string:
.raw_out_LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.raw_out_string_L2
.raw_out_string_L5:
	cmpb	$92, -6(%rbp)
	jne	.raw_out_string_L3
	movl	-4(%rbp), %eax
	cltq
	leaq	1(%rax), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -5(%rbp)
	cmpb	$110, -5(%rbp)
	jne	.raw_out_string_L4
	movb	$10, -6(%rbp)
	addl	$1, -4(%rbp)
	jmp	.raw_out_string_L3
.raw_out_string_L4:
	cmpb	$116, -5(%rbp)
	jne	.raw_out_string_L3
	movb	$9, -6(%rbp)
	addl	$1, -4(%rbp)
.raw_out_string_L3:
	movsbl	-6(%rbp), %eax
	movl	%eax, %edi
	call	putchar
	addl	$1, -4(%rbp)
.raw_out_string_L2:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	movb	%al, -6(%rbp)
	cmpb	$0, -6(%rbp)
	jne	.raw_out_string_L5
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
cool_str_concat:
			pushq	%rbp
			movq	%rsp, %rbp
			subq	$32, %rsp
			movq	%rdi, -24(%rbp)
			movq	%rsi, -32(%rbp)
			movq	-24(%rbp), %rax
			movq	%rax, %rdi
			call	strlen
			movl	%eax, -16(%rbp)
			movq	-32(%rbp), %rax
			movq	%rax, %rdi
			call	strlen
			movl	%eax, -12(%rbp)
			movl	-12(%rbp), %eax
			movl	-16(%rbp), %edx
			addl	%edx, %eax
			addl	$1, %eax
			cltq
			movq	%rax, %rdi
			call	malloc
			movq	%rax, -8(%rbp)
			movq	-24(%rbp), %rdx
			movq	-8(%rbp), %rax
			movq	%rdx, %rsi
			movq	%rax, %rdi
			call	strcpy
			movq	-32(%rbp), %rdx
			movq	-8(%rbp), %rax
			movq	%rdx, %rsi
			movq	%rax, %rdi
			call	strcat
			movq	-8(%rbp), %rax
			leave
			ret
cool_str_substr:
			pushq	%rbp
			movq	%rsp, %rbp
			pushq	%rbx
			subq	$24, %rsp
			movq	%rdi, -24(%rbp)
			movl	%esi, -28(%rbp)
			movl	%edx, -32(%rbp)
			cmpl	$0, -28(%rbp)
			js	.substr_L4
			movl	-32(%rbp), %eax
			movl	-28(%rbp), %edx
			addl	%edx, %eax
			movslq	%eax, %rbx
			movq	-24(%rbp), %rax
			movq	%rax, %rdi
			call	strlen
			cmpq	%rax, %rbx
			jbe	.substr_L5
.substr_L4:
			movq	$error.substr_range, %rdi
			call	raw_out_string
			movq	$0, %rax
			call	exit
.substr_L5:
			movl	-32(%rbp), %eax
			cltq
			movl	-28(%rbp), %edx
			movslq	%edx, %rcx
			movq	-24(%rbp), %rdx
			addq	%rcx, %rdx
			movq	%rax, %rsi
			movq	%rdx, %rdi
			call	strndup
			addq	$24, %rsp
			popq	%rbx
			popq	%rbp
			ret
			## ::::::::::::::::::::::::::::::::::::::::
			##  COMPARISONS
			## ::::::::::::::::::::::::::::::::::::::::

lt_helper:
			pushq	%rbp
			movq	%rsp, %rbp
			## get lhs and rhs pointers from stack
			## move lhs into %r8
			movq	16(%rbp), %r8
			## move rhs into %r9
			movq	24(%rbp), %r9
			## check for void pointers
			cmpq	$0, %r8
			je		cmp_lt_false
			cmpq	$0, %r9
			je		cmp_lt_false
			## move type tags into %r8 and %r9
			movq	(%r8), %r8
			movq	(%r9), %r9
			## check for different types
			cmpq	%r9, %r8
			jne		cmp_lt_false
			## check if lhs and rhs are Ints
			cmpq	$1, %r8
			je		cmp_lt_int
			## check if lhs and rhs are Bools
			cmpq	$0, %r8
			je		cmp_lt_bool
			## check if lhs and rhs are Strings
			cmpq	$4, %r8
			je		cmp_lt_string
			jmp		cmp_lt_false

			## compare Ints and Bools
cmp_lt_bool:
cmp_lt_int:
			movq	16(%rbp), %r8
			movq	24(%rbp), %r9
			movl	24(%r8), %r8d
			movl	24(%r9), %r9d
			cmpl	%r9d, %r8d
			jl		cmp_lt_true
			jmp		cmp_lt_false

			## compare Strings
cmp_lt_string:
			movq	16(%rbp), %r8
			movq	24(%rbp), %r9
			movq	24(%r8), %rdi
			movq	24(%r9), %rsi
			call	strcmp
			cmpl	$0, %eax
			jl		cmp_lt_true
			jmp		cmp_lt_false

			## make new true object in %rax
cmp_lt_true:
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self reg
			pushq	%rbx
			call	Bool..new
			## restore self reg
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	$1, 24(%rax)
			jmp		cmp_lt_end

			## make new false object in %rax
cmp_lt_false:
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self reg
			pushq	%rbx
			call	Bool..new
			## restore self reg
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			jmp		cmp_lt_end

cmp_lt_end:
			leave
			ret

le_helper:
			pushq	%rbp
			movq	%rsp, %rbp
			## get lhs and rhs pointers from stack
			## move lhs into %r8
			movq	16(%rbp), %r8
			## move rhs into %r9
			movq	24(%rbp), %r9
			## check for same pointer
			cmpq	%r9, %r8
			je		cmp_le_true
			## check for void pointers
			cmpq	$0, %r8
			je		cmp_le_false
			cmpq	$0, %r9
			je		cmp_le_false
			## move type tags into %r8 and %r9
			movq	(%r8), %r8
			movq	(%r9), %r9
			## check for different types
			cmpq	%r9, %r8
			jne		cmp_le_false
			## check if lhs and rhs are Ints
			cmpq	$1, %r8
			je		cmp_le_int
			## check if lhs and rhs are Bools
			cmpq	$0, %r8
			je		cmp_le_bool
			## check if lhs and rhs are Strings
			cmpq	$4, %r8
			je		cmp_le_string
			jmp		cmp_le_false

			## compare Ints and Bools
cmp_le_bool:
cmp_le_int:
			movq	16(%rbp), %r8
			movq	24(%rbp), %r9
			movl	24(%r8), %r8d
			movl	24(%r9), %r9d
			cmpl	%r9d, %r8d
			jle		cmp_le_true
			jmp		cmp_le_false

			## compare Strings
cmp_le_string:
			movq	16(%rbp), %r8
			movq	24(%rbp), %r9
			movq	24(%r8), %rdi
			movq	24(%r9), %rsi
			call	strcmp
			cmpl	$0, %eax
			jle		cmp_le_true
			jmp		cmp_le_false

			## make new true object in %rax
cmp_le_true:
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self reg
			pushq	%rbx
			call	Bool..new
			## restore self reg
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	$1, 24(%rax)
			jmp		cmp_le_end

			## make new false object in %rax
cmp_le_false:
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self reg
			pushq	%rbx
			call	Bool..new
			## restore self reg
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			jmp		cmp_le_end

cmp_le_end:
			leave
			ret

eq_helper:
			pushq	%rbp
			movq	%rsp, %rbp
			## get lhs and rhs pointers from stack
			## move lhs into %r8
			movq	16(%rbp), %r8
			## move rhs into %r9
			movq	24(%rbp), %r9
			## check for same pointer
			cmpq	%r9, %r8
			je		cmp_eq_true
			## check for void pointers
			cmpq	$0, %r8
			je		cmp_eq_false
			cmpq	$0, %r9
			je		cmp_eq_false
			## move type tags into %r8 and %r9
			movq	(%r8), %r8
			movq	(%r9), %r9
			## check for different types
			cmpq	%r9, %r8
			jne		cmp_eq_false
			## check if lhs and rhs are Ints
			cmpq	$1, %r8
			je		cmp_eq_int
			## check if lhs and rhs are Bools
			cmpq	$0, %r8
			je		cmp_eq_bool
			## check if lhs and rhs are Strings
			cmpq	$4, %r8
			je		cmp_eq_string
			jmp		cmp_eq_false

			## compare Ints and Bools
cmp_eq_bool:
cmp_eq_int:
			movq	16(%rbp), %r8
			movq	24(%rbp), %r9
			movl	24(%r8), %r8d
			movl	24(%r9), %r9d
			cmpl	%r9d, %r8d
			je		cmp_eq_true
			jmp		cmp_eq_false

			## compare Strings
cmp_eq_string:
			movq	16(%rbp), %r8
			movq	24(%rbp), %r9
			movq	24(%r8), %rdi
			movq	24(%r9), %rsi
			call	strcmp
			cmpl	$0, %eax
			je		cmp_eq_true
			jmp		cmp_eq_false

			## make new true object in %rax
cmp_eq_true:
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self reg
			pushq	%rbx
			call	Bool..new
			## restore self reg
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			movq	$1, 24(%rax)
			jmp		cmp_eq_end

			## make new false object in %rax
cmp_eq_false:
			pushq	%rcx
			pushq	%rdx
			pushq	%rsi
			pushq	%rdi
			pushq	%r8
			pushq	%r9
			pushq	%r10
			pushq	%r11
			## save self reg
			pushq	%rbx
			call	Bool..new
			## restore self reg
			popq	%rbx
			popq	%r11
			popq	%r10
			popq	%r9
			popq	%r8
			popq	%rdi
			popq	%rsi
			popq	%rdx
			popq	%rcx
			jmp		cmp_eq_end

cmp_eq_end:
			leave
			ret

