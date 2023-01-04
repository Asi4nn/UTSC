.globl q12

.data
len:    .word   6
list:   .word   -3, 2, 0, -1, 4, -5

.text
q12:
    	la $s0, list    
    	la $s1, len

	lw $t0, ($s0)
	lw $t1, ($s1)
	
	li $t2, 16
	
LOOP:	ble $t1, $zero, END
	
	mult $t0, $t2
	mflo $t3
	sw $t3, ($s0)
	
	subi $t1, $t1, 1
	addi $s0, $s0, 4
	lw $t0, ($s0)
	j LOOP
END:
	