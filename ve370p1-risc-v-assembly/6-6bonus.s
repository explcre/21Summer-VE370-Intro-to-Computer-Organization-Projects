main:
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        addi    s0,sp,32
        
        li      a5,20480
        addi    a5,a5,768      #21248
        sh      a5,-28(s0)
        li      a5,32
        sb      a5,-26(s0)
        addi    a5,s0,-28

        li      a1,3    #second argument=3
        addi    a0,a5,0 #address of array
        jal     HextoDec(unsigned char const*, int)
        addi    a5,a0,0 #return value saved to a5
        addi    s2,a0,0 #return value saved to s2
        
        sw      a5,-20(s0)
        sh      zero,-32(s0)
        sb      zero,-30(s0)
        li      a5,4096
        addi    a5,a5,1931  #6027=0x178b 
        sw      a5,-24(s0)  #saved in 0x7fffd8
        addi    a5,s0,-32

        li      a2,3       #3-th argument length=3 
        addi    a1,a5,0    #second argument array address
        lw      a0,-24(s0) #first argument,dec=5320 #0x7fffdc
        jal     DectoBCD(int, unsigned char*, int)
        addi    s3,a0,0  #save return value to s3
        li      a5,0
        addi    a0,a5,0
        lw      ra,28(sp)
        lw      s0,24(sp)
        addi    sp,sp,32
        j       exit





divide(int, int):
        addi    sp,sp,-64
        sw      s0,60(sp)
        addi    s0,sp,64
        sw      a0,-52(s0)      #save first argument,dividend
        sw      a1,-56(s0)      #save second argument, divider
                                #the following steps will get the absolute value of 2 arguments
        lw      a5,-52(s0)      #a5=dividend
        srai    a5,a5,31        #a5=a5>>31
        lw      a4,-52(s0)      #a4=dividend
        xor     a4,a5,a4        #a4=a5^a4=(dividend<<31)^dividend
        sub     a5,a4,a5        #a5=a4-a5=(dividend<<31)^dividend-(dividend<<31)
                                #a5=dividend = a < 0 ? (~a+1) : a;
        sw      a5,-20(s0)      #save a5
        lw      a5,-56(s0)      #load a5=divider
        srai    a5,a5,31        #a5=divider<<31
        lw      a4,-56(s0)      #a4=divider
        xor     a4,a5,a4        #a4=(divider<<31) ^divider
        sub     a5,a4,a5        #a5=(divider<<31) ^divider-(divider<<31)
                                ##a5=divider = b < 0 ? (~b+1) : b;
        sw      a5,-36(s0)      #save a5
        addi    a5,x0,2         #a5=invert=2 
        sw      a5,-24(s0)      #save a5=invert=2
.while1_divide:
        lw      a5,-20(s0)
        beq     a5,x0,.outOfWhile1_divide #while(dividend)
                                          #if(dividend==0),jump out of while
        lw      a5,-20(s0)      #a5=|dividend|        
        andi    a5,a5,1         #|dividend| & 1
        lw      a4,-24(s0)      #load a4=invert=2
        or      a5,a4,a5        #a5=invert |  absolute_value(dividend) & 1
        sw      a5,-24(s0)      #save a5=invert
        lw      a5,-24(s0)      #load a5
        slli    a5,a5,1         #a5=a5<<1
        sw      a5,-24(s0)      #save a5
        lw      a5,-20(s0)      #load a5=absolute_value(dividend)
        srai    a5,a5,1         #a5=|dividend|>>1
        sw      a5,-20(s0)       #save a5
        j       .while1_divide
.outOfWhile1_divide:
        sw      x0,-28(s0)  #quotient=0  
        sw      x0,-32(s0)   #reminder =0
