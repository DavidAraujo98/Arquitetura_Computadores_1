	.data
	.eqv print_int10, 1

str1:	.asciiz "Arquitetura de Computadores I"

	.text
	.globl main

###############

strlen:	li	$t0, 0
while:	lb	$t1, 0($a0)
	addiu	$a0, $a0, 1
	beq	$t1, '\0', ewhile
	addi	$t0, $t0, 1
	j	while

ewhile:	move	$v0, $t0
	jr	$ra

# len:	$t0
# s*:	$t1
#
#int strlen(char *s){
#	int len=0;
#	while(*s++ != '\0')
#		len++;
#	return len;
#}

###############

main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)	

	la	$a0, str1
	jal	strlen
	la	$a0, $v0
	li	$v0, print_int10
	syscall
	
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	jr	$ra	

#int main(void) {
#	static char str[]="Arquitetura de Computadores I";
#	print_int10(strlen(str));
#	return 0;
#}
