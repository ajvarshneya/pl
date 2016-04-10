###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;; VIRTUAL METHOD TABLES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl Bool..vtable
Bool..vtable:
			# Virtual function table for Bool
			.quad Bool..string
			.quad Bool..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
.globl IO..vtable
IO..vtable:
			# Virtual function table for IO
			.quad IO..string
			.quad IO..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
			.quad IO.in_int
			.quad IO.in_string
			.quad IO.out_int
			.quad IO.out_string
.globl Int..vtable
Int..vtable:
			# Virtual function table for Int
			.quad Int..string
			.quad Int..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
.globl Main..vtable
Main..vtable:
			# Virtual function table for Main
			.quad Main..string
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
Object..vtable:
			# Virtual function table for Object
			.quad Object..string
			.quad Object..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
.globl String..vtable
String..vtable:
			# Virtual function table for String
			.quad String..string
			.quad String..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
			.quad String.concat
			.quad String.length
			.quad String.substr

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CONSTRUCTORS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl Bool..new
Bool..new:
			# Constructor for Bool
			pushq %rbp
			movq %rsp, %rbp

			# Allocate $4 bytes on heap
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			movq $4, %rdi
			movq $8, %rsi
			call calloc
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $0, %rax
			movq %rax, 0(%rbx)
			movq $4, %rax
			movq %rax, 8(%rbx)
			movq $Bool..vtable, %rax
			movq %rax, 16(%rbx)
			movl $0, 24(%rbx)
			movq %rbx, %rax

Bool_attr_init:

			# Pop callee saved registers
			popq %r12
			popq %r13
			popq %r14
			popq %r15
			leave
			ret

.globl IO..new
IO..new:
			# Constructor for IO
			pushq %rbp
			movq %rsp, %rbp

			# Allocate $3 bytes on heap
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			movq $3, %rdi
			movq $8, %rsi
			call calloc
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $2, %rax
			movq %rax, 0(%rbx)
			movq $3, %rax
			movq %rax, 8(%rbx)
			movq $IO..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

IO_attr_init:

			# Pop callee saved registers
			popq %r12
			popq %r13
			popq %r14
			popq %r15
			leave
			ret

.globl Int..new
Int..new:
			# Constructor for Int
			pushq %rbp
			movq %rsp, %rbp

			# Allocate $4 bytes on heap
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			movq $4, %rdi
			movq $8, %rsi
			call calloc
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $1, %rax
			movq %rax, 0(%rbx)
			movq $4, %rax
			movq %rax, 8(%rbx)
			movq $Int..vtable, %rax
			movq %rax, 16(%rbx)
			movl $0, 24(%rbx)
			movq %rbx, %rax

Int_attr_init:

			# Pop callee saved registers
			popq %r12
			popq %r13
			popq %r14
			popq %r15
			leave
			ret

.globl Main..new
Main..new:
			# Constructor for Main
			pushq %rbp
			movq %rsp, %rbp

			# Allocate $10 bytes on heap
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			movq $10, %rdi
			movq $8, %rsi
			call calloc
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $5, %rax
			movq %rax, 0(%rbx)
			movq $10, %rax
			movq %rax, 8(%rbx)
			movq $Main..vtable, %rax
			movq %rax, 16(%rbx)
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, 24(%rbx)
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, 32(%rbx)
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, 40(%rbx)
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, 48(%rbx)
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, 56(%rbx)
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, 64(%rbx)
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, 72(%rbx)
			movq %rbx, %rax

Main_attr_init:
			# Initialize integer, 111
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $111, 24(%r8)
			# Storing b
			movq %r8, 32(%rbx)
			# Initialize integer, 2222
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $2222, 24(%r8)
			# Storing c
			movq %r8, 40(%rbx)
			# Initialize integer, 44
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $44, 24(%r8)
			# Storing d
			movq %r8, 48(%rbx)
			# Initialize integer, 4444
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $4444, 24(%r8)
			# Storing x
			movq %r8, 56(%rbx)
			# Initialize integer, 10928310
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $10928310, 24(%r8)
			# Storing y
			movq %r8, 64(%rbx)
			# Initialize integer, 88
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $88, 24(%r8)
			# Storing z
			movq %r8, 72(%rbx)

			# Pop callee saved registers
			popq %r12
			popq %r13
			popq %r14
			popq %r15
			leave
			ret

.globl Object..new
Object..new:
			# Constructor for Object
			pushq %rbp
			movq %rsp, %rbp

			# Allocate $3 bytes on heap
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			movq $3, %rdi
			movq $8, %rsi
			call calloc
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $3, %rax
			movq %rax, 0(%rbx)
			movq $3, %rax
			movq %rax, 8(%rbx)
			movq $Object..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

