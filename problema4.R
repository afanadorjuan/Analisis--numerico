#code elaborated by: Emanuel Alvares & Juan José Afanador

calculoError = function(vel, tiempo, errorVel, errorTiempo){
  errorAbsoluto <- (vel*errorVel) + (tiempo*errorTiempo)
  distancia <- vel*tiempo
  errorRelativo <- (errorVel/vel)+(errorTiempo/tiempo)
  cat("recorrio ", distancia, "cm con un tamanio de error entre ",
      distancia-errorAbsoluto, " - ", distancia+errorAbsoluto,
      " \nEl error relativo es ", errorRelativo*100, "%")
}

calculoError(4,5,0.1,0.1)

