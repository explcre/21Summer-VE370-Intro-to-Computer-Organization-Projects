.data

arraySize:.word 12
array:.word 10, -5, 1, 6,200,-100,16,-8,-9,-11,15,-10

.text
main:
        addi    sp,sp,-64         #sp=sp-64
        sw      ra,60(sp)         #ra stored in sp-4
        sw      s0,56(sp)         #s0 stored in sp-8
        sw      s1,52(sp)         #s1 stored in sp-12
        addi    s0,sp,64          #s0=sp-64+64=sp=0x7ffffff0
        addi    t1,sp,0           #t1=sp
        addi    s1,t1,0           #s1=t1=sp
        addi    t1,x0,19          #arraySize=
        sw      t1,-20(s0)        #save t1=arraySize=13 into s0-20
##################################################### 

        lw      t1,-20(s0)        #load t1=arraySize=13 from s0-20
        addi    t1,t1,-1          #t1=t1-1=arraySize-1
        sw      t1,-24(s0)        #save t1=arraySize-1 to s0-24
        addi    t3,t1,0           #t3=t1
        addi    t3,t3,1           #t3=t3+1=arraySize
        addi    a6,t3,0           #a6=t3=arraySize
        addi    a7,x0,0           #a7=0
        srli    t3,a6,27          #t3=arraySize>>27
        slli    a3,a7,5           #a3=0<<5
        or      a3,t3,a3          #a3=t3 | a3=arraySize>>27 | (0<<5)
        slli    a2,a6,5           #a2=a6<<5=arraySize<<5=arraySize*32
        addi    a3,t1,0           #a3=t1=arraySize-1
        addi    a3,a3,1           #a3=a3+1=arraySize
        addi    a0,a3,0           #a0=a3=arraySize
        addi    a1,x0,0           #a1=0
        srli    a3,a0,27          #a3=arraySize>>27
        slli    a5,a1,5           #a5=0<<5
        or      a5,a3,a5          #a5=arraySize>>27 | (0<<5)
        slli    a4,a0,5           #a4=arraySize<<5=arraySize*32
        addi    a5,t1,0           #a5=t1=arraySize-1
        addi    a5,a5,1           #a5=a5+1=arraySize
        slli    a5,a5,2           #a5=a5<<2=arraySize*4
        addi    a5,a5,15          #a5=a5+15=arraySize*4+15
        srli    a5,a5,4           #a5=a5>>4=(arraySize*4+15)/16
        slli    a5,a5,4           #a5=a5<<4=(arraySize*4+15) /16*16
        sub     sp,sp,a5          #sp=sp-a5=sp- (arraySize*4+15) /16*16 
        addi    a5,sp,0           #a5=sp
        addi    a5,a5,3           #a5=a5+3=sp+3
        srli    a5,a5,2           #a5=a5>>2=(sp+3)/4
        slli    a5,a5,2           #a5=a5<<2=(sp+3)/4*4

        sw      a5,-28(s0)        #&A[0] is in s0-28
        lw      a5,-28(s0)        #load &A[0] from s0-28
        
        #addi    a4,x0,10     #A[0]=10
        #sw      a4,0(a5)
        #addi    a5,a5,4
        #addi    a4,t1,-1
        #addi    a3,x0,-5     #A[1]=-5
        #sw      a3,0(a5)
        #addi    a5,a5,4
        #addi    a4,a4,-1
        #addi    a3,x0,1      #A[2]=1
        #sw      a3,0(a5)
        #addi    a5,a5,4
        #addi    a3,a4,-1
        #addi    a4,x0,0      #A[3]=6
        #sw      a4,0(a5)
        #addi    a4,a5,4
        #addi    a5,a3,-1

                              #A[arraySize]={10, -5, 1, 6,100,-100,16,-8,-9,-11,0,15,-10}

addi    a4,x0,50
sw      a4,0(a5)
addi    a5,a5,4
addi    a4,t1,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a4,a4,-1
addi    a3,x0,50
sw      a3,0(a5)
addi    a5,a5,4
addi    a3,a4,-1
addi    a4,x0,50
sw      a4,0(a5)
addi    a4,a5,4
addi    a5,a3,-1

