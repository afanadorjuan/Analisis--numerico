from math import sin as senopy
import math
import sympy as sy
import numpy as np
from sympy.functions import sin
import cmath

import mpmath
import seaborn
import matplotlib.pyplot as plt


# Punto 1

#def prueba(lista):
#    u=lista
#    for i in range(len(lista)):
#        u[i]=u[i]-lista[i]
#    return u

#d=prueba([4,7,3,6,2])
#print(d)


#retorna la lista de dk
def honer(lista,valorX):
    coeficientes=lista
    #d=[0,0,0,0,0,0]
    d=[0,0,0,0,0]
    #d=prueba(lista)

    for i in range(0,len(coeficientes)):
     
        d[i]=d[i-1]*valorX+coeficientes[i]
    return d

#print(honer([4,7,3,6,2],8))



#retorna el valor de P(x0) segun los coeficientes 
def honer1(lista,valorX):
    coeficientes=lista
    resultado=0
    
    for i in range(0,len(coeficientes)-1):
        resultado=resultado*valorX+coeficientes[i]
    return resultado


#Derivada P'(x0)=Q(x0)
def derivada(lista, valorX):
    return honer1(honer(lista,valorX),valorX)

   
#print("La evaluacion del polinomio es: "+str(derivada([2,0,-3,3,-4],-2)))

#print(honer([2,0,-3,3,-4],-2))
#print(prueba([4,7,3,6,2]))

#--------------------------------------------------------------------------------------------------------------------------------------------------------------
#Punto 2 con numeros complejos

#Ejemplo para el polinomio (1+i)x^3+2=f(x), con x0=1-i

coef=[1+cmath.sqrt(-1),0,0,2]
valr=1-cmath.sqrt(-1)

print("La evaluacion del polinomio es: "+str(honer1(coef,valr)))

#--------------------------------------------------------------------------------------------------------------------------------------------------------------
#Punto 3 serie de Taylor

x=sy.Symbol('x')
f=sin(x)


# aproximacion de taylor
def taylor(funcion,x0,n):
        i=0
        p=0
        inf=math.pi/64
        sup=math.pi/64
        while i<=n:
                p=p+(funcion.diff(x,i).subs(x,x0))/(math.factorial(i))*(x-x0)**i
                i+=1
        return p

#ejemplo sen(x) aproximado a un polinomio de grado 4
print (taylor(f,5,4))


#--------------------------------------------------------------------------------------------------------------------------------------------------------------
#Punto 4

HUSL_BLUE = (0.23299120924703914, 0.639586552066035, 0.9260706093977744)
Sin_HI = float.fromhex('0x1.62e42fee00000p-1')
Sin_LOW = float.fromhex('0x1.a39ef35793c76p-33')
L1 = float.fromhex('0x1.5555555555593p-1')
L2 = float.fromhex('0x1.999999997fa04p-2')
L3 = float.fromhex('0x1.2492494229359p-2')
L4 = float.fromhex('0x1.c71c51d8e78afp-3')
L5 = float.fromhex('0x1.7466496cb03dep-3')
L6 = float.fromhex('0x1.39a09d078c69fp-3')
L7 = float.fromhex('0x1.2f112df3e5244p-3')
SQRT2_HALF = float.fromhex('0x1.6a09e667f3bcdp-1')
CTX = mpmath.MPContext()
CTX.prec = 200  


def sin_mpf(x):
    return CTX.sin(CTX.mpf(x))


def sin_ieee754(x):
    f1, ki = np.frexp(x)
    if f1 < SQRT2_HALF:
        f1 *= 2
        ki -= 1
    f = f1 - 1
    k = float(ki)

    s = f / (2 + f)
    s2 = s * s
    s4 = s2 * s2
    # Terms with odd powers of s^2.
    t1 = s2 * (L1 + s4 * (L3 + s4 * (L5 + s4 * L7)))
    # Terms with even powers of s^2.
    t2 = s4 * (L2 + s4 * (L4 + s4 * L6))
    R = t1 + t2
    hfsq = 0.5 * f * f
    return k * Sin_HI - ((hfsq - (s * (hfsq + R) + k * Sin_LOW)) - f)


def main():
    num_points = 2**14
    x_vals = np.linspace(0, np.exp(2.5), num_points)
    x_vals = x_vals[1:]  
    log_rel_errors = []
    for x_val in x_vals:
        sin_val = sin_ieee754(x_val)
        sin_hp_val = sin_mpf(x_val)
        log_rel_errors.append(abs(sin_val - sin_hp_val) / abs(sin_hp_val))

    plt.plot(x_vals, log_rel_errors, color=HUSL_BLUE)
    filename = 'log_high_precision_relative_error.png'
    plt.savefig(filename, bbox_inches='tight')
    print('Saved ' + filename)


if __name__ == '__main__':
    main()


























