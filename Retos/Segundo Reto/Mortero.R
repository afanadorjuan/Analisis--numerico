#-------------------------------------#
#CODE ELABORATED BY:
#EMANUEL ÁLVAREZ
#NICOLAI BARRERA
#JUAN JOSÉ AFANADOR
#DIEGO BURGOS
#-------------------------------------#

require(bezier)
require(rgl)
require(gridBezier)
require(plot3D)
require(magick)

options(digits=4)

grid.newpage()
xsg <- BezierGrob(c(.0, .0, .076, 0.146), c(.8, .8, .8, .578),gp=gpar(lwd=3), stepFn = nSteps(20))
xsg2 <- BezierGrob(c(.146, .146, .469, .577), c(.578, .578, .518, .146),gp=gpar(lwd=3), stepFn = nSteps(60))
xsg3 <- BezierGrob(c(.577, .577, .8, .8), c(.146, .146, .076, .0),gp=gpar(lwd=3), stepFn = nSteps(20))
trace <- BezierPoints(xsg)
trace2 <- BezierPoints(xsg2)
trace3 <- BezierPoints(xsg3)

valoresx=as.vector(trace$x)
valoresx2=as.vector(trace2$x)
valoresx3=as.vector(trace3$x)

valoresy=as.vector(trace$y)
valoresy2=as.vector(trace2$y)
valoresy3=as.vector(trace3$y)

datosx = c(valoresx,valoresx2,valoresx3)
datosy = c(valoresy,valoresy2,valoresy3)

grid.circle(trace$x, trace$y, default.units="inches", r=unit(.5, "mm"))
grid.circle(trace2$x, trace2$y, default.units="inches", r=unit(.5, "mm"))
grid.circle(trace3$x, trace3$y, default.units="inches", r=unit(.5, "mm"))


X = datosx
Y = datosy
Z = c(rep(1,100))



for (i in 1:100) {
  X[i] = X[i]*2
  Y[i] = Y[i]*2
}
plot(X,Y, xlim=c(0,8), ylim=c(0,8) )


length(X)
Y
#----------------------------------GRÁFICA EXTERNA-----------------------------------#


#variables que ayudarán a disminuir los valores de X,Y y Z
contador = length(X) + 1
contador2 = 1
disminucion = 1-0.01
disminucion2 = 0.02
disminucion3 = 0.02


#ciclo que disminuye el valor de la Z
#y a la vez disminuye el ancho de XvsY
#para crear una forma de contenedor(mortero)
while (TRUE)
{
  
  if(X[contador2]-disminucion3 >= 0)
  {
    X[contador] = X[contador2] - disminucion3
  }
  
  if(Y[contador2] -disminucion2 >= 0)
  {
    Y[contador] = Y[contador2] -disminucion2
  }
  else
  {
    Y[contador] = 0
    X[contador]=X[contador-1]
  }
  
  Z[contador] = disminucion
  contador = contador + 1
  contador2 = contador2 + 1
  
  if(contador2 == 101) 
  {
    contador2 = 1
    disminucion = disminucion - 0.01
    disminucion2 = disminucion2 + 0.02
    disminucion3 = disminucion3 + 0.02
  }
  if(contador == 15000)
  {
    cat("profundidad", Z[contador-1], "\n")
    
    break;
  }
}

Xespejo=-1*X 
Yespejo=-1*Y

#---------------------Crear fondo(externo) con cuatro cuadrantes------------------------#

xfinales1 = X[(contador-101):(contador-1)]
yfinales1 = Y[(contador-101):(contador-1)]

suelo = Z[contador-1]
X[contador-1]
posSuelo = contador-1


value = 0.02
aumento = seq(0,10000,100)
print(aumento)

contador2 = 1

X5 = datosx
Y5 = datosy
Z5 = c(rep(1,400))


for (j in aumento) {
  for (i in 1:100) {
    X5[i+j] = xfinales1[contador2]-value
    Y5[i+j] = yfinales1[contador2]-value
    Z5[i+j] = suelo
    contador2 = contador2 + 1
  }
  value = value + 0.02
  contador2 = 1
}

Xespejos1=-1*X5
Yespejos1=-1*Y5


#---------------------Crear gráfica(externa) 3d con cuatro cuadrantes------------------------#


