#code elaborated by: Emanuel Alvares & Juan José Afanador

errorTruncamiento = function(maxDigi, numero){
  num = numero
  contador = 0
  while(num>1){
    num = num/10
    
    contador = contador+1
  }
  numTruncado = trunc(num*10^maxDigi)/10^maxDigi
  respuesta = (num - numTruncado)*10^(contador-1)
  #print(respuesta)
  cat("error de ", respuesta)
  
}
errorTruncamiento(4, 536.78)

