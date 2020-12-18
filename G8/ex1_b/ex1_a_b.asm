	.data
	
str:	.asciiz "2016 e 2020 sao anos bissextos"

	.eqv print_int10, 1
	
	.text
	.globl main
	
main:	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, str
	jal atoi
	
	move $a0, $v0
	li $v0, print_int10
	syscall	

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#int main(void) {
#	static char str[]="2016 e 2020 sao anos bissextos";
#	print_int10( atoi(str) );
#	return 0;
#}

###############