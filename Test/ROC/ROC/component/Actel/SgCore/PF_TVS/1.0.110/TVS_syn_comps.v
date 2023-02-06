`timescale 1 ns/100 ps
// Version: 


module TVS(
       EN,
       TEMP_HIGH_CLEAR,
       TEMP_LOW_CLEAR,
       ACTIVE,
       VALID,
       CHANNEL,
       VALUE,
       TEMP_HIGH,
       TEMP_LOW
    ) ;
/* synthesis syn_black_box

*/
/* synthesis black_box_pad_pin ="" */
input  [3:0] EN;
input  TEMP_HIGH_CLEAR;
input  TEMP_LOW_CLEAR;
output ACTIVE;
output VALID;
output [1:0] CHANNEL;
output [15:0] VALUE;
output TEMP_HIGH;
output TEMP_LOW;
parameter TVS_CONTROL_ENABLE = 4'h0;
parameter TVS_TRIGGER_LOW = 16'h0;
parameter TVS_TRIGGER_HIGH = 16'h0;
parameter TVS_CONTROL_POWEROFF = 1'h0;
parameter TVS_CONTROL_RATE = 8'h0;
parameter SOFTRESET = 1'h0;

endmodule
