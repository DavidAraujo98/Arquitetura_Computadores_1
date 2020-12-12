	.data
	
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
array:	.word str1, str2, str3
	
	.text
	.globl main

main:	la $t0, array
	
	li $t1, SIZE
	sll $t1, $t1, 2
	
	addu $t1, $t0, $t1 

for:	bge $t0, $t1, efor

	lw $a0, 0($t0)
	li $v0, print_string
	syscall
	
	li $a0, '\n'
	li $v0, print_char
	syscall
		
	addiu $t0, $t0, 4
	j for

efor:	jr $ra

# p:		$t0
# penultimo	$t1
#
#define SIZE 3
#void main(void) {
#	static char *array[SIZE]={"Array", "de", "ponteiros"};
#	char **p;
#	char **pultimo;
#
#	p = array;
#	pultimo = array + SIZE;
#
#	for(; p < pultimo; p++) {
#		print_str(*p);
#		print_char('\n');
#	}
#}