#################################################################### 
.main_L3:
        blt     a5,zero,.main_L2           #is a5==0 jumpto  .main_L2
        sw      zero,0(a4)                 #save 0 into a4
        addi    a4,a4,4                    #a4=a4+4
        addi    a5,a5,-1                   #a5=a5-1
        j       .main_L3                   #jump to start of loop .main_L3


.main_L2:
        addi    a2,x0,1                    #a2=cntType=1
        lw      a1,-20(s0)                 #a1=arraySize
        lw      a0,-28(s0)                 #a0=&A[0]
        jal     countArray(int*, int, int) #function arguments a0=A[], a1=arraySize, a2=cntType
        sw      a0,-32(s0)                 #countArray(,,1);return value is stored in s0-32 0x7fffffdc
        addi    s3,a0,0                    #return result in s3
		
        addi    a2,x0,-1                   #a2=cntType=-1
        lw      a1,-20(s0)                 #a1=arraySize
        lw      a0,-28(s0)                 #a0=&A[0]
        jal     countArray(int*, int, int) #function arguments a0=A[], a1=arraySize, a2=cntType
        sw      a0,-36(s0)                 #save return result into s0-36
        addi    s4,a0,0                    #return result in s4

        addi    a2,x0,0                    #a2=cntType=0
        lw      a1,-20(s0)                 #a1=arraySize
        lw      a0,-28(s0)                 #a0=&A[0]
        jal     countArray(int*, int, int) #function arguments a0=A[], a1=arraySize, a2=cntType
        sw      a0,-40(s0)                 #save return result into s0-40
        addi    s5,a0,0                    #return result in s5
        
        addi    a2,x0,1                    #a2=position=1
        lw      a1,-20(s0)                 #a1=arraySize
        lw      a0,-28(s0)                 #a0=&A[0]
        jal     calculateAverage(int*, int, int)
        addi    a5,a0,0                    #a5=a0=return result
        sw      a5,-44(s0)                 #save return result into s0-44
        addi    s6,a5,0                    #return result in s6

        lw      a1,-20(s0)                 #a1=arraySize
        lw      a0,-28(s0)                 #a0=&A[0]
        jal     calculateProduct(int*, int)
        addi    s7,a0,0                    #return result first word(lower 32 bits) in s7
        addi    s8,a1,0                    #return result second word(higher 32 bits) in s8
        addi    s9,a2,0                    #64-96 bits
        addi   s10,a3,0                    #96-128 bits

        sw      a0,-60(s0)                 #return result first word(lower 32 bits) saved in s0-56
        sw      a1,-56(s0)                 #return result second word(higher 32 bits)  saved in s0-52
        sw      a2,-52(s0)           #64-96 bits
        sw      a2,-48(s0) 

        addi    sp,s1,0                    #sp=s1

        addi    a5,x0,0                    #a5=0
        addi    a0,a5,0                    #a0=a5=0
        addi    sp,s0,-64                  #sp=s0-64
        lw      ra,60(sp)                  #load back return address from (sp+60) to ra
        lw      s0,56(sp)                  #load back s0 from (sp+56) to ra
        lw      s1,52(sp)                  #load back s1 from (sp+52) to ra
        addi    sp,sp,64                   #sp=sp+64
        #jr     ra
        j       exit                       #goto exit, end main


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
        sw      a1,-36(s0)        #a1=higher 32 bits of second argument
        sw      a2,-32(s0)         #64-96 bits
        sw      a3,-28(s0)         #96-128 bits
        sw      a4,-44(s0)         #second argument(int)
      
        sw      x0,-24(s0)       #result 0-32 bit
        sw      x0,-20(s0)       #32-64
        sw      x0,-16(s0)       #64-96 bit
        sw      x0,-12(s0)       #result 96-128 bit
        sw      zero,-8(s0)     #i
.for_multiply(long long, int):
        lw      a5,-8(s0)       #i
        addi    a6,x0,63
        blt     a6,a5,.exit_multiply(long long, int)  #i>63, jump out of for loop

        lw      a6,-44(s0)
        andi    a6,a6,1                #if (A[i] &1)  ==0 means 0-th bit of A[i]=0
                                       # if A[i] &1)!=0   means 0-th bit of A[i]=1
        beq     a6,x0,.outOfIf_multiply(long long, int)
        lw      a4,-24(s0)             #load result
        lw      a5,-20(s0)             #32-64
        lw      a6,-16(s0)             #64-96
