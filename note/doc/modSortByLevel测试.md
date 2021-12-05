
# modSortByLevel测试

## 测试文件

- LibBlackbox.v
- s27_net_modified.v

> 在 note 目录下的 misc 中可以找到

## 测试目的

观察 verilator 对模块的排序行为，以及 verilator 对一个模块的定义。

## 测试锚点

在 modSortByLevel 中添加以下代码:

```cpp
    cout<<"顶级模块"<<endl;
    for(auto& top : tops){
        cout<<"name : "<<top->name()<<"\t origin name : "<<top->origName()<<"\tlevel : "<<top->level()<<endl;
    }
    cout<<endl;
    cout<<"所有模块"<<endl;
    for(auto& mod : mods){
        cout<<"name : "<<mod->name()<<"\t origin name : "<<mod->origName()<<"\tlevel : "<<mod->level()<<endl;
    }
    cout<<endl;
```

## 测试结果

锚点输出结果：

```txt
顶级模块
name : s27       origin name : s27      level : 2

所有模块
name : s27       origin name : s27      level : 2
name : ADDFXL    origin name : ADDFXL   level : 3
name : ADDFX1    origin name : ADDFX1   level : 3
name : ADDFX2    origin name : ADDFX2   level : 3
name : ADDFX4    origin name : ADDFX4   level : 3
name : ADDFHXL   origin name : ADDFHXL  level : 3
name : ADDFHX1   origin name : ADDFHX1  level : 3
name : ADDFHX2   origin name : ADDFHX2  level : 3
name : ADDFHX4   origin name : ADDFHX4  level : 3
name : ADDHXL    origin name : ADDHXL   level : 3
name : ADDHX1    origin name : ADDHX1   level : 3
name : ADDHX2    origin name : ADDHX2   level : 3
name : ADDHX4    origin name : ADDHX4   level : 3
name : AND2XL    origin name : AND2XL   level : 3
name : AND2X1    origin name : AND2X1   level : 3
name : AND2X2    origin name : AND2X2   level : 3
name : AND2X4    origin name : AND2X4   level : 3
name : AND3XL    origin name : AND3XL   level : 3
name : AND3X1    origin name : AND3X1   level : 3
name : AND3X2    origin name : AND3X2   level : 3
name : AND3X4    origin name : AND3X4   level : 3
name : AND4XL    origin name : AND4XL   level : 3
name : AND4X1    origin name : AND4X1   level : 3
name : AND4X2    origin name : AND4X2   level : 3
name : AND4X4    origin name : AND4X4   level : 3
name : AOI21XL   origin name : AOI21XL  level : 3
name : AOI21X1   origin name : AOI21X1  level : 3
name : AOI21X2   origin name : AOI21X2  level : 3
name : AOI21X4   origin name : AOI21X4  level : 3
name : AOI211XL  origin name : AOI211XL level : 3
name : AOI211X1  origin name : AOI211X1 level : 3
name : AOI211X2  origin name : AOI211X2 level : 3
name : AOI211X4  origin name : AOI211X4 level : 3
name : AOI22XL   origin name : AOI22XL  level : 3
name : AOI22X1   origin name : AOI22X1  level : 3
name : AOI22X2   origin name : AOI22X2  level : 3
name : AOI22X4   origin name : AOI22X4  level : 3
name : AOI221XL  origin name : AOI221XL level : 3
name : AOI221X1  origin name : AOI221X1 level : 3
name : AOI221X2  origin name : AOI221X2 level : 3
name : AOI221X4  origin name : AOI221X4 level : 3
name : AOI222XL  origin name : AOI222XL level : 3
name : AOI222X1  origin name : AOI222X1 level : 3
name : AOI222X2  origin name : AOI222X2 level : 3
name : AOI222X4  origin name : AOI222X4 level : 3
name : AOI2BB1XL         origin name : AOI2BB1XL        level : 3
name : AOI2BB1X1         origin name : AOI2BB1X1        level : 3
name : AOI2BB1X2         origin name : AOI2BB1X2        level : 3
name : AOI2BB1X4         origin name : AOI2BB1X4        level : 3
name : AOI2BB2XL         origin name : AOI2BB2XL        level : 3
name : AOI2BB2X1         origin name : AOI2BB2X1        level : 3
name : AOI2BB2X2         origin name : AOI2BB2X2        level : 3
name : AOI2BB2X4         origin name : AOI2BB2X4        level : 3
name : AOI31XL   origin name : AOI31XL  level : 3
name : AOI31X1   origin name : AOI31X1  level : 3
name : AOI31X2   origin name : AOI31X2  level : 3
name : AOI31X4   origin name : AOI31X4  level : 3
name : AOI32XL   origin name : AOI32XL  level : 3
name : AOI32X1   origin name : AOI32X1  level : 3
name : AOI32X2   origin name : AOI32X2  level : 3
name : AOI32X4   origin name : AOI32X4  level : 3
name : AOI33XL   origin name : AOI33XL  level : 3
name : AOI33X1   origin name : AOI33X1  level : 3
name : AOI33X2   origin name : AOI33X2  level : 3
name : AOI33X4   origin name : AOI33X4  level : 3
name : BUFXL     origin name : BUFXL    level : 3
name : BUFX1     origin name : BUFX1    level : 3
name : BUFX2     origin name : BUFX2    level : 3
name : BUFX3     origin name : BUFX3    level : 3
name : BUFX4     origin name : BUFX4    level : 3
name : BUFX8     origin name : BUFX8    level : 3
name : BUFX12    origin name : BUFX12   level : 3
name : BUFX16    origin name : BUFX16   level : 3
name : BUFX20    origin name : BUFX20   level : 3
name : CLKBUFXL  origin name : CLKBUFXL level : 3
name : CLKBUFX1  origin name : CLKBUFX1 level : 3
name : CLKBUFX2  origin name : CLKBUFX2 level : 3
name : CLKBUFX3  origin name : CLKBUFX3 level : 3
name : CLKBUFX4  origin name : CLKBUFX4 level : 3
name : CLKBUFX8  origin name : CLKBUFX8 level : 3
name : CLKBUFX12         origin name : CLKBUFX12        level : 3
name : CLKBUFX16         origin name : CLKBUFX16        level : 3
name : CLKBUFX20         origin name : CLKBUFX20        level : 3
name : CLKINVXL  origin name : CLKINVXL level : 3
name : CLKINVX1  origin name : CLKINVX1 level : 3
name : CLKINVX2  origin name : CLKINVX2 level : 3
name : CLKINVX3  origin name : CLKINVX3 level : 3
name : CLKINVX4  origin name : CLKINVX4 level : 3
name : CLKINVX8  origin name : CLKINVX8 level : 3
name : CLKINVX12         origin name : CLKINVX12        level : 3
name : CLKINVX16         origin name : CLKINVX16        level : 3
name : CLKINVX20         origin name : CLKINVX20        level : 3
name : JKFFXL    origin name : JKFFXL   level : 3
name : JKFFX1    origin name : JKFFX1   level : 3
name : JKFFX2    origin name : JKFFX2   level : 3
name : JKFFX4    origin name : JKFFX4   level : 3
name : JKFFRXL   origin name : JKFFRXL  level : 3
name : JKFFRX1   origin name : JKFFRX1  level : 3
name : JKFFRX2   origin name : JKFFRX2  level : 3
name : JKFFRX4   origin name : JKFFRX4  level : 3
name : JKFFSXL   origin name : JKFFSXL  level : 3
name : JKFFSX1   origin name : JKFFSX1  level : 3
name : JKFFSX2   origin name : JKFFSX2  level : 3
name : JKFFSX4   origin name : JKFFSX4  level : 3
name : JKFFSRXL  origin name : JKFFSRXL level : 3
name : JKFFSRX1  origin name : JKFFSRX1 level : 3
name : JKFFSRX2  origin name : JKFFSRX2 level : 3
name : JKFFSRX4  origin name : JKFFSRX4 level : 3
name : DFFXL     origin name : DFFXL    level : 3
name : DFFX1     origin name : DFFX1    level : 3
name : DFFX2     origin name : DFFX2    level : 3
name : DFFX4     origin name : DFFX4    level : 3
name : DFFHQXL   origin name : DFFHQXL  level : 3
name : DFFHQX1   origin name : DFFHQX1  level : 3
name : DFFHQX2   origin name : DFFHQX2  level : 3
name : DFFHQX4   origin name : DFFHQX4  level : 3
name : DFFNSRXL  origin name : DFFNSRXL level : 3
name : DFFNSRX1  origin name : DFFNSRX1 level : 3
name : DFFNSRX2  origin name : DFFNSRX2 level : 3
name : DFFNSRX4  origin name : DFFNSRX4 level : 3
name : DFFRXL    origin name : DFFRXL   level : 3
name : DFFRX1    origin name : DFFRX1   level : 3
name : DFFRX2    origin name : DFFRX2   level : 3
name : DFFRX4    origin name : DFFRX4   level : 3
name : DFFRHQXL  origin name : DFFRHQXL level : 3
name : DFFRHQX1  origin name : DFFRHQX1 level : 3
name : DFFRHQX2  origin name : DFFRHQX2 level : 3
name : DFFRHQX4  origin name : DFFRHQX4 level : 3
name : DFFSXL    origin name : DFFSXL   level : 3
name : DFFSX1    origin name : DFFSX1   level : 3
name : DFFSX2    origin name : DFFSX2   level : 3
name : DFFSX4    origin name : DFFSX4   level : 3
name : DFFSHQXL  origin name : DFFSHQXL level : 3
name : DFFSHQX1  origin name : DFFSHQX1 level : 3
name : DFFSHQX2  origin name : DFFSHQX2 level : 3
name : DFFSHQX4  origin name : DFFSHQX4 level : 3
name : DFFSRXL   origin name : DFFSRXL  level : 3
name : DFFSRX1   origin name : DFFSRX1  level : 3
name : DFFSRX2   origin name : DFFSRX2  level : 3
name : DFFSRX4   origin name : DFFSRX4  level : 3
name : DFFSRHQXL         origin name : DFFSRHQXL        level : 3
name : DFFSRHQX1         origin name : DFFSRHQX1        level : 3
name : DFFSRHQX2         origin name : DFFSRHQX2        level : 3
name : DFFSRHQX4         origin name : DFFSRHQX4        level : 3
name : DFFTRXL   origin name : DFFTRXL  level : 3
name : DFFTRX1   origin name : DFFTRX1  level : 3
name : DFFTRX2   origin name : DFFTRX2  level : 3
name : DFFTRX4   origin name : DFFTRX4  level : 3
name : DLY1X1    origin name : DLY1X1   level : 3
name : DLY2X1    origin name : DLY2X1   level : 3
name : DLY3X1    origin name : DLY3X1   level : 3
name : DLY4X1    origin name : DLY4X1   level : 3
name : EDFFXL    origin name : EDFFXL   level : 3
name : EDFFX1    origin name : EDFFX1   level : 3
name : EDFFX2    origin name : EDFFX2   level : 3
name : EDFFX4    origin name : EDFFX4   level : 3
name : EDFFTRXL  origin name : EDFFTRXL level : 3
name : EDFFTRX1  origin name : EDFFTRX1 level : 3
name : EDFFTRX2  origin name : EDFFTRX2 level : 3
name : EDFFTRX4  origin name : EDFFTRX4 level : 3
name : INVXL     origin name : INVXL    level : 3
name : INVX1     origin name : INVX1    level : 3
name : INVX2     origin name : INVX2    level : 3
name : INVX3     origin name : INVX3    level : 3
name : INVX4     origin name : INVX4    level : 3
name : INVX8     origin name : INVX8    level : 3
name : INVX12    origin name : INVX12   level : 3
name : INVX16    origin name : INVX16   level : 3
name : INVX20    origin name : INVX20   level : 3
name : MX2XL     origin name : MX2XL    level : 3
name : MX2X1     origin name : MX2X1    level : 3
name : MX2X2     origin name : MX2X2    level : 3
name : MX2X4     origin name : MX2X4    level : 3
name : MX4XL     origin name : MX4XL    level : 3
name : MX4X1     origin name : MX4X1    level : 3
name : MX4X2     origin name : MX4X2    level : 3
name : MX4X4     origin name : MX4X4    level : 3
name : MXI2XL    origin name : MXI2XL   level : 3
name : MXI2X1    origin name : MXI2X1   level : 3
name : MXI2X2    origin name : MXI2X2   level : 3
name : MXI2X4    origin name : MXI2X4   level : 3
name : MXI4XL    origin name : MXI4XL   level : 3
name : MXI4X1    origin name : MXI4X1   level : 3
name : MXI4X2    origin name : MXI4X2   level : 3
name : MXI4X4    origin name : MXI4X4   level : 3
name : NAND2XL   origin name : NAND2XL  level : 3
name : NAND2X1   origin name : NAND2X1  level : 3
name : NAND2X2   origin name : NAND2X2  level : 3
name : NAND2X4   origin name : NAND2X4  level : 3
name : NAND2BXL  origin name : NAND2BXL level : 3
name : NAND2BX1  origin name : NAND2BX1 level : 3
name : NAND2BX2  origin name : NAND2BX2 level : 3
name : NAND2BX4  origin name : NAND2BX4 level : 3
name : NAND3XL   origin name : NAND3XL  level : 3
name : NAND3X1   origin name : NAND3X1  level : 3
name : NAND3X2   origin name : NAND3X2  level : 3
name : NAND3X4   origin name : NAND3X4  level : 3
name : NAND3BXL  origin name : NAND3BXL level : 3
name : NAND3BX1  origin name : NAND3BX1 level : 3
name : NAND3BX2  origin name : NAND3BX2 level : 3
name : NAND3BX4  origin name : NAND3BX4 level : 3
name : NAND4XL   origin name : NAND4XL  level : 3
name : NAND4X1   origin name : NAND4X1  level : 3
name : NAND4X2   origin name : NAND4X2  level : 3
name : NAND4X4   origin name : NAND4X4  level : 3
name : NAND4BXL  origin name : NAND4BXL level : 3
name : NAND4BX1  origin name : NAND4BX1 level : 3
name : NAND4BX2  origin name : NAND4BX2 level : 3
name : NAND4BX4  origin name : NAND4BX4 level : 3
name : NAND4BBXL         origin name : NAND4BBXL        level : 3
name : NAND4BBX1         origin name : NAND4BBX1        level : 3
name : NAND4BBX2         origin name : NAND4BBX2        level : 3
name : NAND4BBX4         origin name : NAND4BBX4        level : 3
name : NOR2XL    origin name : NOR2XL   level : 3
name : NOR2X1    origin name : NOR2X1   level : 3
name : NOR2X2    origin name : NOR2X2   level : 3
name : NOR2X4    origin name : NOR2X4   level : 3
name : NOR2BXL   origin name : NOR2BXL  level : 3
name : NOR2BX1   origin name : NOR2BX1  level : 3
name : NOR2BX2   origin name : NOR2BX2  level : 3
name : NOR2BX4   origin name : NOR2BX4  level : 3
name : NOR3XL    origin name : NOR3XL   level : 3
name : NOR3X1    origin name : NOR3X1   level : 3
name : NOR3X2    origin name : NOR3X2   level : 3
name : NOR3X4    origin name : NOR3X4   level : 3
name : NOR3BXL   origin name : NOR3BXL  level : 3
name : NOR3BX1   origin name : NOR3BX1  level : 3
name : NOR3BX2   origin name : NOR3BX2  level : 3
name : NOR3BX4   origin name : NOR3BX4  level : 3
name : NOR4XL    origin name : NOR4XL   level : 3
name : NOR4X1    origin name : NOR4X1   level : 3
name : NOR4X2    origin name : NOR4X2   level : 3
name : NOR4X4    origin name : NOR4X4   level : 3
name : NOR4BXL   origin name : NOR4BXL  level : 3
name : NOR4BX1   origin name : NOR4BX1  level : 3
name : NOR4BX2   origin name : NOR4BX2  level : 3
name : NOR4BX4   origin name : NOR4BX4  level : 3
name : NOR4BBXL  origin name : NOR4BBXL level : 3
name : NOR4BBX1  origin name : NOR4BBX1 level : 3
name : NOR4BBX2  origin name : NOR4BBX2 level : 3
name : NOR4BBX4  origin name : NOR4BBX4 level : 3
name : OAI21XL   origin name : OAI21XL  level : 3
name : OAI21X1   origin name : OAI21X1  level : 3
name : OAI21X2   origin name : OAI21X2  level : 3
name : OAI21X4   origin name : OAI21X4  level : 3
name : OAI211XL  origin name : OAI211XL level : 3
name : OAI211X1  origin name : OAI211X1 level : 3
name : OAI211X2  origin name : OAI211X2 level : 3
name : OAI211X4  origin name : OAI211X4 level : 3
name : OAI22XL   origin name : OAI22XL  level : 3
name : OAI22X1   origin name : OAI22X1  level : 3
name : OAI22X2   origin name : OAI22X2  level : 3
name : OAI22X4   origin name : OAI22X4  level : 3
name : OAI221XL  origin name : OAI221XL level : 3
name : OAI221X1  origin name : OAI221X1 level : 3
name : OAI221X2  origin name : OAI221X2 level : 3
name : OAI221X4  origin name : OAI221X4 level : 3
name : OAI222XL  origin name : OAI222XL level : 3
name : OAI222X1  origin name : OAI222X1 level : 3
name : OAI222X2  origin name : OAI222X2 level : 3
name : OAI222X4  origin name : OAI222X4 level : 3
name : OAI2BB1XL         origin name : OAI2BB1XL        level : 3
name : OAI2BB1X1         origin name : OAI2BB1X1        level : 3
name : OAI2BB1X2         origin name : OAI2BB1X2        level : 3
name : OAI2BB1X4         origin name : OAI2BB1X4        level : 3
name : OAI2BB2XL         origin name : OAI2BB2XL        level : 3
name : OAI2BB2X1         origin name : OAI2BB2X1        level : 3
name : OAI2BB2X2         origin name : OAI2BB2X2        level : 3
name : OAI2BB2X4         origin name : OAI2BB2X4        level : 3
name : OAI31XL   origin name : OAI31XL  level : 3
name : OAI31X1   origin name : OAI31X1  level : 3
name : OAI31X2   origin name : OAI31X2  level : 3
name : OAI31X4   origin name : OAI31X4  level : 3
name : OAI32XL   origin name : OAI32XL  level : 3
name : OAI32X1   origin name : OAI32X1  level : 3
name : OAI32X2   origin name : OAI32X2  level : 3
name : OAI32X4   origin name : OAI32X4  level : 3
name : OAI33XL   origin name : OAI33XL  level : 3
name : OAI33X1   origin name : OAI33X1  level : 3
name : OAI33X2   origin name : OAI33X2  level : 3
name : OAI33X4   origin name : OAI33X4  level : 3
name : OR2XL     origin name : OR2XL    level : 3
name : OR2X1     origin name : OR2X1    level : 3
name : OR2X2     origin name : OR2X2    level : 3
name : OR2X4     origin name : OR2X4    level : 3
name : OR3XL     origin name : OR3XL    level : 3
name : OR3X1     origin name : OR3X1    level : 3
name : OR3X2     origin name : OR3X2    level : 3
name : OR3X4     origin name : OR3X4    level : 3
name : OR4XL     origin name : OR4XL    level : 3
name : OR4X1     origin name : OR4X1    level : 3
name : OR4X2     origin name : OR4X2    level : 3
name : OR4X4     origin name : OR4X4    level : 3
name : RSLATNXL  origin name : RSLATNXL level : 3
name : RSLATNX1  origin name : RSLATNX1 level : 3
name : RSLATNX2  origin name : RSLATNX2 level : 3
name : RSLATNX4  origin name : RSLATNX4 level : 3
name : SDFFXL    origin name : SDFFXL   level : 3
name : SDFFX1    origin name : SDFFX1   level : 3
name : SDFFX2    origin name : SDFFX2   level : 3
name : SDFFX4    origin name : SDFFX4   level : 3
name : SDFFHQXL  origin name : SDFFHQXL level : 3
name : SDFFHQX1  origin name : SDFFHQX1 level : 3
name : SDFFHQX2  origin name : SDFFHQX2 level : 3
name : SDFFHQX4  origin name : SDFFHQX4 level : 3
name : SDFFNSRXL         origin name : SDFFNSRXL        level : 3
name : SDFFNSRX1         origin name : SDFFNSRX1        level : 3
name : SDFFNSRX2         origin name : SDFFNSRX2        level : 3
name : SDFFNSRX4         origin name : SDFFNSRX4        level : 3
name : SDFFRXL   origin name : SDFFRXL  level : 3
name : SDFFRX1   origin name : SDFFRX1  level : 3
name : SDFFRX2   origin name : SDFFRX2  level : 3
name : SDFFRX4   origin name : SDFFRX4  level : 3
name : SDFFRHQXL         origin name : SDFFRHQXL        level : 3
name : SDFFRHQX1         origin name : SDFFRHQX1        level : 3
name : SDFFRHQX2         origin name : SDFFRHQX2        level : 3
name : SDFFRHQX4         origin name : SDFFRHQX4        level : 3
name : SDFFSXL   origin name : SDFFSXL  level : 3
name : SDFFSX1   origin name : SDFFSX1  level : 3
name : SDFFSX2   origin name : SDFFSX2  level : 3
name : SDFFSX4   origin name : SDFFSX4  level : 3
name : SDFFSHQXL         origin name : SDFFSHQXL        level : 3
name : SDFFSHQX1         origin name : SDFFSHQX1        level : 3
name : SDFFSHQX2         origin name : SDFFSHQX2        level : 3
name : SDFFSHQX4         origin name : SDFFSHQX4        level : 3
name : SDFFSRXL  origin name : SDFFSRXL level : 3
name : SDFFSRX1  origin name : SDFFSRX1 level : 3
name : SDFFSRX2  origin name : SDFFSRX2 level : 3
name : SDFFSRX4  origin name : SDFFSRX4 level : 3
name : SDFFSRHQXL        origin name : SDFFSRHQXL       level : 3
name : SDFFSRHQX1        origin name : SDFFSRHQX1       level : 3
name : SDFFSRHQX2        origin name : SDFFSRHQX2       level : 3
name : SDFFSRHQX4        origin name : SDFFSRHQX4       level : 3
name : SDFFTRXL  origin name : SDFFTRXL level : 3
name : SDFFTRX1  origin name : SDFFTRX1 level : 3
name : SDFFTRX2  origin name : SDFFTRX2 level : 3
name : SDFFTRX4  origin name : SDFFTRX4 level : 3
name : SEDFFXL   origin name : SEDFFXL  level : 3
name : SEDFFX1   origin name : SEDFFX1  level : 3
name : SEDFFX2   origin name : SEDFFX2  level : 3
name : SEDFFX4   origin name : SEDFFX4  level : 3
name : SEDFFHQXL         origin name : SEDFFHQXL        level : 3
name : SEDFFHQX1         origin name : SEDFFHQX1        level : 3
name : SEDFFHQX2         origin name : SEDFFHQX2        level : 3
name : SEDFFHQX4         origin name : SEDFFHQX4        level : 3
name : SEDFFTRXL         origin name : SEDFFTRXL        level : 3
name : SEDFFTRX1         origin name : SEDFFTRX1        level : 3
name : SEDFFTRX2         origin name : SEDFFTRX2        level : 3
name : SEDFFTRX4         origin name : SEDFFTRX4        level : 3
name : TBUFXL    origin name : TBUFXL   level : 3
name : TBUFX1    origin name : TBUFX1   level : 3
name : TBUFX2    origin name : TBUFX2   level : 3
name : TBUFX3    origin name : TBUFX3   level : 3
name : TBUFX4    origin name : TBUFX4   level : 3
name : TBUFX8    origin name : TBUFX8   level : 3
name : TBUFX12   origin name : TBUFX12  level : 3
name : TBUFX16   origin name : TBUFX16  level : 3
name : TBUFX20   origin name : TBUFX20  level : 3
name : TIEHI     origin name : TIEHI    level : 3
name : TIELO     origin name : TIELO    level : 3
name : TLATXL    origin name : TLATXL   level : 3
name : TLATX1    origin name : TLATX1   level : 3
name : TLATX2    origin name : TLATX2   level : 3
name : TLATX4    origin name : TLATX4   level : 3
name : TLATNXL   origin name : TLATNXL  level : 3
name : TLATNX1   origin name : TLATNX1  level : 3
name : TLATNX2   origin name : TLATNX2  level : 3
name : TLATNX4   origin name : TLATNX4  level : 3
name : TLATNSRXL         origin name : TLATNSRXL        level : 3
name : TLATNSRX1         origin name : TLATNSRX1        level : 3
name : TLATNSRX2         origin name : TLATNSRX2        level : 3
name : TLATNSRX4         origin name : TLATNSRX4        level : 3
name : TLATSRXL  origin name : TLATSRXL level : 3
name : TLATSRX1  origin name : TLATSRX1 level : 3
name : TLATSRX2  origin name : TLATSRX2 level : 3
name : TLATSRX4  origin name : TLATSRX4 level : 3
name : XNOR2XL   origin name : XNOR2XL  level : 3
name : XNOR2X1   origin name : XNOR2X1  level : 3
name : XNOR2X2   origin name : XNOR2X2  level : 3
name : XNOR2X4   origin name : XNOR2X4  level : 3
name : XOR2XL    origin name : XOR2XL   level : 3
name : XOR2X1    origin name : XOR2X1   level : 3
name : XOR2X2    origin name : XOR2X2   level : 3
name : XOR2X4    origin name : XOR2X4   level : 3
name : XOR3X2    origin name : XOR3X2   level : 3
name : XOR3X4    origin name : XOR3X4   level : 3
```

## 测试结论

自己对照 *.v 文件与 锚点输出结果进行对比，自行观察。

> 此处锚点仍然保留在了代码中，被预编译禁用掉而已。
