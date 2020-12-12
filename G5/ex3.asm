# Mapa de registos
# Read Array
# i         : $t0
# lista     : $t1
# lista + i : $t2

# Bubble Sort
# i 		: $t3
# ck		: $t4
# i * 4  	: $t5
# lista		: $t6
# lista + i 	: $t7

# Print Array
# p: $t3
# *p: $t4
# lista+Size: $t5



	.data
	.eqv SIZE, 10	#define SIZE 10
	.eqv TRUE, 1	#define TRUE 1
	.eqv FALSE,0	#define FALSE 0		
	.eqv print_int10, 1
	.eqv read_int, 5
	.eqv print_string, 4

	
strA:	.asciiz	"\nIntroduza um número: "
	.align 2
strB:	.asciiz "\nConteúdo do array:\n"
	.align 2
strC: 	.asciiz "; "
	.align 2
list:	.space 40 
	.align 2
			
	.text
	.globl main 	
	
main:				
				
				
	li  $t0, 0		
while1:	beq $t0, SIZE, endW1	
	
	la $a0, strA 					
	li $v0, print_string
	syscall
			
	li $v0, read_int	
	syscall
	
	la  $t1, list		
	sll $t2, $t0, 2
	
	addu $t2, $t2, $t1	
	sw $v0, 0($t2)				
														
	addi $t0, $t0, 1	
	j while1
endW1: 				
	la $t6, list		
	
do:				
	li $t3, 0		
	li $t4, FALSE		

				
while:	bge $t3, SIZE, endW	

	sll  $t7, $t3, 2	
	addu $t7, $t7, $t6	
	lw $t8,0($t7) 		
	lw $t9,4($t7) 		
	
if:	ble $t8, $t9, endIf 	
				
	sw $t9, 0($t7)		
	sw $t8, 4($t7)		
	li $t4, TRUE		
endIf: 				
		
	addi $t3, $t3, 1	
	j while		
endW:				
				
endDo:	beq $t4, TRUE, do  	

				
	li $v0, print_string	
	la $a0, strB
	syscall
	
	la $t0, list		
				
				
	li $t2, SIZE			
	sll $t2, $t2, 2		
	addu $t2, $t2, $t0	
				
whileB: bge $t0, $t2, endWB	
	lw $t1, 0($t0)		
	
	li $v0, print_int10	
	move $a0, $t1
	syscall
					
	li $v0, print_string	
	la $a0, strC
	syscall			

	addu $t0, $t0, 4	

	j whileB			
endWB:		
	jr $ra			
