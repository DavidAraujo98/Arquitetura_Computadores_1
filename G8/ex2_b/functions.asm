	.text
	.globl exchange
	.globl strrev
	.globl strlen
	.globl strcpy
	.globl strcat
	.globl atoi
	.globl atoib
	.globl itoa
	.globl toascii

strlen:	li		$t0, 0
while:	lb		$t1, 0($a0)
		addiu	$a0, $a0, 1
		beq		$t1, '\0', ewhile
		addi	$t0, $t0, 1
		j		while
ewhile: move	$v0, $t0
		jr		$ra

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

exchange:
		lb		$t0, 0($a0)
		lb		$t1, 0($a1)
		sb		$t0, 0($a1)
		sb		$t1, 0($a0)
		jr		$ra

#void exchange(char *c1, char *c2) {
#	char aux = *c1;
#	*c1 = *c2;
#	*c2 = aux;
#}

###############

strrev:	addiu	$sp, $sp, -16
		sw		$ra, 0($sp)
		sw		$s0, 4($sp)
		sw		$s1, 8($sp)
		sw		$s2, 12($sp)
		move	$s0, $a0
		move	$s1, $a0
		move	$s2, $a0 

whl11:	lb		$s3, 0($s2)
		beq		$s3, '\0', ewhl11
		addi	$s2, $s2,1
		j		whl11
	
ewhl11:	sub		$s2, $s2,1
	
whl112:	bge		$s1, $s2, ewh1l2
		move	$a0, $s1
		move	$a1, $s2
		jal		exchange
		addi	$s1, $s1,1
		sub		$s2, $s2, 1
		j		whl112
	
ewh1l2:	move	$v0, $s0
		sw		$ra, 0($sp)
		sw		$s0, 4($sp)
		sw		$s1, 8($sp)
		sw		$s2, 12($sp)
		addiu	$sp, $sp, 16
		jr		$ra

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

strcpy:	move	$t0, $a0
		move	$t1, $a1
	
do:		lb		$t2, 0($t1)
		sb		$t2, 0($t0)
	
		addi	$t0, $t0, 1
		addi	$t1, $t1, 1
	
		bne		$t2, '\0', do
	
		move	$v0, $a0
	
		jr		$ra

#char *strcpy(char *dst, char *src){
#	char *p=dst;
#	do {
#		*p++ = ...
#	} while(*src++ ...
#	return dst;
#}

###############

strcat:	addiu	$sp, $sp, -16
		sw		$ra, 0($sp)
		sw		$s0, 4($sp)
		sw		$s1, 8($sp)
		sw		$s2, 12($sp)
	
		move	$s0, $a0
		move	$s1, $a1
	
whl23:	lb		$s2, 0($s0)
		beq		$s2, '\0', ewhl23
		addi	$s2, $s2, 1
		j		whl23

ewhl23:	move	$a0, $s2
		move	$a1, $s1
		jal		strcpy
	
		lw		$ra, 0($sp)
		lw		$s0, 4($sp)
		lw		$s1, 8($sp)
		lw		$s2, 12($sp)	
		addiu	$sp, $sp, 16
	
		jr		$ra

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

atoi:	li		$v0, 0
whl32:	lb		$t0, 0($a0)
		blt		$t0, '0', ewhl32
		bgt		$t0, '9', ewhl32
	
		sub		$t1, $a0, '0'
		addiu	$a0, $a0, 1
	
		mul		$v0, $v0, 10
		add		$v0, $v0, $t1
		j		whl32

ewhl32:	jr		$ra	

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

###############

atoib:	li		$v0, 0
		li		$t1, 0
	
whl4:	lb		$t0, 0($a0)
		beq		$t0, '\0', ewhl4
		
if4:	bne		$t0, '1', else4
		li		$t3, 0	#  i = 0
		li		$t2, 1	#  temp = 1 
	
whl14:	mul		$t2, $t2, 2
		addi	$t3, $t3, 1
		blt		$t3, $t1, whl14
	
		
else4:	add		$v0, $v0, $t2
	
		addi 	$t1, $t1, 1
		addiu 	$a0, $a0, 1
		j 		whl4

ewhl4:	jr	 	$ra	

# int ii = 0
# int temp = 0	
# int res = 0
#
# while ( *s != '\0' ){
# 	if( *s == 1 )~{
#		temp = 1;
#		for(int i = 0; i < ii; i++){
#			temp = temp * 2;
#		}			
# 	}
#	res += temp
#	ii++
#	*s++
#}
#return res

###############

itoa:	addiu	$sp, $sp, -16
		sw		$ra, 0($sp)
		sw 		$s0, 4($sp)
		sw		$s1, 8($sp)
		sw		$s2, 12($sp)
	
		move 	$s0, $a0
		move 	$s1, $a1
		move 	$s2, $a2
		move 	$s3, $a2
	
do5:	rem		$t0, $a0, $a1
		div		$s0, $s0, $a1
		jal 	toascii
	
		sb		$v0, 0($s3)
		addiu	 	$s3, $s3, 1 
	
		bgt		$s0, 0, do5

		sb		$0, 0($s3)

		move	$a0, $s2
		jal		strrev
		move	$s2, $v0
	
		lw		$ra, 0($sp)
		lw 		$s0, 4($sp)
		lw		$s1, 8($sp)
		lw		$s2, 12($sp)
		addiu	$sp, $sp, 16
	
		jr 		$ra
	
# n:		$a0 -> $s0
# b:		$a1 -> $a1
# s:		$a2 -> $s2
# p:		$s3
# digit:	$t0	
#
#char *itoa(unsigned int n, unsigned int b, char *s) {
#	char *p = s;
#	char digit;
#	do {
#		digit = n % b;
#		n = n / b;
#		*p++ = toascii( digit );
#	} while( n > 0 );
#	*p = '\0';
#	strrev( s );
#	return s;
#}

###############

toascii:
		addi	$a0, $a0, '0'
		ble		$a0, '9', end6
		addi	$a0, $a0, 7
end6:	move	$v0, $a0
		jr		$ra

#char toascii(char v) {
#	v += '0';
#	if( v > '9' )
#		v += 7; // 'A' - '9' - 1
#	return v;
#}
