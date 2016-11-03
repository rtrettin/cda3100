###################################
#				                          #
# Name: Remi Trettin		          #
# Class: CDA 3100		              #
# Assignment: 6			              #
#				                          #
###################################

	.data
DIVMSG:	.asciiz "Enter in the Divisor: "
NUMMSG: .asciiz "Enter in the Numerator: "
COLHEADERS: .asciiz "                  Step     Quotient   Divisor Remainder\n"
INITVAL: .asciiz "           Initial Values      "
NL: .asciiz "\n"
SPC2: .asciiz "  "
REM: .asciiz "              Rem=Rem-Div      "
RESTORE: .asciiz "          2b: Restore Rem      "
SHIFT: .asciiz "         Shift Div Right       "
	.text
	.globl main

# BEGIN FUNCTION

main:
	li $t0,1 # lower bound
	li $t1,7 # upper bound
	li $t2,-1 # divisor init
	li $t3,8 # remainder init
	li $s0,0 # quotient
	# $t3 / $t2
query:
	blt $t2,$t0,PROMPTDIV
	bgt $t2,$t1,PROMPTDIV
	blt $t3,$t0,PROMPTNUM
	bgt $t3,$t1,PROMPTNUM
	blt $t3,$t2,PROMPTNUM

	li $v0,4
	la $a0,COLHEADERS
	syscall
	la $a0,INITVAL
	syscall

	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)

	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$t2
	li $a1,28
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)

	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$t3
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsright
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)

	li $v0,4
	la $a0,NL
	syscall

	move $a0,$t3
	move $a1,$t2
	li $a2,28
	li $a3,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal calcremainder
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)

	li $v0,4
	la $a0,REM
	syscall
	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$t2
	li $a1,28
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$s7
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	blt $s7,$zero,restorerem
	#bge $s7,$zero,quo1

continue:
	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$t2
	li $a1,28
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$s7
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsright
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	la $a0,SHIFT
	syscall

	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	sll $t0,$t2,28
	move $t2,$t0
	srl $t0,$t2,1
	move $t2,$t0
	srl $t0,$t2,24
	move $t2,$t0
	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$s7
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsright
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	move $a0,$t3
	move $a1,$t2
	li $a2,24
	li $a3,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal calcremainder
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,REM
	syscall
	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$s7
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	blt $s7,$zero,restorerem2
	#bge $s7,$zero,quo1

continue2:
	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$s7
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsright
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	la $a0,SHIFT
	syscall

	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	sll $t0,$t2,24
	move $t2,$t0
	srl $t0,$t2,1
	move $t2,$t0
	srl $t0,$t2,24
	move $t2,$t0
	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$s7
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsright
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	move $a0,$t3
	move $a1,$t2
	li $a2,24
	li $a3,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal calcremainder
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,REM
	syscall
	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$s7
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	blt $s7,$zero,restorerem3
	#bge $s7,$zero,quo1

continue3:
	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$s7
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsright
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	la $a0,SHIFT
	syscall

	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	sll $t0,$t2,24
	move $t2,$t0
	srl $t0,$t2,1
	move $t2,$t0
	srl $t0,$t2,24
	move $t2,$t0
	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall

	move $a0,$s7
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsright
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	move $a0,$t3
	move $a1,$t2
	li $a2,24
	li $a3,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal calcremainder
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,REM
	syscall
	move $a0,$s0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$t2
	li $a1,24
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bitsleft
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,SPC2
	syscall
	move $a0,$s7
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print8bits
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)
	li $v0,4
	la $a0,NL
	syscall

	#

	jr $ra

restorerem:
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue

restorerem2:
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue2

restorerem3:
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue3

PROMPTDIV:
	li $v0,4
	la $a0,DIVMSG
	syscall
	li $v0,5
	syscall
	move $t2,$v0
	j query

PROMPTNUM:
	li $v0,4
	la $a0,NUMMSG
	syscall
	li $v0,5
	syscall
	move $t3,$v0
	j query

# END FUNCTION

# BEGIN FUNCTION

print4bits:
	move $s0,$a0
	li $s1,4
loop4:
	rol $s0,$s0,1
	and $t0,$s0,1
	add $t0,$t0,48
	move $a0,$t0
	li $v0,11
	syscall
	sub $s1,$s1,1
	bne $s1,$zero,loop4
	jr $ra

# END FUNCTION

# START FUNCTION

print8bits:
	move $s0,$a0
	li $s1,8
loop8:
	rol $s0,$s0,1
	and $t0,$s0,1
	add $t0,$t0,48
	move $a0,$t0
	li $v0,11
	syscall
	sub $s1,$s1,1
	bne $s1,$zero,loop8
	jr $ra

# END FUNCTION

# START FUNCTION

print8bitsleft:
	move $t2,$a0
	sllv $t1,$t2,$a1
	li $s1,8
	move $s2,$t1
loop8left:
	rol $s2,$s2,1
	and $t0,$s2,1
	add $t0,$t0,48
	move $a0,$t0
	li $v0,11
	syscall
	sub $s1,$s1,1
	bne $s1,$zero,loop8left
	jr $ra

# END FUNCTION

# START FUNCTION

print8bitsright:
	move $t3,$a0
	sllv $t1,$t3,$a1
	li $s1,8
	move $s2,$t1
loop8right:
	rol $s2,$s2,1
	and $t0,$s2,1
	add $t0,$t0,48
	move $a0,$t0
	li $v0,11
	syscall
	sub $s1,$s1,1
	bne $s1,$zero,loop8right
	jr $ra

# END FUNCTION

# START FUNCTION

calcremainder:
	move $t3,$a0
	move $t2,$a1
	sllv $t0,$t2,$a2
	sllv $t1,$t3,$a3
	sub $t1,$t1,$t0
	move $s7,$t1
	jr $ra

# END FUNCTION
