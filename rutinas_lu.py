#!/usr/bin/python
# -*- coding: latin-1 -*-

"""
Rutinas en python para los métodos directos de resolución de sistemas de ecuaciones lineales: Factorización LU.

Asignatura: Métodos Numéricos y Estadísticos

Autores:
	* Adrián Delgado Marcos
	* Javier Lobato Pérez
	* Alberto Martínez Campo
	* Pablo Rodríguez Robles

Hemos intentado reunir y documentar en este módulo las rutinas que hemos programado para ayudarnos en la explosición
y explicación de nuestro trabajo sobre la factorización LU.
"""

import numpy as np


#############################
### ELIMINACIÓN GAUSSIANA ###
#############################


def eliminacion_gaussiana(A, b):
    """
    * Toma:
    A --> matriz de coeficientes
    b --> matriz de términos independientes
    
    * Devuelve:
    A y b tras aplicar la eliminación
    
    Las matrices se introducen bajo la estructura de numpy.array, de esta manera se optimiza el cálculo
    vectorizando las operaciones.
    
    La rutina pretende ilustrar la implementación en Python del método de eliminación gaussiana.
    """
    
    
    A = A.astype(float) # Los coeficientes de las matrices pasan a expresarse como float
    b = b.astype(float) # Los coeficientes de las matrices pasan a expresarse como float
    
    n = A.shape[0] # n es el número de filas de A (número de ecuaciones)
    
    
    # __ELIMINACIÓN GAUSIANA__    Ax=b --> Ux=c
    # Para las entradas que esten:
    # * En todas las columnas menos la última
    for j in range(0,n-1):
        # * En cada fila con índice superior al de la columna
        for i in range(j+1,n):
            # Si la entrada no es nula
            if A[i,j] != 0.0:
                # Multiplicador, A[j,j] es el pivote, A[i, j] el término
                mult = A[i,j]/A[j,j]
                # A toda la fila de la entrada le restamos la fila superior por el multiplicador
                A[i,:] = A[i,:] - mult*A[j,:]                                     
                b[i] = b[i] - mult*b[j]
    
    # Devuelve
    return A, b 



def sustitucion_regresiva(A, b):
    """
    * Toma:
    A --> matriz de coeficientes escalonada
    b --> matriz de términos independientes escalonada
    
    * Devuelve:
    b --> vector X de las soluciones (Ax=b)
    
    Las matrices se introducen bajo la estructura de numpy.array, de esta manera se optimiza el cálculo
    vectorizando las operaciones.
    
    La rutina pretende ilustrar la implementación en Python del método de sustitución regresiva.
    """
    
    A = A.astype(float) # Los coeficientes de las matrices pasan a expresarse como float
    b = b.astype(float) # Los coeficientes de las matrices pasan a expresarse como float
    
    n = A.shape[0] # n es el número de filas de A (número de ecuaciones)
    
    
    # SUSTUCIÓN REGRESIVA        
    # Desde la última fila hasta la primera
    for j in range(n-1,-1,-1):
        b[j] = (b[j]-np.dot(A[j, j+1:], b[j+1:]))/A[j,j]
        
    return b



def eliminacion_gaussiana_back(A, b):
    """
    * Toma:
    A --> matriz de coeficientes
    b --> matriz de términos independientes
    
    * Devuelve:
    X --> Solución
    
    Las matrices se introducen bajo la estructura de numpy.array, de esta manera se optimiza el cálculo
    vectorizando las operaciones.
    
    La rutina pretende ilustrar la implementación en Python del método de eliminación gaussiana.
    """
    
    A = A.astype(float)
    b = b.astype(float) 
    
    n = A.shape[0] # n es el número de filas de A (ecuaciones)
    
    
    # ELIMINACIÓN GAUSIANA Ax=b --> Ux=c
    # Para las entradas que esten:
    # * En todas las columnas menos la última
    for j in range(0,n-1):
        # * En cada fila con índice superior al de la columna
        for i in range(j+1,n):
            # Si la entrada no es nula
            if A[i,j] != 0.0:
                # Multiplicador, A[j,j] es el pivote, A[i, j] el término
                mult = A[i,j]/A[j,j]
                # A toda la fila de la entrada le restamos la fila superior por el multiplicador
                A[i,:] = A[i,:] - mult*A[j,:]                                     
                b[i] = b[i] - mult*b[j]
               
            
    # SUSTUCIÓN REGRESIVA        
    X = sustitucion_regresiva(A, b)
 
    return X



def sustitucion_progresiva(A, b):
    """
    * Toma:
    A --> matriz de coeficientes escalonada
    b --> matriz de términos independientes escalonada
    
    * Devuelve:
    x --> vector X de las soluciones (Ax=b)
    
    Las matrices se introducen bajo la estructura de numpy.array, de esta manera se optimiza el cálculo
    vectorizando las operaciones.
    
    La rutina pretende ilustrar la implementación en Python del método de sustitución progresiva.
    """
    
    A = A.astype(float) # Los coeficientes de las matrices pasan a expresarse como float
    b = b.astype(float) # Los coeficientes de las matrices pasan a expresarse como float
    
    n = A.shape[0] # n es el número de filas de A (ecuaciones)
    
    x = np.eye(n,1).astype(float) # Vector para almacenar la solución
    
    # SUSTUCIÓN PROGRESIVA        
    # Desde la última fila hasta la primera
    
    x[0] = b[0]
    for j in range(1,n):
        x[j] = b[j]-np.dot(A[j,0:j], x[0:j])
        
    return x



###################################
### MÉTODOS DE FACTORIZACIÓN LU ###
###################################


