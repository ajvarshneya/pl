###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;; VIRTUAL METHOD TABLES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl Bool..vtable
Bool..vtable:
			# Virtual function table for Bool
			.quad string_constant..Bool
			.quad Bool..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
.globl IO..vtable
IO..vtable:
			# Virtual function table for IO
			.quad string_constant..IO
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
			.quad string_constant..Int
			.quad Int..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
.globl Main..vtable
Main..vtable:
			# Virtual function table for Main
			.quad string_constant..Main
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
			.quad string_constant..Object
			.quad Object..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
.globl String..vtable
String..vtable:
			# Virtual function table for String
			.quad string_constant..String
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
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
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
Bool_attr_init:
			# Attribute initializations for Bool
			movq %rbx, %rax
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl IO..new
IO..new:
			# Constructor for IO
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
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
IO_attr_init:
			# Attribute initializations for IO
			movq %rbx, %rax
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl Int..new
Int..new:
			# Constructor for Int
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
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
Int_attr_init:
			# Attribute initializations for Int
			movq %rbx, %rax
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl Main..new
Main..new:
			# Constructor for Main
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
			# Allocate $17 bytes on heap
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
			movq $17, %rdi
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
			movq $17, %rax
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
			movq %rax, 80(%rbx)
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
			movq %rax, 88(%rbx)
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
			movq %rax, 96(%rbx)
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
			movq %rax, 104(%rbx)
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
			movq %rax, 112(%rbx)
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
			movq %rax, 120(%rbx)
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
			movq %rax, 128(%rbx)
Main_attr_init:
			# Attribute initializations for Main
			# Start of attribute init Main_b
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
			# Move 1 into box
			movl $1, 24(%r8)
			# Storing attribute b
			movq %r8, 32(%rbx)
			# End of attribute init Main_b
			# Start of attribute init Main_c
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
			# Move 2 into box
			movl $2, 24(%r8)
			# Storing attribute c
			movq %r8, 40(%rbx)
			# End of attribute init Main_c
			# Start of attribute init Main_d
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
			# Move 4 into box
			movl $4, 24(%r8)
			# Storing attribute d
			movq %r8, 48(%rbx)
			# End of attribute init Main_d
			# Start of attribute init Main_e
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
			# Move 2 into box
			movl $2, 24(%r8)
			# Storing attribute e
			movq %r8, 56(%rbx)
			# End of attribute init Main_e
			# Start of attribute init Main_f
			# Initialize integer, 0
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
			# Move 0 into box
			movl $0, 24(%r8)
			# Storing attribute f
			movq %r8, 64(%rbx)
			# End of attribute init Main_f
			# Start of attribute init Main_g
			# Initialize integer, 0
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
			# Move 0 into box
			movl $0, 24(%r8)
			# Storing attribute g
			movq %r8, 72(%rbx)
			# End of attribute init Main_g
			# Start of attribute init Main_h
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
			movq %rax, %r8
			# Move 3 into box
			movl $3, 24(%r8)
			# Storing attribute h
			movq %r8, 80(%rbx)
			# End of attribute init Main_h
			# Start of attribute init Main_j
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
			movq %rax, %r8
			# Move 3 into box
			movl $3, 24(%r8)
			# Storing attribute j
			movq %r8, 96(%rbx)
			# End of attribute init Main_j
			# Start of attribute init Main_k
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
			# Move 2 into box
			movl $2, 24(%r8)
			# Storing attribute k
			movq %r8, 104(%rbx)
			# End of attribute init Main_k
			# Start of attribute init Main_y
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
			# Move 1 into box
			movl $1, 24(%r8)
			# Storing attribute y
			movq %r8, 120(%rbx)
			# End of attribute init Main_y
			# Start of attribute init Main_z
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
			# Move 8 into box
			movl $8, 24(%r8)
			# Storing attribute z
			movq %r8, 128(%rbx)
			# End of attribute init Main_z
			movq %rbx, %rax
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl Object..new
Object..new:
			# Constructor for Object
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
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
Object_attr_init:
			# Attribute initializations for Object
			movq %rbx, %rax
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl String..new
String..new:
			# Constructor for String
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
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
			movq $empty.string, %rax
			movq %rax, 24(%rbx)
String_attr_init:
			# Attribute initializations for String
			movq %rbx, %rax
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
