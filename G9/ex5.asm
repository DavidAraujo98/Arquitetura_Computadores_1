max:	addi	$a1, $a1, -1	# n = n - 1
		mtc1	$a1, $f2
		cvt.d.w	$f2, $f2
		add.d	$
		

# $f1		max
# $f2		*u
# $f3		max
#
#double max(double *p, unsigned int n) {
#	double max;
#	double *u = p+n–1;
#	max = *p++;
#	for(; p <= u; p++) {
#		if(*p > max)
#		max = *p;
#	}
#	return max;
#}