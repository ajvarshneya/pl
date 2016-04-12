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
			# in_int
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
			subq $4, %rsp
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
			leaq 72(%rsp), %rsi
			movl $.int_fmt_string, %edi
			movl $0, %eax
			call __isoc99_scanf
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
			movl (%rsp), %eax
			addq $4, %rsp
			movl %eax, %ebx
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
			movl %ebx, 24(%rax)
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl IO.in_string
IO.in_string:
			# Method definition for IO.in_string
			# in_string
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
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
			call cool_in_string
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
			movq %rbx, 24(%rax)
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret
.globl IO.out_int
IO.out_int:
			# Method definition for IO.out_int
			# out_int
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
			# Load formal parameter into %rax
			movq 16(%rbp), %rax
			# Unbox parameter into %eax
			movl 24(%rax), %eax
			# Move unboxed parameter into %esi
			movl %eax, %esi
			# Put string format in %edi
			movl $.int_fmt_string, %edi
			movl $0, %eax
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
			leave
			ret
.globl IO.out_string
IO.out_string:
			# Method definition for IO.out_string
			# out_string
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
			# Load formal parameter into %rax
			movq 16(%rbp), %rax
			# Unbox string into %rax
			movq 24(%rax), %rax
			# Move unboxed string into %rdi
			movq %rax, %rdi
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
			leave
			ret
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
			# Move 3 into box
			movl $3, 24(%r10)
			# Storing parameter for function call
			pushq %r10
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
			movq %rax, %r11
			# Move 8 into box
			movl $8, 24(%r11)
			# Storing parameter for function call
			pushq %r11
			# Initialize string, Hello, world!
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
			movq %rax, %r8
			# Move value into %rax, then box
			movq $string_constant..0, %rax
			movq %rax, 24(%r8)
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
			# Move receiver object into self, call function substr
			movq %r8, %rbx
			# Move vtable pointer into rax
			movq 16(%r8), %rax
			# Move vtable pointer + offset into rax
			movq 56(%rax), %rax
			call *%rax
			addq $16, %rsp
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
			addq $16, %rsp
			movq %rax, %r9
			# Storing parameter for function call
			pushq %r9
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
			subq $8, %rsp
			movq 80(%rsp), %rax
			movq %rax, 0(%rsp)
			# Call function out_string
			# Move vtable pointer into rax
			movq 16(%rbx), %rax
			# Move vtable pointer + offset into rax
			movq 64(%rax), %rax
			call *%rax
			addq $8, %rsp
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
			addq $8, %rsp
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
			call exit
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
			# substring
			pushq %rbp
			movq %rsp, %rbp
			# Push callee saved registers
			pushq %r12
			pushq %r13
			pushq %r14
			pushq %r15
			# Load string into %rax
			movq 16(%rbp), %rax
			# Unbox string into %rax
			movq 24(%rax), %rax
			# Move unboxed string into r11
			movq %rax, %r11
			# Load int1 into %rax
			movq 16(%rbp), %rax
			# Unbox int into %eax
			movl 24(%rax), %eax
			# Move unboxed int into r12d
			movl %eax, %r12d
			# Load int2 into %rax
			movq 16(%rbp), %rax
			# Unbox int into %eax
			movl 24(%rax), %eax
			# Move unboxed int into r13d
			movl %eax, %r13d
			movq $0, %rax
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
			subq $16, %rsp
			movq %r11, -8(%rbp)
			movl %r12d, -16(%rbp)
			movl %r13d, -12(%rbp)
			movl -12(%rbp), %edx
			movl -16(%rbp), %ecx
			movq -8(%rbp), %rax
			movl %ecx, %esi
			movq %rax, %rdi
			call cool_substr
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
			movq %rbx, 24(%rax)
			# Pop callee saved registers
			popq %r15
			popq %r14
			popq %r13
			popq %r12
			leave
			ret

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