def doolittle(A, b):
    """
    Implementación de la Factorización de Doolittle.
    
    * Toma:
    A --> matriz de coeficientes 
    b --> matriz de términos independientes
    
    * Devuelve:
    L --> triangular inferior de la factorización
    U --> triangular superior de la factorización
    b --> términos independientes (no los modifica)
    x --> solución final LUx=b
    y --> solución parcial Ly=b, Ux=y
    
    Las matrices se introducen bajo la estructura de numpy.array, de esta manera se optimiza el cálculo
    vectorizando las operaciones.
    """
    
    A = A.astype(float)
    b = b.astype(float)
    
    n = A.shape[0] # n es el número de filas de A (ecuaciones)
    
    # El algoritmo para Doolittle es el mismo que en la
    # eliminación gaussiana, solo que almacenamos los multiplicadores
    # en la parte inferior de la diagonal
    
    # Crea una matriz identidad nxn donde almacenaremos los multiplicadores  
    L = np.eye(n,n)
    
    # ELIMINACIÓN GAUSIANA Ax=b --> Ux=c
    # Para las entradas que esten:
    # * En todas las columnas menos la última
    for j in range(0,n-1):
        # * En cada fila con índice superior al de la columna
        for i in range(j+1,n):
            # Si la entrada no es nula
            if A[i,j] != 0.0:
                # Multiplicador, A[j,j] es el pivote, A[i, j] el término
                mult = A[i,j]/A[j,j]
                # A toda la fila de la entrada le restamos la fila superior por el multiplicador
                A[i,:] = A[i,:] - mult*A[j,:]
                # _NO_ modificamos b
                # Almacenamos cada multiplicador en la entrada que elimina pero en L
                L[i,j] = mult

                
    # U es A después de escalonar
    U = A
    
    # Ly=b
    y = sustitucion_progresiva(L, b)
    
    # Ux=y
    x = sustitucion_regresiva(U, y)
    
    return L, U, b, x, y



def choleski(A):
    """
    Implementación de la Factorización de Choleski (LL^T=A)
    
    La matriz debe ser:
        * Simétrica
        * Definida positiva (para evitar números complejos)
    
    * Toma:
    A --> matriz de coeficientes 
    
    * Devuelve:
    L --> triangular inferior de la factorización
    
    Las matrices se introducen bajo la estructura de numpy.array, de esta manera se optimiza el cálculo
    vectorizando las operaciones.
    """
    
    
    A = A.astype(float)
    
    n = A.shape[0] # n es el número de filas de A (ecuaciones)
    
    # Aprovechamos A en el algoritmo en vez de crear L ya que los terminos no se vuelven a emplear
    
    # Para cada columna
    for j in range(n):
        # Si la raiz es un número complejo, lanzamos un error
        try:
            # En los elementos de la diagonal
            A[j,j] = np.sqrt(A[j,j] - np.dot(A[j,0:j],A[j,0:j]))
        except ValueError:
            error.err("La matriz no es definida positiva")
        # En los elementos bajo la diagonal
        for i in range(j+1,n):
            A[i,j] = (A[i,j] - np.dot(A[i,0:j],A[j,0:j]))/A[j,j]
    # En los términos sobre la diagonal
    for j in range(1,n):
        A[0:j,j] = 0.0
   

    return A



def tridiagonal(c, d, e, b):
    """
    Implementación del algoritmo de Thomas para matrices tridiagonales.
    
    * Toma:
    c --> vector con la subdiagonal 
    d --> vector de la diagonal
    e --> vector de la superdiagonal
    b --> términos independientes
    
    * Devuelve:
    L --> triangular inferior de la factorización
    U --> triangular superior de la factorización
    b --> términos independientes (no los modifica)
    x --> solución final LUx=b
    y --> solución parcial Ly=b, Ux=y
    
    Las matrices se introducen bajo la estructura de numpy.array, de esta manera se optimiza el cálculo
    vectorizando las operaciones.
    """
    
    c = c.astype(float) # Los coeficientes de los vectores pasan a expresarse como float
    d = d.astype(float) # Los coeficientes de los vectores pasan a expresarse como float
    e = e.astype(float) # Los coeficientes de los vectores pasan a expresarse como float
    b = b.astype(float) # Los coeficientes de los vectores pasan a expresarse como float
    
    n = d.shape[0] # n es el número de filas de A (número de ecuaciones)
    
    # FACTORIZACIÓN
    # En esta fase construimos U, que contiene d y e
    # Así como L, compuesta por la identidad más c
    
    # En cada fila desde la segunda
    for i in range(1,n):
        mult = c[i-1]/d[i-1]
        d[i] = d[i] - mult*e[i-1]
        # Almacenamos los multiplicadores en c
        c[i-1] = mult
        
    # RESOLUCIÓN
    # Por comodidad construiremos L y U de manera completa para la resolución
    # Esto no es un gran inconveniente puesto que el grueso de las operaciones
    # ya las hemos realizado usando solo las diagonales
    
    # L 
    
    L = np.eye(n,n)
    
    # Para los elementos de la diagonal inferior (i, j) = (1,0), (2,1), (3,2)...
    for i in range(1, n):
            # Copia el elemento i de c: c[1], c[2]... nunca el 0 del principio
            L[i,i-1] = c[i]
    
    
    # U
    
    U = np.eye(n,n)
    
    for i in range(n-1):
        # Para los elementos de la diagoanl copia d (todos)
        U[i,i] = d[i]
        # Por encima de la diagonal copia todos los de e menos el último (0)
        if (i!=n):
            U[i,i+1] = e[i]
    
    # Ly=b
    
    y = sustitucion_progresiva(L, b)
    
    # Ux=y
    
    x = sustitucion_regresiva(U, y)
    
    
    return L, U, b, x, y
