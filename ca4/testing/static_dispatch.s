###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;; VIRTUAL METHOD TABLES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl A..vtable
A..vtable:
			# Virtual function table for A
			.quad string_constant..A
			.quad A..new
			.quad Object.abort
			.quad Object.copy
			.quad Object.type_name
			.quad A.a
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
.globl A..new
A..new:
			# Constructor for A
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
			movq $6, %rax
			movq %rax, 0(%rbx)
			movq $3, %rax
			movq %rax, 8(%rbx)
			movq $A..vtable, %rax
			movq %rax, 16(%rbx)
A_attr_init:
			# Attribute initializations for A
			movq %rbx, %rax
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
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
			movq $5, %rax
			movq %rax, 0(%rbx)
			movq $3, %rax
			movq %rax, 8(%rbx)
			movq $Main..vtable, %rax
			movq %rax, 16(%rbx)
Main_attr_init:
			# Attribute initializations for Main
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
			movq empty.string, %rax
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

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;; METHOD DEFINITIONS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl A.a
A.a:
			# Method definition for A.a
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
A_a_0:
			# Start of method A_a
			movq 16(%rbp), %r9
			movq 24(%rbp), %r10
			# assign
			movq %r9, %r8
			# assign
			movq %r10, %r9
			# Unboxing t$2
			movq 24(%r8), %r10
			# Unboxing t$3
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
			# Boxing t$4
			movl %r8d, 24(%rax)
			movq %rax, %r9
			# End of method A_a
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl IO.in_int
IO.in_int:
			# Method definition for IO.in_int
.globl IO.in_string
IO.in_string:
			# Method definition for IO.in_string
.globl IO.out_int
IO.out_int:
			# Method definition for IO.out_int
.globl IO.out_string
IO.out_string:
			# Method definition for IO.out_string
.globl Main.main
Main.main:
			# Method definition for Main.main
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
Main_main_1:
			# Start of method Main_main
			# Initialize integer, 777
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
			# Move 777 into box
			movl $777, 24(%r8)
			pushq %r8
			# Initialize integer, 444
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
			# Move 444 into box
			movl $444, 24(%r8)
			pushq %r8
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
			# Push parameters on in reverse
			subq $16, %rsp
			movq 96(%rsp), %rax
			movq %rax, 0(%rsp)
			movq 88(%rsp), %rax
			movq %rax, 8(%rsp)
			# Move receiver object into self, call function
			movq %r8, %rbx
			call A.a
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
			# End of method Main_main
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl Object.abort
Object.abort:
			# Method definition for Object.abort
.globl Object.copy
Object.copy:
			# Method definition for Object.copy
.globl Object.type_name
Object.type_name:
			# Method definition for Object.type_name
.globl String.concat
String.concat:
			# Method definition for String.concat
.globl String.length
String.length:
			# Method definition for String.length
.globl String.substr
String.substr:
			# Method definition for String.substr

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;; STRING CONSTANTS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl string_constant..A
string_constant..A:
			.string "A"

.globl string_constant..Bool
string_constant..Bool:
			.string "Bool"

.globl string_constant..IO
string_constant..IO:
			.string "IO"

.globl string_constant..Int
string_constant..Int:
			.string "Int"

.globl string_constant..Main
string_constant..Main:
			.string "Main"

.globl string_constant..Object
string_constant..Object:
			.string "Object"

.globl string_constant..String
string_constant..String:
			.string "String"

.global empty.string
empty.string:
			.string "" 


###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;; COMPARISON HANDLERS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
comparison_handlers:
lt_int_cmp:
lt_bool_cmp:
lt_string_cmp:
lt_other_cmp:
le_int_cmp:
le_bool_cmp:
le_string_cmp:
le_other_cmp:
eq_int_cmp:
eq_bool_cmp:
eq_string_cmp:
eq_other_cmp:

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
			movq %rax, %rbx
			call Main.main
			call exit
