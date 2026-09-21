import os
import subprocess
import datetime
import time
import argparse

parser = argparse.ArgumentParser(description='ConfigSync V1')

# parser.add_argument('--msg', action="store", dest='msg', default="0")
parser.add_argument("-m", "--msg", type=str, default="", help="Custom Commit Message")
args = parser.parse_args()

cfg = {}

print(args)

with open("/usr/share/scripts/autoupdate/autoupd.config", "r") as f:
    lines = f.read().split("\n")
    for line in [lines[i] for i in range(len(lines)) if lines[i] != ""]:
        lineparts = line.split("=")
        var, val = [lineparts[0], "".join(lineparts[1:])]
        cfg.update({var: val})

def update_changes():
    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    os.chdir(cfg.get("GIT_DIR"))
    msg = ""
    if args.msg != "" or args.msg != "0":
        msg = args.msg
    print(subprocess.run([f"./sync.sh", timestamp, msg],encoding='utf-8', stdout=subprocess.PIPE))

def check_changes():
    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    os.chdir(cfg.get("GIT_DIR"))
    data = str(subprocess.run(["git", "status"],encoding='utf-8', stdout=subprocess.PIPE))
    if "nothing to commit, working tree clean" in data:
        print(f"Up to date. (checked at '{timestamp}')")
    else:
        print(f"Changes detected. Pushing changes... (checked at '{timestamp}')")
        update_changes()
        print(f"Ran sync. Done at '{timestamp}'")

check_changes()    
