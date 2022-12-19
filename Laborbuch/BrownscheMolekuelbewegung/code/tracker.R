# Data import -------------------------------------------------------------
# Read Values
values = read.csv('Tabellen/out_clean.csv', skip = 1, header=FALSE)

# Tidydata
colnames = c('Frame')
for (i in 1:17) {
  colnames = append(colnames, c(paste("X", i), paste("y", i), paste("dp", i)))
}
colnames(values) = colnames
rownames(values) = values$Frame

# Subsetting
# x-Columns
x = values[,seq(2, ncol(values)-2, by=3)]
# y-Columns
y = values[,seq(3, ncol(values)-1, by=3)]
# absolute walk distanze in pixel: dp-Columns
dp = values[,seq(4, ncol(values), by=3)]

# Analysis ----------------------------------------------------------------

# Plot walk of a partikle
plot(x=values$`X 2`, y=values$`y 2`, type = "l")
points(x=values$`X 2`[1], y=values$`y 2`[1], pch = 20, col="red", cex=3)
points(x=values$`X 2`[100], y=values$`y 2`[100], pch = 20, col="blue", cex=3)

# Calculate the walk-distance within a column
calculateDistance1D = function(vector){
  shift_vector = c(0, vector[1:(length(vector)-1)])
  dist = vector-shift_vector
  dist[1] = 0
  #hist(dist)
  return(dist)
}

# sorted absolute walk distance plot
{col=2
xd = abs(calculateDistance1D(x[,col]))
yd = abs(calculateDistance1D(y[,col]))
xydf = data.frame(x = xd, y = yd)
xydf = xydf[order(xydf$x),]
plot(x=1:100, y=dp[order(dp[,col]), col])
}

# All distances
distances = c()
for (col in 1:17){
  walk = calculateDistance1D(x[, col])
  distances = append(distances, walk)
} 
# Histogram of all distances of all partikles
hist(distances, breaks = 60)

# Plot of szenery
ww = 1200 # windowwidth
plot(x=1:ww, y=1:ww, asp=1, col = "transparent", ylim = c(ww, 0)) 
for (i in 1:17) {
  points(x=y[1,i], y=x[1,i], col = "firebrick3", cex = 2, pch = 20) 
  points(x=y[,i], y=x[,i], type = 'l') 
  points(x=y[nrow(y),i], y=x[nrow(x),i], col = "darkblue", cex = 2, pch = 20) 
}
