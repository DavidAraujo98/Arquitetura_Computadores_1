# p:		$t0
# *p:		$t1
# lista + Size:	$t2
	
	.data

str1:	.asciiz "; "
str2:	.asciiz "\nConteudo do array:\n"
lista:	.word 8, -4, 3, 5, 124, -15, 87, 9, 27, 15

	.eqv print_string, 4
	.eqv print_int10, 1
	.eqv SIZE, 40
	
	.text
	.globl main

main:	li	$a0, str2
	li	$v0, print_string
	syscall
	
	la	$t0, lista
	
	li	$t2, SIZE
	sll	$t2, $t2, 2
	addu	$t2, $t2, $t0
	
while:	bge	$t0, $t2, endW
	lw	$t1, 0($t0)
	
	li	$v0, print_int10
	move	$a0, $t1
	syscall
					
	li	$v0, print_string
	la	$a0, str1
	syscall			

	addu	$t0, $t0, 4

	j	while

endW:	jr	$ra