lw      a7,-12(s0)             #96-128  

        lw      a0,-40(s0)             #lower 32 bits
        lw      a1,-36(s0)             #higher 32bits
        lw      a2,-32(s0)             #product 64-96 bits
lw      a3,-28(s0)             #product 64-96 bits        
        
        add     t3,a4,a0               #a7= product 0-32bits +result 0-32 bits
sw      t3,-24(s0)#save 0-32 result        
        addi    t4,t3,0                #=product 0-32bits +result 0-32 bits
        sltu    t4,t4,a4               #overflowbit t4=(a6<a2)=(product 0-32bits +result 0-32 bits) < result 0-32bits ,then overflow
        

add     t5,a5,t4     #result 32-64 +overflow bit
sltu    t6,t5,a5  #overflow bit1
        add     t3,t5,a1               #result 32-64 bits +overflowbit+ product 32-64 bits
 sw      t3,-20(s0)   #save 32-64 result 
sltu    t4,t3,t5  #overflow bit2
add t4,t4,t6 #overflow bit1+over flow bit 2#存疑，是add还是or
    

add     t5,a6,t4     #result 65-96 +overflow bit
sltu    t6,t5,a6  #overflow bit1
        add     t3,t5,a2               #result 65-96 bits +overflowbit+ product 65-96 bits
 sw      t3,-16(s0)   #save 65-96 result 

sltu    t4,t3,t5  #overflow bit2
add t4,t4,t6 #overflow bit1+over flow bit 2#存疑，是add还是or  



add     t5,a7,t4     #result 97-128 +overflow bit
sltu    t6,t5,a7  #overflow bit1
        add     t3,t5,a3               #result 97-128 bits +overflowbit+ product 96-128 bits
 sw      t3,-12(s0)   #save 97-128 result 
sltu    t4,t3,t5  #overflow bit2
add t4,t4,t6 #overflow bit1+over flow bit 2#存疑，是add还是or  


        #add     t5,t4,t3               # add the over flow bit to result(32-64 bits),
   
        #sltu    t4,t5,t4               #a6=(result+overflow bit< result),if true ,overflow to 64-96 bits
        
        #add     t3,a6,a2               #result 64-96bits + product 64-96 bits
        
        #add     t5,t4,t3               # add the over flow bit to 64-96 bits,     
              
        
        
        #sw      a5,-16(s0)

.outOfIf_multiply(long long, int):
        lw      a5,-32(s0) #product 65-96
        srli    a5,a5,31   # product >>31bits,now only have  96-th bit
        lw      a4,-28(s0) #product 97-128 bits
        slli    a4,a4,1   #a4= (product 97-128 bits <<1)
        or      a5,a4,a5  #a5=a4 | a5  (then , 96-th bit will add to 97-128)
        sw      a5,-28(s0) #save to (97-128)bits (s0-36)


        lw      a5,-36(s0) #product 32-64
        srli    a5,a5,31   # product >>31bits,now only have  64-th bit
        lw      a4,-32(s0) #product 64-96 bits
        slli    a4,a4,1   #a4= (product 64-96 bits <<1)
        or      a5,a4,a5  #a5=a4 | a5  (then , 64-th bit will add to 64-96)
        sw      a5,-32(s0) #save to (64-96)bits (s0-36)

        lw      a5,-40(s0) #product lower 32bits
        srli    a5,a5,31   # product >>31bits,now only have  32-th bit
        lw      a4,-36(s0) #product 32-64 bits
        slli    a4,a4,1   #a4=32-64 bits<<1 (product 32-64 bits <<1)
        or      a5,a4,a5  #a5=a4 | a5  (then , over flow of 0-32 bits will add to 32-64 bits)
        sw      a5,-36(s0) #save to (32-64)bits (s0-36)
         
        lw      a5,-40(s0) # 0-32 bits
        slli    a5,a5,1    #product(0-32bits)<<1
        sw      a5,-40(s0) # save to product(0-32bits)
     #the above do (96 bits) product<<1   

        lw      a5,-44(s0)  #(second argument)
        srai    a5,a5,1    #second aargument >>1
        sw      a5,-44(s0) #save to second argument
      #the above do second argument >>1  
        lw      a5,-8(s0) #load i
        addi    a5,a5,1    #i+=1
        sw      a5,-8(s0)  #save i
        j       .for_multiply(long long, int)

