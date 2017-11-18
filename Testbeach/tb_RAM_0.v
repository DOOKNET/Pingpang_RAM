`timescale  1ns/1ps

module tb_RAM_0();

//------------------------------//
reg		sclk;
reg		[9:0]	data;		//输入的数据
reg		[11:0]	cnt;		//计数,当cnt=12'd1023时写数据使能，其他读数据使能
reg		[9:0]	addr_we;	//写地址
reg		[11:0]	addr_rd;	//读地址
reg		data_tvalid;		//数据有效信号

//----------设置时钟信号----------//
initial     sclk = 0;
always      #5     sclk = ~sclk;   //100M
//-------------------------------//

//------------初始化-------------//
initial	begin
	data = 0;
	cnt = 0;
	addr_we = 0;
	addr_rd = 0;
	data_tvalid = 0;
end
//------------计数器-------------//
always @(posedge sclk) begin
	if(cnt == 12'd3096)	begin
		cnt <= 0;
		addr_rd <= 0;
	end
	else	begin
		cnt <= cnt + 1;
		addr_rd <= addr_rd + 1;
	end
end
//----------读写数据使能----------//
always @(posedge sclk) begin
	if(cnt <= 12'd1023)	begin
		data_tvalid <= 1;
		addr_we <= cnt;
	end
	else if(cnt >= 12'd1024)	begin
		data_tvalid <= 0;
		addr_we <= addr_we;
	end
	else	begin
		data_tvalid <= data_tvalid;
	end
end
//-------------------------------//





endmodule 

