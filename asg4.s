###################################
#				  #
# Name: Remi Trettin		  #
# Class: CDA 3100		  #
# Assignment: 4			  #
#				  #
###################################

	.data
MSG1:	.asciiz "Remi Trettin, Student\n"
MSG2:	.asciiz "Add, subtract, multiply, and divide two numbers\n"
P1:	.asciiz "Enter the first number: "
P2:	.asciiz "Enter the second number: "
ERR:	.asciiz "*** NOPE: The number is below 1. ***\n"
PLUS:	.asciiz " + "
EQ:	.asciiz " = "
MIN:	.asciiz " - "
MULT:	.asciiz " * "
DIV:	.asciiz " / "
REM:	.asciiz " rem "
END:	.asciiz "\nThe program has stopped\n"
NL:	.asciiz "\n"
	.text
	.globl main
NOPE:
	li $v0,4
	la $a0,ERR
	syscall # print error message if either entered number is < 1
	jr $ra
main:
	li $t3,1

	li $v0,4
	la $a0,MSG1
	syscall # print intro 1

	li $v0,4
	la $a0,MSG2
	syscall # print intro 2

	li $v0,4
	la $a0,P1
	syscall # print prompt 1

	# read in first number
	li $v0,5
	syscall
	move $t1,$v0

	li $v0,4
	la $a0,P2
	syscall # print prompt 2

	# read in second number
	li $v0,5
	syscall
	move $t2,$v0

	# check if entered numbers are >= 1
	blt $t1,$t3,NOPE
	blt $t2,$t3,NOPE

	# print and calculate addition operation
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,PLUS
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,EQ
	syscall
	addu $t0,$t1,$t2
	li $v0,1
	move $a0,$t0
	syscall

	# print newline char
	li $v0,4
	la $a0,NL
	syscall

	# print and calculate subtraction operation
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,MIN
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,EQ
	syscall
	subu $t0,$t1,$t2
	li $v0,1
	move $a0,$t0
	syscall

	# print newline char
	li $v0,4
	la $a0,NL
	syscall

	# print and calculate multiplication operation
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,MULT
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,EQ
	syscall
	mul $t0,$t1,$t2
	li $v0,1
	move $a0,$t0
	syscall

	# print newline char
	li $v0,4
	la $a0,NL
	syscall

	# print and calculate division operation
	li $v0,1
	move $a0,$t1
	syscall
	li $v0,4
	la $a0,DIV
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,EQ
	syscall
	divu $t1,$t2
	mflo $t0
	mfhi $t4
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,REM
	syscall
	li $v0,1
	move $a0,$t4
	syscall

	# print end message
	li $v0,4
	la $a0,END
	syscall

	# exit
	jr $ra
