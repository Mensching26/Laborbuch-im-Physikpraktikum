---
title: "Dehnbare Stoffe"
author: "Justus Weyers & Milena Mensching, Team 4"
date: "2022-11-17"
output:
  pdf_document: default
  html_document:
    df_print: paged
---
# Versuch 1

## Ziel

Überprüfung der Anwendbarkeit des Hookeschen Modells auf ein Gummiband durch Bestimmung der Federkonstante


## Materialien

* Stativ 
* Gummiband
* Gewichte
* Maßband
* Haken
* Klebeband

## Versuchsaufbau

* Aufstellung des Stativs, Befestigung am Tisch
* Befestigung des Hakens am Stativ
* Befestigung des Maßbandes am Stativ mit Hilfe von Klebeband
* Aufhängung des Gummibandes am Haken
* In das Gummiband werden die Gewichte gehängt

![Versuchsaufbau 1](C:/Users/milen/Documents/Studium/Physikpraktikum WiSe22,23/Laborbuch-im-Physikpraktikum/Laborbuch/Dehnbare Stoffe/Bilder/Versuch 1, Bild 2.jpeg)

![Versuchsaufbau 1, Nahansicht](C:/Users/milen/Documents/Studium/Physikpraktikum WiSe22,23/Laborbuch-im-Physikpraktikum/Laborbuch/Dehnbare Stoffe/Bilder/Versuch 1, Bild 1.jpeg)


## Durchführung

Die Gewichte werden gewogen und die Messunsicherheiten berechnet.
Gewichte:

```r
Gewichte <- read.csv("Gewichte.csv", sep=";", dec=",")
Gewichte[,c(1,2)]
```

```
##        Name Masse..g.
## 1        5g       4.8
## 2  10g (2x)      10.0
## 3       20g      19.8
## 4       50g      49.9
## 5 100g (2x)      99.5
## 6      200g     198.5
```

Messunsicherheiten: 
$$u_m=\frac{a}{2\sqrt{3}}= \frac{0,0001kg}{2\sqrt{3}}=2,9*10^{-5}kg$$
Zunächst wird die Länge des Gummibandes ohne zusätzliches Gewicht gemessen. Die Länge betrug 11,2 cm. Diese Länge muss später von allen Messwerten abgezogen werden, um nur die Auslenkung aus dem Nullzustand als Datensatz aufzunehmen.

Danach werden nacheinander verschiedene Gewichte an das Gummiband gehängt und die entsprechende Auslenkung gemessen. Unsere Gruppe entschied sich zunächst dafür, eine Messreihe mit Intervalen von 5g durchzuführen. Nach den ersten 20 Messungen (100g) entschieden wir uns dafür, die Intervalle auf 10g zu erhöhen, da wir zunächst den Aufwand unterschätzten und Daten mit einem Abstand von 10g immer noch zur Beurteilung der Federkonstante ausreichen.

Die Auslenkung wird am Maßband abgelesen (Messskala in mm). Dies bedeutet eine Ungenauigket der Skala von:
$$u_{Skala}=\frac{a}{2\sqrt{6}}= \frac{0,001m}{2\sqrt{6}}=2,0*10^{-4}m$$

## Fehlerquellen
Bei den Fehlerquellen ist zunächst der **personenbezogene Ablesefehler** zu erwähnen. Diesen versuchten wir weitestgehend zu eliminieren, indem nur eine Person eine vollständige Datenreihe aufnahm.\

Eine weitere Fehlerquelle kann die **Zeitabhängigkeit der Auslenkung** sein. Ein Gummiband kann nach einer gewissen Zeit mehr nachgeben, als bei der direkten Messung. Wir haben uns bemüht, die Messungen sehr direkt und ohne Verzug vorzunehmen. Die Zeitanghängigkeit haben wir jedoch nicht näher untersucht.\

Besonders wichtig ist zu erwähnen, dass die Länge $x_0$ am Anfang und am Ende nicht übereinstimmten (11,2cm am Anfang zu 11,6cm am Ende). Dies ist auf die **konstante Dehnung des Gummibandes** zurückzuführen und wurde ebenfalls bei der Messung vernachlässigt.


## Messung
Unsere Messergebnisse sind als csv-Datei abgespeichert:


```r
Messreihe <- read.csv("Messreihe.csv", sep=";", dec=",")
colnames(Messreihe)=c("Gewicht", "Auslenkung1",  "Auslenkung2", "a", "b")
Messreihe[,c(1,2)]
```

```
##    Gewicht Auslenkung1
## 1        0        11.2
## 2        5        13.0
## 3       10        13.3
## 4       15        13.5
## 5       20        13.6
## 6       25        13.8
## 7       30        13.8
## 8       35        13.9
## 9       40        14.0
## 10      45        14.1
## 11      50        14.0
## 12      55        14.1
## 13      60        14.2
## 14      65        14.3
## 15      70        14.4
## 16      75        14.5
## 17      80        14.5
## 18      85        14.6
## 19      90        14.6
## 20      95        14.7
## 21     100        14.8
## 22     110        15.1
## 23     120        15.3
## 24     130        15.4
## 25     140        15.6
## 26     150        15.8
## 27     160        16.0
## 28     170        16.4
## 29     180        16.6
## 30     190        16.9
## 31     200        17.3
## 32     210        17.5
## 33     220        17.8
## 34     230        18.2
## 35     240        18.5
## 36     250        18.9
## 37     260        19.3
## 38     270        19.8
## 39     280        20.0
## 40     290        20.3
## 41     300        20.9
## 42     310        21.2
## 43     320        21.5
## 44     330        22.0
## 45     340        22.3
## 46     350        22.7
## 47     360        23.0
## 48     370        23.3
## 49     380        23.6
## 50     390        23.9
## 51     400        24.5
## 52     410        24.7
## 53     420        25.0
## 54     430        25.2
## 55     440        25.5
## 56     450        25.7
## 57     460        26.1
## 58     470        26.2
## 59     480        26.5
## 60     490        26.8
```



