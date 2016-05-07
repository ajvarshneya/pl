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

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;; METHOD DEFINITIONS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl IO.in_int
IO.in_int:
			# Method definition for IO.in_int
			call exit
.globl IO.in_string
IO.in_string:
			# Method definition for IO.in_string
			call exit
.globl IO.out_int
IO.out_int:
			# Method definition for IO.out_int
			call exit
.globl IO.out_string
IO.out_string:
			# Method definition for IO.out_string
			call exit
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
Main_main_0:
			# Start of method Main_main
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
			subq $0, %rsp
			# Call function abort
			# Move vtable pointer into rax
			movq 16(%rbx), %rax
			# Move vtable pointer + offset into rax
			movq 16(%rax), %rax
			call *%rax
			addq $0, %rsp
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
			addq $0, %rsp
			movq %rax, %r8
			movq %r8, %rax
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
			# out_string
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
			# Move abort\n into %rdi
			movq $abort.string, %rdi
			movq $0, %rax
			# Call printf
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
			call printf
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
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			call exit
			leave
			ret
.globl Object.copy
Object.copy:
			# Method definition for Object.copy
			call exit
.globl Object.type_name
Object.type_name:
			# Method definition for Object.type_name
			# Make new string object
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
			call String..new
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
			# Move type name from vtable[0] to String object (currently in %rax)
			movq 16(%rbx), %r8
			movq 0(%r8), %r8
			movq %r8, 24(%rax)
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl String.concat
String.concat:
			# Method definition for String.concat
			call exit
.globl String.length
String.length:
			# Method definition for String.length
			call exit
.globl String.substr
String.substr:
			# Method definition for String.substr
			call exit

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;; STRING CONSTANTS  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
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

.globl abort.string
abort.string:
			.string "abort\n"

.global empty.string
empty.string:
			.string "" 


###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; START ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.int_fmt_string:
	.string "%d"
	.text
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
