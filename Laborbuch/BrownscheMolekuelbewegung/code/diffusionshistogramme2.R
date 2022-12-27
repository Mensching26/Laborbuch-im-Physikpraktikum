### Einlesen des Schrittweiten dataframes
x_meter <- read.csv('Tabellen/x_meter.csv')

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
  walk = calculateDistance1D(x_meter[, col])
  distances = append(distances, walk)
} 
T2 <- distances
mean2 <- mean(distances)
sd2 <- sd(distances)

### Plotten
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
histogram(T2, "Histogramm der Random-Walk-Schrittweite in x-Richtung von Teilchen 2")
