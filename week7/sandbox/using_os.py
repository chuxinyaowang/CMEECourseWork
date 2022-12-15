""" This is blah blah"""

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for directories in dir:
        if directories.startswith("C"):
            FilesDirsStartingWithC.append(directories)
    for file in files:
        if file.startswith("C"):
            FilesDirsStartingWithC.append(file)
  
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
FilesDirsStartingWithCc = []
for (dir, subdir, files) in subprocess.os.walk(home):
    for directories in dir:
        if dir.startswith("C"):
            FilesDirsStartingWithCc.append(directories)
        if dir.startswith("c"):
            FilesDirsStartingWithCc.append(directories)

    for file in files:
        if files.startswith("C"):
            FilesDirsStartingWithCc.append(file)
        if files.startwith("c"):
            FilesDirsStartingWithCc.append(file)
#################################
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 

# Type your code here:
