		.data
		
		.align 3
const:	.double 5.0, 9.0, 32.0
		
		.eqv read_double, 7
		.eqv print_double, 3
		
		.text
		.globl main

main:	addiu	$sp, $sp, -4
		sw		$ra, 0($sp)

		li		$v0, read_double
		syscall
		mov.d	$f12, $f0
		
		jal 	f2c

		mov.d	$f12, $f0
		li		$v0, print_double
		syscall
		
		lw		$ra, 0($sp)
		addiu	$sp, $sp, 4
		
		jr		$ra
		
###############

f2c:	la		$t0, const
		l.d		$f0, 0($t0)		# $f0 = 5
		l.d		$f2, 8($t0)		# $f2 = 9
		l.d		$f4, 16($t0)	# $f4 = 32.0
		
		div.d	$f0, $f0, $f2	# $f0 = 5 / 9
		
		sub.d	$f12, $f12, $f4	# $ft = ft - 32
		
		mul.d	$f0, $f12, $f0	# $f0 = $f0 * $ft
		
		
		jr 		$ra

# $f0:		5.0
# $f2:		9.0
# $f4:		32.0
# $f12:		ft
#
#double f2c(double ft) {
#	return (5.0 / 9.0 * (ft – 32.0));
#}
