	.data
	
	.eqv SIZE, 80
array:	.space SIZE
		
	.eqv read_int, 5
	.eqv print_double, 3
		
	.text
	.globl main
	
main:	addiu	$sp, $sp, -4
	sw	$ra, 0($sp)
		
	la	$t0, array
	li	$t1, 0
		
for:	bge	$t1, 10, efor

	li	$v0, read_int
	syscall
	move	$t2, $v0		# $t2 = read_int()
		
	mtc1	$t2, $f0		
	cvt.d.w	$f0, $f0		# $f0 = (double) $t2
		
	sll	$t2, $t1, 3	# $t2 = i * 8
	addu	$t2, $t2, $t0	# $t2 = a[$t2]
		
	s.d	$f0, 0($t2)	# $t2 = $f0
		
	addi	$t1, $t1, 1	# i++
	j	for

efor:	move	$a0, $t0
	li	$a1, 10
	jal	average

	mov.d	$f12, $f0
	li	$v0, print_double
	syscall
		
	lw	$ra, 0($sp)
	addiu	$sp, $sp, 4
		
	jr	$ra
		
# a:	$t0
# i:	$t1
# i*:	$t2
#
#define SIZE 10
#int main(void) {
#	static double a[SIZE];
#	int i;
#	for(i = 0; i < SIZE; i++) {
#		a[i] = (double)read_int();
#	}
#	print_double( average(a, SIZE) );
#	return 0;
#}

###############

average:	mtc1	$0, $f0
	cvt.d.w	$f0, $f0		# $f0 = 0.0
			
	move	$t0, $a1
	
for1:	blez	$a1, efor1
			
	sll	$t1, $a1, 3		
	addu	$t1, $t1, $a0	
			
	l.d	$f2, 0($t1)	# $f2 = array[i-1]
			
	add.d	$f0, $f0, $f2	# $f0 += $f2
			
	addi	$a1, $a1, -1	# i--
			
	j	for1
			
efor1:	mtc1	$t0, $f2
	cvt.d.w	$f2, $f2
			
	div.d	$f0, $f0, $f2 
			
	jr	$ra


# $t1:	i*
# $f0:	sum
# $f2	array[i-1]	
#
#double average(double *array, int n) {
#	int i = n;
#	double sum = 0.0;
#	for(; i > 0; i--) {
#		sum += array[i-1];
#	}
#	return sum / (double)n;
#}