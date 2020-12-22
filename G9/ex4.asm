		.data

		.eqv SIZE, 80
array:	.space SIZE

		.eqv read_int, 5
		.eqv print_double, 3

		.text
		.globl main

main:	addiu	$sp, $sp, -4
		sw		$ra, 0($sp)
		
		la		$t0, array
		li		$t1, 0
		
for:	bge		$t1, 10, efor

		li		$v0, read_int
		syscall
		move	$t2, $v0			# $t2 = read_int()
		
		mtc1	$t2, $f0		
		cvt.d.w	$f0, $f0			# $f0 = (double) $t2
		
		sll		$t2, $t1, 3			# $t2 = i * 8
		addu	$t2, $t2, $t0		# $t2 = a[$t2]
		
		s.d		$f0, 0($t2)			# $t2 = $f0
		
		addi	$t1, $t1, 1			# i++
		j 		for

efor:	move	$a0, $t0
		li		$a1, 10
		jal		max

		mov.d	$f12, $f0
		li		$v0, print_double
		syscall
		
		lw		$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		jr		$ra
		
# a:		$t0
# i:		$t1
# i*:		$t2
#
#define SIZE 10
#int main(void) {
#	static double a[SIZE];
#	int i;
#	for(i = 0; i < SIZE; i++) {
#		a[i] = (double)read_int();
#	}
#	print_double( max(a, SIZE) );
#	return 0;
#}

###############

max:	addi	$a1, $a1, -1
		sll		$a1, $a1, 3
		
		add		$t0, $a0, $a1	#last position of the array
		
		l.d		$f0, 0($a0)		# max = p[0]
		
for1:	bgt		$a0, $t0, efor1
		l.d		$f2, 0($a0)
				
if1:	c.le.d	$f2, $f0
		bc1t 	eif1
		mov.d	$f0, $f2
		
eif1:	addiu	$a0, $a0, 8 	
		j		for1

efor1:	jr		$ra
		

# $f0		max
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