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
        oldi = 0
        newi = 0
        ignore = 0
        changed = 0
        while newi < len(newer_lines) and oldi < len(old_lines):
          nline = newer_lines[newi]
          oline = old_lines[oldi]
          if not oline in newer_lines[newi:]:
            oldi += 1
            changed += 1
          elif nline == oline:
            fout.write(nline)
            newi += 1
            oldi += 1
          elif not nline in old_lines[oldi:]:
            fout.write(nline)
            newi += 1
            changed += 1
          else:
            fout.write(oline)
            oldi += 1
            newer_lines.pop(newer_lines.index(oline))
            ignore += 1
        for i in range(newi,len(newer_lines)):
          nline = newer_lines[newi]
          fout.write(nline)
          changed += 1

        #fout = open(old_path,"w")
        #for line in newer_lines:
        #    fout.write(line)
        #fout.close()
        #os.system("rm temp.patch")
        #os.system("git diff %s > temp.patch" % (old_path))
        #fpatch = open("temp.patch")
        #plines = fpatch.readlines()
        #if len(plines) > 0:
        #  import pdb;pdb.set_trace()
        #  ignore = []
        #  for i in range(len(plines)):
        #    for j in range(i+1,len(plines)):
        #      if plines[j].startswith('diff'): 
        #        pass
        #      else:
        #        if [plines[i][0],plines[j][0]] in [['+','-'],['-','+']] and plines[i][1:] == plines[j][1:]:
        #          ignore.append(i)
        #          ignore.append(j)
        #  fpatch.close()
        #  os.system("rm temp2.patch")
        #  fpatch2 = open("temp2.patch","w")
        #  for i in range(len(plines)):
        #    if not i in ignore:
        #      fpatch2.write(plines[i])
        #  fpatch2.close()
        #  os.system("git checkout %s > /dev/null" % (old_path))
        #  os.system("git apply temp2.patch")

        if changed+ignore > 0:
          print("Changed",basefn,changed,"(ignored",ignore,"changes)")
