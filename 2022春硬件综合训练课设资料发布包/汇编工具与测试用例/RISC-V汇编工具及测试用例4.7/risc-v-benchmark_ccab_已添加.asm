#############################################################
#测试jal,jalr指令，
#############################################################
.text
 addi s1,zero, 1   #测试jal,jalrr指令
 j jmp_next1       #jal x0,8
 addi s1,zero, 1
 addi s2,zero, 2
 addi s3,zero, 3
jmp_next1:
 j jmp_next2
 addi s1,zero, 1
 addi s2,zero, 2
 addi s3,zero, 3
jmp_next2:
 j jmp_next3
 addi s1,zero, 1
 addi s2,zero, 2
 addi s3,zero, 3
jmp_next3:
 j jmp_next4
 addi s1,zero, 1
 addi s2,zero, 2
 addi s3,zero, 3
jmp_next4:jal jmp_count

#移位测试  需要支持超addi,sll,add,ecall,srl,sll,sra,beq,j,ecall    revise date:2015/12/16 tiger

.text
addi s0,zero,1     #简单移位，循环测试，0号区域显示的是初始值1左移1位重复15次的值，1号区域是累加值
addi s1,zero,1  
slli s1, s1, 31   #逻辑左移31位 s1=0x80000000
 

###################################################################
#                逻辑左移测试 
# 显示区域依次显示0x80000000 0x20000000 0x08000000 0x02000000 0x00800000 0x00200000 0x00080000 0x00020000 0x00008000 0x00002000 0x00000800 0x00000200 0x00000080 0x00000020 0x00000008 0x00000002 0x00000000  
###################################################################
LogicalRightShift:            #逻辑右移测试，将最高位1逐位向右右移直至结果为零

add    a0,zero,s1       #display s1
addi   a7,zero,34        # display hex
ecall                 # we are out of here.  
     
srli s1, s1, 2   
beq s1, zero, shift_next1
j LogicalRightShift

shift_next1:

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  


###################################################################
#                逻辑右移测试 
# 显示区域依次显示0x00000004 0x00000010 0x00000040 0x00000100 0x00000400 0x00001000 0x00004000 0x00010000 0x00040000 0x00100000 0x00400000 0x01000000 0x04000000 0x10000000 0x40000000 0x00000000 
###################################################################

addi s1,zero, 1   
LogicalLeftShift:         #逻辑左移测试，将最低位1逐位向左移直至结果为零
slli s1, s1, 2  

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  
      
beq s1, zero, ArithRightShift
j LogicalLeftShift


###################################################################
#                算术右移测试 
# 显示区域依次显示0x80000000 0xf0000000 0xff000000 0xfff00000 0xffff0000 0xfffff000 0xffffff00 0xfffffff0 0xffffffff 
###################################################################
ArithRightShift:          #算术右移测试，#算术移位测试，80000000算术右移，依次显示为F0000000,FF000000,FFF00000,FFFF0000直至FFFFFFFF

addi s1,zero,1  
slli s1, s1, 31   #逻辑左移31位 s1=0x80000000

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  

srai s1, s1, 3    #s1=0X80000000-->0XF0000000

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  


srai s1, s1, 4    #0XF0000000-->0XFF000000

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  


srai s1, s1, 4    #0XFF000000-->0XFFF00000

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  

srai s1, s1, 4    

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  

srai s1, s1, 4    

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  


srai s1, s1, 4    

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  


srai s1, s1, 4    

add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.  


srai s1, s1, 4    


add    a0,zero,s1       #display s1
addi   a7,zero,34         # display hex
ecall                 # we are out of here.    

#############################################################
#走马灯测试,测试addi,andi,sll,srl,sra,or,ori,nor,ecall  LED按走马灯方式来回显示数据
#############################################################

.text
addi s0,zero,1 
slli s3, s0, 31      # s3=0x80000000
srai s3, s3, 31      # s3=0xFFFFFFFF   
add s0,zero,zero   # s0=0         
addi s2,zero,12 

