# Mapa de registos:
# $t0 - value
# $t1 - bit
# $t2 - i
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
	
	la	$a0, str1			#
	li	$v0, print_string		# print "Introduza um numero: "
	syscall				#
	
	ori	$v0, $0, read_int		#
	syscall				# read value to $t0
	or	$t0, $v0, $0		#
	
	la	$a0, str2			#
	li	$v0, print_string		# print "Introduza um numero: "
	syscall				#
	
for:	bge	$t2, 32, end
	
	rem	$t4, $t2, 4
	bne	$t4, $0, cont
	li	$a0, ' '			#
	li	$v0, print_char		# print espace
	syscall	   			#
	
cont:	andi	$t1, $t0, 0x80000000

	bnez	$t1, else
	li	$a0, '0'			#
	li	$v0, print_char		# print 0
	syscall		   		#
	
	j	endfor
	
else:	li	$a0, '1'			#
	li	$v0, print_char		# print 1
	syscall	   			#	
	
endfor: 	sll	$t0, $t0, 1
	addi	$t2, $t2, 1
	j	for		
		
end:	jr	$ra