.section	.rodata
.int_fmt_string:
	.string "%d"
	.text
.global	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$60, %rsp
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
	movl	%r8d, %edi
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
	movl	%r8d, %r13d
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
	movl	%r8d, %r14d
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
	movl	%r8d, %r15d
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
	movl	%r8d, -60(%rbp)
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
	movl	%r8d, -56(%rbp)
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
	movl	%r8d, -52(%rbp)
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
	movl	%r8d, -48(%rbp)
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
	movl	%r8d, -44(%rbp)
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
	# store
	movl	%r8d, -8(%rbp)
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
	movl	%r8d, -20(%rbp)
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
	movl	%r8d, -16(%rbp)
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
	movl	%r8d, -4(%rbp)
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
	movl	%r8d, %ecx
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
	movl	%r8d, %ebx
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
	movl	%r8d, %esi
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
	movl	%r8d, %eax
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
	movl	%r8d, -24(%rbp)
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
	movl	%r8d, -28(%rbp)
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
	movl	%r8d, -32(%rbp)
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
	movl	%r8d, -36(%rbp)
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
	movl	%r8d, -40(%rbp)
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
	movl	%r8d, %r11d
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
	movl	%r8d, %r12d
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
	movl	%r8d, %r9d
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
	movl	%r8d, %r10d
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %edi
	# addition
	movl	%r8d, %r8d
	addl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r13d, %edi
	# addition
	movl	%r8d, %r8d
	addl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r14d, %edi
	# addition
	movl	%r8d, %r8d
	addl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %edi
	# assign
	movl	%r15d, %r8d
	# addition
	addl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%edi, %edi
	# subtraction
	movl	%r8d, %r8d
	subl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %edi
	# assign
	movl	%r13d, %r8d
	# subtraction
	subl	%edi, %r8d
	negl	%r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r14d, %edi
	# subtraction
	movl	%r8d, %r8d
	subl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r15d, %edi
	# subtraction
	movl	%r8d, %r8d
	subl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%edi, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r13d, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r14d, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r15d, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%edi, %edi
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%edi, 24(%rsp)
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r13d, %edi
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%edi, 24(%rsp)
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r14d, %edi
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%edi, 24(%rsp)
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %edi
	# assign
	movl	%r15d, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%edi, %eax
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$2, %r8d
	# assign
	movl	%edi, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$3, %edi
	# assign
	movl	%r13d, %r8d
	# addition
	addl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$4, %r8d
	# assign
	movl	%r14d, %edi
	# addition
	movl	%r8d, %r8d
	addl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$5, %r8d
	# assign
	movl	%r15d, %edi
	# addition
	movl	%r8d, %r8d
	addl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$6, %r8d
	# assign
	movl	%edi, %edi
	# subtraction
	movl	%r8d, %r8d
	subl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$7, %r8d
	# assign
	movl	%r13d, %edi
	# subtraction
	movl	%r8d, %r8d
	subl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$8, %r8d
	# assign
	movl	%r14d, %edi
	# subtraction
	movl	%r8d, %r8d
	subl	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$9, %edi
	# assign
	movl	%r15d, %r8d
	# subtraction
	subl	%edi, %r8d
	negl	%r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$10, %r8d
	# assign
	movl	%edi, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$11, %edi
	# assign
	movl	%r13d, %r8d
	# multiplication
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	# assign
	movl	%r14d, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$13, %r8d
	# assign
	movl	%r15d, %edi
	# multiplication
	movl	%r8d, %r8d
	imull	%edi, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$14, %r8d
	# assign
	movl	%edi, %edi
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%edi, 24(%rsp)
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$15, %r8d
	# assign
	movl	%r13d, %edi
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%edi, 24(%rsp)
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$16, %edi
	# assign
	movl	%r14d, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%edi, %eax
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	$17, %edi
	# assign
	movl	%r15d, %r8d
	# division
	subq	$8, %rsp
	pushq	%rdx
	pushq	%rax
	pushq	%rcx
	movl	%r8d, 24(%rsp)
	movl	%edi, %eax
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
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
	movl	%edi, %r8d
	# assign
	movl	%r13d, %r13d
	# addition
	movl	%r8d, %r8d
	addl	%r13d, %r8d
	# assign
	movl	%r14d, %r13d
	# addition
	movl	%r8d, %r8d
	addl	%r13d, %r8d
	# assign
	movl	%r15d, %r13d
	# addition
	addl	%r8d, %r13d
	# load
	movl	-60(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-56(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-52(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-48(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-44(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-12(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-8(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-20(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-16(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-4(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	addl	%r13d, %r8d
	# assign
	movl	%ecx, %r13d
	# addition
	movl	%r8d, %r8d
	addl	%r13d, %r8d
	# assign
	movl	%ebx, %r13d
	# addition
	addl	%r8d, %r13d
	# assign
	movl	%esi, %r8d
	# addition
	addl	%r13d, %r8d
	# assign
	movl	%edx, %r13d
	# addition
	movl	%r8d, %r8d
	addl	%r13d, %r8d
	# assign
	movl	%eax, %r13d
	# addition
	addl	%r8d, %r13d
	# load
	movl	-24(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-28(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-32(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-36(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# load
	movl	-40(%rbp), %r8d
	# assign
	movl	%r8d, %r8d
	# addition
	movl	%r13d, %r13d
	addl	%r8d, %r13d
	# assign
	movl	%r11d, %r8d
	# addition
	movl	%r13d, %r11d
	addl	%r8d, %r11d
	# assign
	movl	%r12d, %r8d
	# addition
	movl	%r11d, %r11d
	addl	%r8d, %r11d
	# assign
	movl	%r9d, %r8d
	# addition
	movl	%r11d, %r9d
	addl	%r8d, %r9d
	# assign
	movl	%r10d, %r8d
	# addition
	addl	%r9d, %r8d
	# assign
	movl	%r8d, %edi
	# assign
	movl	%edi, %r8d
	# assign
	movl	%edi, %r8d
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
