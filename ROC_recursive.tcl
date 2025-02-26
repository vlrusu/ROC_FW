#This Tcl file sources other Tcl files to build the design(on which recursive export is run) in a bottom-up fashion

#Sourcing the Tcl file in which all the HDL source files used in the design are imported or linked
source hdl_source.tcl
build_design_hierarchy

#Sourcing the Tcl files in which HDL+ core definitions are created for HDL modules
source components/EW_FIFO_controller.tcl 
source components/DCSRegisters.tcl 
source components/RS485Registers.tcl 
source components/Registers.tcl 
build_design_hierarchy

#Sourcing the Tcl files for creating individual components under the top level
source components/COREJTAGDEBUG_C0.tcl 
source components/CORERESET.tcl 
source components/CORERESET_PF_C1.tcl 
source components/PF_TX_PLL_0.tcl 
source components/PF_XCVR_0.tcl 
source components/PF_XCVR_REF_CLK_0.tcl 
source components/ROCFIFO.tcl 
source components/ROCFIFO_SIM.tcl 
source components/DigiLink.tcl 
source components/DigiLink_sim.tcl 
source components/DigiReaderFIFO.tcl 
source components/DigiInterface.tcl 
source components/INIT_component.tcl 
source components/MIV_RV32IMC_C0.tcl 
source components/AXI4_Interconnect.tcl 
source components/DDR4_Cntrl.tcl 
source components/DREQ_FIFO.tcl 
source components/CNT_FIFO.tcl 
source components/EVT_FIFO.tcl 
source components/EWTAG_FIFO.tcl 
source components/LARGE_TAG_FIFO.tcl 
source components/EW_FIFO.tcl 
source components/SIZE_FIFO.tcl 
source components/SPILLTAG_FIFO.tcl 
source components/SIM_ROC_FIFO.tcl 
source components/pattern_FIFO_filler.tcl 
source components/NewDDRInterface.tcl 
source components/PF_CCC_111.tcl 
source components/PF_CCC_C0.tcl 
source components/PF_CCC_C1.tcl 
source components/PF_CLK_DIV_C0.tcl 
source components/PF_NGMUX_C0.tcl 
source components/PF_OSC_0.tcl 
source components/PF_SRAM.tcl 
source components/APB3.tcl 
source components/CAL_SPI_PROG.tcl 
source components/CMD_TO_PROC_BUFFER.tcl 
source components/CORESPI_IAP.tcl 
source components/DCS_RX_BUFFER.tcl 
source components/DCS_TX_BUFFER.tcl 
source components/GPIO.tcl 
source components/PF_SYSTEM_SERVICES_C0.tcl 
source components/PREAMPSPI.tcl 
source components/SPI0.tcl 
source components/SPI_KEY.tcl 
source components/PF_TVS_C0.tcl 
source components/PF_URAM_C0.tcl 
source components/TVS_Interface.tcl 
source components/UARTapb.tcl 
source components/pwm.tcl 
source components/SLOWCONTROLS.tcl 
source components/RxPacketFIFO.tcl 
source components/CorePCS_C0.tcl 
source components/PF_XCVR_ERM_C0.tcl 
source components/PF_XCVR_REF_CLK_C0.tcl 
source components/XCVR_PLL_0.tcl 
source components/XCVR_Block.tcl 
source components/TOP_SERDES.tcl 
source components/ROC.tcl 
build_design_hierarchy
