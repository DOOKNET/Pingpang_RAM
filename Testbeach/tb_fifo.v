`timescale  1ns/1ps

module tb_fifo();

//------------------------------//
reg		sclk;
reg		rd_clk;
reg		[13:0]	data;		//输入的数据
reg		[12:0]	cnt;		//计数,当cnt=12'd1023时写数据使能，其他读数据使能
reg		data_tvalid;		//数据有效信号

//wire	[13:0]	dout;
//wire 	full;
//wire	almost_full;
//wire	wr_ack;
//wire	empty;
//wire	almost_empty;
//wire	valid;
//wire	[9:0]	rd_data_count;
//wire	[9:0]	wr_data_count;
//----------设置时钟信号----------//
initial     sclk = 0;
always      #5     sclk = ~sclk;   //100M
//----------读数据时钟-----------//
initial		rd_clk = 0;
always	begin
	#50
	rd_clk = 1;
	#10
	rd_clk = 0;
end
//------------初始化-------------//
initial	begin
	data = 0;
	cnt = 0;
	data_tvalid = 0;
end
//------------计数器-------------//
always @(posedge sclk) begin
	if(cnt == 13'd8000)	begin
		cnt <= 0;
	end
	else	begin
		cnt <= cnt + 1;
	end
end
//----------写数据有效-----------//
always @(posedge sclk) begin
	if(cnt <= 13'd1023)	begin
		data_tvalid <= 1;
		data <= cnt;
	end
	else if(cnt > 13'd1024)	begin
		data_tvalid <= 0;
		data <= data;
	end
	else	begin
		data_tvalid <= data_tvalid;
		data <= data;
	end
end
//-------------------------------//

FIFO_Control	FIFO_Control_inst0(
	.clk		(sclk),
	.wr_clk		(sclk),
	.rd_clk		(rd_clk),
	.we_valid	(data_tvalid),
	.data_in	(data)
);


endmodule 





/*
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
*/