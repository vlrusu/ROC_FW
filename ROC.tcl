# Microsemi Tcl Script
# libero
# Date: Wed Jun 24 20:30:11 2020
# Directory C:\Users\vadim\Desktop
# File C:\Users\vadim\Desktop\exported.tcl

set project_folder_name ROC
set project_dir "./$project_folder_name"
set Libero_project_name ROC





proc create_new_project_label { }\
{
	puts "\n ---------------------------------------------------------------------------------------------------------"
	puts "Sean Connery says: Creating a new project for the ROC."
	puts "--------------------------------------------------------------------------------------------------------- \n"
}



proc project_exists { }\
{
	puts "\n ---------------------------------------------------------------------------------------------------------"
	puts "Sean Connery says: Error - A project exists for the ROC in this folder"
	puts "--------------------------------------------------------------------------------------------------------- \n"
}


if {[file exists $project_dir] == 1} then {
    project_exists
} else {
    create_new_project_label
    new_project -location $project_dir -name $Libero_project_name -project_description {} -block_mode 0 -standalone_peripheral_initialization 0 -instantiate_in_smartdesign 1 -ondemand_build_dh 1 -hdl {VHDL} -family {PolarFire} -die {MPF300TS} -package {FCG484} -speed {STD} -die_voltage {1.0} -part_range {IND} -adv_options {IO_DEFT_STD:LVCMOS 1.8V} -adv_options {RESTRICTPROBEPINS:1} -adv_options {RESTRICTSPIPINS:0} -adv_options {SYSTEM_CONTROLLER_SUSPEND_MODE:0} -adv_options {TEMPR:IND} -adv_options {VCCI_1.2_VOLTR:IND} -adv_options {VCCI_1.5_VOLTR:IND} -adv_options {VCCI_1.8_VOLTR:IND} -adv_options {VCCI_2.5_VOLTR:IND} -adv_options {VCCI_3.3_VOLTR:IND} -adv_options {VOLTR:IND}

    source ./ROC_recursive.tcl



    puts "\n ---------------------------------------------------------------------------------------------------------"
    puts "Applying Design Constraints..."
    puts "--------------------------------------------------------------------------------------------------------- \n"



    import_files -io_pdc ./constraints/io/io_constraints.pdc
    import_files -io_pdc ./constraints/io/user.pdc

    import_files -sdc ./constraints/ROC_derived_constraints.sdc
    import_files -sdc ./constraints/timing_user_constraints.sdc
    import_files -sdc ./constraints/timing_pr.sdc
    
    import_files -fp_pdc ./constraints/fp/fp_constraints.pdc
    import_files -fp_pdc ./constraints/fp/user.pdc


    set_root ROC


    # #Associate SDC constraint file to Place and Route tool

    organize_tool_files -tool {PLACEROUTE} \
	-file $project_dir/constraint/io/io_constraints.pdc \
	-file $project_dir/constraint/io/user.pdc \
	-file $project_dir/constraint/ROC_derived_constraints.sdc \
	-file $project_dir/constraint/timing_user_constraints.sdc \
	-file $project_dir/constraint/timing_pr.sdc \
	-file $project_dir/constraint/fp/fp_constraints.pdc \
	-file $project_dir/constraint/fp/user.pdc \
	-module {ROC::work} -input_type {constraint}



    organize_tool_files -tool {SYNTHESIZE} \
	-file $project_dir/constraint/ROC_derived_constraints.sdc \
	-module {ROC::work} -input_type {constraint}



    organize_tool_files -tool {VERIFYTIMING} \
	-file $project_dir/constraint/ROC_derived_constraints.sdc \
	-file $project_dir/constraint/timing_user_constraints.sdc \
	-file $project_dir/constraint/timing_pr.sdc \
	-module {ROC::work} -input_type {constraint}





    run_tool -name {CONSTRAINT_MANAGEMENT}

    derive_constraints_sdc



    puts "\n ---------------------------------------------------------------------------------------------------------"
    puts "Design Constraints Applied."
    puts "--------------------------------------------------------------------------------------------------------- \n"


    

    save_project



}


