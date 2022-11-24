import os
import pandas

'''
Mittels dieses Programmes werden durch R-Markdown erstellte tex-Dateien dahingehend verändert, 
dass sich diese mittels des Latex-Paketes "standalone" zu einem Laborbuch zusammenfügen lassen.

Dafür wird die Dokumentklasse verändert und das Paket "standalone" sowie "import" hinzugefügt.
Einträge wie "\maketitle" werden entfernt. Die neue Datei wird als "_hooked" abgespeichert und 
kann als solche in ../src/main.tex eingebunden werden. 

Dieses Programm verändert tex-Dateien, deren Verzeichnisse als "../Verzeichnis" in der txt-Datei
"chapters" aufgelistet sind.
'''
# Take note of original workingdirectory (owd)
owd = os.getcwd()

# Change into script-Directory
os.chdir(os.path.split(__file__)[0])

# Read list of chapters
chap_list = pandas.read_csv('chapters.txt', header=None)

# For each chapter...
for chapter in chap_list.values.tolist():
    # ... change into chapters directory
    os.chdir(chapter[0])
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
