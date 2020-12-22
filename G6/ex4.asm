	.data
	
	.align 2
	.eqv print_string, 4
	.eqv print_int10, 1

str1:	.asciiz "Nr. de parametros: "
str2:	.asciiz "\nP"
str3:	.asciiz ": "
	
	.text
	.globl main
	
main:	li	$t0, 0

	move	$t1, $a0 
	move	$t2, $a1

	la	$a0, str1
	li	$v0, print_string 
	syscall
	
	move	$a0, $t1
	li	$v0, print_int10
	syscall
	
for:	bge	$t0, $t1, efor

	la	$a0, str2
	li	$v0, print_string
	syscall
	
	move	$a0, $t0
	li	$v0, print_int10
	syscall
	
	la	$a0, str3
	li	$v0, print_string
	syscall
	
	sll	$t4, $t0, 2
	addu	$t3, $t2, $t4
	lw	$t3, 0($t3)
	
	move	$a0, $t3
	li	$v0, print_string
	syscall

	addi	$t0, $t0, 1
	j	for

efor:	li	$v0, 0
	jr	$ra
	
# i:	$t0
# argc:	$t1
# argv:	$t2
# argv[i]:	$t3
# ck:	$t4 
#
#int main(int argc, char *argv[]) {
#	int i;
#	print_str("Nr. de parametros: ");
#	print_int(argc);
#	for(i=0; i < argc; i++) {
#		print_str("\nP");
#		print_int(i);
#		print_str(": ");
#		print_str(argv[i]);
#	}
#	return 0;
#}