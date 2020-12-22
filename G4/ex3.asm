# Mapa de registos
# p:		$t0
# pultimo:	$t1
# *p:		$t2
# soma:		$t3

	.data

	.eqv SIZE, 4
	.eqv print_int10, 1
array:	.word 7692, 23, 5, 234

	.text
	.globl main

main:	li	$t3, 0
	li	$t4, SIZE
	sub	$t4, $t4, 1
	sll	$t4, $t4, 2
	la	$t0, array
	addu	$t1, $t0, $t4
	
while:	bge	$t0, $t1, endw
	
	lw	$t2, 0($t0)
	add	$t3, $t3, $t2
	addi	$t0, $t0, SIZE
	
	j	while

endw:	ori	$v0, $0, print_int10
	or	$a0, $0, $t3
	syscall
	
	jr	$ra