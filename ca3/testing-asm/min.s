.section	.rodata
.int_fmt_string:
	.string "%d"
	.text
.global	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
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
	movl	%r9d, %r11d
	# assign
	movl	%r10d, %r8d
	# less than
	cmpl	%r8d, %r11d
	movl	$1, %r11d
	jl	asm_label_4
	movl	$0, %r11d
asm_label_4:
	# not
	movl	%r11d, %r8d
	xorl	$1, %r8d
	# branch
	cmpl	$1, %r11d
	je	if_then_1
	# branch
	cmpl	$1, %r8d
	je	if_else_2
if_then_1:
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
	jmp	if_fi_3
if_else_2:
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
	jmp	if_fi_3
if_fi_3:
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	movl	%r8d, %eax
	leave
	ret
