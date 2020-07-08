#Importing and Linking all the HDL source files used in the design
import_files -library work -hdl_source hdl/DIGISERDES_Controller.vhd
import_files -library work -hdl_source hdl/serdesmux.vhd
import_files -library work -hdl_source hdl/SerdesRxController.vhd
import_files -library work -hdl_source hdl/EWMaker.vhd
import_files -library work -hdl_source hdl/TWIMaster.vhd
import_files -library work -hdl_source hdl/Registers.vhd
import_files -library work -hdl_source hdl/TVS_Cntrl.v
import_files -library work -hdl_source hdl/counter32.v
