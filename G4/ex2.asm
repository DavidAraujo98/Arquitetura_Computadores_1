# Mapa de registos
# num:	$t0
# p:	$t1
# *p:	$t2
	.data
	.eqv SIZE, 20
	.eqv read_string, 8
	.eqv print_int10, 1
str:	.space SIZE
	.text
	.globl main
	
main:	la $a0, str
	ori $v0, $0, read_string
	li $a1, SIZE
	syscall
	
	la $t1, str
	ori $t0, $0, 0

while:	lb $t2, 0($t1)
	beq $t2, '\0', endloop
	
	blt $t2, '0', endif
	bgt $t2, '9', endif
	
	addi $t0, $t0, 1

endif:	addi $t1, $t1, 1
	j while

endloop:ori $v0, $0, print_int10
	or $a0, $0, $t0
	syscall
	
	jr $ra  