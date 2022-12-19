# Dependencies
from sklearn.cluster import KMeans
import numpy as np
import cv2 as cv
import matplotlib.pyplot as plt
import os
import numpy as np
import pandas as pd
import math

# Definition of clustering-methode
# INPUT: Coordinates
# OUTPUT: Centercoordinates of 7 clusters
def cluster(X):
    kmeans = KMeans(n_clusters=17, n_init=10)
    kmeans.fit(X)

    centers = kmeans.cluster_centers_
    return(centers)

# Definition of image manipulation-methode
# INPUT: RGB image
# OUTPUT: Binary mask of image
def image_manipulation(eimage):
    # Converting to greyscale
    sw = cv.cvtColor(eimage, cv.COLOR_BGR2GRAY)
    # Addaptive thresholding
    ad_thresh = cv.adaptiveThreshold(sw, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY, 211, 70)
    # Creating binary mask
    (thresh, binary) = cv.threshold(ad_thresh, 127, 255, cv.THRESH_BINARY)
    # Return binary mask
    return(binary)

# Definition of draw-points-on-image-methode
# INPUT: Image
# OUTPUT: Image with dots at specified coordinates
def draw_points(image, co, width=5, color = (0, 0, 255)):
    for row in range(0, co.shape[0]):
        center_coordinates = (int(co.loc[row, "Y"]), int(co.loc[row, "X"]))
        image[(int(co.loc[row, "X"])-width):(int(co.loc[row, "X"])+width), 
              (int(co.loc[row, "Y"])-width):(int(co.loc[row, "Y"])+width)] = color
    return(image)

# Show image-function
def display_image(image, scale):
    if ret:
        small = cv.resize(frame, (0,0), fx=scale, fy=scale) 
        cv.imshow('frame', small)

### Main
imagenr = 0
pointnr = 17
table = pd.DataFrame({'X' : [], 'Y':[], 'Label':[], 't': []})
paths = {}

# Take note of original workingdirectory owd
owd = os.getcwd()
# Change into new workingdirectory
wd = os.path.dirname(os.path.realpath(__file__))
os.chdir(wd)

# Read video
cap = cv.VideoCapture('../Daten/styrolpartikel/1.avi')
length = int(cap.get(cv.CAP_PROP_FRAME_COUNT))
# Set speed
frame_period = 1  # 1000msec - assume frame rate is about 1Hz

# Loop over every frame
while(cap.isOpened()):
                
    print(f'Progress: {round(imagenr/length*100)}%')
    # Increment iterator
    imagenr += 1
    
    # Try reading new frame
    try:
        ret, frame = cap.read()
        frame_binary= image_manipulation(frame)
    except:
        break

    # Detect clustercenters
    clusters = cluster(np.column_stack(np.where(frame_binary < 1)))
    # Turn numpy-array of centers into pd-dataframe
    coords = pd.DataFrame(clusters, columns = ['X','Y'])
    # Make column 'tuple' with shortform of xy-coordinates
    coords['tuple'] = list(coords.itertuples(index=False, name=None))

    # Strange part
    if not paths:
        paths = {k: [] for k in range(0, pointnr)}
        for key in range(0, pointnr):
            paths[key] = [(coords.loc[key, 'tuple'][0], coords.loc[key, 'tuple'][1], 0)]
    else:
        for key in paths.keys():
            x1 = paths[key][-1][0]
            y1 = paths[key][-1][1]
            dist = np.sqrt((coords['X']-x1)**2+(coords['Y']-y1)**2)
            closest_position = dist.argmin()
            match = coords.loc[closest_position, 'tuple']
            paths[key].append((match[0], match[1], str(min(dist))))

    # Add new line to master-table
    pd.concat([table, coords], ignore_index=True)
    # Draw points on and display image
    frame = draw_points(frame, coords)
    display_image(frame, scale=0.6)

    # Delay or break video
    if cv.waitKey(frame_period) & 0xFF == ord('q'):
        break

# Save file
mf = pd.DataFrame(paths)
mf.to_csv('out.csv') 

# Editing of the produced csv-file. Not pretty but works.
text = open("out.csv", "r")
text = ''.join([i for i in text]).replace("(", "").replace(")", "").replace('"', "").replace(" ", "").replace("'", "")
x = open("out_clean.csv","w")
x.writelines(text)
x.close()

# Change back to owd
os.chdir(owd)
