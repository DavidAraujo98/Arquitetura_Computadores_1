
buf:	.space 33

	.eqv print_string, 4

print:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
		
	la	$a3, buf
	jal	itoa
		 
	move	$a0, $v0
	li	$v0, print_string
	syscall
		
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4

#void print_int_ac1(unsigned int val, unsigned int base) {
#	static char buf[33];
#	print_string( itoa(val, base, buf) );
#}