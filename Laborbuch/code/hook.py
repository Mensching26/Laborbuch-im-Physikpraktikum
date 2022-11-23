import os
import pandas

# Take note of original workingdirectory (owd)
owd = os.getcwd()

# Change into script-Directory
os.chdir(os.path.split(__file__)[0])

# Read list of chapters
chap_list = pandas.read_csv('chapters.txt', header=None)

# For each chapter...
for chapter in chap_list.values.tolist()[0]:
    # ... change into chapters directory
    os.chdir(chapter)
    # List directory
    dir = os.listdir()
    # Search first tex-file
    texfile = dir[[i for i in range(len(dir)) if dir[i].endswith(".tex")][0]]
    # Read tex-file
    with open(texfile, 'r') as file :
        filedata = file.read()
    # Replace strings
    filedata_c = filedata.replace('% Options for packages loaded elsewhere', r'\documentclass[class=article, crop=false]{standalone}'+'\n'+r'\usepackage[subpreambles=false]{standalone}'+'\n'+r'\usepackage{import}'+'\n'+'% Options for packages loaded elsewhere')
    filedata_c = filedata_c.replace('%\n'+r'\documentclass'+'[\n  9pt,\n]{article}', '\n')
    filedata_c = filedata_c.replace('\maketitle', '')
    # Save tex-file
    with open(f"{texfile[:-4]}_hooked.tex", 'w') as file:
        file.write(filedata_c)
    # Printout
    if filedata != filedata_c:
        print(f"Hooked {os.path.abspath(texfile)}")

# Change back to owd
os.chdir(owd)