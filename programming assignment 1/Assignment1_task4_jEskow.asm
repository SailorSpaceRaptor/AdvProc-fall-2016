#this program takes in a string of 5 integers and sorts them. Ideally the user will input one integer at a time and the program will then sort

.data	# What follows will be data
prompt1: .asciiz "Please enter an integer: "	# the string " Please enter an integer: " 
						# is stored in the buffer named "prompt"
prompt2: .asciiz "Please enter a second integer: "
prompt3: .asciiz "Please enter a third integer: "
prompt4: .asciiz "Please enter a fourth integer: "
prompt5: .asciiz "Please enter a final integer: "

display: .asciiz "The numbers you entered in order are: "
.text	# What follows will be actual code
main: 	
	# Display prompt			
	la	$a0, prompt1	# Load the address of "prompt" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt to the I/O window
	# Read an integer
	li	$v0, 5
	syscall
	move	$ra, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
# Display prompt			
	la	$a0, prompt2	# Load the address of "prompt" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt to the I/O window
	# Read an integer
	li	$v0, 5
	syscall
	move	$s3, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
	# Display prompt			
	la	$a0, prompt3	# Load the address of "prompt" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt to the I/O window
	# Read an integer
	li	$v0, 5
	syscall
	move	$s2, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
	# Display prompt			
	la	$a0, prompt4	# Load the address of "prompt" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt to the I/O window
	# Read an integer
	li	$v0, 5
	syscall
	move	$s1, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
	# Display prompt			
	la	$a0, prompt5	# Load the address of "prompt" to $a0
	li	$v0, 4		# Load register $v0 with 4
	syscall			# print prompt to the I/O window
	# Read an integer
	li	$v0, 5
	syscall
	move	$s0, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
	
sort: addi $sp, $sp, -20 # make room on stack for 5 registers
      sw $ra, 16($sp) #save $ra on stack
      sw $s3, 12($sp) #save $s3 to stack
      sw $s2, 8($sp) #save $s2 on stack
      sw $s1, 4($sp) #save $s1 on stack
      sw $s0, 0($sp) #save $s0 on stack	
      
 procedure: move $s2, $a0 #save a0 into s2
            move $s3, $a1 #save a1 into s3
            move $s0, $zero #i=0
    for1tst: slt $t0, $s0, $s3 #$t0 = 0 if $s0 >= $s3 (i>=n)
             beq $t0, $zero, exit1 #go to exit if s0 >= $s3 (i>=n)
             addi $s1, $s0, -1 #j=i-1
    for2tst: slti $t0, $s1, 0 #t0 = 1 if s1 < 0 < (j<0)
             bne $t0, $zero, exit2 #go to exit2 if s1 < 0 (j<0)
             sll $t1, $s1, 2 #t1 = (j * 4)
             add $t2, $s2, $t1 #t2 = v + (j*4)
             lw $t3, 0($t2) #t3 = v[j]
             lw $t4, 4($t2) #t4 = v[j + 1]
             slt $t0, $t4, $t3 # $t0 = 0 if t4 >= t3
             beq $t0, $zero, exit2 #go to exit2 if t4 >= t3
             move $a0, $s2 #1st param of swap is v (old a0)
             move $a1, $s1 #2nd param of swap is j
             jal swap
             addi $s1, $s1, -1 #j -= 1
             j for2tst #jump to test of inner loop
     exit2: addi $s0, $s0, 1 #i+=1
            j for1tst #jump to test outer loop                       
   swap: sll $t1, $a1, 2 # t1 = k * 4
         add $t1, $a0, $t1 #$t1 = v+(k*4)
                      # (address of v[i])
         lw $t0, 0($t1) #t0 (temp) = v[k]
         lw $t2, 4($t1) #t2 = (v[k+1)
         sw $t2, 0($t1) #v[k] = $t2 (v[k+1])
         sw $t0, 4($t1) #v[k+1] = $t0 (temp)
         jr $ra       
 
exit1: lw $s0,0($sp) #restore $s0 from stack
       lw $s1,4($sp) #restore $s1 from stack
       lw $s2,8($sp) #restore $s2 from stack
       lw $s3,12($sp) #restore $s3 from stack
       lw $ra,16($sp) #restore $rA from stack
       addi $sp, $sp, 20 #restore stack pointer
       #jr $ra #reeturn to calling routine
 
L3:	move	$t0, $v0	# Need to move content of $v0 to another available temporary register ($t0 in this case)
	# Display "The numbers you entered are: " to console
	la	$a0, display	# Load the address of "display" to $a0
	li 	$v0, 4
	syscall
	# Display the entered integer
	move	$a0, $t0	# move the integer to be printed to $a0
	li	$v0, 1		# Load $v0 with 1
	syscall