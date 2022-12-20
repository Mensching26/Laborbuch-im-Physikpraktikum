### Einlesen des Schrittweiten dataframes
d_meter <- read.csv('Tabellen/d_meter.csv')

### Funktion zur Berechnung der Schrittweiten, spaltenweise
calculateDistance1D = function(vector){
  shift_vector = c(0, vector[1:(length(vector)-1)])
  dist = vector-shift_vector
  dist[1] = 0
  return(dist)
}

### Berechnung der Schrittweite der einzelnen random-walks
# Teilchen4
spalten = 4
distances = c()
for (col in spalten){
  walk = calculateDistance1D(d_meter[, col])
  distances = append(distances, walk)
} 
T4 <- distances
mean4 <- mean(distances)
sd4 <- sd(distances)

sd4**2/(2*1)


# Alle Teilchen
distances = c()
for (col in 1:17){
  walk = calculateDistance1D(d_meter[, col])
  distances = append(distances, walk)
} 
TAlle<- distances
meanAlle <- mean(distances)
sdAlle <- sd(distances)

sdAlle**2/(2*1)
