addi 	t0, 	zero, 0x20	
addi 	t1, 	zero, 0x37	
and 	s0, 	t0, 	t1
or 	s0, 	t0, 	t1
sw 	s0, 4(zero)	
sw 	t0, 8(zero)	
add 	s1, 	t0, 	t1
sub 	s2, 	t0, 	t1
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
beq 	s1, 	s2, error0	
lw 	s1, 4(zero)	
andi 	s2, 	s1, 0x48	
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
beq 	s1, 	s2, error1	
lw 	s3, 8(zero)	
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
beq 	s0, 	s3, error2	
Last:slt 	s4, 	s2, 	s1 
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
addi 	t0, 	zero, 0x20	
beq 	s4, 	x0, EXIT	
add 	s2, 	s1, x0
j Last			
error0:
addi 	t0, 	x0, 0
addi 	t1, 	x0, 0	
j EXIT			
error1:
addi 	t0, 	x0, 1	
addi 	t1, 	x0, 1	
j EXIT			
error2:
addi 	t0, 	x0, 2	
addi 	t1, 	x0, 2	
j EXIT			
error3:
addi 	t0, 	x0, 3
addi 	t1, 	x0, 3	
j EXIT	
EXIT: nop		
