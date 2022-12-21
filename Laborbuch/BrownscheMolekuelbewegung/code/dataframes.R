# Einlesen dere Python Daten
data_pixel = read.csv('Tabellen/out_clean_bezug.csv', skip = 1, header=FALSE)

# Umbenennung der Spalten
colnames = c("Frame", "X 1", "y 1", "dp 1", "X 2", "y 2", "dp 2", "X 3", "y 3", 
             "dp 3", "X 4", "y 4", "dp 4", "X 5", "y 5", "dp 5", "X 6", "y 6", 
             "dp 6", "X 7", "y 7", "dp 7", "X 8", "y 8", "dp 8", "X 9", "y 9", 
             "dp 9", "X 10", "y 10", "dp 10", "X 11", "y 11", "dp 11", "X 12", 
             "y 12", "dp 12", "X 13", "y 13", "dp 13", "X 14", "y 14", "dp 14", 
             "X 15", "y 15", "dp 15", "X 16", "y 16", "dp 16", "X 17", "y 17", 
             "dp 17")
colnames(data_pixel) = colnames
rownames(data_pixel) = data_pixel$Frame

# Subsetting
# x-Werte
x_pixel = data_pixel[,seq(2, ncol(data_pixel )-2, by=3)]
# y-Werte
y_pixel = data_pixel[,seq(3, ncol(data_pixel )-1, by=3)]

# Umdrehen der y-Werte (wegen des strangen opencv-koordinatensystems)
y_pixel = y_pixel * -1 + 1200

calculateDistance1D(data_pixel$`X 14`)
plot(x_pixel$`X 14`, y_pixel$`y 14`, type = "l")

# Speichern der Werte in Pixeln
write.csv(x_pixel, "Tabellen/x_pixel.csv", row.names=FALSE)
write.csv(y_pixel, "Tabellen/y_pixel.csv", row.names=FALSE)

# Umrechnung der Entfernung in Pixeln in Meter
Umrechnungsfaktor <- 2*10**(-6)/16
x_meter = x_pixel * Umrechnungsfaktor
y_meter = y_pixel * Umrechnungsfaktor
write.csv(x_meter, "Tabellen/x_meter.csv", row.names=FALSE)
write.csv(y_meter, "Tabellen/y_meter.csv", row.names=FALSE)

### Funktion zur Berechnung der Schrittweiten, spaltenweise
calculateDistance1D = function(vector){
  shift_vector = c(0, vector[1:(length(vector)-1)])
  dist = vector-shift_vector
  dist[1] = 0
  return(dist)
}

# Erstellung eines Dataframes der Schrittweiten 
dx_meter<-data.frame(x_meter)
dy_meter<-data.frame(y_meter)
for (i in 1:17) {
  dx_meter[,i] = calculateDistance1D(x_meter[,i])
  dy_meter[,i] = calculateDistance1D(y_meter[,i])
}

# Vorzeichenbehandlung
vx <- dx_meter>=0
vy <- dy_meter>=0
v <- vx==vy
v[v==TRUE] <- 1
v[v==0] <- -1

d_meter <- sqrt(dx_meter**2+dy_meter**2)*v
write.csv(d_meter, "Tabellen/d_meter.csv", row.names=FALSE)
