	.data
	
	.eqv read_int, 5
	.eqv print_float, 2
label:	.float 2.59375
	
	.text
	.globl main
	
main:			
do:	li	$v0, read_int
	syscal			#read_int
	move 	$t0, $v0
		
	la	$t2, label
	l.s	$f2, 0($t2)	# $f2 = 2.59375
		
	mtc1	$t0, $f4		# $f4 = val 
	cvt.s.w	$f4, $f4		# $f4 = (float) val
	mul.s	$f0, $f2, $f4	# res = $f4 * $f2
		
	mov.s	$f12, $f0		
	li	$v0, print_float
	syscall
		
	li	$a0, '\n'
	li	$v0, 11		# println
	syscall
		
	mtc1	$0, $f2			
	cvt.s.w	$f2, $f2
	c.eq.s	$f0, $f2
	bc1f	do

	jr $ra

# val:			$t0
# res:			$f0
# 2.59375		$f2
# (float)val:	$f4
#
#int main(void) {
#	float res;
#	int val;
#	do {
#		val = read_int();
#		res = (float)val * 2.59375;
#		print_float( res );
#	} while(res != 0.0);
#	return 0;
#}