plot3d(X, Y, Z, type = "l", col = "black",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejo, Y, Z, type = "l", col = "black",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejo, Yespejo, Z, type = "l", col = "black",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(X, Yespejo, Z, type = "l", col = "black",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))


#---------------------Graficar suelo(externo) 3d con cuatro cuadrantes------------------------#

plot3d(X5, Y5, Z5, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejos1, Y5, Z5, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejos1, Yespejos1, Z5, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(X5, Yespejos1, Z5, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))




#----------------------------------GRÁFICA INTERNA-----------------------------------#



xsg4 <- BezierGrob(c(.0, .0, .076, 0.146), c(.8, .8, .8, .578),gp=gpar(lwd=3), stepFn = nSteps(20))
xsg5 <- BezierGrob(c(.146, .146, .469, .577), c(.578, .578, .518, .146),gp=gpar(lwd=3), stepFn = nSteps(60))
xsg6 <- BezierGrob(c(.577, .577, .8, .8), c(.146, .146, .076, .0),gp=gpar(lwd=3), stepFn = nSteps(20))
trace4 <- BezierPoints(xsg4)
trace5 <- BezierPoints(xsg5)
trace6 <- BezierPoints(xsg6)

valoresx4=as.vector(trace4$x)
valoresx5=as.vector(trace5$x)
valoresx6=as.vector(trace6$x)

valoresy4=as.vector(trace4$y)
valoresy5=as.vector(trace5$y)
valoresy6=as.vector(trace6$y)

datosx2 = c(valoresx4,valoresx5,valoresx6)
datosy2 = c(valoresy4,valoresy5,valoresy6)

grid.circle(trace$x, trace4$y, default.units="inches", r=unit(.5, "mm"))
grid.circle(trace2$x, trace5$y, default.units="inches", r=unit(.5, "mm"))
grid.circle(trace3$x, trace6$y, default.units="inches", r=unit(.5, "mm"))


X2 = datosx2
Y2 = datosy2
Z2 = c(rep(1,100))



for (i in 1:100) {
  X2[i] = X2[i]*1.6
  Y2[i] = Y2[i]*1.6
}
plot(X2,Y2, xlim=c(0,8), ylim=c(0,8) )


##############################################################################


#variables que ayudarán a disminuir los valores de X,Y y Z
contador = length(X2) + 1
contador2 = 1
disminucion = 1-0.01
disminucion2 = 0.02
disminucion3 = 0.02

while(TRUE)
{
  
  if(X2[contador2]-disminucion3 >= 0)
  {
    X2[contador] = X2[contador2] - disminucion3
  }
  
  if(Y2[contador2] -disminucion2 >= 0)
  {
    Y2[contador] = Y2[contador2] -disminucion2
  }
  else
  {
    Y2[contador] = 0
    X2[contador]=X2[contador-1]
  }
  
  Z2[contador] = disminucion
  contador = contador + 1
  contador2 = contador2 + 1
  
  if(contador2 == 101) 
  {
    contador2 = 1
    disminucion = disminucion - 0.01
    disminucion2 = disminucion2 + 0.02
    disminucion3 = disminucion3 + 0.02
  }
  if(contador == 14000)
  {
    cat("profundidad", Z2[contador-1], "\n")
    
    break;
  }
}

Xespejo2=-1*X2
Yespejo2=-1*Y2


#---------------------Crear fondo(interno) con cuatro cuadrantes------------------------#

xfinales = X2[(contador-101):(contador-1)]
yfinales = Y2[(contador-101):(contador-1)]

suelo = Z2[contador-1]
X2[contador-1]
posSuelo = contador-1


value = 0.02
aumento = seq(0,6000,100)
print(aumento)

contador2 = 1

X4 = datosx2
Y4 = datosy2
Z4 = c(rep(1,400))


for (j in aumento) {
  for (i in 1:100) {
    X4[i+j] = xfinales[contador2]-value
    Y4[i+j] = yfinales[contador2]-value
    Z4[i+j] = suelo
    contador2 = contador2 + 1
  }
  value = value + 0.02
  contador2 = 1
}

Xespejos=-1*X4
Yespejos=-1*Y4

