.text
addi t6,zero,1   ##初始化关中断
addi a5,zero,2   ##横竖各画2条线
addi a6,zero,124 ##线从3到124号的像素
addi a7,zero,0   ##初始a7
addi a4,zero,0
addi ra,zero,0  ##绘制2条横线
Hengxian:
addi ra,ra,42
addi sp,zero,3
Heng_Dian:
addi sp,sp,1
ecall            ##画像素点
bne sp,a6,Heng_Dian
addi a4,a4,1
bne a4,a5, Hengxian

addi a4,zero,0
addi sp,zero,0  ##绘制2条竖线
Shuxian:
addi sp,sp,42
addi ra,zero,3
Shu_Dian:
addi ra,ra,1
ecall            ##画像素点
bne ra,a6,Shu_Dian
addi a4,a4,1
bne a4,a5, Shuxian

addi t0,zero,0 ##表示X下的格子
addi t1,zero,0 ##表示O下的格子
addi t2,zero,0 ##表示结束清空
addi a3,zero,0 ##0表示正在下，1表示X赢，2表示O赢，3表示平局
addi a1,zero,0 ##0表示X在下，1表示O在下
addi a2,zero,0 ##记录下棋次数
addi t6,zero,0 ##初始化结束开中断

JZQ_Loop:
addi a4,zero,1
beq a3,a4,X_Win
addi a4,zero,2
beq a3,a4,O_Win
addi a4,zero,3
beq a3,a4,PingJu
j JZQ_Loop


PingJu:          ##平局结果
addi t6,zero,1
addi t2,zero,1
addi ra,zero,40
addi sp,zero,40
addi a4,zero,86
Draw_P1:
ecall
addi ra,ra,1
bne ra,a4,Draw_P1
addi ra,zero,35
addi sp,zero,60
addi a4,zero,91
Draw_P2:
ecall
addi ra,ra,1
bne ra,a4,Draw_P2
addi ra,zero,45
addi sp,zero,45
addi a4,zero,15
Draw_P3:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_P3
addi ra,zero,81
addi sp,zero,45
addi a4,zero,15
Draw_P4:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_P4
addi ra,zero,63
addi sp,zero,40
addi a4,zero,95
Draw_P5:
ecall
addi sp,sp,1
bne sp,a4,Draw_P5

addi a7,zero,10
ecall

X_Win:            ##X_Win结果
addi t6,zero,1
addi t2,zero,1
addi s2,zero,63
addi s3,zero,63

##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X1x:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X1x

addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X2x:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X2x

addi a7,zero,10
ecall

O_Win:           ##O_Win结果
addi t6,zero,1
addi t2,zero,1

addi s2,zero,63
addi s3,zero,63

##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O1o:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O1o
addi a4,zero,9
Draw_O2o:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O2o
addi a4,zero,16
Draw_O3o:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O3o
addi a4,zero,9
Draw_O4o:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O4o
addi a4,zero,16
Draw_O5o:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O5o
addi a4,zero,9
Draw_O6o:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O6o
addi a4,zero,16
Draw_O7o:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O7o
addi a4,zero,9
Draw_O8o:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O8o

addi a7,zero,10
ecall


#####################
####按键1中断程序#####
#####################
Interupt1:  ##中断1入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump1  ##为O下时，跳到对应处理位置

addi s2,zero,21 ##设置Xx中心
addi s3,zero,21 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X11:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X11
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X21:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X21

ori t0,t0,0x1  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win1
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win1
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win1
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win1
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win1
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win1
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win1
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win1
addi a4,zero,9
beq a2,a4,PingJu1
addi a1,a1,1
j Interuptend1

O_jump1:
addi s2,zero,21 ##设置Ox中心
addi s3,zero,21 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O11:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O11
addi a4,zero,9
Draw_O21:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O21
addi a4,zero,16
Draw_O31:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O31
addi a4,zero,9
Draw_O41:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O41
addi a4,zero,16
Draw_O51:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O51
addi a4,zero,9
Draw_O61:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O61
addi a4,zero,16
Draw_O71:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O71
addi a4,zero,9
Draw_O81:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O81

ori t1,t1,0x1   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win1
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win1
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win1
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win1
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win1
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win1
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win1
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win1
addi a4,zero,9
beq a2,a4,PingJu1
addi a1,a1,-1
j Interuptend1
X_Win1:
addi a3,zero,1
uret
O_Win1:
addi a3,zero,2
uret
PingJu1:
addi a3,zero,3
uret
Interuptend1:
uret

