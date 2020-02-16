#!/bin/bash
# Remove the binary before attempting assemble and link it again.
# Testing
rm test
rm test.o
as --32 test.s -o test.o &&
ld -m elf_i386 test.o -o test
