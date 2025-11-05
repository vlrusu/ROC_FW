///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: latch_and_clear.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFire> <Die::MPF300TS> <Package::FCG484>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module latch_and_clear(

// async event 'evt_raw' (button, sensor, other clock) -> latched interrupt
input  wire        clk_cpu,      // same clock domain as PLIC/Mi-V
input  wire        rst_n,
input  wire        evt_raw,      // asynchronous pulse
input  wire        cpu_clear,    // 1-cycle strobe from APB/AXI reg write
output wire        ext_sys_irq0 // drive into EXT_SYS_IRQ[0]
);

// 2-FF synchronizer
reg s0, s1;
always @(posedge clk_cpu or negedge rst_n) begin
  if (!rst_n) begin s0 <= 1'b0; s1 <= 1'b0; end
  else begin s0 <= evt_raw; s1 <= s0; end
end

// rising-edge detect in CPU domain
wire evt_sync_rise = s0 & ~s1;

// Pending latch: set on event, clear by CPU
reg pending;
always @(posedge clk_cpu or negedge rst_n) begin
  if (!rst_n)         pending <= 1'b0;
  else if (cpu_clear) pending <= 1'b0;
  else if (evt_sync_rise) pending <= 1'b1;
end

assign ext_sys_irq0 = pending;   // level-high until cleared
endmodule