#####################
####按键2中断程序#####
#####################
Interupt2:  ##中断2入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump2  ##为O下时，跳到对应处理位置

addi s2,zero,63 ##设置Xx中心
addi s3,zero,21 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X12:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X12
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X22:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X22

ori t0,t0,0x2    ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win2
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win2
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win2
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win2
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win2
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win2
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win2
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win2
addi a4,zero,9
beq a2,a4,PingJu2
addi a1,a1,1
j Interuptend2

O_jump2:
addi s2,zero,63 ##设置Ox中心
addi s3,zero,21 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O12:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O12
addi a4,zero,9
Draw_O22:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O22
addi a4,zero,16
Draw_O32:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O32
addi a4,zero,9
Draw_O42:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O42
addi a4,zero,16
Draw_O52:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O52
addi a4,zero,9
Draw_O62:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O62
addi a4,zero,16
Draw_O72:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O72
addi a4,zero,9
Draw_O82:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O82

ori t1,t1,0x2   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win2
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win2
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win2
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win2
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win2
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win2
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win2
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win2
addi a4,zero,9
beq a2,a4,PingJu2
addi a1,a1,-1
j Interuptend2
X_Win2:
addi a3,zero,1
uret
O_Win2:
addi a3,zero,2
uret
PingJu2:
addi a3,zero,3
uret
Interuptend2:
uret


#####################
####按键3中断程序#####
#####################
Interupt3:  ##中断3入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump3  ##为O下时，跳到对应处理位置

addi s2,zero,105 ##设置Xx中心
addi s3,zero,21 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X13:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X13
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X23:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X23

ori t0,t0,0x4  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win3
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win3
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win3
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win3
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win3
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win3
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win3
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win3
addi a4,zero,9
beq a2,a4,PingJu3
addi a1,a1,1
j Interuptend3

O_jump3:
addi s2,zero,105 ##设置Ox中心
addi s3,zero,21 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O13:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O13
addi a4,zero,9
Draw_O23:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O23
addi a4,zero,16
Draw_O33:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O33
addi a4,zero,9
Draw_O43:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O43
addi a4,zero,16
Draw_O53:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O53
addi a4,zero,9
Draw_O63:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O63
addi a4,zero,16
Draw_O73:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O73
addi a4,zero,9
Draw_O83:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O83

ori t1,t1,0x4   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win3
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win3
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win3
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win3
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win3
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win3
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win3
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win3
addi a4,zero,9
beq a2,a4,PingJu3
addi a1,a1,-1
j Interuptend3
X_Win3:
addi a3,zero,1
uret
O_Win3:
addi a3,zero,2
uret
PingJu3:
addi a3,zero,3
uret
Interuptend3:
uret


#####################
####按键4中断程序#####
#####################
Interupt4:  ##中断4入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump4  ##为O下时，跳到对应处理位置

addi s2,zero,21 ##设置Xx中心
addi s3,zero,63 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X14:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X14
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X24:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X24

ori t0,t0,0x8  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win4
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win4
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win4
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win4
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win4
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win4
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win4
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win4
addi a4,zero,9
beq a2,a4,PingJu4
addi a1,a1,1
j Interuptend4

O_jump4:
addi s2,zero,21 ##设置Ox中心
addi s3,zero,63 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O14:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O14
addi a4,zero,9
Draw_O24:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O24
addi a4,zero,16
Draw_O34:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O34
addi a4,zero,9
Draw_O44:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O44
addi a4,zero,16
Draw_O54:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O54
addi a4,zero,9
Draw_O64:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O64
addi a4,zero,16
Draw_O74:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O74
addi a4,zero,9
Draw_O84:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O84

ori t1,t1,0x8   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win4
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win4
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win4
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win4
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win4
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win4
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win4
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win4
addi a4,zero,9
beq a2,a4,PingJu4
addi a1,a1,-1
j Interuptend4
X_Win4:
addi a3,zero,1
uret
O_Win4:
addi a3,zero,2
uret
PingJu4:
addi a3,zero,3
uret
Interuptend4:
uret

#####################
####按键5中断程序#####
#####################
Interupt5:  ##中断5入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump5  ##为O下时，跳到对应处理位置

