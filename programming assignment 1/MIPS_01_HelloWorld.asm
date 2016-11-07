# This program prints "Hello World" (already stored in memory) to the I/O window
# Procedure to print a string to I/O window:
# 1. Load the address of the string to register $a0
# 2. Load register $v0 with 4
# 3. Issue "syscall"
.data	# What follows will be data
display: .asciiz "This is a Test to see if I can type anything in here.\n"	# the string "Hello World" is stored in the buffer named "display"
.text	# What follows will be actual code
main: 				
	la	$a0, display	# Load the address of "display" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# Issue "syscall"
	
