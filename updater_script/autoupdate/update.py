import os
import subprocess
import datetime
import time

cfg = {}

with open("/usr/share/scripts/autoupdate/autoupd.config", "r") as f:
    lines = f.read().split("\n")
    for line in [lines[i] for i in range(len(lines)) if lines[i] != ""]:
        lineparts = line.split("=")
        var, val = [lineparts[0], "".join(lineparts[1:])]
        cfg.update({var: val})

def update_changes():
    timestamp = datetime.datetime.fromtimestamp(time.time()).strftime('%Y-%m-%d %H:%M:%S')
    os.chdir(cfg.get("GIT_DIR"))
    print(subprocess.run(["./sync.sh", timestamp],encoding='utf-8', stdout=subprocess.PIPE))

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
