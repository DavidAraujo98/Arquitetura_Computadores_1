	.data
	
	.text
	.globl xtoy

xtoy:	addiu	$sp, $sp, -4
		sw	$ra, 0($sp)
		
		mtc1 $a0, $f2		# $t1 = x
		cvt.s.w	$f2, $f2
		
		li	$t0, 0			# i = 0
		
		li	$t1, 1			#
		mtc1	$t1, $f0	#
		cvt.s.w	$f0, $f0	# result = 1.0
	
		move $a0, $a1
		jal abss
		
for:	bge	$t0, $v0, efor

if:		blez	$a1, else
		mul.s	$f0, $f0, $f2
		j eif
		
else:	div.s	$f0, $f0, $f2

eif:	addi	$t0, $t0, 1
		j for
		
efor:	lw	$ra, 0($sp)
		addiu $sp, $sp, 4
		jr $ra

# $t0:	i
# $f2:	x
# $f0:	result

#float xtoy(float x, int y) {
#	int i;
#	float result;
#	for(i=0, result=1.0; i < abs(y); i++) {
#		if(y > 0)
#			result *= x;
#		else
#			result /= x;
#	}
#	return result;
#}

abss:	sw	$ra, 0($sp)
		bge	$a0, 0, eif1
		sub	$v0, $0, $a0  

eif1:	lw	$ra, 0($sp)
		jr	$ra 

#int abs(int val) {
#	if(val < 0)
#		val = -val;
#	return val;
#} 
