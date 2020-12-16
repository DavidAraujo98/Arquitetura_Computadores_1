	.data
	
str:	.asciiz "101101"

	.eqv print_int10, 1
	
	.text
	.globl main
	
main:	addiu $sp, $sp, -4
	sw $ra, 0($sp)

	la $a0, str
	jal atoib
	
	move $a0, $v0
	li $v0, print_int10
	syscall	

	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
#int main(void) {
#	static char str[]="2016 e 2020 sao anos bissextos";
#	print_int10( atoi(str) );
#	return 0;
#}

###############

atoib:	li $v0, 0
	li $t1, 0
	
whl:	lb $t0, 0($a0)
	bne $t0, '\0', ewhl
	
			
if:	bne $t0, '1', else
	li $t3, 0	#  i = 0
	li $t2, 1	#  temp = 1 
whl1:	mul $t2, $t2, 2
	addi $t3, $t3, 1
	blt $t3, $t1, whl1
	
		
else:	add $v0, $v0, $t2
	
	addi $t1, $t1, 1
	addiu $a0, $a0, 1
	j whl

ewhl:	jr $ra	

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