	.data
	
	.text
	.globl main
	
main:	ori	$v0,$0,5
	syscall
	or	$t0,$0,$v0
	
	ori	$t2,$0,8 
	add	$t1,$t0,$t0
	sub	$t1,$t1,$t2
	
	or	$a0,$0,$t1
	ori	$v0,$0,1	#print_int10
	syscall
	
	#ori	$v0,$0,34	#print_int16
	#syscall
	
	#ori	$v0,$0,36	#print_intu10
	#syscall
	
	jr	$ra
