.data			# What follows will be data
inputString: .space 64	# set aside 64 bytes to store the input string
prompt: .asciiz "Enter a string: "
#display: .asciiz "You typed: "
.text			# What follows will be actual code
main: 
	# Display prompt
	la	$a0, prompt	# display the prompt to begin
	li	$v0, 4	# system call code to print a string to console
	syscall
	# get the string from console
	la	$a0, inputString	# load $a0 with the address of inputString; procedure: $a0 = buffer, $a1 = length of buffer
	la	$a1, inputString	# maximum number of character
	li	$v0, 8	# The system call code to read a string input
	syscall
#	# Print "You typed: " to console
#	la	$a0, display	
#	li	$v0, 4
#	syscall
	# Print the entered string to console
#	la	$a0, inputString
#	li	$v0, 4
#	syscall
strcopy:
    addi $sp, $sp, -4 #adjust stack for 1 item
    sw $s0, 0($sp) #save $s0
    add $s0, $zero, $zero #i = 0
L1: add $t1, $s0, $a1 #addr of y[i] in $tl
    lbu $t2, 0($t1) #st2 = y[i]
    add $t3, $s0, $a0 #addr of x[i] in $t3
    sb $t2, 0($t3) #x[i] = y[i]     
    beq $t2, $zero, L2 #exit look if y[i] == 0
    addi $s0, $s0, 1 #i = i + 1
    j L1 #next iteration of the loop
L2: lw $s0, 0($sp) #restore saved $s0
    addi $sp, $sp, 4 #pop 1 item from stack
   # jr $ra #return