.exit_multiply(long long, int):
        lw      a4,-24(s0)
        lw      a5,-20(s0)
        lw      a6,-16(s0)
        lw      a7,-12(s0)

        addi    a0,a4,0
        addi    a1,a5,0
        addi    a2,a6,0
        addi    a3,a7,0

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



isPositive(int):
        addi    sp,sp,-32
        sw      s0,28(sp)
        addi    s0,sp,32
        sw      a0,-20(s0)                  #store A[i] into s0-20
        lw      a5,-20(s0)                  #a5=A[i]
        bge     x0,a5,.not_isPositive       #if (A[i]<=0) goto .not_isPositive 
        addi    a5,x0,1                     #a5=return value=1
        j       .exit_isPositive
.not_isPositive:
        addi    a5,x0,0                     #a5=return value=0
.exit_isPositive:
        addi    a0,a5,0                     #a0=a5=return value=0

        lw      s0,28(sp)
        addi    sp,sp,32
        jr      ra


isNegative(int):
        addi    sp,sp,-32
        sw      s0,28(sp)
        addi    s0,sp,32
        sw      a0,-20(s0)                  #store A[i] into s0-20
        lw      a5,-20(s0)                  #a5=A[i]
        bge     a5,zero,.not_isNegative     #if (A[i]>=0) goto .not_isNegative
        addi    a5,x0,1                     #a5=return value=1
        j       .exit_isNegative
.not_isNegative:
        addi    a5,x0,0                     #a5=return value=0
.exit_isNegative:
        addi    a0,a5,0                     #a0=a5=return value=0
        lw      s0,28(sp)
        addi    sp,sp,32
        jr      ra


isSmall(int):
        addi    sp,sp,-32
        sw      s0,28(sp)
        addi    s0,sp,32
        sw      a0,-20(s0)
        lw      a4,-20(s0)                 #a4=A[i]
        addi    a5,x0,-10                  #a5=-10
        blt     a4,a5,.not_isSmall         #if (A[i]<-10) goto .not_isSmall
        lw      a4,-20(s0)
        addi    a5,x0,10                   #a5=10
        blt     a5,a4,.not_isSmall         #if (A[i]>10) goto .not_isSmall
        addi    a5,x0,1                    #if (A[i]<=10 && A[i]>=-10)a5=return result=1
        j       .exit_isSmall
.not_isSmall:
        addi    a5,x0,0                    #if (A[i]>10 || A[i]<-10) a5=return result=0
.exit_isSmall:
        addi    a0,a5,0
        lw      s0,28(sp)
        addi    sp,sp,32
        jr      ra


countArray(int*, int, int):
        addi    sp,sp,-48                           #sp=sp-48
        sw      ra,44(sp)                           #save x1=return address into sp+44
        sw      s0,40(sp)                           #save s0 into sp+40
        addi    s0,sp,48                            #s0=sp+48
        sw      a0,-36(s0)                          #a0=&A[0] saved in s0-36
        sw      a1,-40(s0)                          #a1=arraySize saved in s0-40
        sw      a2,-44(s0)                          #a2=cntType saved in s0-44
        sw      zero,-24(s0)                        #cnt=0 saved in s0-24
        lw      a5,-40(s0)                          #a5=arraySize
        addi    a5,a5,-1                            #a5=arraySize-1
        sw      a5,-20(s0)                          #save a5=i=arraySize-1 into s0-20
