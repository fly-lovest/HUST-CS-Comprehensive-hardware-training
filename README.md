# HUST-CS-Comprehensive-hardware-training
本仓库包含HUST-CS-2019 硬件综合训练-组原课设-riscv实现的logisim电路，含logisim实现的团队项目——井字棋游戏。

- 所有过程版本的电路.circ文件
  - CCAB：SRL、AUIPC、LHU、BGEU
  - 指令集：RISCV32
  - EX段分支
- 2022春硬件综合训练课设资料发布包
  - RISCV指令集手册
  - 汇编工具与测试用例（已添加CCAB）
  - 实验任务书
- 团队项目——井字棋
  - 项目电路.circ文件
  - 井字棋.asm文件和.hex文件
  - 寄存器使用规范
  - 使用logisim实现
- 其他文件
  - 可能会遇到的bug（已删除，由于每个人有不同的bug，希望你能自己发现并解决）

❤❤❤读到这里，若你还未开始实验或正在实验途中，请允许我为你梳理一下实验流程。❤❤❤

推荐过程： **单周期（无CCAB）→ 单周期（之后都带CCAB） → 理想流水线 → 气泡流水线 → 重定向流水线 → 动态分支预测 → 单级中断、流水线中断 → 多级中断**。在单周期实现中，你可能会遇到许许多多的问题，don‘t worry，经过这段痛苦的时期，后续过程将会十分轻松，请你务必弄清单周期每个部件所参与的过程。

一条指令基本执行流程：**取指 → 译码 → 执行 → 访存（maybe） → 写回（maybe）**，并且流水线的设计也基本按照这个过程进行，中途会对某些特殊指令进行特殊处理，你将会知道。

*后续内容，请你做到对应内容后阅读~*

那么你是否想过，为什么做出来了单周期CPU后还要做后续的流水线？这个你一定知道，变快了嘛~ 再提问一句，为啥把他们分段就变快了，对于1条指令的执行仍然要经历这么多时间啊？聪明的你一定会反驳多条指令可以在流水线里流通，相比于单周期，单位时间内指令执行的更多了。其实确实可以这样理解，但我们可以用一句话概括：**关键路径时延减小，从而使得该电路允许高频的时钟周期**。什么是关键路径？什么是时钟周期？什么是CPU主频？这就需要你阅读《大萝卜组原书》+STFW了，且十分重要。

为何要在理想流水线的基础上实现气泡流水线？你知道为何叫  **理想**  流水线嘛，理想就是只允许极极极少的冲突，如结构冲突和ID/WB段数据冲突。那么必然，我们势必要处理更多的冲突。故气泡流水线处理的是什么冲突？思考一下........................Yes，是分支冲突（使用EX段分支）和存在的数据冲突ID\EX、ID\MEM和ID\WB。如何处理就需要你进行探索啦~当然，带着问题探索是个好习惯。

为何又要做重定向流水线？重定向流水线和气泡流水线有啥关系？我们先说明第1个问题，重定向流水线同样是为了解决理想流水线的分支冲突和存在的数据冲突的。嗯？岂不是跟气泡流水线做的一样的工作，那么他们有啥区别啊，即第2个问题。你在实验过程中会发现他们处理ID\EX、ID\MEM的数据冲突时不太一样，但在处理一些指令时又有些相同但又不太一致（Load-Use），谁更好呢！？带着问题继续干！加油~

在重定向流水线实现后，我们来完成动态分支预测，其实可以把动态分支预测当成一个模块，他的功能是对跳转指令进行预测，预测可能对可能错，那么如果预测对怎么办？预测错怎么办？提示一下，其实就是把CPU的PC值进行修改，或者添加些气泡而已。怎么预测？难道随机预测？还是根据概率预测？那必然是根据概率，至于如何实现，可以参考电路或者读书《大萝卜组原书》+《计算机系统结构课程用书》或者STFW。

中断嘛~ 单级中断是很好实现啦，多级中断中，你需要注意如何设置中断屏蔽。不多说了，坚持就能拿100！！！



对于《RISC-V单周期硬布线控制器表达式自动生成》有些简要说明：

用于译码，区分指令：

![译码](https://raw.githubusercontent.com/fly-lovest/HUST-CS-Comprehensive-hardware-training/main/images/译码.png)

用于产生控制信号：

![控制信号](https://raw.githubusercontent.com/fly-lovest/HUST-CS-Comprehensive-hardware-training/main/images/控制信号.png)

控制信号解释：

![控制信号解释](https://raw.githubusercontent.com/fly-lovest/HUST-CS-Comprehensive-hardware-training/main/images/控制信号解释.png)



ALU相关控制信号：

![ALU控制信号](https://raw.githubusercontent.com/fly-lovest/HUST-CS-Comprehensive-hardware-training/main/images/ALU控制信号.png)



benchmark测试效果：

![benchmark测试效果动图](https://raw.githubusercontent.com/fly-lovest/HUST-CS-Comprehensive-hardware-training/main/images/benchmark测试效果动图.gif)

