	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movl	$0, -4(%rbp)
	movl	$20, -24(%rbp)
	movl	$0, -28(%rbp)
	movslq	-24(%rbp), %rax
	shlq	$0, %rax
	movq	%rax, %rdi
	callq	_malloc
	movq	%rax, -16(%rbp)

in_string_l1:                                 ## =>This Inner Loop Header: Depth=1
	callq	_getchar
	movb	%al, %cl
	movb	%cl, -17(%rbp)
	movsbl	-17(%rbp), %eax
	cmpl	$10, %eax
	je	in_string_l2 
	movsbl	-17(%rbp), %eax
	cmpl	$-1, %eax
	jne	in_string_l3

in_string_l2:
	jmp	in_string_l4

in_string_l3:                          
	movb	-17(%rbp), %al
	movslq	-28(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movb	%al, (%rdx,%rcx)
	movl	-28(%rbp), %esi
	addl	$1, %esi
	movl	%esi, -28(%rbp)
	movsbl	-17(%rbp), %esi
	cmpl	$0, %esi
	jne	in_string_l5

	movl	$0, -28(%rbp)
	jmp	in_string_l4

in_string_l5:
	movl	-28(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	in_string_l6

	movl	-24(%rbp), %eax
	addl	$20, %eax
	movl	%eax, -24(%rbp)
	movq	-16(%rbp), %rdi
	movslq	-24(%rbp), %rcx
	shlq	$0, %rcx
	movq	%rcx, %rsi
	callq	_realloc
	movq	%rax, -16(%rbp)

in_string_l6:
	jmp	in_string_l1

in_string_l4:
	movq	-16(%rbp), %rdi
	movslq	-28(%rbp), %rsi
	callq	_strndup
	xorl	%ecx, %ecx
	movq	%rax, -16(%rbp)
	movl	%ecx, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