addi s2,zero,63 ##设置Xx中心
addi s3,zero,63 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X15:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X15
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X25:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X25

ori t0,t0,0x10  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win5
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win5
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win5
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win5
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win5
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win5
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win5
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win5
addi a4,zero,9
beq a2,a4,PingJu5
addi a1,a1,1
j Interuptend5

O_jump5:
addi s2,zero,63 ##设置Ox中心
addi s3,zero,63 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O15:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O15
addi a4,zero,9
Draw_O25:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O25
addi a4,zero,16
Draw_O35:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O35
addi a4,zero,9
Draw_O45:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O45
addi a4,zero,16
Draw_O55:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O55
addi a4,zero,9
Draw_O65:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O65
addi a4,zero,16
Draw_O75:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O75
addi a4,zero,9
Draw_O85:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O85

ori t1,t1,0x10   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win5
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win5
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win5
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win5
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win5
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win5
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win5
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win5
addi a4,zero,9
beq a2,a4,PingJu5
addi a1,a1,-1
j Interuptend5
X_Win5:
addi a3,zero,1
uret
O_Win5:
addi a3,zero,2
uret
PingJu5:
addi a3,zero,3
uret
Interuptend5:
uret

#####################
####按键6中断程序#####
#####################
Interupt6:  ##中断6入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump6  ##为O下时，跳到对应处理位置

addi s2,zero,105 ##设置Xx中心
addi s3,zero,63 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X16:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X16
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X26:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X26

ori t0,t0,0x20  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win6
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win6
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win6
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win6
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win6
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win6
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win6
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win6
addi a4,zero,9
beq a2,a4,PingJu6
addi a1,a1,1
j Interuptend6

O_jump6:
addi s2,zero,105 ##设置Ox中心
addi s3,zero,63 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O16:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O16
addi a4,zero,9
Draw_O26:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O26
addi a4,zero,16
Draw_O36:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O36
addi a4,zero,9
Draw_O46:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O46
addi a4,zero,16
Draw_O56:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O56
addi a4,zero,9
Draw_O66:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O66
addi a4,zero,16
Draw_O76:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O76
addi a4,zero,9
Draw_O86:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O86

ori t1,t1,0x20   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win6
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win6
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win6
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win6
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win6
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win6
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win6
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win6
addi a4,zero,9
beq a2,a4,PingJu6
addi a1,a1,-1
j Interuptend6
X_Win6:
addi a3,zero,1
uret
O_Win6:
addi a3,zero,2
uret
PingJu6:
addi a3,zero,3
uret
Interuptend6:
uret

#####################
####按键7中断程序#####
#####################
Interupt7:  ##中断7入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump7  ##为O下时，跳到对应处理位置

addi s2,zero,21 ##设置Xx中心
addi s3,zero,105 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X17:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X17
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X27:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X27

ori t0,t0,0x40  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win7
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win7
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win7
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win7
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win7
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win7
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win7
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win7
addi a4,zero,9
beq a2,a4,PingJu7
addi a1,a1,1
j Interuptend7

O_jump7:
addi s2,zero,21 ##设置Ox中心
addi s3,zero,105 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O17:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O17
addi a4,zero,9
Draw_O27:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O27
addi a4,zero,16
Draw_O37:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O37
addi a4,zero,9
Draw_O47:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O47
addi a4,zero,16
Draw_O57:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O57
addi a4,zero,9
Draw_O67:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O67
addi a4,zero,16
Draw_O77:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O77
addi a4,zero,9
Draw_O87:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O87

ori t1,t1,0x40   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win7
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win7
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win7
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win7
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win7
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win7
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win7
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win7
addi a4,zero,9
beq a2,a4,PingJu7
addi a1,a1,-1
j Interuptend7
X_Win7:
addi a3,zero,1
uret
O_Win7:
addi a3,zero,2
uret
PingJu7:
addi a3,zero,3
uret
Interuptend7:
uret

#####################
####按键8中断程序#####
#####################
Interupt8:  ##中断8入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump8  ##为O下时，跳到对应处理位置

addi s2,zero,63 ##设置Xx中心
addi s3,zero,105 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X18:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X18
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X28:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X28

ori t0,t0,0x80  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win8
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win8
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win8
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win8
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win8
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win8
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win8
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win8
addi a4,zero,9
beq a2,a4,PingJu8
addi a1,a1,1
j Interuptend8

