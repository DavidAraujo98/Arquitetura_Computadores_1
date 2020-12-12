	.data
	
	.eqv SIZE, 3
	.eqv print_string, 4
	.eqv print_char, 11
	.eqv print_int10, 1
	
str1:	.asciiz "Array"
str2:	.asciiz "de"
str3:	.asciiz "ponteiros"
str4:	.asciiz "\nString #"
str5:	.asciiz ": "
array:	.word str1, str2, str3
	
	.text
	.globl main

main:	la $t0, array
	li $t1, 0
	
for:	bge $t1, SIZE, efor

	la $a0, str4
	li $v0, print_string		#print_str("\nString #")
	syscall
	
	or $a0, $0, $t1
	li $v0, print_int10		#print_int10(i)
	syscall
	
	la $a0, str5
	li $v0, print_string		#print_str(": ")
	syscall
	
	li $t2, 0	

while:	sll $t4, $t1, 2
	addu $t3, $t0, $t4
	lw $t3, 0($t3)
	
	addu $t3, $t3, $t2
	lb $t3, 0($t3)
	
	beq $t3, '\0', ewhile
	
	move $a0, $t3
	li $v0, print_char
	syscall
	
	li $a0, '-'
	li $v0, print_char
	syscall
	
	addi $t2, $t2, 1	

	j while
	
ewhile:	addi $t1, $t1, 1
	j for
	
efor:	jr $ra

# array:	$t0
# i:		$t1
# j:		$t2
# array[i]:	$t3
# ck:		$t4
#
#define SIZE 3
#void main(void) {
#	static char *array[SIZE]={"Array", "de", "ponteiros"};
#	int i, j;
#	for(i=0; i < SIZE; i++) {
#		print_str( "\nString #" );
#		print_int10( i );
#		print_str( ": " );
#		j = 0;
#		while(array[i][j] != '\0') {
#			print_char(array[i][j]);
#			print_char('-');
#			j++;
#		}
#	}
#}