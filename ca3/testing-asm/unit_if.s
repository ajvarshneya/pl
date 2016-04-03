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
	# int init
	movl	$1, %r8d
	# assign
	movl	%r8d, %r9d
	# int init
	movl	$2, %r8d
	# assign
	movl	%r8d, %r8d
	# default
	movl	$0, %r8d
	# bool init
	movl	$1, %r10d
	# not
	movl	%r10d, %r8d
	xorl	$1, %r8d
	# branch
	cmpl	$1, %r10d
	je	if_then_1
	# branch
	cmpl	$1, %r8d
	je	if_else_2
if_then_1:
	# assign
	movl	%r9d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	jmp	if_fi_3
if_else_2:
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	jmp	if_fi_3
if_fi_3:
	# assign
	movl	%r8d, %r8d
	# assign
	movl	%r8d, %r8d
	movl	%r8d, %eax
	leave
	ret
