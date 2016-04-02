                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Bool..vtable
Bool..vtable:           ## virtual function table for Bool
                        .quad string1
                        .quad Bool..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict..vtable
ConsDict..vtable:       ## virtual function table for ConsDict
                        .quad string2
                        .quad ConsDict..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        .quad Dict.construct
                        .quad ConsDict.has_key
                        .quad ConsDict.get_key
                        .quad ConsDict.set_key
                        .quad ConsDict.get_value
                        .quad ConsDict.set_value
                        .quad ConsDict.get_mark
                        .quad ConsDict.set_mark
                        .quad ConsDict.get_tail
                        .quad ConsDict.set_tail
                        .quad ConsDict.get
                        .quad ConsDict.put
                        .quad ConsDict.remove
                        .quad ConsDict.print
                        .quad ConsDict.init
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList..vtable
ConsList..vtable:       ## virtual function table for ConsList
                        .quad string3
                        .quad ConsList..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        .quad List.cons
                        .quad ConsList.get_head
                        .quad ConsList.get_tail
                        .quad ConsList.insert
                        .quad ConsList.prepend
                        .quad ConsList.print
                        .quad ConsList.init
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict..vtable
Dict..vtable:           ## virtual function table for Dict
                        .quad string4
                        .quad Dict..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        .quad Dict.construct
                        .quad Dict.has_key
                        .quad Dict.get_key
                        .quad Dict.set_key
                        .quad Dict.get_value
                        .quad Dict.set_value
                        .quad Dict.get_mark
                        .quad Dict.set_mark
                        .quad Dict.get_tail
                        .quad Dict.set_tail
                        .quad Dict.get
                        .quad Dict.put
                        .quad Dict.remove
                        .quad Dict.print
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl IO..vtable
IO..vtable:             ## virtual function table for IO
                        .quad string5
                        .quad IO..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Int..vtable
Int..vtable:            ## virtual function table for Int
                        .quad string6
                        .quad Int..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List..vtable
List..vtable:           ## virtual function table for List
                        .quad string7
                        .quad List..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        .quad List.cons
                        .quad List.get_head
                        .quad List.get_tail
                        .quad List.insert
                        .quad List.prepend
                        .quad List.print
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Main..vtable
Main..vtable:           ## virtual function table for Main
                        .quad string8
                        .quad Main..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        .quad Main.main
                        .quad Main.top_sort
                        .quad Main.visit
                        .quad Main.visit_helper
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict..vtable
NilDict..vtable:        ## virtual function table for NilDict
                        .quad string9
                        .quad NilDict..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        .quad Dict.construct
                        .quad NilDict.has_key
                        .quad NilDict.get_key
                        .quad NilDict.set_key
                        .quad NilDict.get_value
                        .quad NilDict.set_value
                        .quad NilDict.get_mark
                        .quad NilDict.set_mark
                        .quad NilDict.get_tail
                        .quad NilDict.set_tail
                        .quad NilDict.get
                        .quad NilDict.put
                        .quad NilDict.remove
                        .quad NilDict.print
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList..vtable
NilList..vtable:        ## virtual function table for NilList
                        .quad string10
                        .quad NilList..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad IO.in_int
                        .quad IO.in_string
                        .quad IO.out_int
                        .quad IO.out_string
                        .quad List.cons
                        .quad NilList.get_head
                        .quad NilList.get_tail
                        .quad NilList.insert
                        .quad NilList.prepend
                        .quad NilList.print
                        .quad NilList.remove
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Object..vtable
Object..vtable:         ## virtual function table for Object
                        .quad string11
                        .quad Object..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl String..vtable
String..vtable:         ## virtual function table for String
                        .quad string12
                        .quad String..new
                        .quad Object.abort
                        .quad Object.copy
                        .quad Object.type_name
                        .quad String.concat
                        .quad String.length
                        .quad String.substr
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Bool..new
Bool..new:              ## constructor for Bool
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $4, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $0, %r14
                        movq %r14, 0(%r12)
                        movq $4, %r14
                        movq %r14, 8(%r12)
                        movq $Bool..vtable, %r14
                        movq %r14, 16(%r12)
                        ## initialize attributes
                        ## self[3] holds field (raw content) (Int)
                        movq $0, %r13
                        movq %r13, 24(%r12)
                        ## self[3] (raw content) initializer -- none 
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict..new
ConsDict..new:          ## constructor for ConsDict
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $7, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $10, %r14
                        movq %r14, 0(%r12)
                        movq $7, %r14
                        movq %r14, 8(%r12)
                        movq $ConsDict..vtable, %r14
                        movq %r14, 16(%r12)
                        ## initialize attributes
                        ## self[3] holds field key (String)
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 24(%r12)
                        ## self[4] holds field value (List)
                        movq $0, %r13
                        movq %r13, 32(%r12)
                        ## self[5] holds field mark (Int)
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 40(%r12)
                        ## self[6] holds field tail (Dict)
                        movq $0, %r13
                        movq %r13, 48(%r12)
                        ## self[3] key initializer -- none 
                        ## self[4] value initializer -- none 
                        ## self[5] mark initializer -- none 
                        ## self[6] tail initializer -- none 
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList..new
ConsList..new:          ## constructor for ConsList
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $5, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $11, %r14
                        movq %r14, 0(%r12)
                        movq $5, %r14
                        movq %r14, 8(%r12)
                        movq $ConsList..vtable, %r14
                        movq %r14, 16(%r12)
                        ## initialize attributes
                        ## self[3] holds field head (String)
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 24(%r12)
                        ## self[4] holds field tail (List)
                        movq $0, %r13
                        movq %r13, 32(%r12)
                        ## self[3] head initializer -- none 
                        ## self[4] tail initializer -- none 
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict..new
Dict..new:              ## constructor for Dict
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $3, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $12, %r14
                        movq %r14, 0(%r12)
                        movq $3, %r14
                        movq %r14, 8(%r12)
                        movq $Dict..vtable, %r14
                        movq %r14, 16(%r12)
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl IO..new
IO..new:                ## constructor for IO
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $3, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $13, %r14
                        movq %r14, 0(%r12)
                        movq $3, %r14
                        movq %r14, 8(%r12)
                        movq $IO..vtable, %r14
                        movq %r14, 16(%r12)
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Int..new
Int..new:               ## constructor for Int
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $4, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $1, %r14
                        movq %r14, 0(%r12)
                        movq $4, %r14
                        movq %r14, 8(%r12)
                        movq $Int..vtable, %r14
                        movq %r14, 16(%r12)
                        ## initialize attributes
                        ## self[3] holds field (raw content) (Int)
                        movq $0, %r13
                        movq %r13, 24(%r12)
                        ## self[3] (raw content) initializer -- none 
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List..new
List..new:              ## constructor for List
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $3, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $14, %r14
                        movq %r14, 0(%r12)
                        movq $3, %r14
                        movq %r14, 8(%r12)
                        movq $List..vtable, %r14
                        movq %r14, 16(%r12)
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Main..new
Main..new:              ## constructor for Main
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $6, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $15, %r14
                        movq %r14, 0(%r12)
                        movq $6, %r14
                        movq %r14, 8(%r12)
                        movq $Main..vtable, %r14
                        movq %r14, 16(%r12)
                        ## initialize attributes
                        ## self[3] holds field graph (Dict)
                        movq $0, %r13
                        movq %r13, 24(%r12)
                        ## self[4] holds field sorted_list (List)
                        movq $0, %r13
                        movq %r13, 32(%r12)
                        ## self[5] holds field cycle (Bool)
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 40(%r12)
                        ## self[3] graph initializer <- new NilDict
                        ## new NilDict
                        pushq %rbp
                        pushq %r12
                        movq $NilDict..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 24(%r12)
                        ## self[4] sorted_list initializer <- new NilList
                        ## new NilList
                        pushq %rbp
                        pushq %r12
                        movq $NilList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 32(%r12)
                        ## self[5] cycle initializer <- false
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 40(%r12)
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict..new
NilDict..new:           ## constructor for NilDict
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $3, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $16, %r14
                        movq %r14, 0(%r12)
                        movq $3, %r14
                        movq %r14, 8(%r12)
                        movq $NilDict..vtable, %r14
                        movq %r14, 16(%r12)
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList..new
NilList..new:           ## constructor for NilList
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $3, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $17, %r14
                        movq %r14, 0(%r12)
                        movq $3, %r14
                        movq %r14, 8(%r12)
                        movq $NilList..vtable, %r14
                        movq %r14, 16(%r12)
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Object..new
Object..new:            ## constructor for Object
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $3, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $18, %r14
                        movq %r14, 0(%r12)
                        movq $3, %r14
                        movq %r14, 8(%r12)
                        movq $Object..vtable, %r14
                        movq %r14, 16(%r12)
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl String..new
String..new:            ## constructor for String
                        pushq %rbp
                        movq %rsp, %rbp
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        movq $4, %r12
                        movq $8, %rsi
			movq %r12, %rdi
			call calloc
			movq %rax, %r12
                        ## store class tag, object size and vtable pointer
                        movq $3, %r14
                        movq %r14, 0(%r12)
                        movq $4, %r14
                        movq %r14, 8(%r12)
                        movq $String..vtable, %r14
                        movq %r14, 16(%r12)
                        ## initialize attributes
                        ## self[3] holds field (raw content) (String)
                        movq $the.empty.string, %r13
                        movq %r13, 24(%r12)
                        ## self[3] (raw content) initializer -- none 
                        movq %r12, %r13
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Object.abort
Object.abort:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        movq $string13, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl Object.abort.end
Object.abort.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Object.copy
Object.copy:            ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        movq 8(%r12), %r14
                        movq $8, %rsi
			movq %r14, %rdi
			call calloc
			movq %rax, %r13
                        pushq %r13