.for_countArray:
        lw      a5,-20(s0)
        blt     a5,zero,.exit_for_countArray        #if i<0 ,goto exit_for_countArray
        lw      a4,-44(s0)                          #a4=cntType
        addi    a5,x0,-1                            #a5=-1
        beq     a4,a5,.branch_-1                    #if(cntType==-1),goto function branch_-1
        lw      a4,-44(s0)                          #a4=cntType
        addi    a5,x0,1                             #a5=1
        bne     a4,a5,.branch_default               #if (cntType==1),goto branch_default 
        lw      a5,-20(s0)                          #load a5=i
        slli    a5,a5,2                             #a5=i<<2=i*4
        lw      a4,-36(s0)                          #a4=&A[0]
        add     a5,a4,a5                            #a5=&A[0]+i*4
        lw      a5,0(a5)                            #load a5=A[i]
        addi    a0,a5,0                             #a0=a5=A[i] as function argument
        jal     isPositive(int)                     #if (cntType==1)call function isPositive(int)    
        addi    a4,a0,0                             #a4=return value=isPositive(A[i])
        lw      a5,-24(s0)                          #a5=cnt
        add     a5,a5,a4                            #a5=a5+isPositive(A[i])
        sw      a5,-24(s0)                          #cnt saved into s0-24
        j       .exit_branch                        #goto exit_branch
.branch_-1:
        lw      a5,-20(s0)                          #load a5=i
        slli   a5,a5,2                              #a5=i<<2=i*4
        lw      a4,-36(s0)                          #a4=&A[0]
        add     a5,a4,a5                            #a5=&A[0]+i*4
        lw      a5,0(a5)                            #load a5=A[i]
        addi    a0,a5,0                             #a0=a5=A[i] as function argument
        jal     isNegative(int)                   
        addi    a4,a0,0                             #a4=a0=return result=isNegative(A[i])
        lw      a5,-24(s0)                          #a5=cnt loaded from s0-24
        add     a5,a5,a4                            #a5=a5+a4=cnt+isNegative(A[i])
        sw      a5,-24(s0)                          #save cnt into s0-24
        j       .exit_branch
.branch_default:
        lw      a5,-20(s0)                          #load a5=i
        slli   a5,a5,2                              #a5=i<<2=i*4
        lw      a4,-36(s0)                          #a4=&A[0]
        add     a5,a4,a5                            #a5=&A[0]+i*4
        lw      a5,0(a5)                            #load a5=A[i]
        addi    a0,a5,0                             #a0=a5=A[i] as function argument
        jal     isSmall(int)
        addi    a4,a0,0                             #a4=a0=return result=isSmall(A[i])
        lw      a5,-24(s0)                          #a5=cnt loaded from s0-24
        add     a5,a5,a4                            #a5=a5+a4=cnt+isNegative(A[i])
        sw      a5,-24(s0)                          #save cnt into s0-24
        nop
.exit_branch:
        lw      a5,-20(s0)                          #a5=i load from s0-20
        addi    a5,a5,-1                            #i-=1
        sw      a5,-20(s0)                          #save a5=i into s0-20
        j       .for_countArray                     #jump to start of loop .for_countArray

.exit_for_countArray:
        lw      a5,-24(s0)                          #a5=cnt loaded from s0-24
        addi    a0,a5,0                             #a0=a5=cnt=return result
        lw      ra,44(sp)                           #x1=return address loaded from sp+44
        lw      s0,40(sp)                           #s0=s0 loaded from sp+40
        addi    sp,sp,48                            #sp=sp+48
        jr      ra


calculateAverage(int*, int, int):
        addi    sp,sp,-48                     #sp=sp-48
        sw      ra,44(sp)                     #save x1=return address into sp+44
        sw      s0,40(sp)                     #save s0 into sp+40
        addi    s0,sp,48                      #s0=sp+48
        sw      a0,-36(s0)                    #a0=&A[0] saved in s0-36
        sw      a1,-40(s0)                    #a1=arraySize saved in s0-40
        sw      a2,-44(s0)                    #a2=position saved in s0-44
        
        lw      a5,-40(s0)                    #a5=arraySize
        addi    a5,a5,-1                      #a5=arraySize-1
        lw      a4,-44(s0)                    #a4=position

        bne     a4,a5,.else_calculateAverage  #if position !=arraySize-1 , goto .else_calculateAverage
        lw      a5,-44(s0)                    #if position ==arraySize-1
        slli    a5,a5,2                       #position=position<<2=position*4
        lw      a4,-36(s0)                    #a4=&A[0]
        add     a5,a4,a5                      #a5=a4+a5=&A[]+position
        nop
        nop 
        lw      a5,0(a5)                      #a5=*(A+position)
        nop
        nop
        j       .exit_calculateAverage        #goto .exit_calculateAverage

.else_calculateAverage:
        lw      a5,-44(s0)                    #a5=position
        addi    a5,a5,1                       #a5=position+1
      
        addi    a2,a5,0                       #a2=a5=position+1
        lw      a1,-40(s0)                    #a1=arraySize
        lw      a0,-36(s0)                    #a0=&A[0]
        jal     calculateAverage(int*, int, int) #jal  calculateAverage(int*, int, int)
        addi    a3,a0,0                       #a3 =return value of calculateAverage(,,)

        lw      a4,-40(s0)                    #a4=arraySize loaded from s0-40
        lw      a5,-44(s0)                    #a5=position
        sub     a5,a4,a5                      #a5=arraySize-position
        addi    a5,a5,-1                      #a5=a5-1=arraySize-position-1
        
        addi    a1,a5,0                       #a1=a5=arraySize-position-1
                                              #=multiply(,) second function argument      
        addi    a0,a3,0                       #a0=a3=return value of calculateAverage(,,),multiply(,) first function argument
        jal     multiply(int, int)            #call function multiply(int, int)
        addi    a3,a0,0                       #a3=return value=multiply(, )
        lw      a5,-44(s0)                    #a5=position
        slli    a5,a5,2                       #a5=position<<2=4*position
        lw      a4,-36(s0)                    #a4=&A[0]
        add     a5,a4,a5                      #a5=&A[0]+position*4
        lw      a5,0(a5)                      #load a5=A[position]
        add     a5,a3,a5                      #a5=sum=A[position]+ multiply(,)
        sw      a5,-20(s0)                    #save a5=sum
        lw      a4,-40(s0)                    #load a4=arraySize
        lw      a5,-44(s0)                    #load a5=position
        sub     a5,a4,a5                      #a5=a4-a5=arraySize-position
        addi    a1,a5,0                       #a1=a5=arraySize-position(second function argument)
        lw      a0,-20(s0)                    #load a0=sum (first function argument)
        jal    divide(int, int)               #call divide(sum,arraySize-position)
        addi    a5,a0,0
        nop
        
        #mul     a4,a3,a5                      #a4=a3*a5=calculateAverage(A,arraySize,position+1)*(arraySize-position-1)
        #lw      a5,-44(s0)                    #a5=position, loaded from s0-44 
        #slli   a5,a5,2                        #a5=a5<<2=position*4
        #lw      a3,-36(s0)                    #a3=&A[0] , loaded from s0-36
        #add     a5,a3,a5                      #a5=&A[position]
        #lw      a5,0(a5)                      #a5=A[position] loaded from a5
        #add     a5,a4,a5                      #a5=a4+a5=a4+A[position]=calculateAverage(A,arraySize,position+1)*(arraySize-position-1)+A[position]=sum
        #sw      a5,-20(s0)                    #store a5 into s0-20
        #lw      a4,-40(s0)                    #a4=arraySize loaded from s0-40
        #lw      a5,-44(s0)                    #a5=position loaded form s0-44
        #sub     a5,a4,a5                      #a5=a4-a5=arraySize-position
        #lw      a4,-20(s0)                    #a4=sum=calculateAverage(A,arraySize,position+1)*(arraySize-position-1)+A[position] loaded from s0-20
        #div     a5,a4,a5                      #a5=a4/a5=sum/(arraySize-position)

.exit_calculateAverage:
        addi    a0,a5,0                       #a0=a5  is return result  

        lw      ra,44(sp)
        lw      s0,40(sp)
        addi    sp,sp,48                      #sp=sp+48
        jr      ra


calculateProduct(int*, int):      #return value in a0(0-31),a1(32-63),a2(64-95)
        addi    sp,sp,-48
        sw      ra,44(sp)          #save return address
        sw      s0,40(sp)          #save s0 (below return addres)
        addi    s0,sp,48           #s0=sp+48=sp at the beginning of calculateProduct
        sw      a0,-36(s0)         #&A[0] saved in s0-36
        sw      a1,-40(s0)         #arraySize saved in s0-40
        addi    a4,x0,1            #a4=1    
        addi    a5,x0,0            #a5=0  
        addi    a6,x0,0       
