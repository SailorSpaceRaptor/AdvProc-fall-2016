
# This program allows a user to input an integer through the I/O window using keyboard and give a factorial
# Procedure to print an integer to the I/O window:
# 1. Load the integer to be printed to $a0
# 2. Load $v0 with 1
# 3. Issue "syscall"
.data	# What follows will be data
prompt: .asciiz "Enter a number to find factorial: "	# the string " Please enter an integer: " 
						# is stored in the buffer named "prompt"
display: .asciiz "ans: "
.text	# What follows will be actual code
main: 	
	# Display prompt			
	la	$a0, prompt	# Load the address of "prompt" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt to the I/O window
	# Read an integer
	li	$v0, 5
	syscall
	move	$a0, $v0	# Need to move content of $v0 to $a0
fact:
    addi $sp, $sp, -8 #adjust stack for 2 items
    sw $ra, 4($sp) #save return address
    sw $a0, 0($sp) #save argument
    slti $t0, $a0, 1 #test for n < 1
    beq $t0, $zero, L1
    addi $v0, $zero, 1 #if so, result is 1
    addi $sp, $sp, 8 #pop two items from stack
    jr $ra #return
L1: addi $a0, $a0, -1 #else decrement n
    jal fact #recursive call
    lw $a0, 0($sp) #restore original n
    lw $ra, 4($sp) #return address
    addi $sp, $sp, 8 #pop 2 items from stack
    mul $v0, $a0, $v0 #multiply to get result
    beq $ra,$zero,L2 # checks to see if ra is zero
    jr $ra #return 
L2: move $s1, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
    # Display "ans: " to console
	la	$a0, display	# Load the address of "display" to $a0
	li 	$v0, 4
	syscall
	# Display the entered integer
	move	$a0, $s1	# move the integer to be printed to $a0
	li 	$v0, 1		# Load $v0 with factorial
	syscall