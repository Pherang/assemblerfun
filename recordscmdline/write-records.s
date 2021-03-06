.include "linux.s"
.include "record-def.s"

.section .data

#Constant data of the records we want to write.
#Each text data item is padded to the proper length with null 
#bytes

# .rept is used to pad each item .rept tells
# the assembler to repeat the section between
# .rept and .endr the number of times specified.
# Thisis used in this program to add extra null characters
# at the end of each field to fill it up.

record1:
	.ascii "Frederick\0"
	.rept 30 #Padding to 40 bytes
	.byte 0
	.endr

	.ascii "Bartlett\0"
	.rept 31
	.byte 0
	.endr

	.ascii "4242 S Prairie\nTulsa, OK 55555\0"
	.rept 209
	.byte 0
	.endr
	
	.long 65

record2:
	.ascii "Marilyn\0"
	.rept 32
	.byte 0
	.endr

	.ascii "Taylor\0"
	.rept 33
	.byte 0
	.endr

	.ascii "2224 S Johannan St\nChicago, IL 12345\0"
	.rept 202
	.byte 0
	.endr
	
	.long 68

record3:
	.ascii "Derrick\0"
	.rept 32
	.byte 0
	.endr

	.ascii "McIntire\0"
	.rept 31
	.byte 0
	.endr

	.ascii "500 W Oakland\nSan Siego, CA 54321\0"
	.rept 206
	.byte 0
	.endr

	.long 70
			
record4:
	.ascii "Donald\0"
	.rept 33
	.byte 0
	.endr

	.ascii "Duck\0"
	.rept 35
	.byte 0
	.endr

	.ascii "500 W Oakland\nSan Siego, CA 54321\0"
	.rept 206
	.byte 0
	.endr

	.long 66

file_name:
	.ascii "test.dat\0"

	.equ ST_FILE_DESCRIPTOR, -4


.section .text
.globl _start

#STACK POSITIONS
.equ ST_SIZE_RESERVE, 8
.equ ST_FD_IN, -4
.equ ST_FD_OUT, -8
.equ ST_ARGC, 0
.equ ST_ARGV_0, 4
.equ ST_ARGV_1, 8
.equ ST_ARGV_2, 12

_start:

#Standard stack operations
movl %esp, %ebp
subl $4, %esp

#open the output file
movl $SYS_OPEN, %eax
movl ST_ARGV_1(%ebp), %ebx
movl $03101, %ecx	#This creates file if it doesn't exist
movl $0666, %edx
int $LINUX_SYSCALL

#Store the file descriptor away
movl %eax, ST_FILE_DESCRIPTOR(%ebp)

#Write the first record
pushl ST_FILE_DESCRIPTOR(%ebp)
pushl $record1
call write_record
addl $8, %esp

#Write the second record	
pushl ST_FILE_DESCRIPTOR(%ebp)
pushl $record2
call write_record
addl $8, %esp

#Write the third record
pushl ST_FILE_DESCRIPTOR(%ebp)
pushl $record3
call write_record
addl $8, %esp

#Write the third record
pushl ST_FILE_DESCRIPTOR(%ebp)
pushl $record4
call write_record
addl $8, %esp

#Close the file descriptor
movl $SYS_CLOSE, %eax
movl ST_FILE_DESCRIPTOR(%ebp), %ebx
int $LINUX_SYSCALL

#Exit the program
movl $SYS_EXIT, %eax
movl $0, %ebx
int $LINUX_SYSCALL
