import sys,os
import shutil, errno

def copyanything(src, dst):
    for f in os.listdir(src):
        print(src+f)
        shutil.copy(src+f, dst)

loc = os.path.dirname(os.path.realpath(__file__)) 
verfile = loc + "/version"
targfile = loc + "/target"
levfile = loc + "/level"

with open(targfile) as file: target = next(file).rstrip()
with open(levfile) as file: level = next(file).rstrip()

with open(verfile) as file:
    old_version = int(next(file))
    version = old_version + 1
    
print("================== building version "+str(version)+" ==================")

with open(verfile, 'w') as file:
    file.write(str(version))
    file.close()

build = loc+"/build instance"+str(version)+" "+sys.argv[1]
os.system(build)

if len(sys.argv) == 4:
    olddir = loc+"/../runtime/volumes/instance"+str(old_version)+"/"+target+"/"+level+"/"+sys.argv[2]+"/"
    newdir = loc+"/../runtime/volumes/instance"+str(version)+"/"+target+"/"+level+"/"+sys.argv[3]
    copyanything(olddir,newdir)

print("================== version "+str(version)+" done ==================")
