#This Tcl file sources other Tcl files to build the design(on which recursive export is run) in a bottom-up fashion

#Sourcing the Tcl file in which all the HDL source files used in the design are imported or linked
source hdl_source.tcl
build_design_hierarchy

#Sourcing the Tcl files in which HDL+ core definitions are created for HDL modules
source components/Registers.tcl 
build_design_hierarchy

#Sourcing the Tcl files for creating individual components under the top level
source components/COREJTAGDEBUG_C0.tcl 
source components/DigiReaderFIFO.tcl 
source components/LiteFast_C1.tcl 
source components/TokenFIFO.tcl 
source components/LiteFastRXwrapper.tcl 
source components/COREFIFO_C0.tcl 
source components/LiteFast_C0.tcl 
source components/LiteFastTXwrapper.tcl 
source components/ROCFIFO.tcl 
source components/TransceiverIF.tcl 
source components/TxPLL.tcl 
source components/TxRefCLK.tcl 
source components/SerdesIF.tcl 
source components/DIGIINTERFACE.tcl 
source components/Init_Monitor.tcl 
source components/MIV_RV32IMC_C0.tcl 
source components/PF_CLK_DIV_C0.tcl 
source components/PF_OSC_C0.tcl 
source components/PF_SRAM.tcl 
source components/ROC_CCC.tcl 
source components/APB3.tcl 
source components/GPIO.tcl 
source components/PREAMPSPI.tcl 
source components/SPI0.tcl 
source components/SPI_KEY.tcl 
source components/PF_TVS_C0.tcl 
source components/PF_URAM_C0.tcl 
source components/TVS_Interface.tcl 
source components/UARTapb.tcl 
source components/pwm.tcl 
#source components/sysservices.tcl 
source components/SLOWCONTROLS.tcl 
source components/TrackerCCC.tcl 
source components/pf_reset.tcl 
source components/ROC.tcl 
build_design_hierarchy
