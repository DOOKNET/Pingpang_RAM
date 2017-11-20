`timescale	1ns/1ps

module	tb_fifo();

//---------定义信号-----------//
reg 	sclk;
reg 	wr_clk;
reg 	rd_clk;
reg		wr_en;
reg		rd_en;
reg		[13:0]	data;

wire 	full;
wire	almost_full;
wire	wr_ack;
wire	empty;
wire	almost_empty;
wire	valid;
wire	[9:0]	rd_data_count;
wire	[9:0]	wr_data_count;
//---------------------------//

//---------时钟信号-----------//
initial		sclk = 0;
always	#5	sclk = ~sclk;
//---------------------------//

//---------时钟脉冲-----------//
initial	begin
	wr_clk = 0;
	rd_clk = 0;
end
always	begin
	#100
	wr_clk = 1;
	rd_clk = 1;
	#10
	wr_clk = 0;
	rd_clk = 0;
end
//----------------------------//

//----------使能信号----------//
initial	begin
	wr_en = 0;
	rd_en = 0;
end
always	begin
	#500
	wr_en = 1;
	rd_en = 0;
	#1000
	wr_en = 0;
	rd_en = 0;
	#100
	wr_en = 0;
	rd_en = 1;
	#1000
	wr_en = 0;
	rd_en = 0;
end
//-----------------------------//

FIFO				FIFO_inst0(
  .wr_clk			(wr_clk),
  .rd_clk			(rd_clk),
  .din				(14'd1024),
  .wr_en			(wr_en),
  .rd_en			(rd_en),
  .dout				(dout),
  .full				(full),
  .almost_full		(almost_full),
  .wr_ack			(wr_ack),
  .empty			(empty),
  .almost_empty		(almost_empty),
  .valid			(valid),
  .rd_data_count	(rd_data_count),
  .wr_data_count	(wr_data_count)
);

endmodule
