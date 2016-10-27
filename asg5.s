###################################
#				  #
# Name: Remi Trettin		  #
# Class: CDA 3100		  #
# Assignment: 5			  #
#				  #
###################################

	.data
MSG1:	.asciiz "Enter integer values, one per line, terminated by a negative value.\n"
SUM:	.asciiz "Sum is: "
MIN:	.asciiz "Min is: "
MAX:	.asciiz "Max is: "
MEAN:	.asciiz "Mean is: "
VARI:	.asciiz "Variance is: "
NL:	.asciiz "\n"
ARRAY:	.word 0:100
	.text
	.globl main
main:
	li $t0,0 # init sum
	li $t1,0 # init count
	li $t2,0xFFFF # init min lower
	lui $t2,0x7FFF # init min upper
	li $t3,-1 # init max
	la $t5,ARRAY # load array
	li $t6,0 # array beginning
	li $t7,100 # array end
	li.s $f6,0.0 # init variance

	li $v0,4 # print welcome message
	la $a0,MSG1
	syscall
loop:
	li $v0,5 # read int
	syscall
	move $t4,$v0
	blt $t4,$zero,endloop # if int is negative, endloop
	bge $t6,$t7,endloop # if array is full, endloop
	add $t0,$t0,$t4 # calculate running sum
	add $t1,$t1,1 # increment array counter
	sw $t4,0($t5) # store int in array
	add $t5,$t5,4 # move to next array position
	add $t6,$t6,1 # increment array index
	blt $t4,$t2,calcmin # find new minimum if necessary
	bgt $t4,$t3,calcmax # find new maximum if necessary
	j loop # loop again

endloop:
	li $v0,4 # print sum
	la $a0,SUM
	syscall
	li $v0,1
	move $a0,$t0
	syscall
	li $v0,4
	la $a0,NL
	syscall
	la $a0,MIN # print minimum
	syscall
	li $v0,1
	move $a0,$t2
	syscall
	li $v0,4
	la $a0,NL
	syscall
	la $a0,MAX # print maximum
	syscall
	li $v0,1
	move $a0,$t3
	syscall
	li $v0,4
	la $a0,NL
	syscall
	la $a0,MEAN # print mean
	syscall
	mtc1 $t0,$f0
	cvt.s.w $f0,$f0 # convert to floating point for mean calculation
	mtc1 $t1,$f1
	cvt.s.w $f1,$f1
	li $v0,2
	div.s $f12,$f0,$f1
	syscall
	li $v0,4
	la $a0,NL
	syscall
	la $a0,VARI # print variance
	syscall
	la $t5,ARRAY
	li $t6,0
	li $t7,100
	j calcvari
calcmin:
	move $t2,$t4 # move entered int to minimum
	j loop
calcmax:
	move $t3,$t4 # move entered int to maximum
	j loop
calcvari:
	bge $t6,$t1,exit # loop through array count times
	lw $t4,0($t5) # load array value
	mtc1 $t4,$f4
	cvt.s.w $f4,$f4 # convert to floating point
	sub.s $f0,$f12,$f4
	mul.s $f0,$f0,$f0
	add.s $f6,$f6,$f0 # calculate variance
	add $t5,$t5,4 # move to next array item
	add $t6,$t6,1
	j calcvari
exit:
	li $v0,2
	div.s $f12,$f6,$f1 # finish variance calculation and output it
	syscall
	jr $ra
