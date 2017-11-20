module FIFO_Control(
	input	clk,
	input	wr_clk,
	input	rd_clk,
	input	we_valid,
	input	[13:0]	data_in
);

reg 	wea_en;			//写数据A使能
reg		web_en;			//写数据B使能
reg 	rda_en;			//读数据A使能
reg		rdb_en;			//读数据B使能
reg		[13:0]	din_a;	//输入A数据
reg		[13:0]	din_b;	//输入B数据

wire	fulla;
wire	fullb;
wire	emptya;
wire	emptyb;
wire	[9:0]	rda_data_count;
wire	[9:0]	rdb_data_count;
wire	[9:0]	wea_data_count;
wire	[9:0]	web_data_count;

wire	[13:0]	douta;
wire	[13:0]	doutb;
//---------------------检测跳变沿---------------------//
reg		fulla_pose_r0 = 0;
reg		fulla_pose_r1 = 0;
wire	fulla_pose = 0;			//检测写满A信号上升沿
reg		emptya_pose_r0 = 0;
reg		emptya_pose_r1 = 0;
wire	emptya_pose = 0;		//检测读空A信号上升沿
reg		fullb_pose_r0 = 0;
reg		fullb_pose_r1 = 0;
wire	fullb_pose = 0;			//检测写满B信号上升沿
reg 	emptyb_pose_r0 = 0;
reg 	emptyb_pose_r1 = 0;
wire 	emptyb_pose = 0;		//检测读空B信号上升沿

always @(posedge clk) begin
	fulla_pose_r0 <= fulla;
	fulla_pose_r1 <= fulla_pose_r0;
end
always @(posedge clk) begin
	fullb_pose_r0 <= fullb;
	fullb_pose_r1 <= fullb_pose_r0;
end
always @(posedge clk) begin
	emptyb_pose_r0 <= emptya;
	emptyb_pose_r1 <= emptyb_pose_r0;
end
always @(posedge clk) begin
	emptyb_pose_r0 <= emptyb;
	emptyb_pose_r1 <= emptyb_pose_r0;
end

assign	fulla_pose = fulla_pose_r0 && ~fulla_pose_r1;
assign	fullb_pose = fullb_pose_r0 && ~fullb_pose_r1;
assign	emptya_pose = emptya_pose_r0 && emptya_pose_r1;
assign	emptyb_pose = emptyb_pose_r0 && emptyb_pose_r1;
//-----------------------状态机-----------------------//
reg     [3:0]   current_state = 4'b0001;
reg     [3:0]   next_state = 4'b0001;

parameter   web_rda = 4'b0001;
parameter   rda = 4'b0010;
parameter   wea_rdb = 4'b0100;
parameter   rdb = 4'b1000;
//------------状态跳转程序-----------//
always @(posedge clk) begin
    current_state <= next_state;
end
//------------状态跳转输出-----------//
always @(posedge clk) begin
    case (current_state)
        web_rda:
            begin
                if(fullb_pose == 1)  begin
                    next_state <= rda;
                end
                else    begin
                    next_state <= web_rda;
                end
            end
        rda:
            begin
                if(emptya_pose == 1)  begin
                    next_state <= wea_rdb;
                end
                else    begin
                    next_state <= rda;
                end
            end
        wea_rdb:
            begin
                if(fulla_pose == 1)  begin
                    next_state <= rdb;
                end
                else    begin
                    next_state <= wea_rdb;
                end
            end
        rdb:
            begin
                if(emptyb_pose == 1)  begin
                    next_state <= web_rda;
                end
                else    begin
                    next_state <= rdb;
                end
            end
        default: ;
    endcase
end
//--------------逻辑输出--------------//
always @(posedge clk) begin
    case (next_state)
        web_rda:
            begin
                rda_en <= 1;
				wea_en <= 0;
				rdb_en <= 0;
				web_en <= we_valid;
            end
        rda:
            begin
				rda_en <= 1;
				wea_en <= 0;
				rdb_en <= 0;
				web_en <= 0;
            end
        wea_rdb:
            begin
				rda_en <= 0;
				wea_en <= we_valid;
				rdb_en <= 1;
				web_en <= 0;
            end
        rdb:
            begin
				rda_en <= 0;
				wea_en <= 0;
				rdb_en <= 0;
				web_en <= 0;
            end
      default: ;
    endcase
end
//-----------------------------------//

//-----------------例化-----------------//
FIFO				FIFO_inst0(
  .wr_clk			(wr_clk),
  .rd_clk			(rd_clk),
  .din				(data_in),
  .wr_en			(wea_en),
  .rd_en			(rda_en),

  .dout				(douta),
  .full				(fulla),
  .empty			(emptya),
  .rd_data_count	(rda_data_count),
  .wr_data_count	(wea_data_count)
);

FIFO				FIFO_inst1(
  .wr_clk			(wr_clk),
  .rd_clk			(rd_clk),
  .din				(data_in),
  .wr_en			(we_valid),
  .rd_en			(rdb_en),

  .dout				(doutb),
  .full				(fullb),
  .empty			(emptyb),
  .rd_data_count	(rdb_data_count),
  .wr_data_count	(web_data_count)
);
//--------------------------------------//

endmodule 