#---------------------Crear gráfica(interna) 3d con cuatro cuadrantes------------------------#

plot3d(X2, Y2, Z2, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z",xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejo2, Y2, Z2, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejo2, Yespejo2, Z2, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(X2, Yespejo2, Z2, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z",  xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))


#---------------------Graficar suelo(interna) 3d con cuatro cuadrantes------------------------#

plot3d(X4, Y4, Z4, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejos, Y4, 4, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejos, Yespejos, Z4, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(X4, Yespejos, Z4, type = "l", col = "green",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))



#----------------------------------TAPA-----------------------------------#



xsg4 <- BezierGrob(c(.0, .0, .076, 0.146), c(.8, .8, .8, .578),gp=gpar(lwd=3), stepFn = nSteps(20))
xsg5 <- BezierGrob(c(.146, .146, .469, .577), c(.578, .578, .518, .146),gp=gpar(lwd=3), stepFn = nSteps(60))
xsg6 <- BezierGrob(c(.577, .577, .8, .8), c(.146, .146, .076, .0),gp=gpar(lwd=3), stepFn = nSteps(20))
trace4 <- BezierPoints(xsg4)
trace5 <- BezierPoints(xsg5)
trace6 <- BezierPoints(xsg6)

valoresx4=as.vector(trace4$x)
valoresx5=as.vector(trace5$x)
valoresx6=as.vector(trace6$x)

valoresy4=as.vector(trace4$y)
valoresy5=as.vector(trace5$y)
valoresy6=as.vector(trace6$y)

datosx2 = c(valoresx4,valoresx5,valoresx6)
datosy2 = c(valoresy4,valoresy5,valoresy6)

grid.circle(trace$x, trace$y, default.units="inches", r=unit(.5, "mm"))
grid.circle(trace2$x, trace2$y, default.units="inches", r=unit(.5, "mm"))
grid.circle(trace3$x, trace3$y, default.units="inches", r=unit(.5, "mm"))


X3 = datosx2
Y3 = datosy2
Z3 = c(rep(1,400))

value = 1.7
aumento = seq(0,700,100)
print(aumento)
for (j in aumento) {
  for (i in 1:100) {
    X3[i+j] = datosx2[i]*value
    Y3[i+j] = datosy2[i]*value
  }
  value = value + 0.05
}

Xespejot=-1*X3
Yespejot=-1*Y3


plot(X3,Y3, xlim=c(0,8), ylim=c(0,8) )

plot3d(X3, Y3, Z3, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejot, Y3, Z3, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(Xespejot, Yespejot, Z3, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))

plot3d(X3, Yespejot, Z3, type = "p", col = "red",
       xlab = "x", ylab="y", zlab="z", xlim = c(-10,10), ylim = c(-10,10) , zlim = c(-3,3))



#----------------------------------CÁLCULO DE ERRORES-----------------------------------#


#-------------------------ERRORES-TAPA------------------------#

auxX = X[1:100] 

cat("X original","\t", "X tapa", "\t",  "\t", "error absoluto", "\t", "error relativo", "\n")

cont = 700
for (i in 1:100) {
  errorabs = round(abs(auxX[i]-X3[cont]),3)
  errorrel = round(errorabs/auxX[i],3)
  cat(round(auxX[i],3),"\t\t", round(X3[cont],3), "\t",  "\t\t", errorabs, "\t\t", errorrel, "\n")
  cont = cont+1
}


#-------------------------ERRORES-PARED EXTERNA------------------------#

auxX2 = X[1:100] 


cat("X original","\t", "X pared", "\t",  "\t", "error absoluto", "\t", "error relativo", "\n")

cont = 101
for (i in 1:100) {
  errorabs = round(abs(auxX2[i]-X[cont]),3)
  errorrel = round(errorabs/auxX2[i],3)
  cat(round(auxX2[i],3),"\t\t", round(X[cont],3), "\t",  "\t\t", errorabs, "\t\t", errorrel, "\n")
  cont = cont+1
}
# play3d( spin3d( axis = c(0, 0, 1), rpm = 7), duration = 10 )
#movie3d( spin3d( axis = c(0, 0, 1), rpm = 7),
#         duration = 10, dir = getwd(),
#         type = "gif", clean =  TRUE )

#getwd() 

