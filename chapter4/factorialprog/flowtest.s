# Testing the flow of the program

.section .data

.section .text

.globl _start
.globl f1

_start:
	call f1

	movl $1, %eax
	int $0x80


.type f1,@function

f1:
	pushl %ebp
	movl %esp, %ebp
	movl $5, %ebx 

	jmp end_f1
	movl %ebp, %esp
	popl %ebp	
	ret

end_f1:

	movl $6, %ebx
	movl %ebp, %esp
	popl %ebp	
	ret
