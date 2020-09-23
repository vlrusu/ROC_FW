///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: pattern_FIFO_cntrl.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG1152>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module pattern_FIFO_cntrl( 
//global signals
    input              digiclk,
    input              resetn,

    input       [1:0]  pattern,  //pattern generator type: 0=>INCR+1, 1=>DECR-1, 2=>all A's,  3=>all 5's
    input              pattern_init,
    input              pattern_full,  // PATTERN_FIFO ALMOST_full (to stop PATTERN_FIFO_RE)
    input              pattern_empty, // PATTERN_FIFO empty, to restart pattern generation
    input       [16:0] pattern_rd_cnt, // PATTERN_FIFO rd_cnt, to restart pattern generation
    output reg         pattern_we   /*synthesis syn_preserve=1 */,    // PATTERN_FIFO WR_EN
    output reg [31:0]  pattern_data /*synthesis syn_preserve=1 */     // PATTERN_FIFO input data
);
//<statements>
reg    [32:0]   int_data; 
reg    [32:0]   int_data_alt; 
reg    [1:0]    index;
reg    [15:0]   word_cnt;
reg    [15:0]   blk_cnt;
reg             pattern_init_disable;
wire            pattern_start;

// state machine
localparam [2:0]  IDLE    =   3'b000,
                  VALID   =   3'b001,
                  DONE    =   3'b010, 
                  NEXT    =   3'b011; 
reg [2:0]  wr_state;


// pattern initializer logic
always@(posedge digiclk, negedge resetn)
begin
   if(resetn == 1'b0)
   begin
      int_data    <=   0;
      int_data_alt<=   0;
   end
   else
   begin
      case(pattern)

      2'h0://incremental
      begin
         int_data[32:0] <=  -1'b1;
         int_data_alt   <=  0;
      end

      2'h1://decremental
      begin
         int_data[32:0] <=  33'h1_0000_0000;
         int_data_alt   <=  0;
      end

      2'h2:
      begin
         // 0's and F's
         int_data[31:0]     <=    {8{4'h0}};
         int_data_alt[31:0] <=    {8{4'hF}};
      end

      2'h3:
      begin
         // 5's and A's
         int_data[31:0]     <=    {8{4'h5}};
         int_data_alt[31:0] <=    {8{4'hA}};
      end

      default:
      begin
         int_data    <=   0;
         int_data_alt<=   0;
      end

      endcase
   end // if (resetn == 1'b0)
end

// deal with spurious PATTERN_INIT when reset generates a PATTERN_FIFO EMPTY
always@(posedge digiclk, negedge resetn)
begin
   if(resetn == 1'b0)
   begin
      if (pattern_empty == 1'b1)    pattern_init_disable <= 1'b1;
      else                          pattern_init_disable <= 1'b0;
   end
   else
   begin
      if (pattern_empty == 1'b0)    pattern_init_disable <= 1'b0;
   end
end
assign  pattern_start = pattern_init || (pattern_empty && ~pattern_init_disable);


//pattern output state machine
always@(posedge digiclk, negedge resetn)
begin
   if(resetn == 1'b0)
   begin
      word_cnt      <=  16'h0;
      blk_cnt       <=  16'h0;
      index         <=  2'b00;
      pattern_we    <=  1'b0;
      pattern_data  <=  int_data;
      wr_state      <=  IDLE;
   end

   else
   begin
      case(wr_state)

      //wait for memory init command and start writing to PATTERN_FIFO
      IDLE:
      begin
         word_cnt       <=  16'h0;
         blk_cnt        <=  blk_cnt;
         index          <=  2'b00;
         pattern_we     <=  1'b0;
         //pattern_data   <=  int_data;
         if      (pattern == 2'b00)  pattern_data <=  int_data + blk_cnt*17'h1_0000; 
         else if (pattern == 2'b01)  pattern_data <=  int_data - blk_cnt*17'h1_0000; 
         else                        pattern_data <=  int_data; 
         if(pattern_start)
         begin
            wr_state    <=  VALID;
         end
      end

      // update data pattern
      VALID:
      begin
         word_cnt   <=  word_cnt + 1'b1;
         index      <=  index + 2'b01;
         pattern_we <=  1'b1;

         // add offset to 32-bit pattern_data every time the PATTERN_FIFO is emptied  
         if     (pattern == 2'b00)  pattern_data    <=  pattern_data + 1'b1;
         else if(pattern == 2'b01)  pattern_data    <=  pattern_data - 1'b1;
         else
         begin
            if (index<2'b10) pattern_data <= int_data;
            else             pattern_data <= int_data_alt;
         end

         if (word_cnt == 16'hFFFF) // Condition to restart when PATTERN_FIFO is projected has delivered 256 pages 
         begin
            blk_cnt     <=  blk_cnt + 1'b1;
            wr_state    <=  IDLE;
         end
      end

      default:
      begin
        word_cnt    <=  16'h0;
        blk_cnt     <=  16'h0;
        index       <=  2'b00;
        pattern_we  <=  1'b0;
        pattern_data<=  pattern_data;
        wr_state    <=  IDLE;
      end

      endcase
    end  // if(resetn == 1'b0)
end

endmodule

