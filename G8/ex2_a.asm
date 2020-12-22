	.text
	.globl itoa, toascii
	
itoa:	addiu	$sp, $sp, -16
	sw	$ra, 0($sp)
	sw 	$s0, 4($sp)
	sw	$s1, 8($sp)
	sw	$s2, 12($sp)
	
	move 	$s0, $a0
	move 	$s1, $a1
	move 	$s2, $a2
	move 	$s3, $a2
	
do:	rem	$t0, $a0, $a1
	div	$s0, $s0, $a1
	jal 	toascii
	
	sb	$v0, 0($s3)
	addiu 	$s3, $s3, 1 
	
	bgt	$s0, 0, do

	sb	$0, 0($s3)

	move	$a0, $s2
	jal	strrev
	move	$s2, $v0
	
	lw	$ra, 0($sp)
	lw 	$s0, 4($sp)
	lw	$s1, 8($sp)
	lw	$s2, 12($sp)
	addiu	$sp, $sp, 16
	
	jr	$ra
	
# n:	$a0 -> $s0
# b:	$a1 -> $a1
# s:	$a2 -> $s2
# p:	$s3
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

toascii:	addi	$a0, $a0, '0'
	ble	$a0, '9', end
	addi	$a0, $a0, 7

end:	move	$v0, $a0
	jr	$ra

#char toascii(char v) {
#	v += '0';
#	if( v > '9' )
#		v += 7; // 'A' - '9' - 1
#	return v;
#}
