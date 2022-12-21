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
# Teilchen2
spalten = 2
distances = c()
for (col in spalten){
  walk = calculateDistance1D(d_meter[, col])
  distances = append(distances, walk)
} 
T2 <- distances
mean2 <- mean(distances)
sd2 <- sd(distances)

# Schnelle Teilchen
spalten = c(1, 2, 4, 6, 10)
distances = c()
for (col in spalten){
  walk = calculateDistance1D(d_meter[, col])
  distances = append(distances, walk)
} 
TSchnell <- distances 
meanSchnell <- mean(distances)
sdSchnell <- sd(distances)

# Langsame Teilchen
spalten = c(3, 5, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17)
distances = c()
for (col in spalten){
  walk = calculateDistance1D(d_meter[, col])
  distances = append(distances, walk)
} 
TLangsam <- distances 
meanLangsam <- mean(distances)
sdLangsam <- sd(distances)

# Alle
distances = c()
for (col in 1:17){
  walk = calculateDistance1D(d_meter[, col])
  distances = append(distances, walk)
} 
TAlle <- distances 

### Plotten
# Plottingparameter
par(mfrow=c(2,2))
nbreaks = 15

# Funktion zum plotten der Histogramme
histogram <- function(vektor, title){
  h <- hist(vektor, breaks=nbreaks, main=title,
            xlab="Weite eines Random-walks [m]", 
            ylab = "Häufigleit")
  x2 <- seq(min(vektor), max(vektor), length = 40)
  fun <- dnorm(x2, mean = mean(vektor), sd = sd(vektor))
  fun <- fun * diff(h$mids[1:2]) * length(vektor)
  lines(x2, fun, lwd = 2)
  legend("topright",
         legend=c(paste("Mittelwert: ", round(mean(vektor),9)), 
                  paste("Standardabweichung: ", round(sd(vektor), 9)))
  )
}

# Ausgabe
histogram(T2, "1) Histogramm der Random-Walk-Schrittweite Teilchen 2")
histogram(TSchnell, "2) Histogramm der Random-Walk-Schrittweite der viel bewegten Teilchen")
histogram(TLangsam, "3) Histogramm der Random-Walk-Schrittweite der wenig bewegten Teilchen")
histogram(TAlle, "4) Histogramm der Random-Walk-Schrittweite aller Teilchen")
