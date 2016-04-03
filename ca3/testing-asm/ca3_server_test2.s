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
	# default
	movl	$0, %r11d
	# default
	movl	$0, %r10d
	# default
	movl	$0, %r9d
	# int init
	movl	$1, %r8d
	# assign
	movl	%r8d, %r11d
	# int init
	movl	$1, %r8d
	# assign
	movl	%r8d, %r11d
	# int init
	movl	$1, %r8d
	# assign
	movl	%r8d, %r11d
	# assign
	movl	%r11d, %r10d
	# int init
	movl	$1, %r8d
	# addition
	movl	%r10d, %r9d
	addl	%r8d, %r9d
	# assign
	movl	%r9d, %r10d
	# assign
	movl	%r11d, %r9d
	# int init
	movl	$1, %r10d
	# addition
	movl	%r9d, %r8d
	addl	%r10d, %r8d
	# assign
	movl	%r8d, %r10d
	# assign
	movl	%r11d, %r10d
	# int init
	movl	$1, %r9d
	# addition
	movl	%r10d, %r8d
	addl	%r9d, %r8d
	# assign
	movl	%r8d, %r10d
	# int init
	movl	$3, %r8d
	# assign
	movl	%r8d, %r9d
	# int init
	movl	$3, %r8d
	# assign
	movl	%r8d, %r9d
	# int init
	movl	$3, %r8d
	# assign
	movl	%r8d, %r9d
	# assign
	movl	%r10d, %r9d
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
	movl	%r9d, %esi
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
	movl	%r8d, %r9d
	movl	%r9d, %eax
	leave
	ret