O_jump8:
addi s2,zero,63 ##设置Ox中心
addi s3,zero,105 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O18:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O18
addi a4,zero,9
Draw_O28:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O28
addi a4,zero,16
Draw_O38:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O38
addi a4,zero,9
Draw_O48:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O48
addi a4,zero,16
Draw_O58:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O58
addi a4,zero,9
Draw_O68:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O68
addi a4,zero,16
Draw_O78:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O78
addi a4,zero,9
Draw_O88:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O88

ori t1,t1,0x80   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win8
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win8
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win8
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win8
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win8
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win8
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win8
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win8
addi a4,zero,9
beq a2,a4,PingJu8
addi a1,a1,-1
j Interuptend8
X_Win8:
addi a3,zero,1
uret
O_Win8:
addi a3,zero,2
uret
PingJu8:
addi a3,zero,3
uret
Interuptend8:
uret

#####################
####按键9中断程序#####
#####################
Interupt9:  ##中断9入口
addi a2,a2,1

addi a4,zero,1
beq a1,a4,O_jump9  ##为O下时，跳到对应处理位置

addi s2,zero,105 ##设置Xx中心
addi s3,zero,105 ##设置Xy中心
##画X
addi ra,s2,-17
addi sp,s3,-17
addi a4,zero,34
Draw_X19:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X19
addi ra,s2,17
addi sp,s3,-17
addi a4,zero,34
Draw_X29:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_X29

ori t0,t0,0x100  ##置t0
addi a5,t0,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,X_Win9
addi a5,t0,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,X_Win9
addi a5,t0,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,X_Win9
addi a5,t0,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,X_Win9
addi a5,t0,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,X_Win9
addi a5,t0,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,X_Win9
addi a5,t0,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,X_Win9
addi a5,t0,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,X_Win9
addi a4,zero,9
beq a2,a4,PingJu9
addi a1,a1,1
j Interuptend9

O_jump9:
addi s2,zero,105 ##设置Ox中心
addi s3,zero,105 ##设置Oy中心
##画O
addi ra,s2,-17
addi sp,s3,8
addi a4,zero,16
Draw_O19:
ecall
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O19
addi a4,zero,9
Draw_O29:
ecall
addi ra,ra,1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O29
addi a4,zero,16
Draw_O39:
ecall
addi ra,ra,1
addi a4,a4,-1
bne a4,zero,Draw_O39
addi a4,zero,9
Draw_O49:
ecall
addi ra,ra,1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O49
addi a4,zero,16
Draw_O59:
ecall
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O59
addi a4,zero,9
Draw_O69:
ecall
addi ra,ra,-1
addi sp,sp,1
addi a4,a4,-1
bne a4,zero,Draw_O69
addi a4,zero,16
Draw_O79:
ecall
addi ra,ra,-1
addi a4,a4,-1
bne a4,zero,Draw_O79
addi a4,zero,9
Draw_O89:
ecall
addi ra,ra,-1
addi sp,sp,-1
addi a4,a4,-1
bne a4,zero,Draw_O89

ori t1,t1,0x100   ##置t1
addi a5,t1,0
andi a5,a5,0x7
addi a4,zero,0x7 ##123
beq a5,a4,O_Win9
addi a5,t1,0
andi a5,a5,0x49
addi a4,zero,0x49 ##147
beq a5,a4,O_Win9
addi a5,t1,0
andi a5,a5,0x38
addi a4,zero,0x38 ##456
beq a5,a4,O_Win9
addi a5,t1,0
andi a5,a5,0x92
addi a4,zero,0x92  ##258
beq a5,a4,O_Win9
addi a5,t1,0
andi a5,a5,0x1c0
addi a4,zero,0x1c0 ##789
beq a5,a4,O_Win9
addi a5,t1,0
andi a5,a5,0x124
addi a4,zero,0x124  ##369
beq a5,a4,O_Win9
addi a5,t1,0
andi a5,a5,0x111
addi a4,zero,0x111  ##159
beq a5,a4,O_Win9
addi a5,t1,0
andi a5,a5,0x54
addi a4,zero,0x54 ##357
beq a5,a4,O_Win9
addi a4,zero,9
beq a2,a4,PingJu9
addi a1,a1,-1
j Interuptend9
X_Win9:
addi a3,zero,1
uret
O_Win9:
addi a3,zero,2
uret
PingJu9:
addi a3,zero,3
uret
Interuptend9:
uret

