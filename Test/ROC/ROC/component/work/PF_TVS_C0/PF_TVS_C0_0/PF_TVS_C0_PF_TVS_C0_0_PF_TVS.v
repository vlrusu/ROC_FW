`timescale 1 ns/100 ps
// Version: 2022.3 2022.3.0.8


module PF_TVS_C0_PF_TVS_C0_0_PF_TVS(
       VALUE,
       CHANNEL,
       VALID,
       ACTIVE,
       ENABLE_1V,
       ENABLE_18V,
       ENABLE_25V,
       ENABLE_TEMP,
       TEMP_HIGH_CLEAR,
       TEMP_LOW_CLEAR,
       TEMP_HIGH,
       TEMP_LOW
    );
output [15:0] VALUE;
output [1:0] CHANNEL;
output VALID;
output ACTIVE;
input  ENABLE_1V;
input  ENABLE_18V;
input  ENABLE_25V;
input  ENABLE_TEMP;
input  TEMP_HIGH_CLEAR;
input  TEMP_LOW_CLEAR;
output TEMP_HIGH;
output TEMP_LOW;

    wire gnd_net, vcc_net;
    
    TVS #( .TVS_CONTROL_ENABLE(4'b1111), .TVS_TRIGGER_LOW(16'b0001000100010010)
        , .TVS_TRIGGER_HIGH(16'b0001000100010010), .TVS_CONTROL_POWEROFF(1'b0)
        , .TVS_CONTROL_RATE(8'b00111100) )  TVSInstance (.ACTIVE(
        ACTIVE), .VALID(VALID), .CHANNEL({CHANNEL[1], CHANNEL[0]}), 
        .VALUE({VALUE[15], VALUE[14], VALUE[13], VALUE[12], VALUE[11], 
        VALUE[10], VALUE[9], VALUE[8], VALUE[7], VALUE[6], VALUE[5], 
        VALUE[4], VALUE[3], VALUE[2], VALUE[1], VALUE[0]}), .TEMP_HIGH(
        TEMP_HIGH), .TEMP_LOW(TEMP_LOW), .EN({ENABLE_TEMP, ENABLE_25V, 
        ENABLE_18V, ENABLE_1V}), .TEMP_HIGH_CLEAR(TEMP_HIGH_CLEAR), 
        .TEMP_LOW_CLEAR(TEMP_LOW_CLEAR));
    VCC vcc_inst (.Y(vcc_net));
    GND gnd_inst (.Y(gnd_net));
    
endmodule
