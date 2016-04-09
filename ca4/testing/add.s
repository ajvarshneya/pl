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

			# Push callee saved registers
			pushq %r15
			pushq %r14
			pushq %r13
			pushq %r12
			# Allocate heap space, get self ptr
			movq $4, %rdi
			movq $8, %rsi
			# Push caller saved registers
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
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
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $0, %rax
			movq %rax, 0(%rbx)
			movq $4, %rax
			movq %rax, 8(%rbx)
			movq $Bool..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

Bool_attributes:
			movl $0, 24(%rbx)
			movq %rbx, %r8
			movq %r8, 24(%rbx)

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

			# Push callee saved registers
			pushq %r15
			pushq %r14
			pushq %r13
			pushq %r12
			# Allocate heap space, get self ptr
			movq $3, %rdi
			movq $8, %rsi
			# Push caller saved registers
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
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
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $2, %rax
			movq %rax, 0(%rbx)
			movq $3, %rax
			movq %rax, 8(%rbx)
			movq $IO..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

IO_attributes:

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

			# Push callee saved registers
			pushq %r15
			pushq %r14
			pushq %r13
			pushq %r12
			# Allocate heap space, get self ptr
			movq $4, %rdi
			movq $8, %rsi
			# Push caller saved registers
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
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
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $1, %rax
			movq %rax, 0(%rbx)
			movq $4, %rax
			movq %rax, 8(%rbx)
			movq $Int..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

Int_attributes:
			movl $0, 24(%rbx)
			movq %rbx, %r8
			movq %r8, 24(%rbx)

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

			# Push callee saved registers
			pushq %r15
			pushq %r14
			pushq %r13
			pushq %r12
			# Allocate heap space, get self ptr
			movq $3, %rdi
			movq $8, %rsi
			# Push caller saved registers
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
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
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $5, %rax
			movq %rax, 0(%rbx)
			movq $3, %rax
			movq %rax, 8(%rbx)
			movq $Main..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

Main_attributes:

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

			# Push callee saved registers
			pushq %r15
			pushq %r14
			pushq %r13
			pushq %r12
			# Allocate heap space, get self ptr
			movq $3, %rdi
			movq $8, %rsi
			# Push caller saved registers
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
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
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $3, %rax
			movq %rax, 0(%rbx)
			movq $3, %rax
			movq %rax, 8(%rbx)
			movq $Object..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

Object_attributes:

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

			# Push callee saved registers
			pushq %r15
			pushq %r14
			pushq %r13
			pushq %r12
			# Allocate heap space, get self ptr
			movq $4, %rdi
			movq $8, %rsi
			# Push caller saved registers
			pushq %rcx
			pushq %rdx
			pushq %rsi
			pushq %rdi
			pushq %r8
			pushq %r9
			pushq %r10
			pushq %r11
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
			movq %rax, %rbx

			# Store type tag, size, vtable ptr
			movq $4, %rax
			movq %rax, 0(%rbx)
			movq $4, %rax
			movq %rax, 8(%rbx)
			movq $String..vtable, %rax
			movq %rax, 16(%rbx)
			movq %rbx, %rax

String_attributes:
			movq %r8, 24(%rbx)

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
			# Initialize integer, 111
			# Push caller saved registers
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
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $111, 24(%r8)
			# assign
			movq %r8, %r12
			# Initialize integer, 444
			# Push caller saved registers
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
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $444, 24(%r8)
			# assign
			movq %r8, %r11
			# assign
			movq %r12, %r10
			# assign
			movq %r11, %r8
			# Dereference the box
			movq 24(%r10), %r9
			# Dereference the box
			movq 24(%r8), %r10
			# addition
			movl %r9d, %r8d
			addl %r10d, %r8d
			# Push caller saved registers
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
			# Move value into box, save object pointer
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# assign
			movq %r9, %r12
			# assign
			movq %r12, %r9
			# Initialize integer, 5
			# Push caller saved registers
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
			movq %rax, %r10
			# Move value into box, save object pointer
			movl $5, 24(%r10)
			# Dereference the box
			movq 24(%r9), %r8
			# Dereference the box
			movq 24(%r10), %r9
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r9d, 24(%rsp)
			movl %r8d, %eax
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
			# Move value into box, save object pointer
			movl %r10d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r8, %r11
			# assign
			movq %r12, %r9
			# Dereference the box
			movq 24(%r9), %r8
			# negate
			movl %r8d, %r9d
			negl %r9d
			# Push caller saved registers
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
			# Move value into box, save object pointer
			movl %r9d, 24(%rax)
			movq %rax, %r8
			# Initialize integer, 5
			# Push caller saved registers
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
			movq %rax, %r9
			# Move value into box, save object pointer
			movl $5, 24(%r9)
			# Dereference the box
			movq 24(%r8), %r12
			# Dereference the box
			movq 24(%r9), %r8
			# division
			subq $8, %rsp
			pushq %rdx
			pushq %rax
			pushq %rcx
			movl %r8d, 24(%rsp)
			movl %r12d, %eax
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
			# Move value into box, save object pointer
			movl %r10d, 24(%rax)
			movq %rax, %r9
			# Initialize integer, 6
			# Push caller saved registers
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
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $6, 24(%r8)
			# Dereference the box
			movq 24(%r9), %r10
			# Dereference the box
			movq 24(%r8), %r9
			# multiplication
			movl %r10d, %r8d
			imull %r9d, %r8d
			# Push caller saved registers
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
			# Move value into box, save object pointer
			movl %r8d, 24(%rax)
			movq %rax, %r10
			# Initialize integer, 66
			# Push caller saved registers
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
			movq %rax, %r8
			# Move value into box, save object pointer
			movl $66, 24(%r8)
			# Dereference the box
			movq 24(%r10), %r9
			# Dereference the box
			movq 24(%r8), %r10
			# subtraction
			movl %r9d, %r8d
			subl %r10d, %r8d
			# Push caller saved registers
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
			# Move value into box, save object pointer
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# assign
			movq %r11, %r10
			# Dereference the box
			movq 24(%r9), %r8
			# Dereference the box
			movq 24(%r10), %r9
			# addition
			movl %r8d, %r10d
			addl %r9d, %r10d
			# Push caller saved registers
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
			# Move value into box, save object pointer
			movl %r10d, 24(%rax)
			movq %rax, %r8
			# assign
			movq %r8, %r12
			# assign
			movq %r12, %r8
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