.while2_divide:
        lw      a4,-24(s0)   #load invert
        addi    a5,x0,1      #a5=1
        
        bge     a5,a4,.if_divide #while(1<invert) #if (1>=invert),jump out of while
        lw      a5,-32(s0)      #a5=reminder
        slli    a5,a5,1         #a5=reminder<<1
        sw      a5,-32(s0)      #save a5=reminder
        lw      a5,-24(s0)      #load a5=invert
        andi    a5,a5,1         #a5=a5&1
        lw      a4,-32(s0)      #load reminder
        or      a5,a4,a5        #a5=reminder|(invert&1) 
        sw      a5,-32(s0)      #save a5=reminder
        lw      a5,-24(s0)      # load invert
        srai    a5,a5,1         #a5=invert>>1
        sw      a5,-24(s0)      #save a5
        lw      a5,-28(s0)      #load a5=quotient
        slli    a5,a5,1         #a5=quotient<<1
        sw      a5,-28(s0)      #save quotient
        lw      a4,-32(s0)      #a4=reminder
        lw      a5,-36(s0)      #a5=divider
        blt     a4,a5,.while2_divide  #if(reminder<divider)jump to head of while2
        lw      a5,-28(s0)     #if((reminder>=divider),load a5=quotient
        ori     a5,a5,1         #a5=quotient | 1
        sw      a5,-28(s0)      #save a5 =quotient
        lw      a4,-32(s0)      #load a4=reminder
        lw      a5,-36(s0)      #load a5=divider
        sub     a5,a4,a5        #a5=reminder-divider
        sw      a5,-32(s0)      #save a5=divider
        j       .while2_divide  #jump to head of while2
.if_divide:                     #following about sign
        lw      a4,-52(s0)      #load first argument
        lw      a5,-56(s0)      #load second argument
        xor     a5,a4,a5        #a^b
        bge     a5,x0,.exit_divide #if(a^b) >=0
        lw      a5,-28(s0)       #load quotient
        neg     a5,a5           #a5=~quotient+1
        sw      a5,-28(s0)      #save a5=quotient
  
.exit_divide:
        lw      a5,-28(s0)    #load quotient
        addi    a0,a5,0       #a0=a5=return value
        lw      s0,60(sp)
        addi    sp,sp,64
        jr      ra



multiply(long long, int):
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        sw      a0,-40(s0)       #a0=lower32 bits of first argument
        sw      a1,-36(s0)       #a1=higher 32 bits of second argument
        sw      a2,-44(s0)       #second argument(int)

        sw      x0,-24(s0)       #
        sw      x0,-20(s0)       #
        sw      zero,-28(s0)
.for_multiply(long long, int):
        lw      a4,-28(s0)
        addi    a5,x0,63
        blt     a5,a4,.exit_multiply(long long, int)

        lw      a5,-44(s0)
        andi    a5,a5,1                #if (A[i] &1)  ==0 means 0-th bit of A[i]=0
                                       # if A[i] &1)!=0   means 0-th bit of A[i]=1
        beq     a5,x0,.outOfIf_multiply(long long, int)
        lw      a2,-24(s0)
        lw      a3,-20(s0)

        lw      a0,-40(s0)             #lower 32 bits
        lw      a1,-36(s0)             #higher 32bits

        add     a4,a2,a0               #a4=lower 32bits product*A[i]
        addi    a6,a4,0                #a6=a5=lower 32bits *A[i]
        sltu    a6,a6,a2               #a6=(a6>a2)=lower 32bits*A[i] < A[i]
        add     a5,a3,a1               #
        add     a3,a6,a5
        addi    a5,a3,0
        sw      a4,-24(s0)
        sw      a5,-20(s0)
.outOfIf_multiply(long long, int):
        lw      a5,-40(s0) #lower 32bits
        srli    a5,a5,31   # >>31bits
        lw      a4,-36(s0)
        slli    a4,a4,1   #a4=lower 32bits*A[i]<<1 (second argument)
        or      a5,a4,a5  #a5=a4 | a5
        sw      a5,-36(s0) #save to higher 32bits (s0-36)
        lw      a5,-40(s0)
        slli    a5,a5,1
        sw      a5,-40(s0)
       
        lw      a5,-44(s0)  #(second argument)
        srai    a5,a5,1
        sw      a5,-44(s0)
        lw      a5,-28(s0)
        addi    a5,a5,1
        sw      a5,-28(s0)
        j       .for_multiply(long long, int)

.exit_multiply(long long, int):
        lw      a4,-24(s0)
        lw      a5,-20(s0)
        addi    a0,a4,0
        addi    a1,a5,0
        lw      s0,44(sp)
        addi    sp,sp,48
        jr      ra




multiply(int, int):      #similar to multiply(long long, int),but first argument is int
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        sw      zero,-20(s0)
        sw      zero,-24(s0)
