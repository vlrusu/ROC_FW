#Importing and Linking all the HDL source files used in the design
import_files -library work -hdl_source hdl/DigiReaderSM.vhd
import_files -library work -hdl_source hdl/SerdesRxController.vhd
import_files -library work -hdl_source hdl/SerdesTxController.vhd
import_files -library work -hdl_source hdl/SerdesInitializer.vhd
import_files -library work -hdl_source hdl/SerdesStatus.vhd
import_files -library work -hdl_source hdl/EWMaker.vhd
import_files -library work -hdl_source hdl/TWIMaster.vhd
import_files -library work -hdl_source hdl/Registers.vhd
import_files -library work -hdl_source hdl/TVS_Cntrl.v
import_files -library work -hdl_source hdl/counter32.v
