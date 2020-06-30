#This Tcl file sources other Tcl files to build the design(on which recursive export is run) in a bottom-up fashion

#Sourcing the Tcl file in which all the HDL source files used in the design are imported or linked
source hdl_source.tcl
build_design_hierarchy

#Sourcing the Tcl files in which HDL+ core definitions are created for HDL modules
source components/axi4dma_init.tcl 
source components/fifo_mem_cntrl.tcl 
source components/pattern_gen_checker.tcl 
source components/SerdesRxController.tcl 
source components/Registers.tcl 
source components/ForwardDetector.tcl 
source components/PacketSender.tcl 
source components/RocMonitor.tcl 
source components/CommandHandler.tcl 
build_design_hierarchy

#Sourcing the Tcl files for creating individual components under the top level
source components/COREJTAGDEBUG_C0.tcl 
source components/AXI4_Interconnect.tcl 
source components/CoreAXI4_Lite.tcl 
source components/CoreDMA_Controller.tcl 
source components/MEMFIFO.tcl 
source components/PF_DDR3_Cntrl.tcl 
source components/SRAM_AXI.tcl 
source components/TEMPFIFO.tcl 
source components/TPSRAM.tcl 
source components/DDRInterface.tcl 
source components/DAQFIFO.tcl 
source components/DIGIFIFO.tcl 
source components/RxFIFO.tcl 
source components/RxFIFOReset.tcl 
source components/TxIF.tcl 
source components/TxPLL.tcl 
source components/TxRefCLK.tcl 
source components/serdes.tcl 
source components/DIGIINTERFACE.tcl 
source components/Init_Monitor.tcl 
source components/MIV_RV32IMC_C0.tcl 
source components/PF_SRAM.tcl 
source components/ROC_CCC.tcl 
source components/APB3.tcl 
source components/GPIO.tcl 
source components/PREAMPSPI.tcl 
source components/SPI0.tcl 
source components/PF_TVS_C0.tcl 
source components/PF_URAM_C0.tcl 
source components/TVS_Interface.tcl 
source components/UARTapb.tcl 
source components/pwm.tcl 
source components/sysservices.tcl 
source components/SLOWCONTROLS.tcl 
source components/ALGO_CLK_PLL_0.tcl 
source components/Ctrl_clk.tcl 
source components/DCS_FIFO.tcl 
source components/FIFO.tcl 
source components/FIFO_Response.tcl 
source components/Oscillator1.tcl 
source components/CORERESET_PF_C1.tcl 
source components/ResetController.tcl 
source components/Retransmit_RAM.tcl 
source components/CorePCS_C0.tcl 
source components/PF_XCVR_ERM_C0.tcl 
source components/PF_XCVR_REF_CLK_C0.tcl 
source components/XCVR_PLL_0.tcl 
source components/XCVR_Block.tcl 
source components/TOP_SERDES.tcl 
source components/TrackerCCC.tcl 
source components/pf_reset.tcl 
source components/ROC.tcl 
build_design_hierarchy
