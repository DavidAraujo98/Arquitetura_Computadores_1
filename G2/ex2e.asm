	.data
	.text
	.globl main
main:	li $t1, 0x00000008
	
	srl $t0, $t1, 4		# $t0 = (num >> 4)
	xor $t1, $t0, $t1	# num = num XOR $t0
			
	srl $t0, $t1, 2		# $t0 = ( num >> 2)
	xor $t1, $t0, $t1	# num = num XOR $t0
		
	srl $t0, $t1, 1		# $t0 = (num >> 1)
	xor $t1, $t0, $t1	# num = num XOR $t0
	
	or $t2, $0, $t1		# bin = num
	
	jr $ra