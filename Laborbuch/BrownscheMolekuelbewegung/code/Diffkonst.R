### Einlesen des Random-Walk-Schrittweiten (RWS) Dataframes
d_meter <- read.csv('Tabellen/d_meter.csv')
# Eingabe Zeitlicher Abstand zwischen zwei Aufnahmen
t = 1 #s
# Berechnung der Standardabweichung aller 17 RWS
sigma <- apply(d_meter,2,sd)
# Funktion zum Berechnen der Diffusionskonstante
funcDiff <- function(c) c**2/(2*t)
# Berechnung der Diffusionskonstante
Diffusionskonstanten <- data.frame(Diffusionskonstante=funcDiff(sigma))
# Ausgabe als Dataframe
rownames(Diffusionskonstanten) = paste("T", 1:17)
colnames(Diffusionskonstanten) = "Diffusionskonstante D [m²/s]"
