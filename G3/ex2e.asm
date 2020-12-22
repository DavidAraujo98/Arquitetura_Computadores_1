# Mapa de registos:
# $t0 - value
# $t1 - bit
# $t2 - i
# $t3 - flag
	.data

str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "\nO valor em binário e': "

	.eqv print_string, 4
	.eqv print_char, 11
	.eqv read_int, 5 

	.text
	.globl main

main:	li	$t1, 0
	li	$t2, 0
	li	$t3, 0
	
	la	$a0, str1		#
	li	$v0, print_string	# print "Introduza unm numero: "
	syscall			#
	
	ori	$v0, $0, read_int	#
	syscall			# read value to $t0
	or	$t0, $v0, $0	#
	
	la	$a0, str2		#
	li	$v0, print_string	# print "Introduza um numero: "
	syscall			#
	
for:	bge	$t2, 32, end
	
	srl	$t1, $t0, 31
	
	beq	$t3, 1, cond1
	bnez	$t1, cond1
	j	cont1
	
cond1:	li	$t3, 1
	rem	$t4, $t2, 4
	bne	$t4, 0, cont2

	li	$a0, ' '		#
	li	$v0, print_char	# print espace
	syscall	   		#

cont2:	or	$a0, $t1, $0	#
	li	$v0, 1		# print bit
	syscall			#

cont1:	sll	$t0, $t0, 1	
	addi	$t2, $t2, 1
	j	for
		
end:	jr	$ra