Object_attr_init:

			# Pop callee saved registers
			popq %r12
			popq %r13
			popq %r14
			popq %r15
			leave
			ret

.globl String..new
String..new:
			# Constructor for String
			pushq %rbp
			movq %rsp, %rbp

			# Allocate $4 bytes on heap
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			movq $4, %rdi
			movq $8, %rsi
			call calloc
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $4, %rax
			movq %rax, 0(%rbx)
			movq $4, %rax
			movq %rax, 8(%rbx)
			movq $String..vtable, %rax
			movq %rax, 16(%rbx)
			movq empty.string, %rax
			movq %rax, 24(%rbx)
			movq %rbx, %rax

String_attr_init:

			# Pop callee saved registers
			popq %r12
			popq %r13
			popq %r14
			popq %r15
			leave
			ret


###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;; METHOD DEFINITIONS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl IO.in_int
IO.in_int:
			# Method definition for IO.in_int
			ret
.globl IO.in_string
IO.in_string:
			# Method definition for IO.in_string
			ret
.globl IO.out_int
IO.out_int:
			# Method definition for IO.out_int
			ret
.globl IO.out_string
IO.out_string:
			# Method definition for IO.out_string
			ret
.globl Main.main
Main.main:
			# Method definition for Main.main
			pushq %rbp
			movq %rsp, %rbp

