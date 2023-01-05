# ---- Schaltung 1
# INPUT: Spannung, Stromstärke
# OUTPUT: Benötigter Widerstand
schaltung1 <- function(U0, I0){
  # Randbedingungen
  R1 = 0 # Widerstand Amperemeter
  R2 = 10e6 # Widerstand Voltmeter
  # Berechnung des Gesamtwiderstandes
  Rges = U0/I0
  # Berechnung des benötigten R
  R3 = (1/(Rges-R1)-1/R2)**-1
  return(R3)
}
# Testen mit gemessenen Werten
schaltung1(U0=5, I0=5.4e-06)
schaltung1(U0=0.15, I0=0.1503)

# ---- Schaltung 2
# INPUT: Spannung, Stromstärke
# OUTPUT: Benötigter Widerstand
schaltung2 <- function(U0, I13){
  # Randbedingungen
  R1 = 0 # Widerstand Amperemeter
  R2 = 10e6 # Widerstand Voltmeter
  # Berechnung des Gesamtwiderstandes
  I0 = I13 + U0/R2
  Rges = U0/I0
  # Berechnung des benötigten R
  R3 = (1/Rges-1/R2)**-1
  return(R3)
}
# Testen mit gemessenen Werten
schaltung2(U0=5.03, I13=5e-06)
schaltung2(U0=0.4, I13=0.1018)

###
### Vielleicht noch eine nette Grafik draus machen?
###
