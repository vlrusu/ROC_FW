#Importing and Linking all the HDL source files used in the design
import_files -library work -hdl_source hdl/FIFO_converter_32to64b.v
import_files -library work -hdl_source hdl/MEMFIFO_RE_generator.v
import_files -library work -hdl_source hdl/REG_CTRL.v
import_files -library work -hdl_source hdl/counter32.v
import_files -library work -hdl_source hdl/data_ready_delay.v
import_files -library work -hdl_source hdl/delay.v
import_files -library work -hdl_source hdl/data_valid_generator.v
import_files -library work -hdl_source hdl/FIFO_MEM_CNTRL.v
import_files -library work -hdl_source hdl/PATTERN_GEN_CHECKER.v
import_files -library work -hdl_source hdl/memdata_switch.v
import_files -library work -hdl_source hdl/mux_dcs_sim.v
import_files -library work -hdl_source hdl/pattern_FIFO_cntrl.v
import_files -library work -hdl_source hdl/pattern_switch.v
import_files -library work -hdl_source hdl/pulse_generator.v
import_files -library work -hdl_source hdl/RxController.vhd
import_files -library work -hdl_source hdl/DigiReaderSM.vhd
import_files -library work -hdl_source hdl/EWMaker.vhd
import_files -library work -hdl_source hdl/TWIMaster.vhd
import_files -library work -hdl_source hdl/Registers.vhd
import_files -library work -hdl_source hdl/TVS_Cntrl.v
import_files -library work -hdl_source hdl/EventMarker.vhd
import_files -library work -hdl_source hdl/ClockAligner.vhd
import_files -library work -hdl_source hdl/INV_20bit.vhd
