	.data
	
	.text
	.globl main
	
var:
	jal	average
	cvt.s.d	$f2, $f0
	
	li $t0, 0
	
	mtc1 $t0, $f4
	cvt.s.w	$f4, $f4

for:
	bge	$t0, $a1, efor
	
	sll	$t1, $t0, 3
	add	$t1, $a0, $t1
	
	l.s	$f6, 0($t1)
	sub.s	$f6, $f6, $f2
	
	mfc1	$a0, $f6
	li	$a1, 2
	jal xtoy
			
	addi	$t0, $t0, 1
	j for
	
efor:
	mtc1	$a1, $f2
	cvt.s.w	$f2, $f2
	
	div.s	$f4, $f4, $f2
	cvt.d.s	$f0, $f4

	jr $ra	
	
# $f2:	media -> val
# $f4:	soma
# $f6:	array[i]
#
#double var(double *array, int nval) {
#	int i;
#	float media, soma;
#	
#	media = (float)average(*array, nval);
#	
#	for(i=0, soma=0.0; i < nval; i++)
#		soma += xtoy(array[i] - media, 2);
#	
#	return (double)soma / nval;
#}

###############

stdev:
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	
	jal	var
	mfc1	$a0, $f0
	jal sqrt
	
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	
	jr	$ra

#double stdev(double *array, int nval) {
#	return sqrt( var(*array, nval) );
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