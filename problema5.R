#code elaborated by: Emanuel Alvares & Juan José Afanador

horner <- function(coeficiente, x){
  res <- coeficiente[1]
  iteraciones <-0
  
  for(k in coeficiente[2:length(coeficiente)]){
    res <- x*res + k
    iteraciones <- iteraciones + 2
  }
  return(cat("El resultado es: ", res, "\nEl numero minimo de operaciones es: ", iteraciones,"\n",iteraciones/2," multiplicaciones y ",iteraciones/2, " sumas"))
}
x0 <- -2
coeficiente <- c(2,0,-3,3,-4)
horner(coeficiente,x0)
