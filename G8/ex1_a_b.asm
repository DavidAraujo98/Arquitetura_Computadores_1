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

atoi:	li $v0, 0
whl:	lb $t0, 0($a0)
	blt $t0, '0', ewhl
	bgt $t0, '9', ewhl
	
	sub $t1, $a0, '0'
	addiu $a0, $a0, 1
	
	mul $v0, $v0, 10
	add $v0, $v0, $t1
	j whl

ewhl:	jr $ra	

# Mapa de registos
# res:		$v0
# s:		$a0
# *s:		$t0
# digit:	$t1
#unsigned int atoi(char *s){
#	unsigned int digit, res = 0;
#	while( (*s >= '0') && (*s <= '9') ) {
#		digit = *s++ - '0';
#		res = 10 * res + digit;
#	}
#	return res;
#}
