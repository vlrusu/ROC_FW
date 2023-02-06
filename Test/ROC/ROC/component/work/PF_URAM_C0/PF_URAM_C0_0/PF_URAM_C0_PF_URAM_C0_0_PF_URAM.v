`timescale 1 ns/100 ps
// Version: 2022.3 2022.3.0.8


module PF_URAM_C0_PF_URAM_C0_0_PF_URAM(
       R_DATA,
       W_DATA,
       R_ADDR,
       W_ADDR,
       R_CLK,
       W_CLK,
       W_EN
    );
output [15:0] R_DATA;
input  [15:0] W_DATA;
input  [1:0] R_ADDR;
input  [1:0] W_ADDR;
input  R_CLK;
input  W_CLK;
input  W_EN;

    wire \ACCESS_BUSY[0][0] , \ACCESS_BUSY[0][1] , VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM64x12 #( .RAMINDEX("PF_URAM_C0_0%4%16%SPEED%0%0%MICRO_RAM") )  
        PF_URAM_C0_PF_URAM_C0_0_PF_URAM_R0C0 (.BLK_EN(VCC), .BUSY_FB(
        GND), .R_ADDR({GND, GND, GND, GND, R_ADDR[1], R_ADDR[0]}), 
        .R_ADDR_AD_N(VCC), .R_ADDR_AL_N(VCC), .R_ADDR_BYPASS(GND), 
        .R_ADDR_EN(VCC), .R_ADDR_SD(GND), .R_ADDR_SL_N(VCC), .R_CLK(
        R_CLK), .R_DATA_AD_N(VCC), .R_DATA_AL_N(VCC), .R_DATA_BYPASS(
        GND), .R_DATA_EN(VCC), .R_DATA_SD(GND), .R_DATA_SL_N(VCC), 
        .W_ADDR({GND, GND, GND, GND, W_ADDR[1], W_ADDR[0]}), .W_CLK(
        W_CLK), .W_DATA({GND, GND, GND, GND, W_DATA[7], W_DATA[6], 
        W_DATA[5], W_DATA[4], W_DATA[3], W_DATA[2], W_DATA[1], 
        W_DATA[0]}), .W_EN(W_EN), .ACCESS_BUSY(\ACCESS_BUSY[0][0] ), 
        .R_DATA({nc0, nc1, nc2, nc3, R_DATA[7], R_DATA[6], R_DATA[5], 
        R_DATA[4], R_DATA[3], R_DATA[2], R_DATA[1], R_DATA[0]}));
    RAM64x12 #( .RAMINDEX("PF_URAM_C0_0%4%16%SPEED%0%1%MICRO_RAM") )  
        PF_URAM_C0_PF_URAM_C0_0_PF_URAM_R0C1 (.BLK_EN(VCC), .BUSY_FB(
        GND), .R_ADDR({GND, GND, GND, GND, R_ADDR[1], R_ADDR[0]}), 
        .R_ADDR_AD_N(VCC), .R_ADDR_AL_N(VCC), .R_ADDR_BYPASS(GND), 
        .R_ADDR_EN(VCC), .R_ADDR_SD(GND), .R_ADDR_SL_N(VCC), .R_CLK(
        R_CLK), .R_DATA_AD_N(VCC), .R_DATA_AL_N(VCC), .R_DATA_BYPASS(
        GND), .R_DATA_EN(VCC), .R_DATA_SD(GND), .R_DATA_SL_N(VCC), 
        .W_ADDR({GND, GND, GND, GND, W_ADDR[1], W_ADDR[0]}), .W_CLK(
        W_CLK), .W_DATA({GND, GND, GND, GND, W_DATA[15], W_DATA[14], 
        W_DATA[13], W_DATA[12], W_DATA[11], W_DATA[10], W_DATA[9], 
        W_DATA[8]}), .W_EN(W_EN), .ACCESS_BUSY(\ACCESS_BUSY[0][1] ), 
        .R_DATA({nc4, nc5, nc6, nc7, R_DATA[15], R_DATA[14], 
        R_DATA[13], R_DATA[12], R_DATA[11], R_DATA[10], R_DATA[9], 
        R_DATA[8]}));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
