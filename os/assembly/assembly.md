## 汇编

#### 机器语言

* CPU指令集
* 机器指令: 操作码 + 操作数，二进制编码

#### 汇编语言

汇编语言组成:

* 汇编指令: 机器指令的助记符，例如 mov
* 伪指令: 无对应的机器指令，编译器负责处理，例如 assume
* 其它符号: 无对应的机器指令，编译器负责处理，例如 +、-

#### 8086寄存器

数据寄存器:

* AX(Accumulate): 累加寄存器，AH + AL
* BX(Base): 基址寄存器，BH + BL
* CX(Count): 计数寄存器，CH + CL
* DX(Data): 数据寄存器，DH + DL

段寄存器:

* CS(Code Segment): 代码段寄存器
* DS(Data Segment): 数据段寄存器
* ES(Extra Segment): 附加段寄存器
* SS(Stack Segment): 堆栈段寄存器

指针寄存器:

* BP(Base Pointer): 基址指针寄存器
* SP(Stack Pointer): 堆栈指针寄存器

变址寄存器:

* SI(Source Index): 源变址寄存器
* DI(Destination Index): 目的变址寄存器

其它寄存器:

* IP(Instruction Pointer): 指令指针寄存器
* FR(Flag Register): 标志寄存器

#### 总线

* 地址总线: CPU对内存的寻址能力，n根地址总线最大寻址2的n次方
* 数据总线: CPU和其它器件一次传送的数据量，n根数据总线一次传送n位二进制数据
* 控制总线: CPU对外部器件的控制能力

#### 物理地址

物理地址 = 段地址 * 16 + 偏移地址

#### 内存寻址方式

* 立即数寻址方式: 操作数存放在指令中，例如 `mov ax,05H`
* 寄存器寻址方式: 操作数存放在寄存器中，例如 `mov ax,bx`
* 直接寻址方式: 操作数的偏移地址 = 立即数，例如 `mov ax,[1234H]`
* 寄存器间接寻址方式: 操作数的偏移地址 = 寄存器，例如 `mov ax,[bx]`
* 寄存器相对寻址方式: 操作数的偏移地址 = 寄存器 + 立即数，例如 `mov ax,[bx+2]`
* 基址加变址寻址方式: 操作数的偏移地址 = 基址寄存器 + 变址寄存器，例如 `mov ax,[bx+si]`
* 相对基址加变址寻址方式: 操作数的偏移地址 = 基址寄存器 + 变址寄存器 + 立即数，例如 `mov ax,[bx+si+2]`

#### 汇编指令

数据传送指令:

* mov: 传送，例如 `mov ax,bx`

堆栈操作指令:

* push: 入栈，例如 `push ax`
* pop: 出栈，例如 `pop ax`

push和pop操作的是`SS:SP`指向的栈顶元素，push执行后`SP = SP - 2`，pop执行后`SP = SP + 2`

算术运算指令:

逻辑运算指令:

控制转移指令:

#### 内中断

CPU接收到中断信息后，中断后续指令的执行，转去执行中断处理程序

* 中断码: 标识中断的类型，一个字节，可表示256种中断类型
* 中断处理程序: CPU接收到中断信息后，转去执行的程序
* 中断向量表: 中断码和中断处理程序入口地址的集合，通过中断码查找到对应的中断处理程序的入口地址

中断处理过程

* 接收中断处理程序，获取中断码
* 各个寄存器入栈
* 设置标志寄存器
* CS和IP入栈
* 查找中断向量表，获取中断处理程序的入口地址，并设置`CS:IP`
* 执行中断处理程序
* 各个寄存器出栈
* CS和IP出栈，继续执行下一条指令
