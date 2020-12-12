	.data
	
	.eqv print_string, 4
str:	.asciiz "ITED- orievA ed edadisrevinU"
	
	.text
	.globl main

###############

exchange:
	lb $t0, 0($a0)
	lb $t1, 0($a1)
	sb $t0, 0($a1)
	sb $t1, 0($a0)
	jr $ra

#void exchange(char *c1, char *c2) {
#	char aux = *c1;
#	*c1 = *c2;
#	*c2 = aux;
#}

###############

strrev:	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	move $s0, $a0
	move $s1, $a0
	move $s2, $a0 

whl1:	lb $s3, 0($s2)
	beq $s3, '\0', ewhl1
	addi $s2, $s2,1
	j whl1
	
ewhl1:	sub $s2, $s2,1
	
whl2:	bge $s1, $s2, ewhl2
	move $a0, $s1
	move $a1, $s2
	jal exchange
	addi $s1, $s1,1
	sub $s2, $s2, 1
	j wlh2
	
ewhl2:	move $v0, $s0
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	addiu $sp, $sp, 16
	jr $ra

# str:	$a0
# p1:	$s1
# p2:	$s2
#		
#char *strrev(char *str){
#	char *p1 = str;
#	char *p2 = str;
#	while(*p2 != '\0')
#		p2++;
#	p2--;
#	while( p1 < p2 ) {
#		exchange(p1, p2);
#		p1++;
#		p2--;
#	}
#	return str;
#}

###############

main:	addiu $sp, $sp, 16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	la $a0, str
	jal strrev
	
	move $a0, $v0
	li $v0, print_string
	syscall
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addiu $sp, $sp, -16
	
	jr $ra
	

#int main(void) {
#	static char str[]="ITED - orievA ed edadisrevinU";
#	print_string( strrev(str) );
#	return 0;
#}
