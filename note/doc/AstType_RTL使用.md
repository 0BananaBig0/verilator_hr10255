# AstType_RTL使用

> 列举目前项目 RTL 级中使用到的 AstType 种类
>
> 以 s27_net_modified.v 作为范例

- 类型 ： 示例

- s27 : atModule (module s27 ( VDD, CK, G0, G1, G17, G2, G3 );)
- atVar ： VDD (input VDD, CK, G0, G1, G2, G3;)
- atCell ： DFF_0_I1_Q_reg (DFFHQX1 DFF_0_I1_Q_reg ( .D(G10), .CK(CK), .Q(G5) );)
- atPin : D (.D(G10))
- atVarRef : G10 (.D(G10))
