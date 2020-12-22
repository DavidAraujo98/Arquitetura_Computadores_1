	.data
	
	.eqv MAX, 33
	.eqv read_int, 5
	.eqv print_string, 4
	
str:	.space MAX
	
	.text
	.globl main
	
main:	addiu	$sp, $sp, -12
	sw	$ra, 0($sp)
	sw	$s1, 4($sp)
	sw	$s2, 8($sp)
	
	li	$s1, 0
	la	$s0, str

do:	li	$v0, read_int
	syscall
	move	$t1, $v0
	
	move	$a0, $s1
	li	$a1, 2
	move	$a3, $s0
	jal	itoa
	move	$a0, $v0
	li	$v0, print_string
	syscall
	
	move	$a0, $s1
	li	$a1, 8
	move	$a3, $s0
	jal	itoa
	move	$a0, $v0
	li	$v0, print_string
	syscall
	
	move	$a0, $s1
	li	$a1, 16
	move	$a3, $s0
	jal	itoa
	move	$a0, $v0
	li	$v0, print_string
	syscall
	
	bne	$s1, 0, do
	
	li	$v0, 0
	
	lw	$ra, 0($sp)
	lw	$s1, 4($sp)
	lw	$s2, 8($sp)
	addiu	$sp, $sp, 12
		
	jr	$ra

# val:	$s1
# str:	$s0

#define MAX_STR_SIZE 33
#int main(void) {
#	static char str[MAX_STR_SIZE];
#	int val;
#	do {
#		val = read_int();
#		print_string( itoa(val, 2, str) );
#		print_string( itoa(val, 8, str) );
#		print_string( itoa(val, 16, str) );
#	} while(val != 0);
#	return 0;
#}
