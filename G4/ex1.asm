# Mapa de registo
# num:		$t0
# i:		$t1
# str:		$t2
# str+i:	$t3
# str[i]:	$t4
	.data
	.eqv	SIZE, 20
	.eqv	read_string, 8
	.eqv	print_int10, 1	
str:	.space	SIZE
	.text
	.globl main
	
main:							
							
	la  $a0, str					
	ori  $v0, $0, read_string
	li  $a1, SIZE					
	syscall						
	
	ori  $t0, $0, 0					
	ori  $t1, $0, 0					
	
while:							
	la   $t2, str					
	addu $t3, $t2, $t1				
	lb   $t4, 0($t3) 					
	
	beq  $t4, '\0', endLoop				

if:	blt  $t4, '0', endIf				
	bgt  $t4, '9', endIf				
	addi $t0, $t0, 1				

endIf:  						
	addi $t1, $t1, 1				
	j while						
							
endLoop:ori $v0, $0, print_int10			
	or $a0, $0, $t0
	syscall
	
	jr $ra						