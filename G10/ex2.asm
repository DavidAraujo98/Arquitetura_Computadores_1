	.data

con:	.double 0.5, 25

	.text
	.globl sqrt
	
sqrt:
	mtc1	$a0, $f4
	cvt.d.w	$f4, $f4	# $f4 = val

	li	$t0, 1			# i = 1
	mtc1	$t0, $f0	# xn = i
	cvt.d.w	$f0, $f0	# $f0 = xn
	
	mov.d	$f2, $f0	# $f2 = $f0 (aux = xn)
	
	li $t0, 0			# i = 0
	
	mtc1	$f6, $t0
	cvt.d.w	$f6, $f6	# $f6 = 0.0

if:	c.le.d	$f4, $f6
	bc1t	else
	
do:	
	mov.d	$f2, $f0	# aux = xn
					
	div.d	$f0, $f4, $f0	# xn = val/xn
	
	add.d	$f0, $f2, $f0	# xn = aux + val/xn
	
	la	$t1, con
	l.d	$f8, 0($t1)	
		
	mul.d	$f0, $f0, $f8		# xn = xn * 0.5
	
	c.eq.d	$f2, $f0
	bc1t	end
	
	addi	$t0, $t0, 1
	bge	$t0, 25, end
	
	j do
	
else:
	mtc1	$0, $f0
	cvt.d.w	$f0, $f0
	
end:
	jr	$ra
# $f0:	xn
# $f2:	aux
# $f4:	val
# $f6:	0.0
# $f8:	val/xn
# $t0:	i		
#		
#double sqrt(double val) {
#	double aux, xn = 1.0;
#	int i = 0;
#	if(val > 0.0) {
#		do {
#			aux = xn;
#			xn = 0.5 * (xn + val/xn);
#		} while((aux != xn) && (++i < 25));
#	} else {
#		xn = 0.0;
#	}
#	return xn;
#} 