addi s6,zero,3  #走马灯计数
zmd_loop:

addi s0, s0, 1    #计算下一个走马灯的数据
andi s0, s0, 15  

#######################################
addi t0,zero,8    
addi t1,zero,1
left:

slli s3, s3, 4   #走马灯左移
or s3, s3, s0

add    a0,zero,s3       # display s3
addi   a7,zero,34         # system call for LED display 
ecall                 # display 

sub t0,t0,t1
bne t0,zero,left
#######################################

addi s0, s0, 1   #计算下一个走马灯的数据
addi t6,zero,15
and s0, s0, t6
slli s0, s0, 28     

addi t0,zero,8
addi t1,zero,1

zmd_right:

srli s3, s3, 4  #走马灯右移
or s3, s3, s0

add    a0,zero,s3       # display s3
addi   a7,zero,34         # system call for LED display 
ecall                 # display 

sub t0,t0,t1
bne t0,zero,zmd_right
srli s0, s0, 28  
#######################################

sub s6,s6,t1
beq s6,zero, exit
j zmd_loop

exit:

add t0,zero,zero
xori t0,t0,-1      #test r  xori
slli t0,t0,8
ori t0,t0,255

add   a0,zero,t0       # display t0
addi   a7,zero,34         # system call for LED display 
ecall                 # display 

#################################################################################
#本程序实现0-15号字单元的降序排序,此程序可在rars 仿真器中运行
#运行时请将rars Setting中的Memory Configuration设置为Compact，data at address 0
#################################################################################
 .text
sort_init:
 addi s0,zero,-1
 addi s1,zero,0
 
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
  sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
  sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
 sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
  sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
  sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
  sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
  sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
    sw s0,0(s1)
 addi s0,s0,1
 addi s1,s1,4
   
 addi s0,s0,1
 
 add s0,zero,zero   
 addi s1,zero,60   #排序区间
sort_loop:
 lw s3,0(s0)     
 lw s4,0(s1)
 slt t0,s3,s4
 beq t0,zero,sort_next   #降序排序
 sw s3, 0(s1)
 sw s4, 0(s0)   
sort_next:
 addi s1, s1, -4   
 bne s0, s1, sort_loop  
 
 add    a0,zero,s0       #display s0
 addi   a7,zero,34         # display hex
 ecall                 # we are out of here.  DISP: disp r0, 0
 
 addi s0,s0,4
 addi s1,zero,60
 bne s0, s1, sort_loop


 addi   a7,zero,10         # system call for pause
 ecall                  # we are out of here.   
 
 
#############################################
# insert your ccmb benchmark program here!!!
#############################################

#j benchmark_start       #delete this instruction for ccmb bencmark
#C1 instruction benchmark
#SRLV移位测试    revise date:2021/1/24 tiger
#依次输出  0x87600000 0x08760000 0x00876000 0x00087600 0x00008760 0x00000876 0x00000087 0x00000008 0x00000000
.text

addi t0,zero,1     #sllv 移位次数
addi t1,zero,3     #sllv 移位次数
addi s1,zero,  0x8
slli s1,s1,8
addi s1,s1,0x76     

slli s1,s1,20     #

add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print

addi t3,zero,8

srl_branch:
srl s1,s1,t0     #先移1位
srl s1,s1,t1     #再移3位
add a0,zero,s1          
addi a7,zero,34         # system call for print
ecall                  # print
addi t3,t3, -1    
bne t3,zero,srl_branch   #循环8次

addi   a7,zero,10         # system call for exit
ecall                  # we are out of here.   


#C2 instruction benchmark
#AUIPC测试    revise date:2021/1/24 tiger
#依次输出 0x00430004 0x00430014 0x00430024 0x00430034 0x00430044 0x00430054 0x00430064 0x00430074