.globl string_constant..0
string_constant..0:
			.string "Hello, world!"

.globl abort.string
abort.string:
			.string "abort\n"

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

###############################################################################
#;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; BUILT INS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;#
###############################################################################
.globl cool_in_string
cool_in_string:
			pushq %rbp
			movq %rsp, %rbp
			subq $32, %rsp
			movl $20, -16(%rbp)
			movl $0, -12(%rbp)
			movl -16(%rbp), %eax
			cltq
			movq %rax, %rdi
			call malloc
			movq %rax, -8(%rbp)

in_string_1:
			call getchar
			movb %al, -17(%rbp)
			cmpb $10, -17(%rbp)
			je in_string_2
			cmpb $-1, -17(%rbp)
			je in_string_2
			movl -12(%rbp), %eax
			movslq %eax, %rdx
			movq -8(%rbp), %rax
			addq %rax, %rdx
			movzbl -17(%rbp), %eax
			movb %al, (%rdx)
			addl $1, -12(%rbp)
			cmpb $0, -17(%rbp)
			jne in_string_3
			movl $0, -12(%rbp)
			jmp in_string_2

in_string_3:
			movl -12(%rbp), %eax
			cmpl -16(%rbp), %eax
			jne in_string_1
			addl $20, -16(%rbp)
			movl -16(%rbp), %eax
			movslq %eax, %rdx
			movq -8(%rbp), %rax
			movq %rdx, %rsi
			movq %rax, %rdi
			call realloc
			movq %rax, -8(%rbp)
			jmp in_string_1

in_string_2:
			movl -12(%rbp), %eax
			movslq %eax, %rdx
			movq -8(%rbp), %rax
			movq %rdx, %rsi
			movq %rax, %rdi
			call strndup
			movq %rax, -8(%rbp)
			movq -8(%rbp), %rax
			leave
			ret
.globl cool_substr
cool_substr:
			pushq %rbp
			movq %rsp, %rbp
			subq $48, %rsp
			movq %rdi, -40(%rbp)
			movl %esi, -44(%rbp)
			movl %edx, -48(%rbp)
			movl $20, -16(%rbp)
			movl $0, -12(%rbp)
			movl -16(%rbp), %eax
			cltq
			movq %rax, %rdi
			call malloc
			movq %rax, -8(%rbp)
			jmp substr_l4
substr_l1:
			movl -48(%rbp), %eax
			movslq %eax, %rdx
			movq -40(%rbp), %rax
			addq %rdx, %rax
			movzbl (%rax), %eax
			movb %al, -17(%rbp)
			cmpb $-1, -17(%rbp)
			je substr_l5
			movl -12(%rbp), %eax
			movslq %eax, %rdx
			movq -8(%rbp), %rax
			addq %rax, %rdx
			movzbl -17(%rbp), %eax
			movb %al, (%rdx)
			addl $1, -12(%rbp)
			cmpb $0, -17(%rbp)
			jne substr_l2
			movl $0, -12(%rbp)
			jmp substr_l6
substr_l2:
			movl -12(%rbp), %eax
			cmpl -16(%rbp), %eax
			jne substr_l3
			addl $20, -16(%rbp)
			movl -16(%rbp), %eax
			movslq %eax, %rdx
			movq -8(%rbp), %rax
			movq %rdx, %rsi
			movq %rax, %rdi
			call realloc
			movq %rax, -8(%rbp)
substr_l3:
			addl $1, -48(%rbp)
substr_l4:
			movl -48(%rbp), %eax
			cmpl -44(%rbp), %eax
			jl substr_l1
			jmp substr_l6
substr_l5:
			nop
substr_l6:
			movl -12(%rbp), %eax
			movslq %eax, %rdx
			movq -8(%rbp), %rax
			movq %rdx, %rsi
			movq %rax, %rdi
			call strndup
			movq %rax, -8(%rbp)
			movq -8(%rbp), %rax
			leave
			ret
