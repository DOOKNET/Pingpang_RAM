module RAM_Control(
    input   clk,
    input   data_tvalid,        //数据有效使能，拉高时写数据
    input   [9:0]   addr_we,
    input   [11:0]  addr_rd
);

//----------input---------//
reg     wea;            //写端口使能
reg     web;
reg     [9:0]   addra,  //端口地址
reg     [9:0]   addrb,
reg     [13:0]  dina;   //输入数据
reg     [13:0]  dinb;
//---------output---------//
wire    [13:0]  douta;  //输出a
wire    [13:0]  doutb;  //输出b
//------------------------//

//---------数据选择器----------//
always @(posedge clk) begin
    if((addr_we <= 10'd1023)&&(addr_rd <= 12'd1023))   begin
        wea <= 10;
        web <= 0;
    end
    else if((addr_rd >= 12'd1023)&&(addr_rd <= 12'd3095))    begin
        wea <= 0;
        web <= 0;
    end
    else if((addr_we <= ))
end

//-----------------------状态机-----------------------//
reg     [3:0]   current_state = 4'b0001;
reg     [3:0]   next_state = 4'b0001;

parameter   wea_rdb = 4'b0001;
parameter   rdb = 4'b0010;
parameter   web_rda = 4'b0100;
parameter   rda = 4'b1000;
//------------状态跳转程序-----------//
always @(posedge clk) begin
    current_state <= next_state;
end
//------------状态跳转输出-----------//
always @(posedge clk) begin
    case (current_state)
        wea_rdb:
            begin
                if((wea == 0)&&(web == 0))  begin
                    next_state <= rdb;
                end
                else    begin
                    next_state <= wea_rdb;
                end
            end
        rdb:
            begin
                if((web == 1)&&(wea == 0))  begin
                    next_state <= web_rda;
                end
                else    begin
                    next_state <= rdb;
                end
            end
        web_rda:
            begin
                if((web == 0)&&(wea == 0))  begin
                    next_state <= rda;
                end
                else    begin
                    next_state <= web_rda;
                end
            end
        rda:
            begin
                if((wea == 1)&&(web == 0))  begin
                    next_state <= wea_rdb;
                end
                else    begin
                    next_state <= rda;
                end
            end
        default: ;
    endcase
end
//--------------逻辑输出--------------//
always @(posedge clk) begin
    case (next_state)
        wea_rdb:
            begin
                addra <= addr_we;
                addrb <= addr_rd;
            end
        rdb:
            begin
                addra <= 0;
                addrb <= addr_rd;
            end
        web_rda:
            begin
                addra <= addr_we;
                addrb <= addr_rd;
            end
        rda:
            begin
                addra <= addr_we;
                addrb <= 0;
            end
      default: ;
    endcase
end
//-----------------------------------//

/*
always @(posedge clk) begin
    if(data_tvalid) begin
        wea <= 1;
        web <= 1;
    end
end

always @(posedge clk) begin
    if(wea) begin
        addra <= addr_we;
    end
end

always @(posedge clk) begin
    if(wea) begin
        addra <= addr_we;
        web <= 0;
        addrb <= addr_out;
    end
    else    begin
        addra <= addr_out;

end
*/
//-----------调用RAM-----------//
RAM           RAM_inst0(
    .clka     (clk),
    .ena      (1),
    .wea      (wea),
    .addra    (addra),
    .dina     (dina),
    .douta    (douta),
    .clkb     (clk),
    .enb      (1),
    .web      (web),
    .addrb    (addrb),
    .dinb     (dinb),
    .doutb    (doutb)
);
//----------------------------//






endmodule
