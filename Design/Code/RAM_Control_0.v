module RAM_Control(
    input   clk,
    input   [9:0]   addra,
    input   [9:0]   addrb,

);

//----------input---------//
reg     wea;        //写端口使能
reg     web;
reg     [9:0]   addra;  //端口的地址
reg     [9:0]   addrb;
reg     [13:0]  dina;   //输入数据
reg     [13:0]  dinb;
//---------output---------//
wire    [13:0]  douta;
wire    [13:0]  doutb;
//------------------------//




  input clka;
  input ena;
  input [0:0]wea;
  input [9:0]addra;
  input [13:0]dina;
  output [13:0]douta;
  input clkb;
  input enb;
  input [0:0]web;
  input [9:0]addrb;
  input [13:0]dinb;
  output [13:0]doutb;







endmodule // RAM_Control