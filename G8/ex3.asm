		.text
		.globl div
		
div:	addiu	$sp, $sp, -24
		sw		$ra, 0($sp)
		sw		$s0, 4($sp)
		sw		$s1, 8($sp)
		sw		$s2, 12($sp)
		sw		$s3, 16($sp)
		sw		$s4, 20($sp)
		
		li		$s2, 0
		li		$s3, 0
		
		sll		$a1, $a1, 16
		andi	$a0, $a0, 0xFFFF
		sll		$a0, $a0, 1
		
		li		$s0, 0
for:	li		$s1, 0
		blt		$a0, $a1, eif
		sub		$a0, $a0, $a1
		li		$s1, 1
		
eif:	sll		$a0, $a0, 1
		or		$a0, $a0, $s1
		
		addi	$s1, $s1, 1
		blt		$s0, 16, for
		
		srl		$s4, $a0, 1
		and		$s3, $s4, 0xFFFF
		
		and		$s2, $a0, 0xFFFF
		
		or		$v0, $s3, $s2
		
		lw		$ra, 0($sp)
		lw		$s0, 4($sp)
		lw		$s1, 8($sp)
		lw		$s2, 12($sp)
		lw		$s3, 16($sp)
		lw		$s4, 20($sp)
		addiu	$sp, $sp, 20
		
		jr		$ra
		
# i:			$s0
# bit:			$s1
# quociente:	$s2
# tquociente:	$s4
# resto:		$s3	
#
#unsigned int div(unsigned int dividendo, unsigned int divisor) {
#	int i, bit, quociente, resto;
#	divisor = divisor << 16;
#	dividendo = (dividendo & 0xFFFF) << 1;
#	for(i=0; i < 16; i++) {
#		bit = 0;
#		if(dividendo >= divisor) {
#			dividendo = dividendo - divisor;
#			bit = 1;
#		}
#		dividendo = (dividendo << 1) | bit;
#	}
#	resto = (dividendo >> 1) & 0xFFFF0000;
#	quociente = dividendo & 0xFFFF;
#	return (resto | quociente);
#}
