strcpy:	move	$t0, $a0
	move	$t1, $a1
	
do:	lb	$t2, 0($t1)
	sb	$t2, 0($t0)
	
	addi	$t0, $t0, 1
	addi	$t1, $t1, 1
	
	bne	$t2, '\0', do
	
	move	$v0, $a0
	
	jr	$ta

#char *strcpy(char *dst, char *src){
#	char *p=dst;
#	do {
#		*p++ = ...
#	} while(*src++ ...
#	return dst;
#}