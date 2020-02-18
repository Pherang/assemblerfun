#!/bin/bash
# Remove the binary before attempting assemble and link it again.
# Testing
rm factorial_iter
rm factorial_iter.o
as --32 factorial_iter.s -o factorial_iter.o &&
ld -m elf_i386 factorial_iter.o -o factorial_iter