.globl l1
l1:                     cmpq $0, %r14
			je l2
                        movq 0(%r12), %r15
                        movq %r15, 0(%r13)
                        movq $8, %r15
                        addq %r15, %r12
                        addq %r15, %r13
                        movq $1, %r15
                        subq %r15, %r14
                        jmp l1
.globl l2
l2:                     ## done with Object.copy loop
                        popq %r13
.globl Object.copy.end
Object.copy.end:        ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Object.type_name
Object.type_name:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## obtain vtable for self object
                        movq 16(%r12), %r14
                        ## look up type name at offset 0 in vtable
                        movq 0(%r14), %r14
                        movq %r14, 24(%r13)
.globl Object.type_name.end
Object.type_name.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl IO.in_int
IO.in_int:              ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## method body begins
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, %r14
                        movl	$1, %esi
			movl $4096, %edi
			call calloc
			pushq %rax
			movq %rax, %rdi
			movq $4096, %rsi 
			movq stdin(%rip), %rdx
			call fgets 
			popq %rdi 
			movl $0, %eax
			pushq %rax
			movq %rsp, %rdx
			movq $percent.ld, %rsi
			call sscanf
			popq %rax
			movq $0, %rsi 
			cmpq $2147483647, %rax 
			cmovg %rsi, %rax
			cmpq $-2147483648, %rax 
			cmovl %rsi, %rax
			movq %rax, %r13
                        movq %r13, 24(%r14)
                        movq %r14, %r13
.globl IO.in_int.end
IO.in_int.end:          ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl IO.in_string
IO.in_string:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, %r14
                        call coolgetstr 
			movq %rax, %r13
                        movq %r13, 24(%r14)
                        movq %r14, %r13
.globl IO.in_string.end
IO.in_string.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl IO.out_int
IO.out_int:             ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument x (Int)
                        ## method body begins
                        movq 24(%rbp), %r14
                        movq 24(%r14), %r13
                        movq $percent.d, %rdi
		movl %r13d, %eax
		cdqe
		movq %rax, %rsi
			movl $0, %eax
			call printf
                        movq %r12, %r13
.globl IO.out_int.end
IO.out_int.end:         ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl IO.out_string
IO.out_string:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument x (String)
                        ## method body begins
                        movq 24(%rbp), %r14
                        movq 24(%r14), %r13
                        movq %r13, %rdi
			call cooloutstr
                        movq %r12, %r13
.globl IO.out_string.end
IO.out_string.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.construct
Dict.construct:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[5] holds argument k (String)
                        ## fp[4] holds argument v (List)
                        ## fp[3] holds argument m (Int)
                        ## method body begins
                        ## fp[0] holds local cell (ConsDict)
                        ## new ConsDict
                        pushq %rbp
                        pushq %r12
                        movq $ConsDict..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 0(%rbp)
                        ## cell.init(...)
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 40(%rbp), %r13
                        pushq %r13
                        ## v
                        movq 32(%rbp), %r13
                        pushq %r13
                        ## m
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## cell
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l3
                        movq $string14, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l3
l3:                     pushq %r13
                        ## obtain vtable from object in r1 with static type ConsDict
                        movq 16(%r13), %r14
                        ## look up init() at offset 23 in vtable
                        movq 184(%r14), %r14
                        call *%r14
                        addq $40, %rsp
                        popq %rbp
                        popq %r12
.globl Dict.construct.end
Dict.construct.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.has_key
ConsDict.has_key:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        pushq %r12
                        pushq %rbp
                        ## key
                        movq 24(%r12), %r13
                        pushq %r13
                        ## k
                        movq 24(%rbp), %r13
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l4
.globl l5
l5:                     ## false branch
                        ## tail.has_key(...)
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 24(%rbp), %r13
                        pushq %r13
                        ## tail
                        movq 48(%r12), %r13
                        cmpq $0, %r13
			jne l7
                        movq $string15, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l7
