import subprocess

p = subprocess.Popen(["Rscript","fmr.R"], stdout=subprocess.PIPE)
stdout, stderr = p.communicate()
print(stdout.decode())