.text
nop
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
auipc s1,0x430
add a0,zero,s1           
addi a7,zero,34         # system call for print
ecall                  # print
addi   a7,zero,10         # system call for exit
ecall                  # we are out of here.   




#Mem instruction benchmark

#LHU 测试   revise date:2021/1/24 tiger
#依次输出  0x00008281 0x00008483 0x00008685 0x00008887 0x00008a89 0x00008c8b 0x00008e8d 0x0000908f 0x00009291 0x00009493 0x00009695 0x00009897 0x00009a99 0x00009c9b 0x00009e9d 0x0000a09f 0x0000a2a1 0x0000a4a3 0x0000a6a5 0x0000a8a7 0x0000aaa9 0x0000acab 0x0000aead 0x0000b0af 0x0000b2b1 0x0000b4b3 0x0000b6b5 0x0000b8b7 0x0000bab9 0x0000bcbb 0x0000bebd 0x0000c0bf
.text

addi t1,zero,0     #init_addr 
addi t3,zero,16     #counter

#预先写入数据，实际是按字节顺序存入 0x81,82,84,86,87,88,89.......等差数列

addi s1,zero,  0x84
slli s1,s1,8
addi s1,s1,0x83 
addi s2,zero,  0x04
slli s2,s2,8
addi s2,s2,0x04
slli s1,s1,8
addi s1,s1,0x82 
slli s1,s1,8
addi s1,s1,0x81
slli s2,s2,8
addi s2,s2,0x04
slli s2,s2,8
addi s2,s2,0x04    #    init_data= 0x84838281 next_data=init_data+ 0x04040404

lhu_store:
sw s1,(t1)
add s1,s1,s2   #data +1
addi t1,t1,4    # addr +4  
addi t3,t3,-1   #counter
bne t3,zero,lhu_store

addi t3,zero,32   #循环次数
addi t1,zero,0    # addr
lhu_branch:
lhu s1,(t1)     #测试指令
add a0,zero,s1          
addi a7,zero,34         
ecall                  # print
addi t1,t1, 2    
addi t3,t3, -1    
bne t3,zero,lhu_branch

addi   a7,zero,10         # system call for exit
ecall                  # we are out of here.   




#Branch instruction benchmark

#bgeu 测试    大于跳转  递减运算 ，从正数开始向零运算  revise date:2022/2/24 tiger
#依次输出0x0000000f 0x0000000e 0x0000000d 0x0000000c 0x0000000b 0x0000000a 0x00000009 0x00000008 0x00000007 0x00000006 0x00000005 0x00000004 0x00000003 0x00000002 0x00000001 
.text


addi s1,zero,15  
addi s2,zero,1

bgeu_branch:
sub s3,s2,s1
add a0,zero,s1        
addi a7,zero,34         
ecall                  # 输出当前值
addi s1,s1,-1  
bgeu s3,s2,bgeu_branch    #当前测试指令


addi   a7,zero,10         
ecall                  # 程序暂停或退出




                 
 addi   a7,zero,10         # system call for exit
 ecall                  # we are out of here.   
 
 #处理器实现中请用停机指令实现ecall

jmp_count: addi s0,zero, 0
       addi s0,s0, 1
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       ecall                 # we are out of here.  
       
       addi s0,s0, 2
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       ecall                 # we are out of here.  
       
       addi s0,s0, 3
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       ecall                 # we are out of here.  
       
       addi s0,s0, 4       
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       ecall                 # we are out of here.  
       
       addi s0,s0, 5              
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       ecall                 # we are out of here.  

       addi s0,s0, 6              
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       ecall                 # we are out of here.  

       addi s0,s0, 7              
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       ecall                 # we are out of here.  

       addi s0,s0, 8              
       add    a0,zero,s0      
       addi   a7,zero,34         # display hex
       addi   a7,zero,34         # display hex       
       ecall                 # we are out of here.  
       
       ret  #persudo instruction  jalr x0,x1,0
