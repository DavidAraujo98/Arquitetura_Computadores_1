# Mapa de resgistos:
# $t0 - soma
# $t1 - value
# $t2 - i

	.data

str1:	.asciiz "Introduza um numero: "
str2:	.asciiz "Valor ignorado\n"
str3:	.asciiz "A soma dos dos positivos e': "
	
	.eqv print_string, 4
	.eqv read_int, 5
	.eqv print_int, 1

	.text
	.globl main

main:	li	$t0, 0		# soma = 0
	li	$t2, 0		# i = 0
for:	bge	$t2,5,end		# if i >= 5 jump to end
	
	la	$a0, str1		#
	li	$v0, print_string	# print "Introduza um numero: "
	syscall			#
	
	ori	$v0, $0, read_int	#
	syscall			# read value to $t1
	or	$t1, $v0, $0	#
	
	blez	$t1, else
	add	$t0, $t0, $t1
	addi	$t2, $t2, 1
	
	j	for
	
else:	la	$a0, str2			#
	li	$v0 print_string		# print "Valor ignorado \n"
	syscall				#
	
	addi	$t2, $t2, 1		
	j	for

end: 	la	$a0, str3			#
	ori	$v0, $0, print_string		# print "Valor ignorado \n"
	syscall				# 
	
	or	$a0, $t0, $0 
	ori	$v0, $0, print_int
	syscall
	
	jr	$ra