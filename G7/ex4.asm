	.data 
	
	.eqv print_string, 4
	.eqv SIZE, 50
	
str1:	.asciiz "Arquitetura de "
str2	.space SIZE
str3:	.asciiz "Computadores I"
nline:	.asciiz "\n"  
	
	.text
	.globl main

###############

strcat:	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	
	move	$s0, $a0
	move	$s1, $a1
	
whl:	lb	$s2, 0($s0)
	beq	$s2, '\0', ewhl
	addi	$s2, $s2, 1
	j	whl

ewhl:	move	$a0, $s2
	move	$a1, $s1
	jal	strcopy
	
	lw	$ra, 0($sp)
	lw	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)	
	addiu	$sp, $sp, 16
	
	jr	$ra

# dst:	$s0
# src:	$s1
# *p:	$s2
#
#char *strcat(char *dst, char *src) {
#	char *p = dst;
#	while(*p != '\0')
#		p++;
#	strcpy(p, src);
#	return dst;
#}

###############

strcpy:	move	$t0, $a0
	move	$t1, $a1
	
do:	lb	$t2, 0($t1)
	sb	$t2, 0($t0)
	
	addi	$t0, $t0, 1
	addi	$t1, $t1, 1
	
	bne	$t2, '\0', do
	
	move	$v0, $a0
	
	jr	$ta

#char *strcpy(char *dst, char *src){
#	char *p=dst;
#	do {
#		*p++ = ...
#	} while(*src++ ...
#	return dst;
#}

###############

main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)

	la	$a0, str2
	la	$a1, str1
	
	jal	strcpy
	
	move	$a0, $v0
	li	$v0, print_string
	syscall
	
	la	$a0, nline
	li	$v0, print_string
	syscall
	
	la	$a0, str2
	la	$a1, str3
	
	jal	strcat
	
	move	$a0, $v0
	li	$v0, print_string
	syscall
	
	move	$v0, $0
	
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
	
	jr	$ra

#int main(void) {
#	static char str1[]="Arquitetura de ";
#	static char str2[50];
#
#	strcpy(str2, str1);
#	print_string(str2);
#	print_string("\n");
#	print_string( strcat(str2, "Computadores I") );
#	return 0;
#}