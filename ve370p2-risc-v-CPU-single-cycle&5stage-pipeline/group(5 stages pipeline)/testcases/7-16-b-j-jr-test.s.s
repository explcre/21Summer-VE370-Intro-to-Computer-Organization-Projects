addi x10,x0,60
#branch_beq
nop
nop
beq x10,x10,jump
nop
nop
not_run:
nop
nop
addi x27,x0,100
nop
nop
jump:
addi x27,x0,80

#x28 should be 80 =0x50


#branch_bge
nop
nop
bge x10,x0,jump2
nop
nop
not_run2:
nop
nop
addi x28,x0,110
nop
nop
jump2:
addi x28,x0,90


#branch_blt
nop
nop
blt x0,x10,jump3
nop
nop
not_run3:
nop
nop
addi x26,x0,112
nop
nop
jump3:
addi x26,x0,98

#branch_bne:
nop
nop
bne x10,x0,jump4
nop
nop
not_run4:
nop
nop
addi x25,x0,188
nop
nop
jump4:
addi x25,x0,83





#branch_beq, don't jump case
nop
nop
beq x10,x0,jump_
nop
nop
not_run_:
nop
nop
addi x17,x0,100
nop
nop
jump_:
addi x17,x0,53

#x28 should be 80 =0x50


#branch_bge  don't jump case
nop
nop
bge x0,x10,jump2_
nop
nop
not_run2_:
nop
nop
addi x18,x0,110
nop
nop
jump2_:
addi x18,x0,43


#branch_blt  don't jump case
nop
nop
blt x10,x0,jump3_
nop
nop
not_run3_:
nop
nop
addi x16,x0,112
nop
nop
jump3_:
addi x16,x0,33

#branch_bne  don't jump case
nop
nop
bne x10,x10,jump4_
nop
nop
not_run4_:
nop
nop
addi x15,x0,188
nop
nop
jump4_:
addi x15,x0,23






#x29 should be 90 =0x5a
j bigjump

addi x9,x0,100
addi x9,x0,100
addi x9,x0,100
addi x9,x0,100
addi x9,x0,100
addi x9,x0,100

bigjump:
addi x9,x0,99

jal exit

addi x9,x0,100
addi x9,x0,100
addi x9,x0,100
addi x9,x0,100
addi x9,x0,100
addi x9,x0,99

j exit2
nop
addi x6,x0,100
addi x9,x0,100
exit:
nop
#addi x1,x0,0xd8
jr x1

exit2:
nop
