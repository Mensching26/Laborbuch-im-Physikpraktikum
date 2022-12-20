### Einlesen der darzustellenden Inhalte

x_pixel <-read.csv('Tabellen/x_pixel.csv')
y_pixel <-read.csv('Tabellen/y_pixel.csv')

xy <- data.frame(x=t(x_pixel[1,2:17]), y=t(y_pixel[1,2:17]))
plot(x=xy[,1], y=xy[,2], ylim=c(0, 1200))

### Plottingvariablen
# Positionierung des Maßstabes
xm = 50
ym = 0

# Auswahl des genauer untersuchten Teilchens
nr= 2

# Fenstergröße in pixel
ww = 1290

# Plottingarameter
par(mfrow=c(1,2), mar=c(5,4,4,2))
#png(filename="Plots/Raumplot.png"){
# Leerer Hauptplot
plot(x=0:ww, y=0:ww, asp=1, col = "transparent", 
     xlab = 'x-Position in Pixel', ylab = 'y-Position in Pixel', 
     main = "Pfade aller Polystyrolpartikel")

# Hinzufügen eines Maßstabes mit Beschriftung
arrows(x0=xm, y0=ym, x1=(xm+80), y1=ym, angle=90, length=0.05)
arrows(x0=(xm+80), y0=ym, x1=xm, y1=ym, angle=90, length=0.05)
text(x=xm+25, y=ym, labels = "10µm", pos = 1, cex = 1)

# Hinzufügen einer Box um das näher zu betrachtende PSP
rect(max(x_pixel[,nr]), min(y_pixel[,nr]), min(x_pixel[,nr]),
     max(y_pixel[,nr]), border="red", lwd=2)

# Hinzufügen einer Legende
legend("bottomright",
      legend=c("Anfangsposition",
               "Endposition",
               "Ausgewählter PSP"),
      pch=c(20, 20, 0), cex=1.3,
      col=c("firebrick3", "darkblue", "red"))
# Einzeichnen der Diffusionsphfade und Anfange- bzw. Endpunkte
for (i in 1:17){
 points(x=x_pixel[1,i], y=y_pixel[1,i], col = "red", pch = 20, cex=2)
 text(x=x_pixel[1,i], y=y_pixel[1,i], pos=3, labels=paste("T", i))
 points(x=x_pixel[nrow(y_pixel),i], y=y_pixel[nrow(x_pixel),i], col = "darkblue", pch = 20, cex=2)
 points(x_pixel[,i], y_pixel[,i], type="l")
}

# Plot walk of a partikle
plot(x=x_pixel[,nr], y=y_pixel[,nr], type = "l", asp = 1,
   xlab = "x-Position in Pixel", ylab = "y-Position in Pixel",
   main="Pfad des markierten Teilchens")
points(x=x_pixel[1,nr], y=y_pixel[1,nr], cex = 2, col = "firebrick3", pch=20)
points(x=x_pixel[100,nr], y=y_pixel[100,nr], cex = 2, col = "darkblue", pch=20)

# Hinzufügen eines Maßstabes mit Beschriftung
xm = 1020
ym = 1100
arrows(x0=xm, y0=ym, x1=(xm+40), y1=ym, angle=90, length=0.05)
arrows(x0=(xm+40), y0=ym, x1=xm, y1=ym, angle=90, length=0.05)
text(x=xm+2, y=ym, labels = "5µm", pos = 1, cex = 1)

# Abschalten des Graphicdevice
# dev.off()
}