.for_multiply(int, int):
        lw      a4,-24(s0)
        li      a5,31
        blt     a5,a4,.exit_multiply(int, int)   
        lw      a5,-40(s0)
        andi    a5,a5,1
        beq     a5,zero,.outOfIf_multiply(int, int)
        lw      a4,-20(s0)
        lw      a5,-36(s0)
        add     a5,a4,a5
        sw      a5,-20(s0)
.outOfIf_multiply(int, int):
        lw      a5,-36(s0)
        slli    a5,a5,1
        sw      a5,-36(s0)
        lw      a5,-40(s0)
        srai    a5,a5,1
        sw      a5,-40(s0)
        lw      a5,-24(s0)
        addi    a5,a5,1
        sw      a5,-24(s0)
        j       .for_multiply(int, int)
.exit_multiply(int, int):
        lw      a5,-20(s0)
        addi    a0,a5,0
        lw      s0,44(sp)
        addi    sp,sp,48
        jr      ra

HextoDec(unsigned char const*, int):
        addi    sp,sp,-48
        sw      s0,44(sp)
        addi    s0,sp,48
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        sw      zero,-24(s0)
        sw      zero,-20(s0)
.for_HextoDec:
        lw      a4,-20(s0)
        lw      a5,-40(s0)
        bge     a4,a5,.exit_HextoDec
        lw      a5,-20(s0)
        lw      a4,-36(s0)
        add     a5,a4,a5
        lbu     a5,0(a5)
        addi    a3,a5,0
        lw      a5,-40(s0)
        addi    a4,a5,-1
        lw      a5,-20(s0)
        sub     a5,a4,a5
        slli    a5,a5,3
        sll     a5,a3,a5
        lw      a4,-24(s0)
        add     a5,a4,a5
        sw      a5,-24(s0)
        lw      a5,-20(s0)
        addi    a5,a5,1
        sw      a5,-20(s0)
        j       .for_HextoDec
.exit_HextoDec:
        lw      a5,-24(s0)
        addi    a0,a5,0
        lw      s0,44(sp)
        addi    sp,sp,48
        jr      ra


DectoBCD(int, unsigned char*, int):
        addi    sp,sp,-48
        sw      ra,44(sp)
        sw      s0,40(sp)
        sw      s1,36(sp)
        sw      s2,32(sp)
        addi    s0,sp,48
        sw      a0,-36(s0)
        sw      a1,-40(s0)
        sw      a2,-44(s0)
        lw      a5,-44(s0)
        addi    a5,a5,-1
        sw      a5,-20(s0)
.for_DectoBCD:
        lw      a5,-20(s0)
        blt     a5,zero,.exit_DectoBCD
        li      a1,100
        lw      a0,-36(s0)
        jal     divide(int, int)
        addi    a5,a0,0
        li      a1,100
        addi      a0,a5,0
        jal     multiply(int, int)
        addi    a4,a0,0
        lw      a5,-36(s0)
        sub     a5,a5,a4
        sw      a5,-24(s0)
        li      a1,10
        lw      a0,-24(s0)
        jal     divide(int, int)
        addi    a5,a0,0
        andi    a5,a5,0xff
        slli    a5,a5,4
        andi    s1,a5,0xff
        lw      a5,-24(s0)
        andi    s2,a5,0xff
        li      a1,10
        lw      a0,-24(s0)
        jal    divide(int, int)
        addi      a5,a0,0
        li      a1,10
        addi    a0,a5,0
        jal     multiply(int, int)
        addi    a5,a0,0
        andi    a5,a5,0xff
        sub     a5,s2,a5
        andi    a5,a5,0xff
        andi    a5,a5,15
        andi    a4,a5,0xff
        lw      a5,-20(s0)
        lw      a3,-40(s0)
        add     a5,a3,a5
        add     a4,s1,a4
        andi    a4,a4,0xff
        sb      a4,0(a5)
        li      a1,100
        lw      a0,-36(s0)
        jal    divide(int, int)
        sw      a0,-36(s0)
        lw      a5,-20(s0)
        addi    a5,a5,-1
        sw      a5,-20(s0)
        j       .for_DectoBCD
.exit_DectoBCD:
        li      a5,0
        addi    a0,a5,0
        lw      ra,44(sp)
        lw      s0,40(sp)
        lw      s1,36(sp)
        lw      s2,32(sp)
        addi    sp,sp,48
        jr      ra





exit:
         nop