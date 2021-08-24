addi x3,x0,99
addi x4,x0,156
add  x5,x3,x4
sub  x6,x3,x4
sub  x1,x4,x3

addi x2,x0,6
addi x7,x0,1

andi x8,x2,1 
and x9,x2,x7

xor x10,x2,x7

sll x11,x7,x2
slli x12,x7,6
slli x13,x7,3

slt x14,x2,x7
slti x15,x2,7

branch1:
beq x2,x2,first
branch2:
bne x2,x2,second
branch3:
blt x7,x2,third
branch4:
bge x2,x7,fourth
branch5:
j exit

first:
addi x16,x0,1
jal branch2

second:
addi x17,x0,2
j branch3

third:
addi x18,x0,3
j branch4

fourth:
addi x19,x0,4
j branch5

exit:
nop