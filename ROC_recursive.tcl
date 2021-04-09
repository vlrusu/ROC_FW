#This Tcl file sources other Tcl files to build the design(on which recursive export is run) in a bottom-up fashion

#Sourcing the Tcl file in which all the HDL source files used in the design are imported or linked
source hdl_source.tcl
build_design_hierarchy

#Sourcing the Tcl files in which HDL+ core definitions are created for HDL modules
source components/fifo_mem_cntrl.tcl 
source components/pattern_gen_checker.tcl 
source components/Registers.tcl 
build_design_hierarchy

#Sourcing the Tcl files for creating individual components under the top level
source components/COREJTAGDEBUG_C0.tcl 
source components/CORERESET_PF_C0.tcl 
source components/CORERESET_PF_C2.tcl 
source components/AXI4_Interconnect.tcl 
source components/DDR3_Cntrl.tcl 
source components/MEMFIFO.tcl 
source components/TEMPFIFO.tcl 
source components/TPSRAM.tcl 
source components/PATTERN_FIFO.tcl 
source components/pattern_FIFO_filler.tcl 
source components/DDRInterface.tcl 
source components/DigiClkReset.tcl 
source components/DigiFIFOReset.tcl 
source components/CORERESET_PF_C1.tcl 
source components/PF_TX_PLL_0.tcl 
source components/PF_XCVR_0.tcl 
source components/PF_XCVR_REF_CLK_0.tcl 
source components/ROCFIFO.tcl 
source components/DigiLink.tcl 
source components/DigiReaderFIFO.tcl 
source components/DigiInterface.tcl 
source components/DigiReset.tcl 
source components/INIT_component.tcl 
source components/MIV_RV32IMC_C0.tcl 
source components/PF_CCC_C0.tcl 
source components/PF_CCC_C1.tcl 
source components/PF_CLK_DIV_C0.tcl 
source components/PF_NGMUX_C0.tcl 
source components/PF_OSC_0.tcl 
source components/PF_SRAM.tcl 
source components/APB3.tcl 
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
source components/CorePCS_C0.tcl 
source components/PF_XCVR_ERM_C0.tcl 
source components/PF_XCVR_REF_CLK_C0.tcl 
source components/XCVR_PLL_0.tcl 
source components/XCVR_Block.tcl 
source components/TOP_SERDES.tcl 
source components/ROC.tcl 
build_design_hierarchy
