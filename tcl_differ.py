import glob
import os
from shutil import copyfile
import sys
import filecmp

old_dir = sys.argv[1]
new_dir = sys.argv[2]

old_files = glob.glob(os.path.join(old_dir,"*.tcl"))
new_files = glob.glob(os.path.join(new_dir,"*.tcl"))

for new_path in new_files:
    basefn = os.path.basename(new_path) 
    old_path = os.path.join(old_dir,basefn)
    if not old_path in old_files:
        print("New file",basefn)
        copyfile(new_path, old_path)

for old_path in old_files:
    basefn = os.path.basename(old_path) 
    new_path = os.path.join(new_dir,basefn)
    if not new_path in new_files:
        os.remove(old_path)
        print("Deleted file",basefn)
    elif not filecmp.cmp(old_path,new_path):
        old_lines = open(old_path).readlines()
        new_lines = open(new_path).readlines()
        old_connect_pins = []
        old_pin_groups = []
        for line in old_lines:
            if line.startswith("sd_create_pin_group"):
                pg = {'group': line.split(" -pin_names")[0],'pins':[],'line':line}
                for pin in line.rstrip().split(" -pin_names {")[-1].split(" }")[0].split(" "):
                    pg['pins'].append(pin)
                old_pin_groups.append(pg)
            if line.startswith("sd_connect_pins"):
                pins = {'line':line,'pins':[]}
                for pin in line.rstrip().split(" -pin_names {")[-1].split(" }")[0].split(" "):
                    pins['pins'].append(pin)
                old_connect_pins.append(pins)
        changed = False
        newer_lines = []
        for line in new_lines:
            if line.startswith("sd_create_pin_group"):
                pg = {'group': line.split(" -pin_names")[0],'pins':[]}
                for pin in line.rstrip().split(" -pin_names {")[-1].split(" }")[0].split(" "):
                    pg['pins'].append(pin)
                if pg['group'] in old_pin_groups:
                    if set(pg['pins']) == set(old_pin_groups[pg['group']]['pins']):
                        newer_lines.append(old_pin_groups[pg['group']]['line'])
                    else:
                        newer_lines.append(line)
                else:
                    newer_lines.append(line)
            elif line.startswith("sd_connect_pins"):
                pins = []
                for pin in line.rstrip().split(" -pin_names {")[-1].split(" }")[0].split(" "):
                    pins.append(pin)
                found = False
                for i in range(len(old_connect_pins)):
                    if set(pins) == set(old_connect_pins[i]['pins']):
                        found = True
                        newer_lines.append(old_connect_pins[i]['line'])
                        break
                if not found:
                    newer_lines.append(line)
            else:
                newer_lines.append(line)
        fout = open(old_path,"w")
        for line in newer_lines:
            fout.write(line)
        fout.close()

        print("Changed",basefn)
