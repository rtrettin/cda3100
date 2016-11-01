###################################
#				  #
# Name: Remi Trettin		  #
# Class: CDA 3100		  #
# Assignment: 6			  #
#				  #
###################################

	.data
DIVMSG:	.asciiz "Enter in the Divisor: "
NUMMSG: .asciiz "Enter in the Numerator: "
	.text
	.globl main
main:
	# needs to be encapsulated within a loop/function
	li $v0,4
	la $a0,DIVMSG
	syscall
	li $v0,5
	syscall
	move $t0,$v0

	# needs to be encapsulated within a loop/function
	li $v0,4
	la $a0,NUMMSG
	syscall
	li $v0,5
	syscall
	move $t1,$v0

	jr $ra
