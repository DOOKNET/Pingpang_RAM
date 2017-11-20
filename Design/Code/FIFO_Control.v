module FIFO_Control(
	input	clk,
	input	[13:0]	data_in,
	input	wr_en,
	input	rd_en
);





module FIFO(
  input wr_clk;
  input rd_clk;
  input [13:0]din;
  input wr_en;
  input rd_en;
  output [13:0]dout;
  output full;
  output almost_full;
  output wr_ack;
  output empty;
  output almost_empty;
  output valid;
  output [9:0]rd_data_count;
  output [9:0]wr_data_count;



endmodule 