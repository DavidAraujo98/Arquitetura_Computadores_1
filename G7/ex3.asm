	.data
	
str1:	.asciiz	"I serodatupmoC ed arutetiuqrA"
str2:	.space 31
str3:	.asciiz	"String too long: "
str4:	.asciiz	"\n"
	
	.eqv SIZE, 30
	.eqv MAX_SIZE, 31
	.eqv print_string, 4
	.eqv print_int10, 1
	
	.text
	.globl main

main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	la	$a0, str1
	jal	strlen

if:	bgt	$v0, MAX_SIZE, else

	la	$a0, 
	la	$a1, str1
	jal	strcpy 
	
	move	$t1, $v0
	move	$a0, $t1
	li	$v0, print_string
	syscall
	
	la	$a0, str4
	li	$v0, print_string
	syscall
	
	move	$a0, $t1
	jal	strrev
	move	$a0, $v0
	li	$v0, print_string
	syscall

	li	$t0, 0
	j	end

else:	la	$a0, str3
	li	$v0, print_string
	syscall
	
	la	$a0, str1
	jal	strlen
	move	$a0, $v0
	li	$v0, print_int10
	syscall
	
	li	$t0, -1	

end:	lw	$ra, 0($sp)	
	addiu	$sp, $sp, 4

	move	$v0, $t0
	jr	$ra

#define STR_MAX_SIZE 30
#int main(void){
#	static char str1[]="I serodatupmoC ed arutetiuqrA";
#	static char str2[STR_MAX_SIZE + 1];
#	int exit_value;
#	if(strlen(str1) <= STR_MAX_SIZE) {
#		strcpy(str2, str1);
#		print_string(str2);
#		print_string("\n");
#		print_string(strrev(str2));
#		exit_value = 0;
#	} else {
#		print_string("String too long: ");
#		print_int10(strlen(str1));
#		exit_value = -1;
#	}
#	return exit_value;
#}

###############

strcpy:	addiu	$sp, $sp, -8
	sw	$s0, 0($sp)
	sw	$s1, 4($sp)
	
	li	$t0, 0
	move	$s0, $a0
	move	$s1, $a1
	
do:	addu	$t1, $s0, $t0
	addu	$t2, $s1, $t0
	
	lb	$t3, 0($t2)
	sb	$t3, 0($t1)
	addi	$t0, $t0, 1
	bne	$t3, '\0', do
	move	$v0, $s0
	
	lw	$s0, 0($sp)
	lw	$s1, 4($sp)
	addiu	$sp, $sp, 8
	
	jr	$ra

# dst:	$sp0
# src:	$sp1
# i:	$t0
#
#char *strcpy(char *dst, char *src) {
#	int i=0;
#	do {
#		dst[i] = src[i];
#	} while(src[i++] != '\0');
#	return dst;
#}

###############

strlen:	li	$t0, 0

while:	lb	$t1, 0($a0)
	addiu	$a0, $a0, 1
	beq	$t1, '\0', ewhile«
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

strrev:	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	move	$s0, $a0
	move	$s1, $a0
	move	$s2, $a0 

whl1:	lb	$s3, 0($s2)
	beq	$s3, '\0', ewhl1
	addi	$s2, $s2,1
	j	whl1
	
ewhl1:	sub	$s2, $s2,1
	
whl2:	bge	$s1, $s2, ewhl2
	move	$a0, $s1
	move	$a1, $s2
	jal	exchange
	addi	$s1, $s1,1
	sub	$s2, $s2, 1
	j	wlh2
	
ewhl2:	move	$v0, $s0
	sw	$ra, 0($sp)
	sw	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	addiu	$sp, $sp, 16
	jr	$ra

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