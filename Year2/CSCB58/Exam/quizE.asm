.data
len:            .word    10
list:           .word    5, -6, 8, -4, 7, 3, -2, 6, -18, 24 

even:           .word    0:10
odd:            .word    0:10
negt:           .word    0:10
pos:            .word    0:10

str1:     .asciiz "\nOdd number:  "
str2:     .asciiz "\nEven number:  "
str3:     .asciiz "\nFound negative number:  "
str4:     .asciiz "\nFound positive number:  "

.text
main: 
	la $t0, even
	la $t1, odd
	la $t2, negt
	la $t3, pos
	
	lw $s0, len
	la $s1, list
	
# check odd / even
odd_even:
	beq $s0, 0, pos_neg
	
	lw $t6, ($s1)	
	andi $t7, $t6, 1
	beq $t7, 0, call_even	# check if even
	# else its odd
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 1
	addi $a0, $t6, 0
	syscall
	
	sw $t6, ($t1)
	addi $t1, $t1, 4
	subi $s0, $s0, 1
	addi $s1, $s1, 4
	j odd_even
call_even:
	li $v0, 4
	la $a0, str2
	syscall
	li $v0, 1
	addi $a0, $t6, 0
	syscall
	
	sw $t6, ($t0)
	addi $t0, $t0, 4
	subi $s0, $s0, 1
	addi $s1, $s1, 4
	j odd_even

# check positive/negative
pos_neg:
	# refresh needed registers
	lw $s0, len
	la $s1, list
pos_neg_loop:
	beq $s0, 0, END
	
	lw $t6, ($s1)
	bge $t6, 0, positive	# check if positive
	# else its negative
	li $v0, 4
	la $a0, str3
	syscall
	li $v0, 1
	addi $a0, $t6, 0
	syscall
	
	sw $t6, ($t2)
	addi $t2, $t2, 4
	subi $s0, $s0, 1
	addi $s1, $s1, 4
	j pos_neg_loop
positive:
	li $v0, 4
	la $a0, str4
	syscall
	li $v0, 1
	addi $a0, $t6, 0
	syscall

	sw $t6, ($t3)
	addi $t3, $t3, 4
	subi $s0, $s0, 1
	addi $s1, $s1, 4
	j pos_neg_loop
END: