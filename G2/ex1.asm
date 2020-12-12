	.data
	.text
	.globl main
	
main:	ori $t0, $0, 0x5C1B
	ori $t1, $0, 0xA3E4
	ori $t7, $0, 0xE543  
	ori $t8, $0, 0xFFFFFFFF
	and $t2, $t0, $t1
	or $t3, $t0, $t1
	nor $t4, $t0, $t1
	xor $t5, $t0, $t1
	xor $t6, $t7, $t8
	jr $ra 