## Auswertung
Zur besseren Interpretation der Messergebnisse wird die Anfangshöhe des Gummibandes als Nullauslenkung $x_0$ definiert und von den anderen Messwerten subtrahiert. 
Da die wirkende Kraft die Gewichtskraft $F=m*g$ ist gilt folgende Formel:

$$F = m * g = D*x$$
$$\rightarrow D =\frac{m*g}{x}$$
Die Unsicherheit ergibt sich daher aus folgender Formel:

$$u_D=\sqrt{(\frac{\partial{D}}{\partial{m}}*u_m)^2+(\frac{\partial{D}}{\partial{x}}*u_x)^2}$$
Mit:
$$\frac{\partial{D}}{\partial{m}} = \frac{g}{x}$$
$$\frac{\partial{D}}{\partial{x}} = -\frac{m*g}{x^2}$$
$$u_D=\sqrt{(\frac{g}{x}*u_m)^2+(-\frac{m*g}{x^2}*u_x)^2}$$



```r
# Erdbeschleunigung
g = 9.81 #m/s^2
u_m = 2.9*10**(-5) #kg
u_x = 2.0*10**(-4) #m

# Daten einlesen
Messreihe <- read.csv("Messreihe.csv", sep=";", dec=",")
colnames(Messreihe)=c("Gewicht", "Auslenkung1",  "Auslenkung2", "a", "b")

# Nullwerte abziehen
# Messreihe$Auslenkung1 <- Messreihe$Auslenkung1 - 11.2

# Einheitenrechnung
# Messreihe$Gewicht <- Messreihe$Gewicht/1000 #kg
# Messreihe[, c(2,3)] <-  Messreihe[, c(2,3)]/100 #m

# Testplot
# plot(x=Messreihe$Auslenkung2, y=Messreihe$Gewicht, 
#      ylim=c(0,500),
#      xlim=c(0,50))
# points(x=Messreihe$Auslenkung1, y=Messreihe$Gewicht)

# Subset
Messreihe1 <- Messreihe[, c(1,2)]
Messreihe1$Kraft <- Messreihe1$Gewicht * g

unsicherheit_funktion <- function(x,m){
 
  return( sqrt( ((g/x)*u_m)**2 + ((-m*g/x**2)*u_x)**2 ))
}

Messreihe1$u_Federkonstante <- unsicherheit_funktion(x=Messreihe1$Auslenkung1,m=Messreihe1$Gewicht)

Messreihe1$Federkonstante <- Messreihe1$Kraft/Messreihe1$Auslenkung1

plot(x=Messreihe1$Auslenkung1, y=Messreihe1$Federkonstante)
```

![](DehnbareStoffe_files/figure-latex/unnamed-chunk-3-1.pdf)<!-- --> 

```r
plot(x=Messreihe1$Auslenkung1, y=Messreihe1$Kraft)
```

![](DehnbareStoffe_files/figure-latex/unnamed-chunk-3-2.pdf)<!-- --> 

## Interpretation


# Versuch 2

## Ziel

Untersuchung der Fragestellung, ob sich der Zusammenhang zwischen Kraft und Auslenkung verändert, wenn man die Angrifffskraft auf einen Strang des Gummibandes anstatt auf zwei verteilt.

Eine Hypothese ist, dass die Auslenkung bei gleicher Gewichtskraft doppelt so hoch ist, weil die Kraft auf nur einen Strang wirkt.


## Materialien 

* Stativ 
* Gummiband
* Gewichte
* Maßband
* Haken
* Klebeband
* Schere

## Versuchsaufbau

* Analog zu Versuch 1, aber das Gummiband wurde vorher mit einer Schere zerschnitten und durch geknotete Schlaufen an Haken und Gewicht befestigt.

![Versuchsaufbau 2](C:/Users/milen/Documents/Studium/Physikpraktikum WiSe22,23/Laborbuch-im-Physikpraktikum/Laborbuch/Dehnbare Stoffe/Bilder/Versuch 2, Bild 2.jpeg)

![Versuchsaufbau 2, Nahansicht](C:/Users/milen/Documents/Studium/Physikpraktikum WiSe22,23/Laborbuch-im-Physikpraktikum/Laborbuch/Dehnbare Stoffe/Bilder/Versuch 2, Bild 1.jpeg)

## Durchführung

Analog zu Versuch 1. Wir haben uns dafür entschieden bis zur Marke von 100g in 5g - Intervallen und danach in 10g- Schriiten zu messen, um die Daten mit den Daten aus der ersten Versuchsreihe gut vergleichen können. Da das Band allerdings viel stärker durch das Anbringen von Gewicht gedehnt wurde, konnten wir ab 360g keine Messungewn mehr durchführen, da die Gewichte durch ihre Länge anfingen am Tisch aufzuliegen und so die Normalkraft die Gewichtskraft verfälscht hätte. Stattdessen haben wir den aus platztechnisch noch gut messbaren Wert für 400g genommen und den Rest der Tabelle nicht ausgefüllt.
$x_0$ lag bei uns in diesem Fall bei 15,8cm.

## Messung

## Auswertung

## Interpretation

