# Name: Remi Trettin
# Class: CDA 3100
# Assignment: 6

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
KEEP: .asciiz "        2a: Quotient to 1      "
	.text
	.globl main

main:
	li $t0,1 # lower numerator/divisor bound
	li $t1,7 # upper numerator/divisor bound
	li $t2,-1 # divisor init
	li $t3,8 # remainder init
	li $s0,0 # quotient
query:
	blt $t2,$t0,PROMPTDIV # ask for and validate divisor
	bgt $t2,$t1,PROMPTDIV
	blt $t3,$t0,PROMPTNUM # ask for and validate numerator
	bgt $t3,$t1,PROMPTNUM
	blt $t3,$t2,PROMPTNUM

	li $v0,4 # print column headers and initial values
	la $a0,COLHEADERS
	syscall
	la $a0,INITVAL
	syscall

	move $a0,$s0
	li $a1,0
	addi $sp,$sp,-16
	sw $t2,4($sp)
	sw $t3,8($sp)
	sw $s0,12($sp)
	sw $ra,16($sp)
	jal print4bits # function call, print 4 bits
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
	jal print8bitsleft # function call, print 8 bits left aligned
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
	jal print8bitsright # function call, print 8 bits right aligned
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
	jal calcremainder # do rem=rem-div calculation
	lw $t2,4($sp)
	lw $t3,8($sp)
	lw $s0,12($sp)
	lw $ra,16($sp)

	li $v0,4
	la $a0,REM
	syscall
	move $a0,$s0
	li $a1,0
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

	blt $s7,$zero,restorerem # check whether to restore remainder and add 0 to quotient
	bge $s7,$zero,quo11 # or keep remainder and add 1 to quotient

# repeat this process 5 times because 4 bits = 5 required steps
continue:
	move $a0,$s0
	li $a1,0
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
	li $a1,0
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
	li $a1,0
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
	bge $s7,$zero,quo12

continue2:
	move $a0,$s0
	li $a1,0
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
	li $a1,0
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
	li $a1,0
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
	bge $s7,$zero,quo13

continue3:
	move $a0,$s0
	li $a1,0
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
	li $a1,0
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
	li $a1,0
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

	blt $s7,$zero,restorerem4
	bge $s7,$zero,quo14

continue4:
	move $a0,$s0
	li $a1,28
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
	li $a1,0
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
	li $a1,28
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
	li $a1,0
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
	li $a1,28
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

	blt $s7,$zero,restorerem5
	bge $s7,$zero,quo15

continue5:
	move $a0,$s0
	li $a1,28
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
	li $a1,0
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
	li $a1,28
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
	li $a1,0
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

	jr $ra

quo11:
	ori $t0,$s0,1
	move $s0,$t0
	move $t3,$s7
	li $v0,4
	la $a0,KEEP
	syscall
	j continue

quo12:
	ori $t0,$s0,1
	move $s0,$t0
	move $t3,$s7
	li $v0,4
	la $a0,KEEP
	syscall
	j continue2

quo13:
	ori $t0,$s0,1
	move $s0,$t0
	move $t3,$s7
	li $v0,4
	la $a0,KEEP
	syscall
	j continue3

quo14:
	ori $t0,$s0,1
	move $s0,$t0
	move $t3,$s7
	li $v0,4
	la $a0,KEEP
	syscall
	j continue4

quo15:
	ori $t0,$s0,1
	move $s0,$t0
	move $t3,$s7
	li $v0,4
	la $a0,KEEP
	syscall
	j continue5

restorerem:
	sll $t0,$s0,1
	move $s0,$t0
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue

restorerem2:
	sll $t0,$s0,1
	move $s0,$t0
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue2

restorerem3:
	sll $t0,$s0,1
	move $s0,$t0
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue3

restorerem4:
	sll $t0,$s0,1
	move $s0,$t0
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue4

restorerem5:
	sll $t0,$s0,1
	move $s0,$t0
	move $s7,$t3
	li $v0,4
	la $a0,RESTORE
	syscall
	j continue5

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
	sllv $t1,$s0,$a1 # shift bits left because registers are 32 bits
	move $s0,$t1
	li $s1,4
loop4:
	rol $s0,$s0,1 # print bits from left to right
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
	sllv $t0,$t2,$a2 # shift bits left so subtraction gives correct answer
	sllv $t1,$t3,$a3
	sub $t1,$t1,$t0
	move $s7,$t1
	jr $ra

# END FUNCTION
