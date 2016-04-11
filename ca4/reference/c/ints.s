	.file	"ints.c"
	.section	.rodata
.LC0:
	.string	"%d"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	pushq	%rbp
	movq	%rsp, %rbp

	subq	$16, %rsp

	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	
	xorl	%eax, %eax
	leaq	-12(%rbp), %rax

	movq	%rax, %rsi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	__isoc99_scanf
	movl	-12(%rbp), %eax

	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	movl	$0, %eax

	movq	-8(%rbp), %rdx
	leave
	ret
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 5.2.1-22ubuntu2) 5.2.1 20151010"
	.section	.note.GNU-stack,"",@progbits
