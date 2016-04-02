.section	.rodata
.int_fmt_string:
	.string "%d"
	.text
.global	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$44, %rsp
Main_main_0:
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r8d
	addq	$4, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -4(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r8d
	addq	$4, %rsp
	# assign
	movl	%r8d, %r8d
	# store
	movl	%r8d, -12(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r8d
	addq	$4, %rsp
	# assign
	movl	%r8d, %r8d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %esi
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %ecx
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r10d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r8d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r11d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r12d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r15d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %eax
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r13d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r14d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %ebx
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %edx
	# store
	movl	%edx, -44(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %r9d
	addq	$4, %rsp
	# assign
	movl	%r9d, %r9d
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -40(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -36(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -32(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -28(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -16(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -24(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -20(%rbp)
	# in_int
	subq	$4, %rsp
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	leaq	72(%rsp), %rsi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	movl	(%rsp), %edx
	addq	$4, %rsp
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -8(%rbp)
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %edx
	# assign
	movl	%r8d, %edi
	# addition
	movl	%edx, %edx
	addl	%edi, %edx
	# assign
	movl	%edx, %edx
	# store
	movl	%edx, -4(%rbp)
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %edx
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%edx, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%edx, %r8d
	# assign
	movl	%r8d, %edx
	# assign
	movl	%esi, %r8d
	# subtraction
	subl	%edx, %r8d
	negl	%r8d
	# assign
	movl	%r8d, %r8d
	# store
	movl	%r8d, -12(%rbp)
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%esi, %edx
	# assign
	movl	%ecx, %r8d
	# multiplication
	imull	%edx, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%ecx, %r8d
	# assign
	movl	%r10d, %edx
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%edx, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %esi
	# assign
	movl	%esi, %r8d
	# assign
	movl	%esi, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$12324509, %r8d
	# assign
	movl	%r10d, %edx
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%edx, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %esi
	# assign
	movl	%esi, %r8d
	# assign
	movl	%esi, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%ecx, %r8d
	# assign
	movl	%ecx, %ecx
	# addition
	movl	%r8d, %r8d
	addl	%ecx, %r8d
	# assign
	movl	%r8d, %ecx
	# assign
	movl	%ecx, %r8d
	# assign
	movl	%ecx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r10d, %edx
	# assign
	movl	%r10d, %r10d
	# int init
	movl	$0, %r8d
	# multiplication
	imull	%r10d, %r8d
	# addition
	addl	%edx, %r8d
	# assign
	movl	%r8d, %r10d
	# assign
	movl	%r10d, %r8d
	# assign
	movl	%r10d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r11d, %r8d
	# int init
	movl	$0, %r10d
	# subtraction
	movl	%r8d, %r8d
	subl	%r10d, %r8d
	# assign
	movl	%r15d, %r10d
	# multiplication
	movl	%r8d, %r8d
	imull	%r10d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r12d, %r10d
	# assign
	movl	%r15d, %r8d
	# addition
	movl	%r10d, %r10d
	addl	%r8d, %r10d
	# assign
	movl	%eax, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r10d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %r11d
	# assign
	movl	%r11d, %r8d
	# assign
	movl	%r11d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$111, %r10d
	# assign
	movl	%ecx, %r8d
	# addition
	addl	%r10d, %r8d
	# assign
	movl	%r8d, %ecx
	# assign
	movl	%ecx, %r8d
	# assign
	movl	%ecx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$222, %ecx
	# int init
	movl	$444, %r8d
	# int init
	movl	$0, %r10d
	# multiplication
	movl	%r8d, %r8d
	imull	%r10d, %r8d
	# addition
	addl	%ecx, %r8d
	# assign
	movl	%r8d, %r10d
	# assign
	movl	%r10d, %r8d
	# assign
	movl	%r10d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r11d, %r8d
	# int init
	movl	$0, %r10d
	# subtraction
	movl	%r8d, %r8d
	subl	%r10d, %r8d
	# int init
	movl	$333, %r10d
	# multiplication
	movl	%r8d, %r8d
	imull	%r10d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r12d, %r8d
	# assign
	movl	%r15d, %r10d
	# addition
	movl	%r8d, %r8d
	addl	%r10d, %r8d
	# int init
	movl	$2, %r10d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r10d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %r11d
	# assign
	movl	%r11d, %r8d
	# assign
	movl	%r11d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$0, %r8d
	# negate
	movl	%r8d, %r8d
	negl	%r8d
	# int init
	movl	$0, %r10d
	# assign
	movl	%r13d, %r11d
	# addition
	movl	%r10d, %r10d
	addl	%r11d, %r10d
	# addition
	movl	%r8d, %r8d
	addl	%r10d, %r8d
	# assign
	movl	%r8d, %r12d
	# assign
	movl	%r12d, %r8d
	# assign
	movl	%r12d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%eax, %r8d
	# assign
	movl	%r13d, %r10d
	# addition
	addl	%r8d, %r10d
	# assign
	movl	%r14d, %r8d
	# subtraction
	subl	%r10d, %r8d
	negl	%r8d
	# assign
	movl	%r8d, %r15d
	# assign
	movl	%r15d, %r8d
	# assign
	movl	%r15d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r13d, %r8d
	# negate
	movl	%r8d, %r10d
	negl	%r10d
	# assign
	movl	%r14d, %r8d
	# assign
	movl	%ebx, %r11d
	# multiplication
	movl	%r8d, %r8d
	imull	%r11d, %r8d
	# addition
	addl	%r10d, %r8d
	# assign
	movl	%r8d, %eax
	# assign
	movl	%eax, %r8d
	# assign
	movl	%eax, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r14d, %r10d
	# assign
	movl	%ebx, %r8d
	# addition
	addl	%r10d, %r8d
	# load
	movl	-44(%rbp), %edx
	# assign
	movl	%edx, %r10d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r10d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %r13d
	# assign
	movl	%r13d, %r8d
	# assign
	movl	%r13d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%ebx, %r10d
	# load
	movl	-44(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# negate
	movl	%r8d, %r8d
	negl	%r8d
	# subtraction
	subl	%r10d, %r8d
	negl	%r8d
	# assign
	movl	%r9d, %r10d
	# addition
	movl	%r8d, %r8d
	addl	%r10d, %r8d
	# assign
	movl	%r8d, %r14d
	# assign
	movl	%r14d, %r8d
	# assign
	movl	%r14d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-44(%rbp), %edx
	# assign
	movl	%edx, %r10d
	# assign
	movl	%r9d, %r8d
	# subtraction
	movl	%r10d, %r9d
	subl	%r8d, %r9d
	# load
	movl	-40(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# subtraction
	subl	%r9d, %r8d
	negl	%r8d
	# assign
	movl	%r8d, %ebx
	# assign
	movl	%ebx, %r8d
	# assign
	movl	%ebx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$0, %r10d
	# int init
	movl	$0, %r8d
	# negate
	movl	%r8d, %r9d
	negl	%r9d
	# load
	movl	-36(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# multiplication
	imull	%r9d, %r8d
	# subtraction
	subl	%r10d, %r8d
	negl	%r8d
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -44(%rbp)
	# load
	movl	-44(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-44(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-40(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# load
	movl	-36(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# negate
	movl	%r8d, %r10d
	negl	%r10d
	# load
	movl	-32(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r10d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# subtraction
	subl	%r9d, %r8d
	negl	%r8d
	# assign
	movl	%r8d, %r9d
	# assign
	movl	%r9d, %r8d
	# assign
	movl	%r9d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-36(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-32(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# load
	movl	-28(%rbp), %edx
	# assign
	movl	%edx, %r10d
	# addition
	movl	%r9d, %r9d
	addl	%r10d, %r9d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r9d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -40(%rbp)
	# load
	movl	-40(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-40(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-32(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-28(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# multiplication
	movl	%r8d, %r8d
	imull	%r9d, %r8d
	# load
	movl	-16(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# subtraction
	movl	%r8d, %r8d
	subl	%r9d, %r8d
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -36(%rbp)
	# load
	movl	-36(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-36(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-28(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-16(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# load
	movl	-24(%rbp), %edx
	# assign
	movl	%edx, %r10d
	# multiplication
	movl	%r9d, %r9d
	imull	%r10d, %r9d
	# multiplication
	movl	%r8d, %r8d
	imull	%r9d, %r8d
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -32(%rbp)
	# load
	movl	-32(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-32(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-16(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# load
	movl	-24(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# multiplication
	movl	%r9d, %r9d
	imull	%r8d, %r9d
	# load
	movl	-20(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r9d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -28(%rbp)
	# load
	movl	-28(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-28(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-20(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r9d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# addition
	movl	%r8d, %r8d
	addl	%r9d, %r8d
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -16(%rbp)
	# load
	movl	-16(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-16(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r9d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r9d
	addq	$8, %rsp
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# multiplication
	imull	%r9d, %r8d
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -20(%rbp)
	# load
	movl	-20(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-20(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# int init
	movl	$4, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r9d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -8(%rbp)
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$123, %r9d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r9d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -8(%rbp)
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-16(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r9d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r9d
	addq	$8, %rsp
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# multiplication
	imull	%r9d, %r8d
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -20(%rbp)
	# load
	movl	-20(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-20(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# int init
	movl	$4, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r9d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -8(%rbp)
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$123, %r9d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r9d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -8(%rbp)
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-8(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$12, %r8d
	# int init
	movl	$4, %r9d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r9d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -4(%rbp)
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# int init
	movl	$3, %r8d
	# int init
	movl	$12, %r9d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r9d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# assign
	movl	%r8d, %r8d
	# store
	movl	%r8d, -12(%rbp)
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# multiplication
	movl	%r8d, %r8d
	imull	%r9d, %r8d
	# int init
	movl	$3, %r10d
	# int init
	movl	$2, %r9d
	# addition
	addl	%r10d, %r9d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r9d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r9d
	addq	$8, %rsp
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%r9d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r9d
	addq	$8, %rsp
	# int init
	movl	$6, %r8d
	# subtraction
	movl	%r9d, %r9d
	subl	%r8d, %r9d
	# int init
	movl	$1234, %r8d
	# addition
	movl	%r9d, %r10d
	addl	%r8d, %r10d
	# int init
	movl	$2, %r8d
	# int init
	movl	$3, %r9d
	# multiplication
	movl	%r8d, %r8d
	imull	%r9d, %r8d
	# subtraction
	movl	%r10d, %r10d
	subl	%r8d, %r10d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# multiplication
	movl	%r8d, %r8d
	imull	%r9d, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r9d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r9d, 24(%rsp)
	movl	%r8d, %eax
	cltd
	movl	24(%rsp), %ecx
	idivl	%ecx
	movl	%eax, 28(%rsp)
	popq	%rcx
	popq	%rax
	popq	%rdx
	movl	4(%rsp), %r8d
	addq	$8, %rsp
	# addition
	addl	%r10d, %r8d
	# assign
	movl	%r8d, %edx
	# store
	movl	%edx, -4(%rbp)
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# load
	movl	-4(%rbp), %edx
	# assign
	movl	%edx, %r8d
	# out_int
	pushq	%rax
	pushq	%rcx
	pushq	%rdx
	pushq	%rsi
	pushq	%rdi
	pushq	%r8
	pushq	%r9
	pushq	%r10
	pushq	%r11
	movl	%r8d, %esi
	movl	$.int_fmt_string, %edi
	movl	$0, %eax
	call	printf
	popq	%r11
	popq	%r10
	popq	%r9
	popq	%r8
	popq	%rdi
	popq	%rsi
	popq	%rdx
	popq	%rcx
	popq	%rax
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	movl	%r8d, %eax
	leave
	ret