addi    a7,x0,0 
        
        sw      a4,-24(s0)         #product=1 is stored in s0-24(lower 32 bits of product)
        sw      a5,-20(s0)         #0 is stored in s0-20(higher 32 bits of product)
        
        sw      a6,-16(s0)         #64-96bits
sw      a7,-12(s0)   #96-128 bits
        sw      zero,-28(s0)       #i=0 is stored in s0-28
.for_calculateProduct:
        lw      a4,-28(s0)         #a4=i=0
        lw      a5,-40(s0)         #a5=arraySize
        bge     a4,a5,.exit_for_calculateProduct          #if i>=arraySize,goto .exit_for_calculateProduct
        lw      a5,-28(s0)         #a5=i
        slli    a5,a5,2            #a5=a5<<2=i*4
        lw      a4,-36(s0)         #a0=&A[0]
        add     a5,a4,a5           #a5=a4+a5=&A[i]
        lw      a5,0(a5)           #a5=A[i] loaded from a1
        
        addi    a4,a5,0            #a4=A[i] (second functinon argument)
        
        lw      a0,-24(s0)         #a0=product(lower 32 bits)
        lw      a1,-20(s0)         #a1=product(higher 32 bits)
        lw      a2,-16(s0)         #a2=product(64-96 bits)
 lw      a3,-12(s0)       
        jal     multiply(long long, int) #call multiply function
        sw      a0,-24(s0)         #return value is product,lower 32 bits saved in s0-24
        sw      a1,-20(s0)         #return value is product,higher 32 bits saved in s0-24
        
        sw      a2,-16(s0)          #64-96 bits
sw      a3,-12(s0)          #64-96 bits        
        #srai    a1,a1,31           #a1=A[i]>>31=A[i]/(2^31)
        #addi    a3,a1,0            #a3=a1=A[i]>>31=A[i]/(2^31)
        #lw      a1,-20(s0)         #a1=0
        #mul     a0,a1,a2           #a0=a1*a2=A[i]>>31 * A[i]
        #lw      a5,-24(s0)         #a1=product lower 32 bits
        #mul     a1,a1,a3           #a1=a1*a3=product * A[i]/(2^31)
        #add     a0,a0,a1           #a0=a0+a1=A[i]>>31 * A[i] + product * A[i]>>31
        #lw      a1,-24(s0)         #a1=product
		 #mul     a6,a1,a2           #a6=a1*a2= product* A[i]
        #mulhu   a5,a1,a2           #a5=a1*a2(high, unsigned)=product* A[i](high, unsigned)
        #addi    a4,a6,0            #a4=a6=product* A[i]
        #add     a1,a0,a5           #a1=a0+a5=A[i]>>31 * A[i] + product * A[i]>>31 + product* A[i](high, unsigned)
        #addi    a5,a1,0            #a5=a1=A[i]>>31 * A[i] + product * A[i]>>31 + product* A[i](high, unsigned)
        
		 #sw      a4,-24(s0)         #a4 saved into s0-24
        #sw      a5,-20(s0)         #a5 saved into s0-20

        lw      a5,-28(s0)         #a1=i loaded from s0-28
        addi    a5,a5,1            #a1=a1+1=i+1
        sw      a5,-28(s0)         # i saved into s0-28
        j       .for_calculateProduct  #goto start of loop, .for_calculateProduct

.exit_for_calculateProduct:
        lw      a4,-24(s0)         #load a4=product* A[i] from s0-24
        lw      a5,-20(s0)         #load a5=A[i]>>31 * A[i] + product * A[i]>>31 + product* A[i](high, unsigned) from s0-20
        lw      a6,-16(s0)         #load back a6
lw      a7,-12(s0)         #load back a6
        addi    a0,a4,0            #a0=a4=product* A[i]
        addi    a1,a5,0            #a1=a5=A[i]>>31 * A[i] + product * A[i]>>31 + product* A[i](high, unsigned)
        addi    a2,a6,0
 addi    a3,a7,0
        lw      ra,44(sp)          #load the return address(in main function calculateProduct function instruction)
        lw      s0,40(sp)          #load s0=*(sp+44)= s0( before this function calculateProduct)
        addi    sp,sp,48           #sp=sp+48   
        jr      ra


exit:                  
        nop                                #exit of main
        nop