Main_main_0:
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r11
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r13
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r12
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r14
			# Initialize integer, 2
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $2, 24(%r8)
			# Initialize integer, 3
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r10
			# Move value into box, save object pointer
			movl $3, 24(%r10)
			# Unboxing t$24
			movq 24(%r8), %r9
			# Unboxing t$25
			movq 24(%r10), %r8
			# multiplication
			movl %r9d, %r10d
			imull %r8d, %r10d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$26
			movl %r10d, 24(%rax)
			movq %rax, %r11
			# Initialize integer, 4
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r9
			# Move value into box, save object pointer
			movl $4, 24(%r9)
			# Initialize integer, 2
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $2, 24(%r8)
			# Unboxing t$38
			movq 24(%r9), %r10
			# Unboxing t$39
			movq 24(%r8), %r9
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r9d, 24(%rsp)
			movl %r10d, %eax
			cltd
			movl 24(%rsp), %ecx
			idivl %ecx
			movl %eax, 28(%rsp)
			popq %rcx
			popq %rax
			popq %rdx
			movl 4(%rsp), %r8d
			addq $8, %rsp
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$40
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# Initialize integer, 123
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $123, 24(%r8)
			# Unboxing t$34
			movq 24(%r9), %r10
			# Unboxing t$35
			movq 24(%r8), %r9
			# multiplication
			movl %r10d, %r8d
			imull %r9d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$36
			movl %r8d, 24(%rax)
			movq %rax, %r10
			# Initialize integer, 8
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $8, 24(%r8)
			# Unboxing t$30
			movq 24(%r10), %r9
			# Unboxing t$31
			movq 24(%r8), %r10
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r10d, 24(%rsp)
			movl %r9d, %eax
			cltd
			movl 24(%rsp), %ecx
			idivl %ecx
			movl %eax, 28(%rsp)
			popq %rcx
			popq %rax
			popq %rdx
			movl 4(%rsp), %r8d
			addq $8, %rsp
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$32
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# Unboxing t$20
			movq 24(%r11), %r10
			# Unboxing t$21
			movq 24(%r9), %r8
			# addition
			movl %r10d, %r11d
			addl %r8d, %r11d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$22
			movl %r11d, 24(%rax)
			movq %rax, %r9
			# Initialize integer, 4
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $4, 24(%r8)
			# Unboxing t$16
			movq 24(%r9), %r10
			# Unboxing t$17
			movq 24(%r8), %r9
			# addition
			movl %r10d, %r8d
			addl %r9d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$18
			movl %r8d, 24(%rax)
			movq %rax, %r11
			# Initialize integer, 234
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $234, 24(%r8)
			# Initialize integer, 2
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r9
			# Move value into box, save object pointer
			movl $2, 24(%r9)
			# Unboxing t$47
			movq 24(%r8), %r10
			# Unboxing t$48
			movq 24(%r9), %r8
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r8d, 24(%rsp)
			movl %r10d, %eax
			cltd
			movl 24(%rsp), %ecx
			idivl %ecx
			movl %eax, 28(%rsp)
			popq %rcx
			popq %rax
			popq %rdx
			movl 4(%rsp), %r9d
			addq $8, %rsp
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$49
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# Unboxing t$12
			movq 24(%r11), %r9
			# Unboxing t$13
			movq 24(%r8), %r10
			# subtraction
			movl %r9d, %r8d
			subl %r10d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$14
			movl %r8d, 24(%rax)
			movq %rax, %r10
			# Initialize integer, 1
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $1, 24(%r8)
			# Unboxing t$8
			movq 24(%r10), %r9
			# Unboxing t$9
			movq 24(%r8), %r10
			# addition
			movl %r9d, %r8d
			addl %r10d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$10
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# Unboxing t$5
			movq 24(%r9), %r8
			# negate
			movl %r8d, %r9d
			negl %r9d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$6
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r8, %r11
			# assign
			movq %r11, %r9
			# assign
			movq %r13, %r8
			# Unboxing t$58
			movq 24(%r9), %r10
			# Unboxing t$59
			movq 24(%r8), %r13
			# subtraction
			movl %r10d, %r9d
			subl %r13d, %r9d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$60
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r12, %r9
			# assign
			movq %r14, %r13
			# Unboxing t$64
			movq 24(%r9), %r10
			# Unboxing t$65
			movq 24(%r13), %r9
			# multiplication
			movl %r10d, %r13d
			imull %r9d, %r13d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$66
			movl %r13d, 24(%rax)
			movq %rax, %r9
			# Unboxing t$54
			movq 24(%r8), %r10
			# Unboxing t$55
			movq 24(%r9), %r8
			# addition
			movl %r10d, %r9d
			addl %r8d, %r9d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$56
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r8, %r13
			# assign
			movq %r11, %r8
			# assign
			movq %r13, %r9
			# Unboxing t$70
			movq 24(%r8), %r10
			# Unboxing t$71
			movq 24(%r9), %r11
			# addition
			movl %r10d, %r8d
			addl %r11d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$72
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# assign
			movq %r9, %r11
			# Initialize integer, 8888
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r9
			# Move value into box, save object pointer
			movl $8888, 24(%r9)
			# Initialize integer, 8
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $8, 24(%r8)
			# Unboxing t$84
			movq 24(%r9), %r13
			# Unboxing t$85
			movq 24(%r8), %r10
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r10d, 24(%rsp)
			movl %r13d, %eax
			cltd
			movl 24(%rsp), %ecx
			idivl %ecx
			movl %eax, 28(%rsp)
			popq %rcx
			popq %rax
			popq %rdx
			movl 4(%rsp), %r9d
			addq $8, %rsp
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$86
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# Initialize integer, 333
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r13
			# Move value into box, save object pointer
			movl $333, 24(%r13)
			# Unboxing t$80
			movq 24(%r8), %r10
			# Unboxing t$81
			movq 24(%r13), %r9
			# addition
			movl %r10d, %r8d
			addl %r9d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$82
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# Initialize integer, 111
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $111, 24(%r8)
			# Initialize integer, 2
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r10
			# Move value into box, save object pointer
			movl $2, 24(%r10)
			# Unboxing t$95
			movq 24(%r8), %r13
			# Unboxing t$96
			movq 24(%r10), %r8
			# multiplication
			movl %r13d, %r10d
			imull %r8d, %r10d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$97
			movl %r10d, 24(%rax)
			movq %rax, %r8
			# Initialize integer, 2
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r10
			# Move value into box, save object pointer
			movl $2, 24(%r10)
			# Unboxing t$91
			movq 24(%r8), %r13
			# Unboxing t$92
			movq 24(%r10), %r8
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r8d, 24(%rsp)
			movl %r13d, %eax
			cltd
			movl 24(%rsp), %ecx
			idivl %ecx
			movl %eax, 28(%rsp)
			popq %rcx
			popq %rax
			popq %rdx
			movl 4(%rsp), %r10d
			addq $8, %rsp
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$93
			movl %r10d, 24(%rax)
			movq %rax, %r13
			# Unboxing t$76
			movq 24(%r9), %r8
			# Unboxing t$77
			movq 24(%r13), %r9
			# subtraction
			movl %r8d, %r10d
			subl %r9d, %r10d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$78
			movl %r10d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r8, %r13
			# assign
			movq %r11, %r8
			# assign
			movq %r13, %r9
			# Unboxing t$110
			movq 24(%r8), %r10
			# Unboxing t$111
			movq 24(%r9), %r8
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r8d, 24(%rsp)
			movl %r10d, %eax
			cltd
			movl 24(%rsp), %ecx
			idivl %ecx
			movl %eax, 28(%rsp)
			popq %rcx
			popq %rax
			popq %rdx
			movl 4(%rsp), %r9d
			addq $8, %rsp
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$112
			movl %r9d, 24(%rax)
			movq %rax, %r10
			# assign
			movq %r12, %r9
			# Initialize integer, 4
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r12
			# Move value into box, save object pointer
			movl $4, 24(%r12)
			# Unboxing t$116
			movq 24(%r9), %r8
			# Unboxing t$117
			movq 24(%r12), %r9
			# multiplication
			movl %r8d, %r12d
			imull %r9d, %r12d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$118
			movl %r12d, 24(%rax)
			movq %rax, %r8
			# Unboxing t$106
			movq 24(%r10), %r12
			# Unboxing t$107
			movq 24(%r8), %r9
			# addition
			movl %r12d, %r8d
			addl %r9d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$108
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# Initialize integer, 11111
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $11111, 24(%r8)
			# Unboxing t$102
			movq 24(%r9), %r12
			# Unboxing t$103
			movq 24(%r8), %r10
			# subtraction
			movl %r12d, %r9d
			subl %r10d, %r9d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$104
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r8, %r12
			# Initialize integer, 22334235
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r10
			# Move value into box, save object pointer
			movl $22334235, 24(%r10)
			# Initialize integer, 1111
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r9
			# Move value into box, save object pointer
			movl $1111, 24(%r9)
			# Unboxing t$139
			movq 24(%r10), %r8
			# Unboxing t$140
			movq 24(%r9), %r10
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r10d, 24(%rsp)
			movl %r8d, %eax
			cltd
			movl 24(%rsp), %ecx
			idivl %ecx
			movl %eax, 28(%rsp)
			popq %rcx
			popq %rax
			popq %rdx
			movl 4(%rsp), %r9d
			addq $8, %rsp
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$141
			movl %r9d, 24(%rax)
			movq %rax, %r10
			# Initialize integer, 8
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $8, 24(%r8)
			# Unboxing t$135
			movq 24(%r10), %r9
			# Unboxing t$136
			movq 24(%r8), %r10
			# addition
			movl %r9d, %r8d
			addl %r10d, %r8d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$137
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# assign
			movq %r12, %r14
			# Unboxing t$131
			movq 24(%r9), %r10
			# Unboxing t$132
			movq 24(%r14), %r8
			# subtraction
			movl %r10d, %r9d
			subl %r8d, %r9d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$133
			movl %r9d, 24(%rax)
			movq %rax, %r10
			# assign
			movq %r11, %r9
			# Unboxing t$127
			movq 24(%r10), %r8
			# Unboxing t$128
			movq 24(%r9), %r10
			# addition
			movl %r8d, %r9d
			addl %r10d, %r9d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$129
			movl %r9d, 24(%rax)
			movq %rax, %r10
			# assign
			movq %r13, %r9
			# Unboxing t$123
			movq 24(%r10), %r8
			# Unboxing t$124
			movq 24(%r9), %r10
			# addition
			movl %r8d, %r9d
			addl %r10d, %r9d
			# Push caller saved registers
			pushq %rbx
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
			call Int..new
			# Pop caller saved registers
			popq %r11
			popq %r10
			popq %r9
			popq %r8
			popq %rdi
			popq %rsi
			popq %rdx
			popq %rcx
			popq %rbx
			# Boxing t$125
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r8, %r14
			# assign
			movq %r14, %r8
			movq %r8, %rax
			leave
			ret
.globl Object.abort
Object.abort:
			# Method definition for Object.abort
			ret
.globl Object.copy
Object.copy:
			# Method definition for Object.copy
			ret
.globl Object.type_name
Object.type_name:
			# Method definition for Object.type_name
			ret
.globl String.concat
String.concat:
			# Method definition for String.concat
			ret
.globl String.length
String.length:
			# Method definition for String.length
			ret
.globl String.substr
String.substr:
			# Method definition for String.substr
			ret

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;; STRING CONSTANTS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl Bool..string
Bool..string:
			.string "Bool"

.globl IO..string
IO..string:
			.string "IO"

.globl Int..string
Int..string:
			.string "Int"

.globl Main..string
Main..string:
			.string "Main"

.globl Object..string
Object..string:
			.string "Object"

.globl String..string
String..string:
			.string "String"

.global empty.string
empty.string:
			.string "" 


###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPARISON HANDLERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; START ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl start
start:
			# Program begins here
			.globl main
			.type main, @function
main:
			call Main..new
			call Main.main
			call exit
