#!/bin/bash
# Remove the binary before attempting assemble and link it again.
# Testing
rm flowtest
rm flowtest.o
as --32 flowtest.s -oflowtest.o &&
ld -m elf_i386 flowtest.o -oflowtest