l7:                     pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up has_key() at offset 10 in vtable
                        movq 80(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l6
.globl l4
l4:                     ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
.globl l6
l6:                     ## end of if conditional
.globl ConsDict.has_key.end
ConsDict.has_key.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.get_key
ConsDict.get_key:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## method body begins
                        ## key
                        movq 24(%r12), %r13
.globl ConsDict.get_key.end
ConsDict.get_key.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.set_key
ConsDict.set_key:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        ## k
                        movq 24(%rbp), %r13
                        movq %r13, 24(%r12)
                        movq %r12, %r13
.globl ConsDict.set_key.end
ConsDict.set_key.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.get_value
ConsDict.get_value:     ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## method body begins
                        ## value
                        movq 32(%r12), %r13
.globl ConsDict.get_value.end
ConsDict.get_value.end: ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.set_value
ConsDict.set_value:     ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument v (List)
                        ## method body begins
                        ## v
                        movq 24(%rbp), %r13
                        movq %r13, 32(%r12)
                        movq %r12, %r13
.globl ConsDict.set_value.end
ConsDict.set_value.end: ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.get_mark
ConsDict.get_mark:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## method body begins
                        ## mark
                        movq 40(%r12), %r13
.globl ConsDict.get_mark.end
ConsDict.get_mark.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.set_mark
ConsDict.set_mark:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument m (Int)
                        ## method body begins
                        ## m
                        movq 24(%rbp), %r13
                        movq %r13, 40(%r12)
                        movq %r12, %r13
.globl ConsDict.set_mark.end
ConsDict.set_mark.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.get_tail
ConsDict.get_tail:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## method body begins
                        ## tail
                        movq 48(%r12), %r13
.globl ConsDict.get_tail.end
ConsDict.get_tail.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.set_tail
ConsDict.set_tail:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument t (Dict)
                        ## method body begins
                        ## t
                        movq 24(%rbp), %r13
                        movq %r13, 48(%r12)
                        movq %r12, %r13
.globl ConsDict.set_tail.end
ConsDict.set_tail.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.get
ConsDict.get:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 24(%rbp), %r13
                        pushq %r13
                        ## key
                        movq 24(%r12), %r13
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l8
.globl l9
l9:                     ## false branch
                        ## tail.get(...)
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 24(%rbp), %r13
                        pushq %r13
                        ## tail
                        movq 48(%r12), %r13
                        cmpq $0, %r13
			jne l11
                        movq $string16, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l11
l11:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get() at offset 19 in vtable
                        movq 152(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l10
.globl l8
l8:                     ## true branch
                        movq %r12, %r13
.globl l10
l10:                    ## end of if conditional
.globl ConsDict.get.end
ConsDict.get.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.put
ConsDict.put:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[5] holds argument k (String)
                        ## fp[4] holds argument v (List)
                        ## fp[3] holds argument m (Int)
                        ## method body begins
                        pushq %r12
                        pushq %rbp
                        ## key
                        movq 24(%r12), %r13
                        pushq %r13
                        ## k
                        movq 40(%rbp), %r13
                        pushq %r13
                        pushq %r12
                        call lt_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l12
.globl l13
l13:                    ## false branch
                        ## new ConsDict.init(...)
                        pushq %r12
                        pushq %rbp
                        ## key
                        movq 24(%r12), %r13
                        pushq %r13
                        ## value
                        movq 32(%r12), %r13
                        pushq %r13
                        ## mark
                        movq 40(%r12), %r13
                        pushq %r13
                        ## tail.put(...)
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 40(%rbp), %r13
                        pushq %r13
                        ## v
                        movq 32(%rbp), %r13
                        pushq %r13
                        ## m
                        movq 24(%rbp), %r13
                        pushq %r13
                        ## tail
                        movq 48(%r12), %r13
                        cmpq $0, %r13
			jne l15
                        movq $string17, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l15
l15:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up put() at offset 20 in vtable
                        movq 160(%r14), %r14
                        call *%r14
                        addq $32, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new ConsDict
                        pushq %rbp
                        pushq %r12
                        movq $ConsDict..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l16
                        movq $string17, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l16
l16:                    pushq %r13
                        ## obtain vtable from object in r1 with static type ConsDict
                        movq 16(%r13), %r14
                        ## look up init() at offset 23 in vtable
                        movq 184(%r14), %r14
                        call *%r14
                        addq $40, %rsp
                        popq %rbp
                        popq %r12
                        jmp l14
.globl l12
l12:                    ## true branch
                        ## new ConsDict.init(...)
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 40(%rbp), %r13
                        pushq %r13
                        ## v
                        movq 32(%rbp), %r13
                        pushq %r13
                        ## m
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## new ConsDict
                        pushq %rbp
                        pushq %r12
                        movq $ConsDict..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l17
                        movq $string18, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l17
l17:                    pushq %r13
                        ## obtain vtable from object in r1 with static type ConsDict
                        movq 16(%r13), %r14
                        ## look up init() at offset 23 in vtable
                        movq 184(%r14), %r14
                        call *%r14
                        addq $40, %rsp
                        popq %rbp
                        popq %r12
.globl l14
l14:                    ## end of if conditional
.globl ConsDict.put.end
ConsDict.put.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.remove
ConsDict.remove:        ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 24(%rbp), %r13
                        pushq %r13
                        ## key
                        movq 24(%r12), %r13
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l18
.globl l19
l19:                    ## false branch
                        ## tail.remove(...)
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 24(%rbp), %r13
                        pushq %r13
                        ## tail
                        movq 48(%r12), %r13
                        cmpq $0, %r13
			jne l21
                        movq $string19, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l21
l21:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up remove() at offset 21 in vtable
                        movq 168(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 48(%r12)
                        movq %r12, %r13
                        jmp l20
.globl l18
l18:                    ## true branch
                        ## tail
                        movq 48(%r12), %r13
.globl l20
l20:                    ## end of if conditional
.globl ConsDict.remove.end
ConsDict.remove.end:    ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.print
ConsDict.print:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## method body begins
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## key
                        movq 24(%r12), %r13
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type ConsDict
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        ## tail.print(...)
                        pushq %r12
                        pushq %rbp
                        ## tail
                        movq 48(%r12), %r13
                        cmpq $0, %r13
			jne l22
                        movq $string20, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l22
l22:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up print() at offset 22 in vtable
                        movq 176(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
.globl ConsDict.print.end
ConsDict.print.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsDict.init
ConsDict.init:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field key (String)
                        ## self[4] holds field value (List)
                        ## self[5] holds field mark (Int)
                        ## self[6] holds field tail (Dict)
                        ## fp[6] holds argument k (String)
                        ## fp[5] holds argument v (List)
                        ## fp[4] holds argument m (Int)
                        ## fp[3] holds argument t (Dict)
                        ## method body begins
                        ## k
                        movq 48(%rbp), %r13
                        movq %r13, 24(%r12)
                        ## v
                        movq 40(%rbp), %r13
                        movq %r13, 32(%r12)
                        ## m
                        movq 32(%rbp), %r13
                        movq %r13, 40(%r12)
                        ## t
                        movq 24(%rbp), %r13
                        movq %r13, 48(%r12)
                        movq %r12, %r13
.globl ConsDict.init.end
ConsDict.init.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List.cons
List.cons:              ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field head (String)
                        ## self[4] holds field tail (List)
                        ## fp[3] holds argument head (String)
                        ## method body begins
                        ## fp[0] holds local cell (ConsList)
                        ## new ConsList
                        pushq %rbp
                        pushq %r12
                        movq $ConsList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 0(%rbp)
                        ## cell.init(...)
                        pushq %r12
                        pushq %rbp
                        ## head
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## cell
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l23
                        movq $string21, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l23
l23:                    pushq %r13
                        ## obtain vtable from object in r1 with static type ConsList
                        movq 16(%r13), %r14
                        ## look up init() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
.globl List.cons.end
List.cons.end:          ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList.get_head
ConsList.get_head:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field head (String)
                        ## self[4] holds field tail (List)
                        ## method body begins
                        ## head
                        movq 24(%r12), %r13
.globl ConsList.get_head.end
ConsList.get_head.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList.get_tail
ConsList.get_tail:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field head (String)
                        ## self[4] holds field tail (List)
                        ## method body begins
                        ## tail
                        movq 32(%r12), %r13
.globl ConsList.get_tail.end
ConsList.get_tail.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList.insert
ConsList.insert:        ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field head (String)
                        ## self[4] holds field tail (List)
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        pushq %r12
                        pushq %rbp
                        ## head
                        movq 24(%r12), %r13
                        pushq %r13
                        ## s
                        movq 24(%rbp), %r13
                        pushq %r13
                        pushq %r12
                        call lt_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l24
.globl l25
l25:                    ## false branch
                        ## new ConsList.init(...)
                        pushq %r12
                        pushq %rbp
                        ## head
                        movq 24(%r12), %r13
                        pushq %r13
                        ## tail.insert(...)
                        pushq %r12
                        pushq %rbp
                        ## s
                        movq 24(%rbp), %r13
                        pushq %r13
                        ## tail
                        movq 32(%r12), %r13
                        cmpq $0, %r13
			jne l27
                        movq $string22, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l27
l27:                    pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up insert() at offset 12 in vtable
                        movq 96(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new ConsList
                        pushq %rbp
                        pushq %r12
                        movq $ConsList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l28
                        movq $string22, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l28
l28:                    pushq %r13
                        ## obtain vtable from object in r1 with static type ConsList
                        movq 16(%r13), %r14
                        ## look up init() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        jmp l26
.globl l24
l24:                    ## true branch
                        ## new ConsList.init(...)
                        pushq %r12
                        pushq %rbp
                        ## s
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## new ConsList
                        pushq %rbp
                        pushq %r12
                        movq $ConsList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l29
                        movq $string23, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l29
l29:                    pushq %r13
                        ## obtain vtable from object in r1 with static type ConsList
                        movq 16(%r13), %r14
                        ## look up init() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
.globl l26
l26:                    ## end of if conditional
.globl ConsList.insert.end
ConsList.insert.end:    ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList.prepend
ConsList.prepend:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field head (String)
                        ## self[4] holds field tail (List)
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        ## new ConsList.init(...)
                        pushq %r12
                        pushq %rbp
                        ## s
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## new ConsList
                        pushq %rbp
                        pushq %r12
                        movq $ConsList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l30
                        movq $string24, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l30
l30:                    pushq %r13
                        ## obtain vtable from object in r1 with static type ConsList
                        movq 16(%r13), %r14
                        ## look up init() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
.globl ConsList.prepend.end
ConsList.prepend.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList.print
ConsList.print:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field head (String)
                        ## self[4] holds field tail (List)
                        ## method body begins
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## head
                        movq 24(%r12), %r13
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type ConsList
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string25 holds "\n"
                        movq $string25, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type ConsList
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        ## tail.print(...)
                        pushq %r12
                        pushq %rbp
                        ## tail
                        movq 32(%r12), %r13
                        cmpq $0, %r13
			jne l31
                        movq $string26, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l31
l31:                    pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up print() at offset 14 in vtable
                        movq 112(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
.globl ConsList.print.end
ConsList.print.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl ConsList.init
ConsList.init:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field head (String)
                        ## self[4] holds field tail (List)
                        ## fp[4] holds argument h (String)
                        ## fp[3] holds argument t (List)
                        ## method body begins
                        ## h
                        movq 32(%rbp), %r13
                        movq %r13, 24(%r12)
                        ## t
                        movq 24(%rbp), %r13
                        movq %r13, 32(%r12)
                        movq %r12, %r13
.globl ConsList.init.end
ConsList.init.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.has_key
Dict.has_key:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl Dict.has_key.end
Dict.has_key.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.get_key
Dict.get_key:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
.globl Dict.get_key.end
Dict.get_key.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.set_key
Dict.set_key:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        movq %r12, %r13
.globl Dict.set_key.end
Dict.set_key.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.get_value
Dict.get_value:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new NilList
                        pushq %rbp
                        pushq %r12
                        movq $NilList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl Dict.get_value.end
Dict.get_value.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.set_value
Dict.set_value:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument v (List)
                        ## method body begins
                        movq %r12, %r13
.globl Dict.set_value.end
Dict.set_value.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.get_mark
Dict.get_mark:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $0, %r14
                        movq %r14, 24(%r13)
.globl Dict.get_mark.end
Dict.get_mark.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.set_mark
Dict.set_mark:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument m (Int)
                        ## method body begins
                        movq %r12, %r13
.globl Dict.set_mark.end
Dict.set_mark.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.get_tail
Dict.get_tail:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        movq %r12, %r13
.globl Dict.get_tail.end
Dict.get_tail.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.set_tail
Dict.set_tail:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument t (Dict)
                        ## method body begins
                        movq %r12, %r13
.globl Dict.set_tail.end
Dict.set_tail.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.get
Dict.get:               ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        movq %r12, %r13
.globl Dict.get.end
Dict.get.end:           ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.put
Dict.put:               ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[5] holds argument k (String)
                        ## fp[4] holds argument v (List)
                        ## fp[3] holds argument m (Int)
                        ## method body begins
                        movq %r12, %r13
.globl Dict.put.end
Dict.put.end:           ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.remove
Dict.remove:            ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        movq %r12, %r13
.globl Dict.remove.end
Dict.remove.end:        ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Dict.print
Dict.print:             ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## abort(...)
                        pushq %r12
                        pushq %rbp
                        pushq %r12
                        ## obtain vtable for self object of type Dict
                        movq 16(%r12), %r14
                        ## look up abort() at offset 2 in vtable
                        movq 16(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
.globl Dict.print.end
Dict.print.end:         ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List.get_head
List.get_head:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
.globl List.get_head.end
List.get_head.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List.get_tail
List.get_tail:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        movq %r12, %r13
.globl List.get_tail.end
List.get_tail.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List.insert
List.insert:            ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        movq %r12, %r13
.globl List.insert.end
List.insert.end:        ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List.prepend
List.prepend:           ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        movq %r12, %r13
.globl List.prepend.end
List.prepend.end:       ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl List.print
List.print:             ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## abort(...)
                        pushq %r12
                        pushq %rbp
                        pushq %r12
                        ## obtain vtable for self object of type List
                        movq 16(%r12), %r14
                        ## look up abort() at offset 2 in vtable
                        movq 16(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
.globl List.print.end
List.print.end:         ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Main.main
Main.main:              ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 6
                        movq $48, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field graph (Dict)
                        ## self[4] holds field sorted_list (List)
                        ## self[5] holds field cycle (Bool)
                        ## method body begins
                        ## fp[0] holds local done (Bool)
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, 0(%rbp)
.globl l32
l32:                    ## while conditional check
                        ## done
                        movq 0(%rbp), %r13
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l34
.globl l35
l35:                    ## false branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp l36
.globl l34
l34:                    ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl l36
l36:                    ## end of if conditional
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			je l33
                        ## fp[-1] holds local dst (String)
                        ## in_string(...)
                        pushq %r12
                        pushq %rbp
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up in_string() at offset 6 in vtable
                        movq 48(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, -8(%rbp)
                        pushq %r12
                        pushq %rbp
                        ## dst
                        movq -8(%rbp), %r13
                        pushq %r13
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l37
.globl l38
l38:                    ## false branch
                        ## fp[-2] holds local src (String)
                        ## in_string(...)
                        pushq %r12
                        pushq %rbp
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up in_string() at offset 6 in vtable
                        movq 48(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, -16(%rbp)
                        ## graph.has_key(...)
                        pushq %r12
                        pushq %rbp
                        ## src
                        movq -16(%rbp), %r13
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l40
                        movq $string28, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l40
l40:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up has_key() at offset 10 in vtable
                        movq 80(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l41
.globl l42
l42:                    ## false branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp l43
.globl l41
l41:                    ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl l43
l43:                    ## end of if conditional
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l44
.globl l45
l45:                    ## false branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l46
.globl l44
l44:                    ## true branch
                        ## fp[-3] holds local adj_list (List)
                        ## new NilList
                        pushq %rbp
                        pushq %r12
                        movq $NilList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, -24(%rbp)
                        ## graph.put(...)
                        pushq %r12
                        pushq %rbp
                        ## src
                        movq -16(%rbp), %r13
                        pushq %r13
                        ## adj_list
                        movq -24(%rbp), %r13
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $0, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l47
                        movq $string29, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l47
l47:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up put() at offset 20 in vtable
                        movq 160(%r14), %r14
                        call *%r14
                        addq $32, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
.globl l46
l46:                    ## end of if conditional
                        ## graph.has_key(...)
                        pushq %r12
                        pushq %rbp
                        ## dst
                        movq -8(%rbp), %r13
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l48
                        movq $string30, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l48
l48:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up has_key() at offset 10 in vtable
                        movq 80(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l49
.globl l50
l50:                    ## false branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp l51
.globl l49
l49:                    ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl l51
l51:                    ## end of if conditional
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l52
.globl l53
l53:                    ## false branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l54
.globl l52
l52:                    ## true branch
                        ## fp[-3] holds local adj_list (List)
                        ## new NilList
                        pushq %rbp
                        pushq %r12
                        movq $NilList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, -24(%rbp)
                        ## graph.put(...)
                        pushq %r12
                        pushq %rbp
                        ## dst
                        movq -8(%rbp), %r13
                        pushq %r13
                        ## adj_list
                        movq -24(%rbp), %r13
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $0, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l55
                        movq $string31, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l55
l55:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up put() at offset 20 in vtable
                        movq 160(%r14), %r14
                        call *%r14
                        addq $32, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
.globl l54
l54:                    ## end of if conditional
                        ## fp[-3] holds local adj_list (List)
                        ## graph.get(...).get_value(...)
                        pushq %r12
                        pushq %rbp
                        ## graph.get(...)
                        pushq %r12
                        pushq %rbp
                        ## src
                        movq -16(%rbp), %r13
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l56
                        movq $string32, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l56
l56:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get() at offset 19 in vtable
                        movq 152(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        cmpq $0, %r13
			jne l57
                        movq $string32, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l57
l57:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_value() at offset 13 in vtable
                        movq 104(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, -24(%rbp)
                        ## graph.remove(...)
                        pushq %r12
                        pushq %rbp
                        ## src
                        movq -16(%rbp), %r13
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l58
                        movq $string33, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l58
l58:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up remove() at offset 21 in vtable
                        movq 168(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
                        ## adj_list.insert(...)
                        pushq %r12
                        pushq %rbp
                        ## dst
                        movq -8(%rbp), %r13
                        pushq %r13
                        ## adj_list
                        movq -24(%rbp), %r13
                        cmpq $0, %r13
			jne l59
                        movq $string34, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l59
l59:                    pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up insert() at offset 12 in vtable
                        movq 96(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, -24(%rbp)
                        ## graph.put(...)
                        pushq %r12
                        pushq %rbp
                        ## src
                        movq -16(%rbp), %r13
                        pushq %r13
                        ## adj_list
                        movq -24(%rbp), %r13
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $0, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l60
                        movq $string35, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l60
l60:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up put() at offset 20 in vtable
                        movq 160(%r14), %r14
                        call *%r14
                        addq $32, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
                        jmp l39
.globl l37
l37:                    ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        movq %r13, 0(%rbp)
.globl l39
l39:                    ## end of if conditional
                        jmp l32
.globl l33
l33:                    ## end of while loop
                        ## top_sort(...)
                        pushq %r12
                        pushq %rbp
                        ## graph
                        movq 24(%r12), %r13
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up top_sort() at offset 10 in vtable
                        movq 80(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        ## cycle
                        movq 40(%r12), %r13
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l61
.globl l62
l62:                    ## false branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp l63
.globl l61
l61:                    ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl l63
l63:                    ## end of if conditional
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l64
.globl l65
l65:                    ## false branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l66
.globl l64
l64:                    ## true branch
                        ## sorted_list.print(...)
                        pushq %r12
                        pushq %rbp
                        ## sorted_list
                        movq 32(%r12), %r13
                        cmpq $0, %r13
			jne l67
                        movq $string36, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l67
l67:                    pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up print() at offset 14 in vtable
                        movq 112(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
.globl l66
l66:                    ## end of if conditional
.globl Main.main.end
Main.main.end:          ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Main.top_sort
Main.top_sort:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field graph (Dict)
                        ## self[4] holds field sorted_list (List)
                        ## self[5] holds field cycle (Bool)
                        ## fp[3] holds argument node (Dict)
                        ## method body begins
                        pushq %r12
                        pushq %rbp
                        ## node.get_key(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l68
                        movq $string37, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l68
l68:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_key() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l69
.globl l70
l70:                    ## false branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp l71
.globl l69
l69:                    ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl l71
l71:                    ## end of if conditional
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l72
.globl l73
l73:                    ## false branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l74
.globl l72
l72:                    ## true branch
                        pushq %r12
                        pushq %rbp
                        ## graph.get(...).get_mark(...)
                        pushq %r12
                        pushq %rbp
                        ## graph.get(...)
                        pushq %r12
                        pushq %rbp
                        ## node.get_key(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l75
                        movq $string38, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l75
l75:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_key() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l76
                        movq $string38, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l76
l76:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get() at offset 19 in vtable
                        movq 152(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        cmpq $0, %r13
			jne l77
                        movq $string38, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l77
l77:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_mark() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $0, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l78
.globl l79
l79:                    ## false branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l80
.globl l78
l78:                    ## true branch
                        ## visit(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up visit() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
.globl l80
l80:                    ## end of if conditional
                        ## top_sort(...)
                        pushq %r12
                        pushq %rbp
                        ## node.get_tail(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l81
                        movq $string39, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l81
l81:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_tail() at offset 17 in vtable
                        movq 136(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up top_sort() at offset 10 in vtable
                        movq 80(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
.globl l74
l74:                    ## end of if conditional
.globl Main.top_sort.end
Main.top_sort.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Main.visit
Main.visit:             ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 2
                        movq $16, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field graph (Dict)
                        ## self[4] holds field sorted_list (List)
                        ## self[5] holds field cycle (Bool)
                        ## fp[3] holds argument node (Dict)
                        ## method body begins
                        ## fp[0] holds local temp (Dict)
                        ## node
                        movq 24(%rbp), %r13
                        movq %r13, 0(%rbp)
                        ## graph.remove(...)
                        pushq %r12
                        pushq %rbp
                        ## node.get_key(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l82
                        movq $string40, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l82
l82:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_key() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l83
                        movq $string40, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l83
l83:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up remove() at offset 21 in vtable
                        movq 168(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
                        ## graph.put(...)
                        pushq %r12
                        pushq %rbp
                        ## temp.get_key(...)
                        pushq %r12
                        pushq %rbp
                        ## temp
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l84
                        movq $string41, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l84
l84:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_key() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## temp.get_value(...)
                        pushq %r12
                        pushq %rbp
                        ## temp
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l85
                        movq $string41, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l85
l85:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_value() at offset 13 in vtable
                        movq 104(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l86
                        movq $string41, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l86
l86:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up put() at offset 20 in vtable
                        movq 160(%r14), %r14
                        call *%r14
                        addq $32, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
                        ## visit_helper(...)
                        pushq %r12
                        pushq %rbp
                        ## node.get_value(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l87
                        movq $string42, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l87
l87:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_value() at offset 13 in vtable
                        movq 104(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up visit_helper() at offset 12 in vtable
                        movq 96(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        ## fp[0] holds local temp (Dict)
                        ## node
                        movq 24(%rbp), %r13
                        movq %r13, 0(%rbp)
                        ## graph.remove(...)
                        pushq %r12
                        pushq %rbp
                        ## node.get_key(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l88
                        movq $string43, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l88
l88:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_key() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l89
                        movq $string43, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l89
l89:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up remove() at offset 21 in vtable
                        movq 168(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
                        ## graph.put(...)
                        pushq %r12
                        pushq %rbp
                        ## temp.get_key(...)
                        pushq %r12
                        pushq %rbp
                        ## temp
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l90
                        movq $string44, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l90
l90:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_key() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## temp.get_value(...)
                        pushq %r12
                        pushq %rbp
                        ## temp
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l91
                        movq $string44, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l91
l91:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_value() at offset 13 in vtable
                        movq 104(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $2, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l92
                        movq $string44, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l92
l92:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up put() at offset 20 in vtable
                        movq 160(%r14), %r14
                        call *%r14
                        addq $32, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 24(%r12)
                        ## sorted_list.prepend(...)
                        pushq %r12
                        pushq %rbp
                        ## node.get_key(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l93
                        movq $string45, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l93
l93:                    pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_key() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## sorted_list
                        movq 32(%r12), %r13
                        cmpq $0, %r13
			jne l94
                        movq $string45, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l94
l94:                    pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up prepend() at offset 13 in vtable
                        movq 104(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 32(%r12)
.globl Main.visit.end
Main.visit.end:         ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl Main.visit_helper
Main.visit_helper:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 3
                        movq $24, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## self[3] holds field graph (Dict)
                        ## self[4] holds field sorted_list (List)
                        ## self[5] holds field cycle (Bool)
                        ## fp[3] holds argument adj (List)
                        ## method body begins
                        pushq %r12
                        pushq %rbp
                        ## adj.get_head(...)
                        pushq %r12
                        pushq %rbp
                        ## adj
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l95
                        movq $string46, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l95
l95:                    pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up get_head() at offset 10 in vtable
                        movq 80(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l96
.globl l97
l97:                    ## false branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp l98
.globl l96
l96:                    ## true branch
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl l98
l98:                    ## end of if conditional
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l99
.globl l100
l100:                   ## false branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l101
.globl l99
l99:                    ## true branch
                        ## fp[0] holds local node (Dict)
                        ## graph.get(...)
                        pushq %r12
                        pushq %rbp
                        ## adj.get_head(...)
                        pushq %r12
                        pushq %rbp
                        ## adj
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l102
                        movq $string47, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l102
l102:                   pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up get_head() at offset 10 in vtable
                        movq 80(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## graph
                        movq 24(%r12), %r13
                        cmpq $0, %r13
			jne l103
                        movq $string47, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l103
l103:                   pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get() at offset 19 in vtable
                        movq 152(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        movq %r13, 0(%rbp)
                        pushq %r12
                        pushq %rbp
                        ## node.get_mark(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l104
                        movq $string48, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l104
l104:                   pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_mark() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $0, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l105
.globl l106
l106:                   ## false branch
                        pushq %r12
                        pushq %rbp
                        ## node.get_mark(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 0(%rbp), %r13
                        cmpq $0, %r13
			jne l108
                        movq $string49, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l108
l108:                   pushq %r13
                        ## obtain vtable from object in r1 with static type Dict
                        movq 16(%r13), %r14
                        ## look up get_mark() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        call eq_handler
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
                        movq 24(%r13), %r13
                        cmpq $0, %r13
			jne l109
.globl l110
l110:                   ## false branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        jmp l111
.globl l109
l109:                   ## true branch
                        ## out_string(...)
                        pushq %r12
                        pushq %rbp
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string50 holds "cycle\n"
                        movq $string50, %r14
                        movq %r14, 24(%r13)
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up out_string() at offset 8 in vtable
                        movq 64(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        movq %r13, 40(%r12)
.globl l111
l111:                   ## end of if conditional
                        jmp l107
.globl l105
l105:                   ## true branch
                        ## visit(...)
                        pushq %r12
                        pushq %rbp
                        ## node
                        movq 0(%rbp), %r13
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up visit() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
.globl l107
l107:                   ## end of if conditional
                        ## visit_helper(...)
                        pushq %r12
                        pushq %rbp
                        ## adj.get_tail(...)
                        pushq %r12
                        pushq %rbp
                        ## adj
                        movq 24(%rbp), %r13
                        cmpq $0, %r13
			jne l112
                        movq $string51, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l112
l112:                   pushq %r13
                        ## obtain vtable from object in r1 with static type List
                        movq 16(%r13), %r14
                        ## look up get_tail() at offset 11 in vtable
                        movq 88(%r14), %r14
                        call *%r14
                        addq $8, %rsp
                        popq %rbp
                        popq %r12
                        pushq %r13
                        pushq %r12
                        ## obtain vtable for self object of type Main
                        movq 16(%r12), %r14
                        ## look up visit_helper() at offset 12 in vtable
                        movq 96(%r14), %r14
                        call *%r14
                        addq $16, %rsp
                        popq %rbp
                        popq %r12
.globl l101
l101:                   ## end of if conditional
.globl Main.visit_helper.end
Main.visit_helper.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.has_key
NilDict.has_key:        ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl NilDict.has_key.end
NilDict.has_key.end:    ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.get_key
NilDict.get_key:        ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
.globl NilDict.get_key.end
NilDict.get_key.end:    ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.set_key
NilDict.set_key:        ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        movq %r12, %r13
.globl NilDict.set_key.end
NilDict.set_key.end:    ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.get_value
NilDict.get_value:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new NilList
                        pushq %rbp
                        pushq %r12
                        movq $NilList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
.globl NilDict.get_value.end
NilDict.get_value.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.set_value
NilDict.set_value:      ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument v (List)
                        ## method body begins
                        movq %r12, %r13
.globl NilDict.set_value.end
NilDict.set_value.end:  ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.get_mark
NilDict.get_mark:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $0, %r14
                        movq %r14, 24(%r13)
.globl NilDict.get_mark.end
NilDict.get_mark.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.set_mark
NilDict.set_mark:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument m (Int)
                        ## method body begins
                        movq %r12, %r13
.globl NilDict.set_mark.end
NilDict.set_mark.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.get_tail
NilDict.get_tail:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        movq %r12, %r13
.globl NilDict.get_tail.end
NilDict.get_tail.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.set_tail
NilDict.set_tail:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument t (Dict)
                        ## method body begins
                        movq %r12, %r13
.globl NilDict.set_tail.end
NilDict.set_tail.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.get
NilDict.get:            ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        movq %r12, %r13
.globl NilDict.get.end
NilDict.get.end:        ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.put
NilDict.put:            ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[5] holds argument k (String)
                        ## fp[4] holds argument v (List)
                        ## fp[3] holds argument m (Int)
                        ## method body begins
                        ## new ConsDict.init(...)
                        pushq %r12
                        pushq %rbp
                        ## k
                        movq 40(%rbp), %r13
                        pushq %r13
                        ## v
                        movq 32(%rbp), %r13
                        pushq %r13
                        ## m
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## new ConsDict
                        pushq %rbp
                        pushq %r12
                        movq $ConsDict..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l113
                        movq $string52, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l113
l113:                   pushq %r13
                        ## obtain vtable from object in r1 with static type ConsDict
                        movq 16(%r13), %r14
                        ## look up init() at offset 23 in vtable
                        movq 184(%r14), %r14
                        call *%r14
                        addq $40, %rsp
                        popq %rbp
                        popq %r12
.globl NilDict.put.end
NilDict.put.end:        ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.remove
NilDict.remove:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument k (String)
                        ## method body begins
                        movq %r12, %r13
.globl NilDict.remove.end
NilDict.remove.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilDict.print
NilDict.print:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
.globl NilDict.print.end
NilDict.print.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList.get_head
NilList.get_head:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        ## string27 holds ""
                        movq $string27, %r14
                        movq %r14, 24(%r13)
.globl NilList.get_head.end
NilList.get_head.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList.get_tail
NilList.get_tail:       ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        movq %r12, %r13
.globl NilList.get_tail.end
NilList.get_tail.end:   ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList.insert
NilList.insert:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        ## new ConsList.init(...)
                        pushq %r12
                        pushq %rbp
                        ## s
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## new ConsList
                        pushq %rbp
                        pushq %r12
                        movq $ConsList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l114
                        movq $string53, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l114
l114:                   pushq %r13
                        ## obtain vtable from object in r1 with static type ConsList
                        movq 16(%r13), %r14
                        ## look up init() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
.globl NilList.insert.end
NilList.insert.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList.prepend
NilList.prepend:        ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        ## new ConsList.init(...)
                        pushq %r12
                        pushq %rbp
                        ## s
                        movq 24(%rbp), %r13
                        pushq %r13
                        movq %r12, %r13
                        pushq %r13
                        ## new ConsList
                        pushq %rbp
                        pushq %r12
                        movq $ConsList..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        cmpq $0, %r13
			jne l115
                        movq $string54, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l115
l115:                   pushq %r13
                        ## obtain vtable from object in r1 with static type ConsList
                        movq 16(%r13), %r14
                        ## look up init() at offset 15 in vtable
                        movq 120(%r14), %r14
                        call *%r14
                        addq $24, %rsp
                        popq %rbp
                        popq %r12
.globl NilList.prepend.end
NilList.prepend.end:    ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList.print
NilList.print:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
.globl NilList.print.end
NilList.print.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl NilList.remove
NilList.remove:         ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        movq %r12, %r13
.globl NilList.remove.end
NilList.remove.end:     ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl String.concat
String.concat:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[3] holds argument s (String)
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, %r15
                        movq 24(%rbp), %r14
                        movq 24(%r14), %r14
                        movq 24(%r12), %r13
                        movq %r13, %rdi
			movq %r14, %rsi
			call coolstrcat
			movq %rax, %r13
                        movq %r13, 24(%r15)
                        movq %r15, %r13
.globl String.concat.end
String.concat.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl String.length
String.length:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## method body begins
                        ## new Int
                        pushq %rbp
                        pushq %r12
                        movq $Int..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, %r14
                        movq 24(%r12), %r13
                        movq %r13, %rdi
			movl $0, %eax
			call coolstrlen
			movq %rax, %r13
                        movq %r13, 24(%r14)
                        movq %r14, %r13
.globl String.length.end
String.length.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl String.substr
String.substr:          ## method definition
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 16(%rbp), %r12
                        ## stack room for temporaries: 1
                        movq $8, %r14
                        subq %r14, %rsp
                        ## return address handling
                        ## fp[4] holds argument i (Int)
                        ## fp[3] holds argument l (Int)
                        ## method body begins
                        ## new String
                        pushq %rbp
                        pushq %r12
                        movq $String..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq %r13, %r15
                        movq 24(%rbp), %r14
                        movq 24(%r14), %r14
                        movq 32(%rbp), %r13
                        movq 24(%r13), %r13
                        movq 24(%r12), %r12
                        movq %r12, %rdi
			movq %r13, %rsi
			movq %r14, %rdx
			call coolsubstr
			movq %rax, %r13
                        cmpq $0, %r13
			jne l116
                        movq $string55, %r13
                        movq %r13, %rdi
			call cooloutstr
                        movl $0, %edi
			call exit
.globl l116
l116:                   movq %r13, 24(%r15)
                        movq %r15, %r13
.globl String.substr.end
String.substr.end:      ## method body ends
                        ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                        ## global string constants
.globl the.empty.string
the.empty.string:       # ""
.byte 0

.globl percent.d
percent.d:              # "%ld"
.byte  37 # '%'
.byte 108 # 'l'
.byte 100 # 'd'
.byte 0

.globl percent.ld
percent.ld:             # " %ld"
.byte  32 # ' '
.byte  37 # '%'
.byte 108 # 'l'
.byte 100 # 'd'
.byte 0

.globl string1
string1:                # "Bool"
.byte  66 # 'B'
.byte 111 # 'o'
.byte 111 # 'o'
.byte 108 # 'l'
.byte 0

.globl string2
string2:                # "ConsDict"
.byte  67 # 'C'
.byte 111 # 'o'
.byte 110 # 'n'
.byte 115 # 's'
.byte  68 # 'D'
.byte 105 # 'i'
.byte  99 # 'c'
.byte 116 # 't'
.byte 0

.globl string3
string3:                # "ConsList"
.byte  67 # 'C'
.byte 111 # 'o'
.byte 110 # 'n'
.byte 115 # 's'
.byte  76 # 'L'
.byte 105 # 'i'
.byte 115 # 's'
.byte 116 # 't'
.byte 0

.globl string4
string4:                # "Dict"
.byte  68 # 'D'
.byte 105 # 'i'
.byte  99 # 'c'
.byte 116 # 't'
.byte 0

.globl string5
string5:                # "IO"
.byte  73 # 'I'
.byte  79 # 'O'
.byte 0

.globl string6
string6:                # "Int"
.byte  73 # 'I'
.byte 110 # 'n'
.byte 116 # 't'
.byte 0

.globl string7
string7:                # "List"
.byte  76 # 'L'
.byte 105 # 'i'
.byte 115 # 's'
.byte 116 # 't'
.byte 0

.globl string8
string8:                # "Main"
.byte  77 # 'M'
.byte  97 # 'a'
.byte 105 # 'i'
.byte 110 # 'n'
.byte 0

.globl string9
string9:                # "NilDict"
.byte  78 # 'N'
.byte 105 # 'i'
.byte 108 # 'l'
.byte  68 # 'D'
.byte 105 # 'i'
.byte  99 # 'c'
.byte 116 # 't'
.byte 0

.globl string10
string10:               # "NilList"
.byte  78 # 'N'
.byte 105 # 'i'
.byte 108 # 'l'
.byte  76 # 'L'
.byte 105 # 'i'
.byte 115 # 's'
.byte 116 # 't'
.byte 0

.globl string11
string11:               # "Object"
.byte  79 # 'O'
.byte  98 # 'b'
.byte 106 # 'j'
.byte 101 # 'e'
.byte  99 # 'c'
.byte 116 # 't'
.byte 0

.globl string12
string12:               # "String"
.byte  83 # 'S'
.byte 116 # 't'
.byte 114 # 'r'
.byte 105 # 'i'
.byte 110 # 'n'
.byte 103 # 'g'
.byte 0

.globl string13
string13:               # "abort\\n"
.byte  97 # 'a'
.byte  98 # 'b'
.byte 111 # 'o'
.byte 114 # 'r'
.byte 116 # 't'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string14
string14:               # "ERROR: 225: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  50 # '2'
.byte  50 # '2'
.byte  53 # '5'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string15
string15:               # "ERROR: 264: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  50 # '2'
.byte  54 # '6'
.byte  52 # '4'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string16
string16:               # "ERROR: 320: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  51 # '3'
.byte  50 # '2'
.byte  48 # '0'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string17
string17:               # "ERROR: 330: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  51 # '3'
.byte  51 # '3'
.byte  48 # '0'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string18
string18:               # "ERROR: 328: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  51 # '3'
.byte  50 # '2'
.byte  56 # '8'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string19
string19:               # "ERROR: 310: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  51 # '3'
.byte  49 # '1'
.byte  48 # '0'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string20
string20:               # "ERROR: 338: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  51 # '3'
.byte  51 # '3'
.byte  56 # '8'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string21
string21:               # "ERROR: 157: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  53 # '5'
.byte  55 # '7'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string22
string22:               # "ERROR: 191: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  57 # '9'
.byte  49 # '1'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string23
string23:               # "ERROR: 188: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  56 # '8'
.byte  56 # '8'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string24
string24:               # "ERROR: 198: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  57 # '9'
.byte  56 # '8'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string25
string25:               # "\\n"
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string26
string26:               # "ERROR: 205: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  50 # '2'
.byte  48 # '0'
.byte  53 # '5'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string27
string27:               # ""
.byte 0

.globl string28
string28:               # "ERROR: 39: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  51 # '3'
.byte  57 # '9'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string29
string29:               # "ERROR: 42: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  52 # '4'
.byte  50 # '2'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string30
string30:               # "ERROR: 49: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  52 # '4'
.byte  57 # '9'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string31
string31:               # "ERROR: 52: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  53 # '5'
.byte  50 # '2'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string32
string32:               # "ERROR: 60: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  54 # '6'
.byte  48 # '0'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string33
string33:               # "ERROR: 62: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  54 # '6'
.byte  50 # '2'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string34
string34:               # "ERROR: 63: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  54 # '6'
.byte  51 # '3'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string35
string35:               # "ERROR: 64: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  54 # '6'
.byte  52 # '4'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string36
string36:               # "ERROR: 74: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  55 # '7'
.byte  52 # '4'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string37
string37:               # "ERROR: 83: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  56 # '8'
.byte  51 # '3'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string38
string38:               # "ERROR: 84: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  56 # '8'
.byte  52 # '4'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string39
string39:               # "ERROR: 90: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  57 # '9'
.byte  48 # '0'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string40
string40:               # "ERROR: 104: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  48 # '0'
.byte  52 # '4'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string41
string41:               # "ERROR: 105: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  48 # '0'
.byte  53 # '5'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string42
string42:               # "ERROR: 108: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  48 # '0'
.byte  56 # '8'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string43
string43:               # "ERROR: 112: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  49 # '1'
.byte  50 # '2'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string44
string44:               # "ERROR: 113: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  49 # '1'
.byte  51 # '3'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string45
string45:               # "ERROR: 116: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  49 # '1'
.byte  54 # '6'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string46
string46:               # "ERROR: 123: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  50 # '2'
.byte  51 # '3'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string47
string47:               # "ERROR: 124: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  50 # '2'
.byte  52 # '4'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string48
string48:               # "ERROR: 126: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  50 # '2'
.byte  54 # '6'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string49
string49:               # "ERROR: 131: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  51 # '3'
.byte  49 # '1'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string50
string50:               # "cycle\\n"
.byte  99 # 'c'
.byte 121 # 'y'
.byte  99 # 'c'
.byte 108 # 'l'
.byte 101 # 'e'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string51
string51:               # "ERROR: 142: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  49 # '1'
.byte  52 # '4'
.byte  50 # '2'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string52
string52:               # "ERROR: 359: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  51 # '3'
.byte  53 # '5'
.byte  57 # '9'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string53
string53:               # "ERROR: 215: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  50 # '2'
.byte  49 # '1'
.byte  53 # '5'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string54
string54:               # "ERROR: 214: Exception: dispatch on void\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  50 # '2'
.byte  49 # '1'
.byte  52 # '4'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte 100 # 'd'
.byte 105 # 'i'
.byte 115 # 's'
.byte 112 # 'p'
.byte  97 # 'a'
.byte 116 # 't'
.byte  99 # 'c'
.byte 104 # 'h'
.byte  32 # ' '
.byte 111 # 'o'
.byte 110 # 'n'
.byte  32 # ' '
.byte 118 # 'v'
.byte 111 # 'o'
.byte 105 # 'i'
.byte 100 # 'd'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

.globl string55
string55:               # "ERROR: 0: Exception: String.substr out of range\\n"
.byte  69 # 'E'
.byte  82 # 'R'
.byte  82 # 'R'
.byte  79 # 'O'
.byte  82 # 'R'
.byte  58 # ':'
.byte  32 # ' '
.byte  48 # '0'
.byte  58 # ':'
.byte  32 # ' '
.byte  69 # 'E'
.byte 120 # 'x'
.byte  99 # 'c'
.byte 101 # 'e'
.byte 112 # 'p'
.byte 116 # 't'
.byte 105 # 'i'
.byte 111 # 'o'
.byte 110 # 'n'
.byte  58 # ':'
.byte  32 # ' '
.byte  83 # 'S'
.byte 116 # 't'
.byte 114 # 'r'
.byte 105 # 'i'
.byte 110 # 'n'
.byte 103 # 'g'
.byte  46 # '.'
.byte 115 # 's'
.byte 117 # 'u'
.byte  98 # 'b'
.byte 115 # 's'
.byte 116 # 't'
.byte 114 # 'r'
.byte  32 # ' '
.byte 111 # 'o'
.byte 117 # 'u'
.byte 116 # 't'
.byte  32 # ' '
.byte 111 # 'o'
.byte 102 # 'f'
.byte  32 # ' '
.byte 114 # 'r'
.byte  97 # 'a'
.byte 110 # 'n'
.byte 103 # 'g'
.byte 101 # 'e'
.byte  92 # '\\'
.byte 110 # 'n'
.byte 0

                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl eq_handler
eq_handler:             ## helper function for =
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 32(%rbp), %r12
                        ## return address handling
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je eq_true
                        movq $0, %r15
                        cmpq %r15, %r13
			je eq_false
                        cmpq %r15, %r14
			je eq_false
                        movq 0(%r13), %r13
                        movq 0(%r14), %r14
                        ## place the sum of the type tags in r1
                        addq %r14, %r13
                        movq $0, %r14
                        cmpq %r14, %r13
			je eq_bool
                        movq $2, %r14
                        cmpq %r14, %r13
			je eq_int
                        movq $6, %r14
                        cmpq %r14, %r13
			je eq_string
                        ## otherwise, use pointer comparison
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je eq_true
.globl eq_false
eq_false:               ## not equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        jmp eq_end
.globl eq_true
eq_true:                ## equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp eq_end
.globl eq_bool
eq_bool:                ## two Bools
.globl eq_int
eq_int:                 ## two Ints
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        cmpq %r14, %r13
			je eq_true
                        jmp eq_false
.globl eq_string
eq_string:              ## two Strings
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        
  movq %r13, %rdi
  movq %r14, %rsi
  call strcmp 
  cmp $0, %eax
  je eq_true
                        jmp eq_false
.globl eq_end
eq_end:                 ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl le_handler
le_handler:             ## helper function for <=
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 32(%rbp), %r12
                        ## return address handling
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je le_true
                        movq $0, %r15
                        cmpq %r15, %r13
			je le_false
                        cmpq %r15, %r14
			je le_false
                        movq 0(%r13), %r13
                        movq 0(%r14), %r14
                        ## place the sum of the type tags in r1
                        addq %r14, %r13
                        movq $0, %r14
                        cmpq %r14, %r13
			je le_bool
                        movq $2, %r14
                        cmpq %r14, %r13
			je le_int
                        movq $6, %r14
                        cmpq %r14, %r13
			je le_string
                        ## for non-primitives, equality is our only hope
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        cmpq %r14, %r13
			je le_true
.globl le_false
le_false:               ## not less-than-or-equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        jmp le_end
.globl le_true
le_true:                ## less-than-or-equal
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp le_end
.globl le_bool
le_bool:                ## two Bools
.globl le_int
le_int:                 ## two Ints
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        cmpl %r14d, %r13d
			jle le_true
                        jmp le_false
.globl le_string
le_string:              ## two Strings
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        
  movq %r13, %rdi
  movq %r14, %rsi
  call strcmp 
  cmp $0, %eax
  jle le_true
                        jmp le_false
.globl le_end
le_end:                 ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl lt_handler
lt_handler:             ## helper function for <
                        pushq %rbp
                        movq %rsp, %rbp
                        movq 32(%rbp), %r12
                        ## return address handling
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq $0, %r15
                        cmpq %r15, %r13
			je lt_false
                        cmpq %r15, %r14
			je lt_false
                        movq 0(%r13), %r13
                        movq 0(%r14), %r14
                        ## place the sum of the type tags in r1
                        addq %r14, %r13
                        movq $0, %r14
                        cmpq %r14, %r13
			je lt_bool
                        movq $2, %r14
                        cmpq %r14, %r13
			je lt_int
                        movq $6, %r14
                        cmpq %r14, %r13
			je lt_string
                        ## for non-primitives, < is always false
.globl lt_false
lt_false:               ## not less than
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        jmp lt_end
.globl lt_true
lt_true:                ## less than
                        ## new Bool
                        pushq %rbp
                        pushq %r12
                        movq $Bool..new, %r14
                        call *%r14
                        popq %r12
                        popq %rbp
                        movq $1, %r14
                        movq %r14, 24(%r13)
                        jmp lt_end
.globl lt_bool
lt_bool:                ## two Bools
.globl lt_int
lt_int:                 ## two Ints
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        cmpl %r14d, %r13d
			jl lt_true
                        jmp lt_false
.globl lt_string
lt_string:              ## two Strings
                        movq 32(%rbp), %r13
                        movq 24(%rbp), %r14
                        movq 24(%r13), %r13
                        movq 24(%r14), %r14
                        
  movq %r13, %rdi
  movq %r14, %rsi
  call strcmp 
  cmp $0, %eax
  jl lt_true
                        jmp lt_false
.globl lt_end
lt_end:                 ## return address handling
                        movq %rbp, %rsp
                        popq %rbp
                        ret
                        ## ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.globl start
start:                  ## program begins here
                        .globl main
			.type main, @function
main:
                        movq $Main..new, %r14
                        pushq %rbp
                        call *%r14
                        pushq %rbp
                        pushq %r13
                        movq $Main.main, %r14
                        call *%r14
                        movl $0, %edi
			call exit
                        
.globl cooloutstr
	.type	cooloutstr, @function
cooloutstr:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L2
.L5:
	movl	-4(%rbp), %eax
	cltq
	addq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$92, %al
	jne	.L3
	movl	-4(%rbp), %eax
	cltq
	addq	$1, %rax
	addq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$110, %al
	jne	.L3
	movq	stdout(%rip), %rax
	movq	%rax, %rsi
	movl	$10, %edi
	call	fputc
	addl	$2, -4(%rbp)
	jmp	.L2
.L3:
	movl	-4(%rbp), %eax
	cltq
	addq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$92, %al
	jne	.L4
	movl	-4(%rbp), %eax
	cltq
	addq	$1, %rax
	addq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$116, %al
	jne	.L4
	movq	stdout(%rip), %rax
	movq	%rax, %rsi
	movl	$9, %edi
	call	fputc
	addl	$2, -4(%rbp)
	jmp	.L2
.L4:
	movq	stdout(%rip), %rdx
	movl	-4(%rbp), %eax
	cltq
	addq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	fputc
	addl	$1, -4(%rbp)
.L2:
	movl	-4(%rbp), %eax
	cltq
	addq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L5
	movq	stdout(%rip), %rax
	movq	%rax, %rdi
	call	fflush
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	cooloutstr, .-cooloutstr
.globl coolstrlen
	.type	coolstrlen, @function
coolstrlen:
.LFB1:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)
	movl	$0, -4(%rbp)
	jmp	.L7
.L8:
	movl	-4(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
.L7:
	movl	-4(%rbp), %eax
	mov	%eax, %eax
	addq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L8
	movl	-4(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	coolstrlen, .-coolstrlen
	.section	.rodata
.LC0:
	.string	"%s%s"
	.text
.globl coolstrcat
	.type	coolstrcat, @function
coolstrcat:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.L10
	.cfi_offset 3, -24
	movq	-48(%rbp), %rax
	jmp	.L11
.L10:
	cmpq	$0, -48(%rbp)
	jne	.L12
	movq	-40(%rbp), %rax
	jmp	.L11
.L12:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	coolstrlen
	movl	%eax, %ebx
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	coolstrlen
	leal	(%rbx,%rax), %eax
	addl	$1, %eax
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	cltq
	movl	$1, %esi
	movq	%rax, %rdi
	call	calloc
	movq	%rax, -32(%rbp)
	movl	$.LC0, %edx
	movl	-20(%rbp), %eax
	movslq	%eax, %rbx
	movq	-48(%rbp), %rsi
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rax
	movq	%rsi, %r8
	movq	%rbx, %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf
	movq	-32(%rbp), %rax
.L11:
	addq	$40, %rsp
	popq	%rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	coolstrcat, .-coolstrcat
	.section	.rodata
.LC1:
	.string	""
	.text
.globl coolgetstr
	.type	coolgetstr, @function
coolgetstr:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	$1, %esi
	movl	$40960, %edi
	call	calloc
	movq	%rax, -16(%rbp)
	movl	$0, -4(%rbp)
.L20:
	movq	stdin(%rip), %rax
	movq	%rax, %rdi
	call	fgetc
	movl	%eax, -20(%rbp)
	cmpl	$-1, -20(%rbp)
	je	.L14
	cmpl	$10, -20(%rbp)
	jne	.L15
.L14:
	cmpl	$0, -4(%rbp)
	je	.L16
	movl	$.LC1, %eax
	jmp	.L17
.L16:
	movq	-16(%rbp), %rax
	jmp	.L17
.L15:
	cmpl	$0, -20(%rbp)
	jne	.L18
	movl	$1, -4(%rbp)
	jmp	.L20
.L18:
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	coolstrlen
	mov	%eax, %eax
	addq	-16(%rbp), %rax
	movl	-20(%rbp), %edx
	movb	%dl, (%rax)
	jmp	.L20
.L17:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3:
	.size	coolgetstr, .-coolgetstr
.globl coolsubstr
	.type	coolsubstr, @function
coolsubstr:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	coolstrlen
	movl	%eax, -4(%rbp)
	cmpq	$0, -32(%rbp)
	js	.L22
	cmpq	$0, -40(%rbp)
	js	.L22
	movq	-40(%rbp), %rax
	movq	-32(%rbp), %rdx
	addq	%rax, %rdx
	movl	-4(%rbp), %eax
	cltq
	cmpq	%rax, %rdx
	jle	.L23
.L22:
	movl	$0, %eax
	jmp	.L24
.L23:
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	addq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strndup
.L24:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	coolsubstr, .-coolsubstr

