<TeXmacs|1.99.2>

<style|<tuple|article|spanish>>

<\body>
  <doc-data|<doc-title|Métodos directos de resolución de sistemas de
  ecuaciones lineales: Factorización LU>|<doc-author|<\author-data|<author-name|Delgado
  Marcos, A; Lobato Pérez, J; Martínez Campo, A y Rodríguez Robles,
  P>|<\author-affiliation>
    \;
  </author-affiliation>>
    \;
  <|author-data>
    \;

    \;
  <|author-data>
    \;

    \;

    \;
  </author-data>>>

  <abstract-data|<abstract|El documento prentende presentar el contexto de la
  factorización LU en los métodos directos de resolución de sistemas de
  ecuaciones lineales, así como la descripción de este procedimiento y su
  ejemplificación mediante problemas realizados con la ayuda del leguaje de
  programación Python.>>

  <section|Sistemas de ecuaciones lineales>

  \;

  En cualquier disciplina de la ingeniería solemos encontrarnos con la
  resolución de sistemas de ecuaciones lineales de la forma:

  <\equation*>
    Ax=b
  </equation*>

  \;

  Donde <math|A> es la matriz cuadrada de dimensión <math|n\<times\>n> cuyos
  elementos <math|a<rsub|ij>> pueden ser números reales o complejos, mientras
  que <math|x> y <math|b> son un par de vectores de dimensión <math|n> en los
  que <math|x> representa el conjunto de la solución desconocida y <math|b>
  es un vector dado. Podemos escribir un sistema de ecuaciones como:

  <\eqnarray*>
    <tformat|<table|<row|<cell|a<rsub|11>x<rsub|11>+a<rsub|12>x<rsub|12>+\<ldots\>+a<rsub|1n>x<rsub|1n>=b<rsub|1>>|<cell|>|<cell|>>|<row|<cell|a<rsub|21>x<rsub|21>+a<rsub|22>x<rsub|22>+\<ldots\>+a<rsub|2n>x<rsub|2n>=b<rsub|2>>|<cell|>|<cell|>>|<row|<cell|\<vdots\>>|<cell|>|<cell|>>|<row|<cell|a<rsub|n1>x<rsub|n1>+a<rsub|n2>x<rsub|n2>+\<ldots\>+a<rsub|nn>x<rsub|nn>=b<rsub|n>>|<cell|>|<cell|<with|font-series|bold|>>>>>
  </eqnarray*>

  \;

  También es posible escribir los sistemas usando la notación matricial:

  <\strong>
    \;

    <with|font-series|medium|<\equation*>
      <with|font-series|medium|<with|font-series|bold|><matrix|<tformat|<table|<row|<cell|a<rsub|11>>|<cell|a<rsub|12>>|<cell|a<rsub|13>>|<cell|a<rsub|14>>>|<row|<cell|a<rsub|21>>|<cell|a<rsub|22>>|<cell|a<rsub|23>>|<cell|a<rsub|24>>>|<row|<cell|a<rsub|31>>|<cell|a<rsub|32>>|<cell|a<rsub|33>>|<cell|a<rsub|34>>>|<row|<cell|a<rsub|41>>|<cell|a<rsub|42>>|<cell|a<rsub|43>>|<cell|a<rsub|44>>>>>>\<cdot\><matrix|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>|<row|<cell|x<rsub|4>>>>>>=<matrix|<tformat|<table|<row|<cell|b<rsub|1>>>|<row|<cell|b<rsub|2>>>|<row|<cell|b<rsub|3>>>|<row|<cell|b<rsub|4>>>>>>>
    </equation*>>

    \;
  </strong>

  \;

  La resolución de estos sistemas es muy importante ya que se emplea en el
  análisis de todo tipo de sistemas físicos que se presentan como modelos
  matemáticos lineales. Así son las estructuras, los sólidos elásticos, el
  transporte de calor, la mecánica de fluidos, los campos electromagnéticos,
  circuitos, ect.

  \;

  En la física de medios continuos (mecánica de fluidos, por ejemplo) el
  comportamiento del sistema es descrito mediante ecuaciones diferenciales.
  Como el análisis numérico solo conoce variables discretas (finitas), se
  utilizan distintos métodos de aproximación que transforman estas
  expresiones diferenciales en sistemas de ecuaciones algebraicas que los
  computadores sí pueden resolver.

  \;

  En esencia, cuando resumimos los sistemas de ecuaciones lineales en la
  forma <math|Ax=b> encontramos que para el sistema físico descrito, <math|A>
  son las características de éste, <math|b> resulta ser la interacción
  supuesta y <math|x> la respuesta del sistema físico a ésta. De este modo,
  queda justificada la búsqueda de métodos que lleven a la resolución de
  sistemas simultáneos (misma <math|A>) para el análisis repetido del mismo
  sistema físico en distintas condiciones iniciales con un coste
  computacional mínimo, como veremos que lo es la factorización
  <math|LU>.<new-page>

  Disponemos de dos tipos de resolución para los sistemas de ecuaciones
  lineales. Por una parte, los métodos directos son aquellos que utilizan un
  número finito de pasos para transformar el sistema en otro equivalente que
  sea más fácil de resolver. Estos pasos se conocen como operaciones
  elementales y no cambian la solución del sistema, aunque sí pueden cambiar
  el determinante de la matriz de coeficientes (<math|<around*|\||A|\|>>).
  Distinguimos tres operaciones elementales:

  \;

  <\itemize>
    <item>Intercambio de dos ecuaciones (cambia el signo de
    <math|<around*|\||A|\|>>). <math|<around*|(|E<rsub|i>|)>\<rightarrow\><around*|(|E<rsub|j>|)>>

    <item>Multiplicar una ecuación por una constante distinta de cero
    (multiplica a <math|<around*|\||A|\|>> por la misma constante).
    <math|<around*|(|\<lambda\>E<rsub|i>|)>\<rightarrow\><around*|(|E<rsub|i>|)>>

    <item>Multiplicar una ecuación por una constante distinta de cero y
    sumarla a otra ecuación (no altera <math|<around*|\||A|\|>>).
    <math|<around*|(| E<rsub|i>+\<lambda\>E<rsub|j>|)>\<rightarrow\><around*|(|E<rsub|i>|)>>
  </itemize>

  \;

  Las operaciones elementales también pueden ser concebidas como el producto
  de una matriz que llamamos elemental. Es decir, el producto matricial por
  la matriz identidad a la que se le han aplicado las transformaciones
  buscadas. Si multiplicamos por la izquierda, los cambios se aplican por
  filas (nuestras ecuaciones), en el caso de hacerlo por la derecha
  obtendríamos los mismos cambios pero por columnas.\ 

  \;

  Por otro lado, los métodos iterados para la resolución de sistemas de
  ecuaciones lineales comienzan con una aproximación inicial de la solución
  <math|X<rsub|0>>, que se va refinando a través de cada iteración hasta que
  se alcanza un criterio de convergencia elegido. Estos métodos son menos
  eficientes que los directos debido al gran número de iteraciones que
  necesitamos, aunque resultan muy interesantes cuando se trabaja con
  matrices con muchos ceros (algo bastante común en los sistemas físicos).

  \;

  \;

  <strong|Matrices elementales<with|font-base-size|12|>>

  \;

  Tras tratar las operaciones elementales que podemos aplicar a las matrices
  de nuestros sistemas, veremos cómo expresar estas transformaciones por
  medio del producto de matrices elementales. Estas matrices elementales se
  obtienen de la matriz identidad al aplicar una operación elemental.\ 

  \;

  Computacionalmente encontramos que las matrices son un operador, es decir,
  un objeto que realiza una operación buscada sobre un vector. Si lo hace
  sobre un vector, una matriz también puede actuar sobre otra matriz actuando
  simultáneamente en todos los vectores:

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|<wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|Id<rsub|3>>>|<cell|<long-arrow|\<rubber-rightarrow\>|E<rsub|2>\<rightarrow\>E<rsub|2>+6E<rsub|1>>>|<cell|<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|6>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|Matriz
    elemental>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|Id<rsub|4>>>|<cell|<long-arrow|\<rubber-rightarrow\>|E<rsub|3>\<rightarrow\>E<rsub|3>-5E<rsub|1>>>|<cell|<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-5>|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|Matriz
    elemental>>>>>
  </eqnarray*>

  <new-page>

  El producto de esta matriz elemental por una matriz equivale a realizar las
  operaciones elementales sobre ella. De hacerlo por la izquierda el cambio
  será en las filas. En el caso contrario modificaremos las columnas:

  \;

  <\equation*>
    <wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-3>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|Matriz
    elemental><text|><around*|(|<tabular*|<tformat|<table|<row|<cell|6>|<cell|-1>|<cell|1>>|<row|<cell|7>|<cell|2>|<cell|3>>|<row|<cell|0>|<cell|-3>|<cell|-2>>>>>|)>=<around*|(|<tabular*|<tformat|<table|<row|<cell|6>|<cell|-1>|<cell|2>>|<row|<cell|-11>|<cell|5>|<cell|-3>>|<row|<cell|0>|<cell|-3>|<cell|-2>>>>>|)>
  </equation*>

  \;

  \;

  Esto equivale a la operación <math|E<rsub|2>\<rightarrow\>E<rsub|2>-3E<rsub|1>>

  \;

  Debemos considerar también el procedimiento para el cálculo de la inversa
  de una de estas matrices elementales, es decir, cambiar el signo de todos
  los elementos que no pertenecen a la diagonal principal:

  \;

  \;

  \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ <math|E=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|-2>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>\<nocomma\>\<nocomma\>
  > \ \ \ \ \ \ \ \ \ \ \ \ <math| E<rsup|-1>=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|2>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>>

  \;

  \;

  Es fácil comprobar que el producto <math|E\<cdummy\>E<rsup|-1>=Id>

  \;

  \;

  \;

  <subsection|Métodos directos>

  \;

  Podemos resumir los principales métodos empleando la siguiente tabla:

  \;

  <\equation*>
    <tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<cwith|1|-1|1|-1|cell-background|>|<table|<row|<cell|Metodo>|<cell|Forma
    inicial >|<cell|Forma final>>|<row|<cell|Eliminacion gaussiana>|<cell|A x
    = b>|<cell|U x = c>>|<row|<cell|Descomposicion LU>|<cell|A x = b>|<cell|L
    U x = b>>|<row|<cell|Eliminacion Gauss-Jordan>|<cell|A x = b>|<cell|I x =
    c>>>>>
  </equation*>

  \;

  \;

  <subsubsection|Método de eliminación gaussiana>

  \;

  La explicación de este método tiene un alto contenido didáctico y es con el
  que todo el mundo está familiarizado. Distiguimos dos partes:

  \;

  <\itemize-dot>
    <item><strong|Fase de eliminación>: consiste en eliminar las entradas
    bajo la diagonal de <math|A> haciendo uso de las operaciones elementales
    hasta conseguir <math|Ux=c>

    \;

    Es de importancia para posteriores técnicas de pivoteo la introducción
    del término <math|\<lambda\>> que llamaremos multiplicador<em|<strong|>>:

    \;

    \;

    <\equation*>
      \<lambda\>=<frac|a<rsub|i j>|a<rsub|i i>>
    </equation*>

    <new-page>

    La representación simbólica de cada operación es la :

    \;

    <\equation*>
      E<rsub|i>\<rightarrow\>E<rsub|i>-\<lambda\>\<cdot\>E<rsub|j>
    </equation*>

    \;

    Llegando a la forma final buscada:
  </itemize-dot>

  \;

  <\equation*>
    <around*|(|<tabular*|<tformat|<table|<row|<cell|u<rsub|11>>|<cell|u<rsub|12>>|<cell|u<rsub|13>>>|<row|<cell|0>|<cell|u<rsub|22>>|<cell|u<rsub|23>>>|<row|<cell|0>|<cell|0>|<cell|u<rsub|33>>>>>>|)>\<cdot\><around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>>>>|)>=<around*|(|<tabular*|<tformat|<table|<row|<cell|c<rsub|1>>>|<row|<cell|c<rsub|2>>>|<row|c<rsub|3>>>>>|)>
  </equation*>

  \;

  <\example>
    Ejemplo de eliminación gaussiana:
  </example>

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|4>|<cell|-2>|<cell|1>>|<row|<cell|-2>|<cell|4>|<cell|-2>>|<row|<cell|1>|<cell|-2>|<cell|4>>>>>|)><around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>>>>|)>>|<cell|=>|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|11>>|<row|<cell|-16>>|<row|<cell|17>>>>>|)><long-arrow|\<rubber-rightarrow\>|E<rsub|2>\<rightarrow\>E<rsub|2>-<frac|-2|4>E<rsub|1>>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|4>|<cell|-2>|<cell|1>>|<row|<cell|0>|<cell|3>|<cell|-1.5>>|<row|<cell|1>|<cell|-2>|<cell|4>>>>>|)><around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>>>>|)>>|<cell|=>|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|11>>|<row|<cell|-10.5>>|<row|<cell|17>>>>>|)><long-arrow|\<rubber-rightarrow\>|E<rsub|3>\<rightarrow\>E<rsub|3>-<frac|1|4>E<rsub|1>>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|4>|<cell|-2>|<cell|1>>|<row|<cell|0>|<cell|3>|<cell|-1.5>>|<row|<cell|0>|<cell|-1.5>|<cell|3.75>>>>>|)><around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>>>>|)>>|<cell|=>|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|11>>|<row|<cell|-10.5>>|<row|<cell|14.25>>>>>|)><long-arrow|\<rubber-rightarrow\>|E<rsub|3>\<rightarrow\>E<rsub|3>-<frac|-1.5|3>E<rsub|2>>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|4>|<cell|-2>|<cell|1>>|<row|<cell|0>|<cell|3>|<cell|-1.5>>|<row|<cell|0>|<cell|0>|<cell|3>>>>>|)><around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>>>>|)>>|<cell|=>|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|11>>|<row|<cell|-10.5>>|<row|<cell|9>>>>>|)>>>>>
  </eqnarray*>

  <new-page>

  La rutina pretende ilustrar la implementación en Python del método de
  eliminación gaussiana.

  <\algorithm>
    <\with|color|cyan>
      \;

      <\with|font|Andale|font-base-size|9>
        <\with|color|blue>
          def eliminacion_gaussiana(A, b):

          \ \ \ \ """

          \ \ \ \ * Toma:

          \ \ \ \ A --\<gtr\> matriz de coeficientes

          \ \ \ \ b --\<gtr\> matriz de términos independientes

          \ \ \ \ 

          \ \ \ \ * Devuelve:

          \ \ \ \ A y b tras aplicar la eliminación

          \ \ \ \ """

          \ \ \ \ 

          \ \ \ \ 

          \ \ \ \ A = A.astype(float) # Los coeficientes de las matrices
          pasan a expresarse \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ como
          float

          \ \ \ \ b = b.astype(float) # Los coeficientes de las matrices
          pasan a expresarse \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ como
          float

          \ \ \ \ 

          \ \ \ \ n = A.shape[0] # n es el número de filas de A (número de
          ecuaciones)

          \ \ \ \ 

          \ \ \ \ 

          \ \ \ \ # __ELIMINACIÓN GAUSIANA__ \ \ \ Ax=b --\<gtr\> Ux=c

          \ \ \ \ # Para las entradas que esten:

          \ \ \ \ # * En todas las columnas menos la última

          \ \ \ \ for j in range(0,n-1):

          \ \ \ \ \ \ \ \ # * En cada fila con índice superior al de la
          columna

          \ \ \ \ \ \ \ \ for i in range(j+1,n):

          \ \ \ \ \ \ \ \ \ \ \ \ # Si la entrada no es nula

          \ \ \ \ \ \ \ \ \ \ \ \ if A[i,j] != 0.0:

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ # Multiplicador, A[j,j] es el
          pivote, A[i, j] el término

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ mult = A[i,j]/A[j,j]

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ # A toda la fila de la entrada le
          restamos la fila superior \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ por el
          multiplicador

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ A[i,:] = A[i,:] - mult*A[j,:]
          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 

          \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ b[i] = b[i] - mult*b[j]

          \ \ \ \ 

          \ \ \ \ # Devuelve

          \ \ \ \ return A, b
        </with>
      </with>
    </with>
  </algorithm>

  \;

  <\itemize-dot>
    <item><strong|Sustitución regresiva>: Comenzamos a sustituir las
    incógnitas empezando por la última fila. Ésta es la forma en la que el
    computador resuelve los sistemas una vez que están escalonados:
  </itemize-dot>

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|>|<cell|x<rsub|n>=<frac|1|u<rsub|nn>>c<rsub|n,>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|x<rsub|i>=
    <frac|1|u<rsub|ii>><around*|(|c<rsub|i>-<big|sum><rsup|n><rsub|j=i+1>u<rsub|ij>x<rsub|j>|)>\<nocomma\>,i=n-1\<nocomma\>,\<ldots\>,1>>>>
  </eqnarray*>

  <page-break>

  <\example>
    Ejemplo de sustitución regresiva:
  </example>

  \;

  <\eqnarray*>
    <tformat|<cwith|1|3|2|2|cell-halign|l>|<table|<row|<cell|<around*|\<nobracket\>|<tabular*|<tformat|<table|<row|<cell|4x<rsub|1>>|<cell|-2x<rsub|2>>|<cell|+x<rsub|3>>|<cell|=>|<cell|11>>|<row|<cell|>|<cell|3x<rsub|2>>|<cell|-1.5x<rsub|3>>|<cell|=>|<cell|-10.5>>|<row|<cell|>|<cell|>|<cell|3x<rsub|3>>|<cell|=>|<cell|9>>>>>|}>>|<cell|\<nocomma\>x<rsub|3>=<frac|1|3>\<cdot\>9=3>|<cell|>>|<row|<cell|<around*|\<nobracket\>|<tabular*|<tformat|<table|<row|<cell|4x<rsub|1>>|<cell|-2x<rsub|2>>|<cell|+x<rsub|3>>|<cell|=>|<cell|11>>|<row|<cell|>|<cell|3x<rsub|2>>|<cell|-1.5x<rsub|3>>|<cell|=>|<cell|-10.5>>|<row|<cell|>|<cell|>|<cell|x<rsub|3>>|<cell|=>|<cell|3>>>>>|}>>|<cell|x<rsub|2>=<frac|1|3>\<cdot\><around*|(|-10.5+1.5\<cdot\>3|)>=-2>|<cell|>>|<row|<cell|<around*|\<nobracket\>|<tabular*|<tformat|<table|<row|<cell|4x<rsub|1>>|<cell|-2x<rsub|2>>|<cell|+x<rsub|3>>|<cell|=>|<cell|11>>|<row|<cell|>|<cell|>|<cell|x<rsub|2>>|<cell|=>|<cell|-2>>|<row|<cell|>|<cell|>|<cell|x<rsub|3>>|<cell|=>|<cell|3>>>>>|}>>|<cell|x<rsub|1>=<frac|1|4>\<cdot\><around*|(|11-1\<cdot\>3+2\<cdot\><around*|(|-2|)>|)>=1>|<cell|>>|<row|<cell|<around*|{|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>|<cell|=>|<cell|1>>|<row|<cell|x<rsub|2>>|<cell|=>|<cell|-2>>|<row|<cell|x<rsub|3>>|<cell|=>|<cell|3>>>>>|}>>|<cell|>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  \;

  La rutina pretende ilustrar la implementación en Python del método de
  sustitución regresiva.

  \;

  <\algorithm>
    <\with|color|blue>
      \;

      <\with|font|Andale>
        <\with|font-base-size|9>
          def sustitucion_regresiva(A, b):

          \ \ \ \ """

          \ \ \ \ * Toma:

          \ \ \ \ A --\<gtr\> matriz de coeficientes escalonada

          \ \ \ \ b --\<gtr\> matriz de términos independientes escalonada

          \ \ \ \ 

          \ \ \ \ * Devuelve:

          \ \ \ \ b --\<gtr\> vector X de las soluciones (Ax=b)

          \ \ \ \ """

          \ \ \ \ 

          \ \ \ \ A = A.astype(float) # Los coeficientes de las matrices
          pasan a expresarse \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ como
          float

          \ \ \ \ b = b.astype(float) # Los coeficientes de las matrices
          pasan a expresarse \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ como
          float

          \ \ \ \ 

          \ \ \ \ n = A.shape[0] # n es el número de filas de A (número de
          ecuaciones)

          \ \ \ \ 

          \ \ \ \ 

          \ \ \ \ # SUSTUCIÓN REGRESIVA \ \ \ \ \ \ \ 

          \ \ \ \ # Desde la última fila hasta la primera

          \ \ \ \ for j in range(n-1,-1,-1):

          \ \ \ \ \ \ \ \ b[j] = (b[j]-np.dot(A[j, j+1:], b[j+1:]))/A[j,j]

          \ \ \ \ \ \ \ \ 

          \ \ \ \ return b
        </with>
      </with>
    </with>
  </algorithm>

  <new-page>

  <subsubsection|Método de Gauss-Jordan>

  \;

  La eliminacion de Gauss Jordan es una modificación de la eliminación
  gaussiana, aunque también estamos muy familiarizados con ella. El método de
  Gauss transforma A en una matriz triangular superior. El método de
  Gauss-Jordan continúa el proceso hasta obtener una matriz diagonal,
  simplificable en una matriz identidad:

  \;

  <\equation*>
    <around*|(|<tabular|<tformat|<table|<row|<cell|a<rsub|11>>|<cell|a<rsub|12>>|<cell|a<rsub|13>>>|<row|<cell|a<rsub|21>>|<cell|a<rsub|22>>|<cell|a<rsub|23>>>|<row|<cell|a<rsub|31>>|<cell|a<rsub|32>>|<cell|a<rsub|33>>>>>><around*|\||<tabular|<tformat|<table|<row|<cell|b<rsub|1>>>|<row|<cell|b<rsub|2>>>|<row|<cell|b<rsub|3>>>>>>|\<nobracket\>>|)>\<rightarrow\><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|l<rsub|11>>|<cell|l<rsub|12>>|<cell|l<rsub|13>>>|<row|<cell|0>|<cell|l<rsub|22>>|<cell|l<rsub|23>>>|<row|<cell|0>|<cell|0>|<cell|l<rsub|33>>>>>><around*|\||<tabular|<tformat|<table|<row|<cell|b<rprime|'><rsub|1>>>|<row|<cell|b<rprime|'><rsub|2>>>|<row|<cell|b<rprime|'><rsub|3>>>>>>|\<nobracket\>>|)>\<rightarrow\><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|d<rsub|11>>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|d<rsub|22>>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|d<rsub|33>>>>>><around*|\||<tabular|<tformat|<table|<row|<cell|b<rprime|''><rsub|1>>>|<row|<cell|b<rprime|''><rsub|2>>>|<row|<cell|b<rprime|''><rsub|3>>>>>>|\<nobracket\>>|)>
    \<rightarrow\><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>><around*|\||<tabular|<tformat|<table|<row|<cell|c<rsub|1>>>|<row|<cell|c<rsub|2>>>|<row|<cell|c<rsub|3>>>>>>|\<nobracket\>>|)>
  </equation*>

  \;

  \;

  Ir obteniendo <with|font-shape|italic|unos> en la diagonal es otra manera
  de desarrollar el método (tal y como se verá en el ejemplo).

  \;

  Este método es muy usado sobretodo en el cálculo de matrices inversas,
  buscando transformaciones que conviertan la matriz A en la matriz
  identidad:

  \;

  \;

  <\equation*>
    <around*|\<nobracket\>|<around*|(|<tabular|<tformat|<table|<row|<cell|>|<cell|>>|<row|<cell|A>|<cell|>>|<row|<cell|>|<cell|>>>>>|\|><tabular|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>
    \<rightarrow\><around*|(|<tabular|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>><around*|\||<tabular|<tformat|<table|<row|<cell|>>|<row|<cell|A<rsup|<with|font-base-size|8|-1>>>>|<row|<cell|>>>>>|\<nobracket\>>|)>
  </equation*>

  \;

  \;

  <\example>
    Vamos a mostrar un ejemplo de una eliminación de Gauss-Jordan, ya que el
    proce-

    dimiento es muy similar al de Gauss y los algoritmos se pueden deducir:
  </example>

  <\equation*>
    <around*|{|<tabular|<tformat|<table|<row|<cell|x+y+z=5>>|<row|<cell|2x+3y+5z=8>>|<row|<cell|4x+5z=2>>>>>|}><long-arrow|\<rubber-rightarrow\>|forma
    matricial><around*|(|<tabular|<tformat|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|2>|<cell|3>|<cell|5>>|<row|<cell|4>|<cell|0>|<cell|5>>>>><around*|\||<tabular|<tformat|<table|<row|<cell|5>>|<row|<cell|8>>|<row|<cell|2>>>>>|\<nobracket\>>|)>
  </equation*>

  \;

  \;

  Primero obtenemos la matriz triangular superior:

  \;

  <\equation*>
    <around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|2>|<cell|3>|<cell|5>>|<row|<cell|4>|<cell|0>|<cell|5>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|5>>|<row|<cell|8>>|<row|<cell|2>>>>>|\<nobracket\>>|)><long-arrow|\<rubber-rightarrow\>|E<rprime|'><rsub|2>=E<rsub|2>-2E<rsub|1>><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|3>>|<row|<cell|4>|<cell|0>|<cell|5>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|5>>|<row|<cell|-2>>|<row|<cell|2>>>>>|\<nobracket\>>|)><long-arrow|\<rubber-rightarrow\>|E<rprime|'><rsub|3>=E<rsub|3>-4E<rsub|1>><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|3>>|<row|<cell|0>|<cell|-4>|<cell|1>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|5>>|<row|<cell|-2>>|<row|<cell|-18>>>>>|\<nobracket\>>|)><long-arrow|\<rubber-rightarrow\>|E<rprime|'><rsub|3>=E<rsub|3>+4E<rsub|2>><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|3>>|<row|<cell|0>|<cell|0>|<cell|13>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|5>>|<row|<cell|-2>>|<row|<cell|-26>>>>>|\<nobracket\>>|)>
  </equation*>

  \;

  \;

  \;

  A continuación vamos buscando <with|font-shape|italic|ceros> en la diagonal
  principal y sustituyendo hacia atrás:

  \;

  <\equation*>
    <around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|3>>|<row|<cell|0>|<cell|0>|<cell|13>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|5>>|<row|<cell|-2>>|<row|<cell|-26>>>>>|\<nobracket\>>|)><long-arrow|\<rubber-rightarrow\>|E<rprime|'><rsub|3>=<dfrac|E<rsub|3>|13>><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|3>>|<row|<cell|0>|<cell|0>|<cell|1>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|5>>|<row|<cell|-2>>|<row|<cell|-2>>>>>|\<nobracket\>>|)><below|<long-arrow|\<rubber-rightarrow\>|E<rprime|'><rsub|2>=E<rsub|2>-3E<rsub|3>>|E<rprime|'><rsub|1>=E<rsub|1>-3E<rsub|3>><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|7>>|<row|<cell|4>>|<row|<cell|-2>>>>>|\<nobracket\>>|)><below|<long-arrow|\<rubber-rightarrow\>|E<rprime|'><rsub|1>=E<rsub|1>-E<rsub|2>>|><around*|(|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>><around*|\||<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|3>>|<row|<cell|4>>|<row|<cell|-2>>>>>|\<nobracket\>>|)>
  </equation*>

  \;

  \;

  De esta manera obtenemos la solución del sistema:

  \;

  \;

  <\equation*>
    <around*|{|<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|x=3>>|<row|<cell|y=4>>|<row|<cell|z=-2>>>>>|}>
  </equation*>

  <new-page>

  <subsubsection|Sustitución progresiva>

  \;

  Es un buen momento para introducir el algoritmo de la sustitución
  progresiva. El procedimiento el similar al de la sustitución regresiva y su
  uso será vital el los posteriores métodos.\ 

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|x<rsub|1>=<frac|1|u<rsub|11>>b<rsub|1,>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|x<rsub|i>=
    <frac|1|u<rsub|ii>><around*|(|b<rsub|i>-<big|sum><rsup|n><rsub|j=1>u<rsub|ij>x<rsub|j>|)>\<nocomma\>,i=
    2\<nocomma\>\<nocomma\>,3,\<ldots\>, n>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  <\example>
    Ejemplo de sustitución progresiva:
  </example>

  <\eqnarray*>
    <tformat|<table|<row|<cell|<around*|\<nobracket\>|<tabular*|<tformat|<table|<row|<cell|3x<rsub|1>>|<cell|>|<cell|>|<cell|=>|<cell|9>>|<row|<cell|-1.5x<rsub|1>>|<cell|3x<rsub|2>>|<cell|>|<cell|=>|<cell|-10.5>>|<row|<cell|x<rsub|1>>|<cell|-2x<rsub|2>>|<cell|+4x<rsub|3>>|<cell|=>|<cell|11>>>>>|}>>|<cell|\<nocomma\>x<rsub|1>=<frac|1|3>\<cdot\>9=3>|<cell|>>|<row|<cell|<around*|\<nobracket\>|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>|<cell|>|<cell|>|<cell|=>|<cell|3>>|<row|<cell|-1.5x<rsub|1>>|<cell|3x<rsub|2>>|<cell|>|<cell|=>|<cell|-10.5>>|<row|<cell|x<rsub|1>>|<cell|-2x<rsub|2>>|<cell|+4x<rsub|3>>|<cell|=>|<cell|11>>>>>|}>>|<cell|x<rsub|2>=<frac|1|3>\<cdot\><around*|(|-10.5+1.5\<cdot\>3|)>=-2>|<cell|>>|<row|<cell|<around*|\<nobracket\>|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>|<cell|>|<cell|>|<cell|=>|<cell|3>>|<row|<cell|>|<cell|x<rsub|2>>|<cell|>|<cell|=>|<cell|-2>>|<row|<cell|x<rsub|1>>|<cell|-2x<rsub|2>>|<cell|+4x<rsub|3>>|<cell|=>|<cell|11>>>>>|}>>|<cell|x<rsub|3>=<frac|1|4>\<cdot\><around*|(|11-1\<cdot\>3+2\<cdot\><around*|(|-2|)>|)>=1>|<cell|>>|<row|<cell|<around*|{|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>|<cell|=>|<cell|3>>|<row|<cell|x<rsub|2>>|<cell|=>|<cell|-2>>|<row|<cell|x<rsub|3>>|<cell|=>|<cell|1>>>>>|}>>|<cell|>|<cell|>>>>
  </eqnarray*>

  <new-page>

  La rutina pretende ilustrar la implementación en Python del método de
  sustitución progresiva.

  \;

  <\algorithm>
    <\with|color|magenta>
      \;

      <\with|font|Andale|font-base-size|9>
        <\with|color|blue>
          def sustitucion_progresiva(A, b):

          \ \ \ \ """

          \ \ \ \ * Toma:

          \ \ \ \ A --\<gtr\> matriz de coeficientes escalonada

          \ \ \ \ b --\<gtr\> matriz de términos independientes escalonada

          \ \ \ \ 

          \ \ \ \ * Devuelve:

          \ \ \ \ x --\<gtr\> vector X de las soluciones (Ax=b)

          \ \ \ \ """

          \ \ \ \ 

          \ \ \ \ A = A.astype(float) # Los coeficientes de las matrices
          pasan a expresarse \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ como
          float

          \ \ \ \ b = b.astype(float) # Los coeficientes de las matrices
          pasan a expresarse \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ como
          float

          \;

          \ \ \ \ n = A.shape[0] # n es el número de filas de A (ecuaciones)

          \ \ \ \ 

          \ \ \ \ x = np.eye(n,1).astype(float) # Vector para almacenar la
          solución

          \ \ \ \ # SUSTUCIÓN PROGRESIVA \ \ \ \ \ \ \ 

          \ \ \ \ # Desde la última fila hasta la primera

          \ \ \ \ 

          \ \ \ \ x[0] = b[0]

          \ \ \ \ for j in range(1,n):

          \ \ \ \ \ \ \ \ x[j] = b[j]-np.dot(A[j,0:j], x[0:j])

          \ \ \ \ \ \ \ \ 

          \ \ \ \ return x
        </with>
      </with>
    </with>
  </algorithm>

  \;

  <subsection|Pivoteo>

  \;

  El pivoteo dentro de la factorización LU es un punto muy importante. Parte
  de dicha factori- zación reside en ir haciendo una eliminacion Gaussiana
  con sustitución hacia atrás.\ 

  \;

  Para una matriz <math|A\<in\>\<bbb-R\><rsup|nxn >>, la factorización de
  Gauss existe y es única si y solo si las principales submatrices
  <math|A<rsub|i> >de <math|A> (de orden <math|i= >1,2,...,n-1; obtenidas
  restringiendo A a su primera fila y columna <math|i>) son \ invertibles.

  \;

  Si esto no se cumpliera, es decir, si <math|a<rsub|<rsub|i i>>=0>
  (cualquier elemento de la diagonal principal que se use para hacer el
  pivoteo), entonces no se puede seguir con la clásica eliminación gaussiana.
  Por ello surgen los distintos tipos de pivoteo, siendo dificil encontrar un
  buen pivote.\ 

  \;

  <\example>
    Veamos un ejemplo en el que por la elección de un mal pivote (y el
    consecuente redondeo) se obtienen resultados muy diferentes de los
    reales:
  </example>

  Primero vamos a resolver el sistema por Gauus tomando como pivote
  <math|a<rsub|1 1>>=0.0030000 y redon- deando a 4 cifras:

  \;

  <\equation*>
    <with|font-base-size|8|<around*|{|<with|font-base-size|9|<tabular|<tformat|<table|<row|<cell|0.003x<rsub|1>+59.14x<rsub|2>=59.17>>|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
    = 46.78>>>>>>|}>><long-arrow|\<rubber-rightarrow\>|E<rsub|2><rprime|'>=E<rsub|2>-m<rsub|21>*E<rsub|1>|m<rsub|21>=<frac|a<rsub|jk>|a<rsub|k
    k>>=<frac|a<rsub|21>|a<rsub|11>>=<frac|5.291|0.003>=1764><with|font-base-size|8|<around*|{|<tabular|<tformat|<table|<row|<cell|0.003x<rsub|1>+59.14x<rsub|2>\<approx\>59.17>>|<row|<cell|-104300x<rsub|2>
    \<approx\> -104400>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|x<rsub|1>\<approx\>-10>>|<row|<cell|x<rsub|2>
    \<approx\> 1.001>>>>>|}>>
  </equation*>

  <new-page>

  Ahora vamos a resolver el sistema sin redondeo (lo cual hace más tedioso el
  proceso): \ 

  \;

  <\equation*>
    <with|font-base-size|8|<around*|{|<with|font-base-size|9|<tabular|<tformat|<table|<row|<cell|0.003x<rsub|1>+59.14x<rsub|2>=59.17>>|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
    = 46.78>>>>>>|}>><long-arrow|\<rubber-rightarrow\>|E<rsub|2><rprime|'>=E<rsub|2>-m<rsub|21>*E<rsub|1>|m<rsub|21>=<frac|a<rsub|21>|a<rsub|11>>=<frac|5.291|0.003>=1763.6<wide|6|\<invbreve\>>><with|font-base-size|8|<around*|{|<tabular|<tformat|<table|<row|<cell|0.003x<rsub|1>+59.14x<rsub|2>=59.17>>|<row|<cell|-104309.37<wide|6|\<invbreve\>>x<rsub|2>
    =-104309.37<wide|6|\<invbreve\>>>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|x<rsub|1>=10>>|<row|<cell|x<rsub|2>
    = 1>>>>>|}>>
  </equation*>

  \;

  Debido a que el <math|a<rsub|11> >sea un valor muy pequeño y sea elegido
  como pivote, hace que haya una diferencia entre <math|x<rsub|1>> aproximado
  y real (de 20 unidades, lo cual es un gran error). Por lo tanto se emplean
  distintos tipos de pivoteo para solucionar este problema.

  \;

  <subsubsection|Pivoteo parcial>

  \;

  El pivoteo parcial cosiste en analizar los elementos de la columna que
  estén por debajo del <math|a<rsub|i j> <around*|(|siendo i = j\<nocomma\>,
  es decir\<nocomma\>, por debajo del elemento de la diagonal principal|)>> y
  \ selecccionar el elemento <math|a<rsub|p j>> con un mayor valor absoluto
  que el de <math|a<rsub|i j>>, que será el pivote:

  <\equation*>
    a<rsub|<rsub|p j>>=<below|max|i=j,\<ldots\>,n>
    <around*|{|<around*|\||a<rsub|i j>|\|>|}>\<rightarrow\>intercambio filas
    E<rsub|p>\<leftrightharpoons\>E<rsub|i>\ 
  </equation*>

  \;

  <\example>
    Resolvamos de nuevo el sistema aplicando pivoteo parcial y redondeo a 4
    cifras:
  </example>

  <\equation*>
    a<rsub|<rsub|p j>>=max <around*|{|<around*|\||a<rsub|11>|\|>,<around*|\||a<rsub|21>|\|>|}>=
    max <around*|{|<around*|\||0.003|\|>,<around*|\||5.291|\|>|}> =
    <around*|\||5.291|\|> =<around*|\||a<rsub|21>|\|>
  </equation*>

  Por lo tanto vamos a intercambiar <math|E<rsub|1>\<rightleftharpoons\>
  E<rsub|2>>

  <\equation*>
    <with|font-base-size|8|<around*|{|<with|font-base-size|9|<tabular|<tformat|<table|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
    = 46.78>>|<row|<cell|0.003x<rsub|1>+59.14x<rsub|2>=59.17>>>>>>|}>><long-arrow|\<rubber-rightarrow\>|E<rsub|2><rprime|'>=E<rsub|2>-m<rsub|21>*E<rsub|1>|m<rsub|21>=<frac|a<rsub|j
    k>|a<rsub|k k>>=<frac|a<rsub|21>|a<rsub|11>>=<frac|0.003|5.291>=0.000567><with|font-base-size|8|<around*|{|<tabular|<tformat|<table|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
    = 46.78>>|<row|<cell|59.14x<rsub|2> =59.14>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|x<rsub|1>=10>>|<row|<cell|x<rsub|2>
    = 1>>>>>|}>>
  </equation*>

  \;

  Para hacer un cambio de filas, se emplea una matriz <math|P<rsub|n>>
  (matriz identidad a la que se le han aplicado cambios) para que al
  multiplicarla por la izquierda los cambios afecten a las filas:\ 

  \;

  <\equation*>
    <around*|\<nobracket\>|<tabular|<tformat|<table|<row|<cell|I*d<rsub|2>=<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|2|2|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|1>>>>>|)>>>|<row|<cell|S=<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|2|2|cell-rborder|0ln>|<table|<row|<cell|0.003>|<cell|59.14>>|<row|<cell|5.291>|<cell|-6.130>>>>>|)>>>>>>|}><long-arrow|\<rubber-rightarrow\>|E<rsup|
    <around*|(|P|)>><rsub|1>\<leftrightharpoons\>E<rsup|<around*|(|P|)>><rsub|2>>P=<left|(><tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|2|2|cell-rborder|0ln>|<table|<row|<cell|0>|<cell|1>>|<row|<cell|1>|<cell|0>>>>><right|)>\<rightarrow\>P*S=<left|(><tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|l>|<cwith|1|-1|2|2|cell-rborder|0ln>|<table|<row|<cell|5.291>|<cell|-6.130>>|<row|<cell|0.003>|<cell|59.14>>>>><right|)>
  </equation*>

  Una buena matriz <math|P> cumple <math|P<rsup|-1>=P<rsup|t>>

  \;

  Vamos a tomar de nuevo el sistema de ecuaciones anterior (habiendo
  multiplicado la primera fila por <math|10<rsup|4>>) y resolverlo:

  \;

  <with|font-base-size|9|<math|<with|font-base-size|8|<around*|{|<with|font-base-size|8|<tabular|<tformat|<table|<row|<cell|30.00x<rsub|1>+591400x<rsub|2>=591700>>|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
  = 46.78>>>>>>|}>><long-arrow|\<rubber-rightarrow\>|E<rsub|2><rprime|'>=E<rsub|2>-m<rsub|21>*E<rsub|1>|m<rsub|21>=<frac|a<rsub|21>|a<rsub|11>>=<frac|5.291|30.00>=0.1764><with|font-base-size|8|<around*|{|<tabular|<tformat|<table|<row|<cell|30.00x<rsub|1>+591400x<rsub|2>=591700>>|<row|<cell|-104300x<rsub|2>
  =-104400>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|x<rsub|1>=-10>>|<row|<cell|x<rsub|2>
  = 1.001>>>>>|}>>>>

  \;

  Como el valor <math|a<rsub|<rsub|11>>> es el mayor de su columna y es
  distinto de cero, no se aplica el pivoteo parcial, pero los valores
  obtenidos vuelven a ser incorrectos. Para solucionar esto se aplica el
  pivoteo parcial escalado.

  \;

  <subsubsection|Pivoteo parcial escalado>

  \;

  El pivoteo parcial escalado es similar al pivoteo parcial, solo que se
  escoge como pivote el elemento con mayor valor absoluto respecto a todos
  los elementos de la fila. Primero se escoge el elemento de la fila con
  mayor tamaño relativo de cada fila de la matriz:\ 

  <\equation*>
    S<rsub|i>= <below|max|j=1,\<ldots\>,n> <around*|{|<around*|\||a<rsub|i
    j>|\|>|}>\ 
  </equation*>

  <new-page>

  Suponiendo que no hay ningún <math|S<rsub|i >=0>, aplicamos la siguiente
  fórmula:

  <\equation*>
    <frac|<around*|\||a<rsub|11>|\|>|S<rsub|1>>,<frac|<around*|\||a<rsub|21>|\|>|S<rsub|2>>,\<ldots\>,<frac|<around*|\||a<rsub|i1>|\|>|S<rsub|i>>
    <around*|(|siendo i= 1,2,\<ldots\>,n|)>
    <long-arrow|\<rubber-rightarrow\>|p=fila
    pivote><frac|<around*|\||a<rsub|p1>|\|>|S<rsub|p>>=<below|max|k=1,\<ldots\>,n><frac|<around*|\||a<rsub|k1>|\|>|S<rsub|k>>\<rightarrow\>intercambio
    E<rsub|p>\<leftrightharpoons\>E<rsub|k>
  </equation*>

  \;

  <\example>
    Resolvamos el sistema multiplicado por <math|10<rsup|4>> que
    anteriormente dio resultados in correctos:
  </example>

  <\equation*>
    <with|font-base-size|8|<around*|{|<with|font-base-size|8|<tabular|<tformat|<table|<row|<cell|30.00x<rsub|1>+591400x<rsub|2>=591700>>|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
    = 46.78>>>>>>|}>><rsub|><long-arrow|\<rubber-rightarrow\>|<frac|<around*|\||a<rsub|11>|\|>|S<rsub|1>>=
    <frac|30.00|max <around*|{|<around*|\||30.00|\|>,<around*|\||591400|\|>|}>>=<frac|30.00|591400>=0.5073*10<rsup|-4>|<frac|<around*|\||a<rsub|21>|\|>|S<rsub|2>>=
    <frac|5.291|max <around*|{|<around*|\||5.291|\|>,<around*|\||6.130|\|>|}>>=<frac|5.291|6.130>=0.8631><with|font-base-size|8|<around*|{|<with|font-base-size|8|<tabular|<tformat|<table|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
    = 46.78>>|<row|<cell|30.00x<rsub|1>+591400x<rsub|2>=591700>>>>>>|}>>
  </equation*>

  \;

  \;

  Como <math|<frac|<around*|\||a<rsub|11>|\|>|S<rsub|1>>\<less\><frac|<around*|\||a<rsub|21>|\|>|S<rsub|2>>>,
  se lleva a cabo el cambio <math|E<rsub|1>\<rightleftharpoons\> E<rsub|2>
  >(para que así <math|a<rsub|21>> sea el pivote). Despejando se obtienen las
  soluciones correctas:

  \;

  <with|font-base-size|9|<math|<with|font-base-size|8|<around*|{|<with|font-base-size|8|<tabular|<tformat|<table|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
  = 46.78>>|<row|<cell|30.00x<rsub|1>+591400x<rsub|2>=591700>>>>>>|}>><long-arrow|\<rubber-rightarrow\>|E<rsub|2><rprime|'>=E<rsub|2>-m<rsub|21>*E<rsub|1>|m<rsub|21>=<frac|a<rsub|j
  k>|a<rsub|k k>>=<frac|a<rsub|21>|a<rsub|11>>=<frac|30.00|5.291>=5.670><with|font-base-size|8|<around*|{|<with|font-base-size|8|<tabular|<tformat|<table|<row|<cell|5.291x<rsub|1>-6.130x<rsub|2>
  = 46.78>>|<row|<cell|591434.76x<rsub|2>=591434.76>>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|x<rsub|1>=10>>|<row|<cell|x<rsub|2>
  = 1>>>>>|}>>>>

  \;

  \;

  \;

  Existe otro tipo de pivoteo, denominado pivoteo completo, que analiza filas
  y columnas. Su uso, debido al gran número de comparaciones que hay que
  llevar a cabo, se reserva solamente para algunos sistemas en los que la
  precisión sea esencial.

  <section|Factorización LU>

  \;

  Para la factorización <math|LU> supondremos que la matriz <math|A> de
  <math|Ax=b> se puede factorizar como el producto de una matriz triangular
  inferior <math|L> y una matriz triangular superior <math|U>

  <\equation*>
    A=LU
  </equation*>

  \;

  Siendo esto posible, podemos representar nuestro sistema como:

  <\equation*>
    LUx=b
  </equation*>

  \;

  Denominando <math|y> a la matriz columna de <math|n> filas resultado del
  producto de las matrices <math|Ux>, tenemos que la ecuación anterior se
  puede escribir del siguiente modo:

  <\equation*>
    Ly=b
  </equation*>

  \;

  Trabajaremos con <math|LUx=b> y <math|Ly=b>, para resolverlas seguiremos
  estos pasos:

  \;

  <\itemize>
    <item>Primero obtendremos <math|y> utilizando sustitución progresiva en
    la ecuación <math|Ly=b>

    <item>Posteriormenrte obtendremos los valores de x aplicando el algoritmo
    de sustitución regresiva a la ecuación <math|Ux=y>
  </itemize>

  \;

  Encontramos que es posible obtener las matrices L y U mediante la
  eliminación gaussiana.

  \;

  Hemos visto que cualquier matriz <math|A> que podamos factorizar en la
  forma <math|A=LU> es válida para aplicar este método. Pero la ecuación
  anterior no determina la forma única de <math|L> y de <math|U>:

  \;

  <\equation*>
    <around*|(|<tabular*|<tformat|<table|<row|<cell|l<rsub|11>>|<cell|0>|<cell|0>>|<row|<cell|l<rsub|21>>|<cell|l<rsub|22>>|<cell|0>>|<row|<cell|l<rsub|31>>|<cell|l<rsub|32>>|<cell|l<rsub|33>>>>>>|)>\<cdot\><around*|(|<tabular*|<tformat|<table|<row|<cell|u<rsub|11>>|<cell|u<rsub|12>>|<cell|u<rsub|13>>>|<row|0|<cell|u<rsub|22>>|<cell|u<rsub|23>>>|<row|<cell|0>|<cell|0>|<cell|u<rsub|33>>>>>>|)>=<around*|(|<tabular*|<tformat|<table|<row|a<rsub|11>|<cell|a<rsub|12>>|<cell|a<rsub|13>>>|<row|<cell|a<rsub|21>>|<cell|a<rsub|22>>|<cell|a<rsub|23>>>|<row|<cell|a<rsub|31>>|<cell|a<rsub|32>>|<cell|a<rsub|33>>>>>>|)>
  </equation*>

  <new-page>

  Haciendo uso de la multiplicación de matrices obtenemos las siguientes
  ecuaciones no lineales:

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|l<rsub|11>\<cdot\>u<rsub|11>>|<cell|=>|<cell|a<rsub|11>>>|<row|<cell|l<rsub|11>\<cdot\>u<rsub|12>>|<cell|=>|<cell|a<rsub|12>>>|<row|<cell|l<rsub|11>\<cdot\>u<rsub|13>>|<cell|=>|<cell|a<rsub|13>>>|<row|<cell|l<rsub|21>\<cdot\>u<rsub|11>>|<cell|=>|<cell|a<rsub|21>>>|<row|<cell|l<rsub|21>\<cdot\>u<rsub|12>+l<rsub|22>\<cdot\>u<rsub|22>>|<cell|=>|<cell|a<rsub|22>>>|<row|<cell|l<rsub|21>\<cdot\>u<rsub|13>+l<rsub|22>\<cdot\>u<rsub|23>>|<cell|=>|<cell|a<rsub|23>>>|<row|<cell|l<rsub|31>\<cdot\>u<rsub|11>>|<cell|=>|<cell|a<rsub|31>>>|<row|<cell|l<rsub|31>\<cdot\>u<rsub|12>+l<rsub|32>\<cdot\>u<rsub|22>>|<cell|=>|<cell|a<rsub|32>>>|<row|<cell|l<rsub|31>\<cdot\>u<rsub|13>+l<rsub|32>\<cdot\>u<rsub|23>+l<rsub|33>\<cdot\>u<rsub|33>>|<cell|=>|<cell|a<rsub|33>>>>>
  </eqnarray*>

  \;

  Este sistema es indeterminado, contamos con más incógnitas que ecuaciones.
  De este modo la búsqueda de <math|A=LU> arroja infinitas combinaciones
  encerradas en el anterior sistema (que es no lineal). Así, para obtener la
  factorización debemos imponer a las matrices <math|L> y <math|U> alguna
  restricción arbitraria que simplifique las ecuaciones y lleve a una
  solución única. De aquí nacen los distintos métodos para la descomposición
  <math|LU>

  \;

  \;

  <\equation*>
    <tabular|<tformat|<table|<row|<cell|Nombre>|<cell|Restriccion>>|<row|Descomposicion
    de Doolittle|<cell|L<rsub|ii>=1\<nocomma\>\<nocomma\>\<rightarrow\>
    i=1,2\<ldots\> , n>>|<row|<cell|Descomposicion de
    Crout>|<cell|U<rsub|ii>=1\<nocomma\>\<nocomma\>\<rightarrow\>
    i=1,2\<ldots\> , n>>|<row|<cell|Descomposicion de Choleski>|<cell|L =
    U<rsup|T>>>>>>
  </equation*>

  \;

  <subsection|Factorización <math|LU> en términos de operaciones elementales.
  Un primer algoritmo>

  \;

  La búsqueda de la descomposición <math|A=LU> nos lleva al primero de los
  algoritmos. Para ello utilizaremos el concepto de matriz elemental que
  antes hemos repasado.

  \;

  Vamos a descomponer la matriz:

  \;

  <\equation*>
    A= <around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|8>|<cell|11>|<cell|-1>>|<row|<cell|4>|<cell|18>|<cell|5>>>>>|)>
  </equation*>

  \;

  \;

  En cada uno de nuestros pasos escribiremos <math|A >como el producto
  <math|LU>. Tomaremos <math|L> como triangular inferior y <math|>U será
  convertida en triangular superior paso a paso.

  \;

  \;

  El primer paso es partir de <math|L=Id<rsub|3>>, <math|U=A>:

  \;

  \;

  <\equation*>
    A=<wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|L><wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|8>|<cell|11>|<cell|-1>>|<row|<cell|4>|<cell|18>|<cell|5>>>>>|)>|\<wide-underbrace\>><rsub|U>
  </equation*>

  <new-page>

  Para lograr la matriz triangular superior en <math|U> comenzaremos por
  eliminar la entrada <math|U<rsub|2,1>> aplicando la operación elemental
  <math|E<rsub|2>\<rightarrow\>E<rsub|2>+2E<rsub|1>>. Aplicaremos esta
  operación usando la matriz elemental:

  \;

  <\equation*>
    E= <around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|2>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>
  </equation*>

  \;

  \;

  Debemos multiplicar <math|E> por el lado izquierdo de la matriz <math|A>.
  Pero para seguir cumpliendo la igualdad <math|A=LU> utilizaremos el
  producto por su inversa <math|A=LE<rsup|-1>EU >:

  \;

  <\equation*>
    A=<wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|L><wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|E<rsup|-1>><wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|2>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|E><wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|8>|<cell|11>|<cell|-1>>|<row|<cell|4>|<cell|18>|<cell|5>>>>>|)>|\<wide-underbrace\>><rsub|E>
  </equation*>

  \;

  \;

  Simplificando la expresión, <math|U> sufrirá la transformación buscada
  (<math|E<rsub|2>\<rightarrow\>E<rsub|2>+2E<rsub|1>>):

  \;

  <\equation*>
    A=<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|L><wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|0>|<cell|5>|<cell|1>>|<row|<cell|4>|<cell|18>|<cell|5>>>>>|)>|\<wide-underbrace\>><rsub|U>
  </equation*>

  \;

  \;

  Tras el primer paso, <math|A> sigue siendo igual a <math|LU>, <math|L> es
  triangular inferior y seguimos transformando <math|U> en triangular
  superior. Eliminaremos <math|U<rsub|3,1>> con la operación elemental
  <math|E<rsub|3>\<rightarrow\>E<rsub|3>+E<rsub|1>> que se expresa mediante
  la matriz elemental:

  \;

  <\equation*>
    <around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|1>|<cell|0>|<cell|1>>>>>|)>
  </equation*>

  \;

  \;

  Volveremos a usar la inversa de ésta para no romper la igualdad:

  \;

  <\equation*>
    A=<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|L><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|-1>|<cell|0>|<cell|1>>>>>|)><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|1>|<cell|0>|<cell|1>>>>>|)><wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|0>|<cell|5>|<cell|1>>|<row|<cell|4>|<cell|18>|<cell|5>>>>>|)>|\<wide-underbrace\>><rsub|U>
  </equation*>

  \;

  \;

  Esto lleva a la operación <math|E<rsub|3>\<rightarrow\>E<rsub|3>+E<rsub|1>>
  en las filas de <math|U> y <math|C<rsub|3>\<rightarrow\>C<rsub|3>+C<rsub|1>>
  en las columnas de <math|L>:

  \;

  <\equation*>
    A=<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|-1>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|L><wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|0>|<cell|5>|<cell|1>>|<row|<cell|0>|<cell|15>|<cell|6>>>>>|)>|\<wide-underbrace\>><rsub|U>
  </equation*>

  \;

  \;

  Los resultados son similares a los del paso anterior. Pasamos a eliminar
  <math|U<rsub|3,2>> aplicando la operación
  <math|E<rsub|3>\<rightarrow\>E<rsub|3>-3E<rsub|2><rsub|>> mediante la
  matriz elemental:

  \;

  <\equation*>
    <around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|-3>|<cell|1>>>>>|)>
  </equation*>

  <new-page>

  Continuamos con el procedimiento

  \;

  <\equation*>
    A=<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|-1>|<cell|0>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|L><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|3>|<cell|1>>>>>|)><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|-3>|<cell|1>>>>>|)><wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|0>|<cell|5>|<cell|1>>|<row|<cell|0>|<cell|15>|<cell|6>>>>>|)>|\<wide-underbrace\>><rsub|U>
  </equation*>

  \;

  \;

  Finalmemte, obtenemos la operación <math|E<rsub|3>\<rightarrow\>E<rsub|3>-3E<rsub|2>>
  en las filas de <math|U> y <math|C<rsub|3>\<rightarrow\>C<rsub|3>-3C<rsub|2>>
  en las columnas de <math|L>

  \;

  <\equation*>
    A=<wide*|<around*|(|<tabular*|<tformat|<table|<row|1|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|-1>|<cell|3>|<cell|1>>>>>|)>|\<wide-underbrace\>><rsub|L><wide*|<around*|(|<tabular*|<tformat|<table|<row|<cell|-4>|<cell|-3>|<cell|1>>|<row|<cell|0>|<cell|5>|<cell|1>>|<row|<cell|0>|<cell|0>|<cell|3>>>>>|)>|\<wide-underbrace\>><rsub|U>
  </equation*>

  \;

  \;

  Así hemos llegado a la solución que buscábamos.

  <subsection|Permutación>

  \;

  Aunque este método resulta muy cómodo, en ocasiones tenemos algunos
  problemas con la situación de algún 0 en la matriz, que nos impide
  desarrollar dicho proceso adecuadamente. Por ello, debemos hacer algunos
  ajustes y recurrir a la llamada matriz de permutación P. Para ello
  utilizamos la siguiente expresión:

  \;

  <\equation*>
    P*<math|>A=L*U
  </equation*>

  \;

  \;

  donde la matriz <math|P> no es más que una variación de la matriz <math|>
  Id<math|<rsub|n>> a la que se realizan los cambios de filas deseados y se
  introduce a la izquierda de la matriz <math|A>, colocando sus respectivas
  filas de forma adecuada. Además, cabe destacar que para que <math|P> sea
  una buena matriz de permutación, debe tener inversa y se debe cumplir que
  <math|P<rsup|<math|-1>>=P<math|<rsup|t>>>.

  \;

  Así, de forma parecida a como procedemos con el método <math|LU> planteamos
  una serie de expresiones para acabar consiguiendo de nuevo dos sistemas de
  ecuaciones que nos permitan resolver el ejercicio:

  \;

  \;

  <\equation*>
    A\<cdot\>X=b<long-arrow|\<rubber-rightarrow\>|>P\<cdot\>A\<cdot\>X=P\<cdot\>b<long-arrow|\<rubber-rightarrow\>|A=L\<cdot\>U>L\<cdot\>U\<cdot\>X=P\<cdot\>
    b\<rightarrow\><around*|{|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|1|1|cell-rborder|0ln>|<table|<row|<cell|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|l>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|1|1|cell-rborder|0ln>|<table|<row|<cell|L\<cdot\>Y=P\<cdot\>
    b>>|<row|<cell|U\<cdot\>X=Y>>>>>>>>>>|}>
  </equation*>

  \;

  En ambos métodos se tienen i-1 sumas; i-1 productos y 1 división. Por tanto
  el número de operaciones realizadas es:

  \;

  \;

  <\equation*>
    <big|sum><rsub|i=1><rsup|n>1+2*<big|sum><rsub|i=1><rsup|n><around*|(|i-1|)>=
    2*<big|sum><rsub|i=1><rsup|n><around*|(|i-n|)>= n<rsup|2> operaciones
  </equation*>

  <new-page>

  <\example>
    Ejemplo de permutación:
  </example>

  \;

  <\equation*>
    A =<around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|5>|<cell|2>>|<row|<cell|1>|<cell|3>|<cell|-6>>|<row|<cell|-2>|<cell|4>|<cell|9>>>>>|)>\<nocomma\>,
    b=<around*|(|<tabular*|<tformat|<table|<row|<cell|b<rsub|1>>>|<row|<cell|b<rsub|2>>>|<row|<cell|b<rsub|3>>>>>>|)>,X=<around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>>>>|)>
  </equation*>

  \;

  \;

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>||<cell|U<rsub|inicial>=<around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|5>|<cell|2>>|<row|<cell|1>|<cell|3>|<cell|-6>>|<row|<cell|-2>|<cell|4>|<cell|9>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|1>\<leftrightharpoons\>F<rsub|3>><around*|(|<tabular*|<tformat|<table|<row|<cell|-2>|<cell|4>|<cell|9>>|<row|<cell|1>|<cell|3>|<cell|-6>>|<row|<cell|0>|<cell|5>|<cell|2>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|2>\<rightarrow\>F<rsub|1>+2F<rsub|2>><around*|(|<tabular*|<tformat|<table|<row|<cell|-2>|<cell|4>|<cell|9>>|<row|<cell|0>|<cell|10>|<cell|-3>>|<row|<cell|0>|<cell|5>|<cell|2>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|3>\<rightarrow\>F<rsub|2>-2F<rsub|3>>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|<long-arrow|\<rubber-rightarrow\>|F<rsub|3>\<rightarrow\>F<rsub|2>-2F<rsub|3>><around*|(|<tabular*|<tformat|<table|<row|<cell|-2>|<cell|4>|<cell|9>>|<row|<cell|0>|<cell|10>|<cell|-3>>|<row|<cell|0>|<cell|0>|<cell|-7>>>>>|)>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|L<rsub|inicial>=<around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|0>>>>>|)><long-arrow|\<rubber-rightarrow\>|Sin
    cambios><around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|0>>>>>|)><long-arrow|\<rubber-rightarrow\>|Multiplicador
    1><around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|0>>>>>|)><long-arrow|\<rubber-rightarrow\>|Multiplicador
    2>>>|<row|<cell|>|<cell|>|<cell|>>|<row|||<cell|<long-arrow|\<rubber-rightarrow\>|Multiplicador
    2><around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|2>|<cell|0>>>>>|)><long-arrow|\<rubber-rightarrow\>|+Identidad><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|2>|<cell|1>>>>>|)>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|P<rsub|inicial>=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>><text|>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|1>\<leftrightarrows\>F<rsub|3>><around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|1>|<cell|0>|<cell|0>>>>>|)><long-arrow|\<rubber-rightarrow\>|Sin
    cambios><around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|1>|<cell|0>|<cell|0>>>>>|)><long-arrow|\<rubber-rightarrow\>|Sin
    cambios><around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|1>|<cell|0>|<cell|0>>>>>|)>>>>>
  </eqnarray*>

  \;

  \;

  \;

  \;

  \;

  <\equation*>
    U=<around*|(|<tabular*|<tformat|<table|<row|<cell|-2>|<cell|4>|<cell|9>>|<row|<cell|0>|<cell|10>|<cell|-3>>|<row|<cell|0>|<cell|0>|<cell|-7>>>>>|)>\<nocomma\>,L=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-2>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|2>|<cell|1>>>>>|)>,P=<around*|(|<tabular*|<tformat|<table|<row|<cell|0>|<cell|0>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|1>|<cell|0>|<cell|0>>>>>|)>,y=<around*|(|<tabular*|<tformat|<table|<row|<cell|y<rsub|1>>>|<row|<cell|y<rsub|2>>>|<row|<cell|y<rsub|3>>>>>>|)>
  </equation*>

  \;

  \;

  \;

  <\equation*>
    <around*|\<nobracket\>|<tabular|<tformat|<table|<row|<cell|A*x=b>>|<row|<cell|P*A*x=P*b>>|<row|<cell|P*A=L*U>>|<row|<cell|L*U*x=P*b>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|L*x=P*b>>|<row|<cell|U*x=y>>>>>|}>
  </equation*>

  \;

  \;

  \;

  De este modo se plantean los dos sistemas de ecuaciones, se resuelven y se
  obtienen las soluciones del problema.<new-page>

  <subsection|Descomposición de Crout>

  \;

  En el método de Crout, la matriz L es una matriz triangular inferior,
  mientras que la matriz U es una matriz trianguilar superior con elementos
  unitarios en la diagonal principal. Presentan la siguiente forma:

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|L=<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|5|5|1|1|cell-halign|c>|<cwith|5|5|1|1|cell-lborder|0ln>|<cwith|5|5|2|2|cell-halign|c>|<cwith|5|5|3|3|cell-halign|c>|<cwith|1|5|5|5|cell-halign|c>|<cwith|1|5|5|5|cell-rborder|0ln>|<cwith|5|5|5|5|cell-halign|c>|<cwith|5|5|5|5|cell-rborder|0ln>|<table|<row|<cell|L<rsub|11>>|<cell|0>|<cell|0>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|L<rsub|21>>|<cell|L<rsub|22>>|<cell|0>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|L<rsub|33>>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|L<rsub|n1>>|<cell|L<rsub|n2>>|<cell|L<rsub|n3>>|<cell|\<ldots\>>|<cell|L<rsub|nn>>>>>>|)>
    >|<cell| >|<cell| U=<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|5|5|1|1|cell-halign|c>|<cwith|5|5|1|1|cell-lborder|0ln>|<cwith|5|5|2|2|cell-halign|c>|<cwith|5|5|3|3|cell-halign|c>|<cwith|1|5|5|5|cell-halign|c>|<cwith|1|5|5|5|cell-rborder|0ln>|<cwith|5|5|5|5|cell-halign|c>|<cwith|5|5|5|5|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|U<rsub|12>>|<cell|U<rsub|13>>|<cell|\<ldots\>>|<cell|U<rsub|1n>>>|<row|<cell|0>|<cell|1>|<cell|U<rsub|23>>|<cell|\<ldots\>>|<cell|U<rsub|2n>>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|\<ldots\>>|<cell|U<rsub|3n>>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|\<ldots\>>|<cell|U<rsub|nn>>>>>>|)>>>>>
  </eqnarray*>

  \;

  \;

  Una vez planteados estos esquemas, se utilizará la condición existente de
  que el producto de ambas matrices triangulares debe ser igual a la matriz
  de coeficientes A. De este modo se plantean las ecuaciones, que nos
  permiten determinar el valor de los términos de cada matriz. Además, es
  aconsejable que esta serie de cálculos se hagan en un determinado orden
  para poder obtener directamente los valores sin que aparezcan varias
  incógnitas en las expresiones, de forma que se alternen el cálculo de
  columnas de L con las propias de U:

  \;

  \;

  <\equation*>
    <around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|4|4|1|1|cell-halign|c>|<cwith|4|4|1|1|cell-lborder|0ln>|<cwith|4|4|2|2|cell-halign|c>|<cwith|4|4|3|3|cell-halign|c>|<cwith|1|4|4|4|cell-halign|c>|<cwith|1|4|4|4|cell-rborder|0ln>|<cwith|4|4|4|4|cell-halign|c>|<cwith|4|4|4|4|cell-rborder|0ln>|<table|<row|<cell|L<rsub|11>>|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|L<rsub|21>>|<cell|L<rsub|22>>|<cell|0>|<cell|0>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|L<rsub|33>>|<cell|0>>|<row|<cell|L<rsub|41>>|<cell|L<rsub|42>>|<cell|L<rsub|43>>|<cell|L<rsub|44>>>>>>|)>\<cdot\><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|4|4|1|1|cell-halign|c>|<cwith|4|4|1|1|cell-lborder|0ln>|<cwith|4|4|2|2|cell-halign|c>|<cwith|4|4|3|3|cell-halign|c>|<cwith|1|4|4|4|cell-halign|c>|<cwith|1|4|4|4|cell-rborder|0ln>|<cwith|4|4|4|4|cell-halign|c>|<cwith|4|4|4|4|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|U<rsub|12>>|<cell|U<rsub|13>>|<cell|U<rsub|14>>>|<row|<cell|0>|<cell|1>|<cell|U<rsub|23>>|<cell|U<rsub|24>>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|U<rsub|34>>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|1>>>>>|)>=<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|4|4|cell-halign|c>|<cwith|1|-1|4|4|cell-rborder|0ln>|<table|<row|<cell|a<rsub|11>>|<cell|a<rsub|12>>|<cell|a<rsub|13>>|<cell|a<rsub|14>>>|<row|<cell|a<rsub|21>>|<cell|a<rsub|22>>|<cell|a<rsub|23>>|<cell|a<rsub|24>>>|<row|<cell|a<rsub|31>>|<cell|a<rsub|32>>|<cell|a<rsub|33>>|<cell|a<rsub|34>>>|<row|<cell|a<rsub|41>>|<cell|a<rsub|42>>|<cell|a<rsub|43>>|<cell|a<rsub|44>>>>>>|)>
  </equation*>

  \;

  \;

  <\itemize-dot>
    <item>Se calcula la primera columna de L:
  </itemize-dot>

  <strong|>

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|<tabular|<tformat|<cwith|1|4|1|1|cell-halign|c>|<cwith|1|4|1|1|cell-lborder|0ln>|<cwith|4|4|1|1|cell-halign|c>|<cwith|4|4|1|1|cell-lborder|0ln>|<cwith|1|4|2|2|cell-halign|c>|<cwith|1|4|2|2|cell-lborder|0ln>|<table|<row|<cell|L<rsub|11>=>|<cell|a<rsub|11>>>|<row|<cell|L<rsub|21>=>|<cell|a<rsub|21>>>|<row|<cell|L<rsub|31>=>|<cell|a<rsub|31>>>|<row|<cell|L<rsub|41>=>|<cell|a<rsub|41>>>>>>>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  <\itemize-dot>
    <item>A continuación se procede con la primera fila de U:
  </itemize-dot>

  \;

  <\eqnarray*>
    <tformat|<cwith|1|1|2|2|cell-halign|c>|<cwith|1|1|2|2|cell-lborder|0ln>|<cwith|1|1|2|2|cell-halign|c>|<cwith|1|1|2|2|cell-lborder|0ln>|<table|<row|<cell|>|L<rsub|11>\<cdot\>U<rsub|12>=a<rsub|12>\<rightarrow\>U<rsub|12>=<frac|a<rsub|12>|L<rsub|11>>|<cell|>>|<row|<cell|>|<cell|L<rsub|11>\<cdot\>U<rsub|13>=a<rsub|13>\<rightarrow\>U<rsub|13>=<frac|a<rsub|13>|L<rsub|11>>>|<cell|>>|<row|<cell|>|<cell|L<rsub|11>\<cdot\>U<rsub|14>=a<rsub|14>\<rightarrow\>U<rsub|14>=<frac|a<rsub|14>|L<rsub|11>>>|<cell|>>>>
  </eqnarray*>

  \;

  <\itemize-dot>
    <item>Después se van planteando el resto de ecuaciones (cuyo número
    dependerá de la dimensión de la matriz de coeficientes) y despejando
    términos hasta obtener todos los valores de las matrices L y U.
  </itemize-dot>

  <\itemize-dot>
    <item>Una vez que se tienen ambas matrices, se puede realizar la
    factorización LU de forma normal como se explicó anteriormente.
  </itemize-dot>

  <new-page>

  <\example>
    Descomposición de Crout:
  </example>

  <\equation*>
    A= <around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|5>|<cell|3>>|<row|<cell|-1>|<cell|0>|<cell|1>>|<row|<cell|3>|<cell|2>|<cell|4>>>>>|)>
  </equation*>

  \;

  Se plantea la ecuación <math|LU=A>:

  \;

  <\equation*>
    <around*|(|<tabular|<tformat|<cwith|1|3|1|1|cell-halign|c>|<cwith|1|3|1|1|cell-lborder|0ln>|<cwith|2|3|2|2|cell-halign|c>|<table|<row|<cell|L<rsub|11>>|<cell|0>|<cell|0>>|<row|<cell|L<rsub|21>>|<cell|L<rsub|22>>|<cell|0>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|L<rsub|33>>>>>>|)>\<cdot\><around*|(|<tabular|<tformat|<cwith|1|3|1|1|cell-halign|c>|<cwith|1|3|1|1|cell-lborder|0ln>|<cwith|2|3|2|2|cell-halign|c>|<cwith|1|1|2|2|cell-halign|c>|<cwith|1|1|3|3|cell-halign|c>|<table|<row|<cell|1>|<cell|U<rsub|12>>|<cell|U<rsub|13>>>|<row|<cell|0>|<cell|1>|<cell|U<rsub|23>>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>=<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|-1>|<cell|0>|<cell|1>>|<row|<cell|3>|<cell|2>|<cell|4>>>>>|)>
  </equation*>

  \;

  \;

  A continuación se van resolviendo las ecuaciones y se obtienen los valores
  de cada término de ambas matrices triangulares:

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|<around*|{|<tabular|<tformat|<cwith|1|3|1|1|cell-halign|c>|<cwith|1|3|1|1|cell-lborder|0ln>|<table|<row|<cell|L<rsub|11>=1>|<cell|>>|<row|<cell|L<rsub|21>=-1>|<cell|>>|<row|<cell|L<rsub|31>=3>|<cell|>>>>>|}>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<around*|{|<tabular|<tformat|<table|<row|<cell|U<rsub|12>=<frac|5|L<rsub|11>>>>|<row|<cell|U<rsub|13>=<frac|2|L<rsub|11>>>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|U<rsub|12>=5>>|<row|<cell|U<rsub|13>=2>>>>>|}>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|<around*|{|<rsub|><tabular|<tformat|<table|<row|<cell|L<rsub|21>\<cdot\>U<rsub|12>+L<rsub|22>=0>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|L<rsub|22>=5>>>>>|}>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|<around*|{|<tabular|<tformat|<table|<row|<cell|L<rsub|21>\<cdot\>U<rsub|13>+L<rsub|22>\<cdot\>U<rsub|23>=1>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|U<rsub|23>=<frac|3|5>>>>>>|}>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|<around*|{|<tabular|<tformat|<table|<row|<cell|L<rsub|31>\<cdot\>U<rsub|12>+L<rsub|32>=2>>|<row|<cell|L<rsub|31>\<cdot\>U<rsub|13>+L<rsub|32>\<cdot\>U<rsub|23>+L<rsub|33>=4>>>>>|}>\<rightarrow\><around*|{|<tabular|<tformat|<table|<row|<cell|L<rsub|32>=-13>>|<row|<cell|L<rsub|33>=29/5>>>>>|}>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>>>
  </eqnarray*>

  \;

  Una vez que se obtienen todos los valores tenemos las matrices <math|L> y
  <math|U>:

  \;

  \;

  <\equation*>
    <around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|-1>|<cell|0>|<cell|1>>|<row|<cell|3>|<cell|2>|<cell|4>>>>>|)>=<around*|(|<tabular|<tformat|<cwith|1|3|1|1|cell-halign|c>|<cwith|1|3|1|1|cell-lborder|0ln>|<cwith|2|3|2|2|cell-halign|c>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-1>|<cell|5>|<cell|0>>|<row|<cell|3>|<cell|-13>|<frac|29|5>>>>>|)>\<cdot\><around*|(|<tabular|<tformat|<cwith|1|3|1|1|cell-halign|c>|<cwith|1|3|1|1|cell-lborder|0ln>|<cwith|2|3|2|2|cell-halign|c>|<cwith|1|1|2|2|cell-halign|c>|<cwith|1|1|3|3|cell-halign|c>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|0>|<cell|1>|<cell|<frac|3|5>>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)>
  </equation*>

  \;

  \;

  <\equation*>
    <tabular*|<tformat|<table|<row|<cell|A*x=b>>|<row|<cell|L*U*x=b>>>>>\<rightarrow\><around*|{|<tabular*|<tformat|<table|<row|<cell|L*y=b>>|<row|<cell|U*x=y>>>>>|}>
  </equation*>

  \;

  \;

  Se plantean los dos sistemas de ecuaciones y se resuelven obteniendo las
  soluciones del problema.<new-page>

  <subsection|Descomposición de Doolittle>

  \;

  En este método, la diagonal principal de la matriz L está compuesta de
  <with|font-shape|italic|unos>:

  \;

  \;

  \ \ \ \ \ \ \ \ <math|L=<around*|(|<tabular|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|L<rsub|21>>|<cell|1>|<cell|0>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|1>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|L<rsub|n1>>|<cell|L<rsub|n2>>|<cell|L<rsub|n3>>|<cell|\<ldots\>>|<cell|1<rsub|n
  n>>>>>>|)> > \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ <math|U=<around*|(|<tabular|<tformat|<table|<row|<cell|U<rsub|11>>|<cell|U<rsub|12>>|<cell|U<rsub|13>>|<cell|\<ldots\>>|<cell|U<rsub|1n>>>|<row|<cell|0>|<cell|U<rsub|22>>|<cell|U<rsub|23>>|<cell|\<ldots\>>|<cell|U<rsub|2n>>>|<row|<cell|0>|<cell|0>|<cell|U<rsub|33>>|<cell|\<ldots\>>|<cell|U<rsub|3n>>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|\<ldots\>>|<cell|U<rsub|nn>>>>>>|)>>

  \;

  \;

  \;

  <\itemize>
    <item>Para este tipo de descomposición, tomando una matriz 3x3 como
    ejemplo, las matrices L y U son de la forma:
  </itemize>

  \;

  <\equation*>
    L=<matrix|<tformat|<twith|table-min-cols|3>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|L<rsub|21>>|<cell|1>|<cell|0>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|1>>>>>
    ; U=<matrix|<tformat|<table|<row|<cell|U<rsub|11>>|<cell|U<rsub|12>>|<cell|U<rsub|13>>>|<row|<cell|0>|<cell|U<rsub|22>>|<cell|U<rsub|23>>>|<row|<cell|0>|<cell|0>|<cell|U<rsub|33>>>>>>
  </equation*>

  \;

  \;

  \ 

  <\itemize>
    <item>Aplicando la igualdad genérica A=LU:
  </itemize>

  \;

  <\equation*>
    A=<matrix|<tformat|<table|<row|<cell|U<rsub|11>>|<cell|U<rsub|12>>|<cell|U<rsub|13>>>|<row|<cell|U<rsub|11>L<rsub|21>>|<cell|U<rsub|12>L<rsub|21>+U<rsub|22>>|<cell|U<rsub|13>L<rsub|21>+U<rsub|23>>>|<row|<cell|U<rsub|11>L<rsub|31>>|<cell|U<rsub|12>L<rsub|31>+U<rsub|22>L<rsub|32>>|<cell|U<rsub|13>L<rsub|31>+U<rsub|23>L<rsub|32>+U<rsub|33>>>>>>
  </equation*>

  \;

  \;

  <\itemize>
    <item>Aplicando eliminación gaussiana:
  </itemize>

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|<with|font-base-size|9|<tformat|<table|<row|<cell|<with|font-base-size|8|<with|font-base-size|8|<matrix|<tformat|<table|<row|<cell|U<rsub|11>>|<cell|U<rsub|12>>|<cell|U<rsub|13>>>|<row|<cell|U<rsub|11>L<rsub|21>>|<cell|U<rsub|12>L<rsub|21>+U<rsub|22>>|<cell|U<rsub|13>L<rsub|21>+U<rsub|23>>>|<row|<cell|U<rsub|11>L<rsub|31>>|<cell|U<rsub|12>L<rsub|31>+U<rsub|22>L<rsub|32>>|<cell|U<rsub|13>L<rsub|31>+U<rsub|23>L<rsub|32>+U<rsub|33>>>>>><long-arrow|\<rubber-rightarrow\>|F<rsub|2>\<rightarrow\>F<rsub|2>-L<rsub|21>F<rsub|1>*|F<rsub|3>\<rightarrow\>F<rsub|3>-L<rsub|31>F<rsub|1>>><matrix|<tformat|<table|<row|<cell|U<rsub|11>>|<cell|U<rsub|12>>|<cell|U<rsub|13>>>|<row|<cell|0>|<cell|U<rsub|22>>|<cell|U<rsub|23>>>|<row|<cell|0>|<cell|U<rsub|22>L<rsub|32>>|<cell|U<rsub|23>L<rsub|32>+U<rsub|33>>>>>><long-arrow|\<rubber-rightarrow\>|F<rsub|3>\<rightarrow\>F<rsub|3>-L<rsub|32>F<rsub|2>*><matrix|<tformat|<table|<row|<cell|U<rsub|11>>|<cell|U<rsub|12>>|<cell|U<rsub|13>>>|<row|<cell|0<rsub|>>|<cell|U<rsub|22>>|<cell|U<rsub|23>>>|<row|<cell|0>|<cell|0>|<cell|U<rsub|33>>>>>>>>|<cell|>>>>>>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  <\itemize>
    <item>Es interesante al realizar la eliminación gaussiana, en vez de
    escribir los ceros, escribir los coeficientes que hemos aplicado para
    anular cada uno de los elementos. Así, finalmente nos quedaría una matriz
    de la siguiente forma:
  </itemize>

  \;

  <\equation*>
    <matrix|<tformat|<table|<row|<cell|L<around*|\|||\<nobracket\>>U>>>>>=<matrix|<tformat|<table|<row|<cell|U<rsub|11>>|<cell|U<rsub|12>>|<cell|U<rsub|13>>>|<row|<cell|L<rsub|21>>|<cell|U<rsub|22>>|<cell|U<rsub|23>>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|U<rsub|33>>>>>>
  </equation*>

  \;

  \;

  <\itemize>
    <item>Podemos hacer tres observaciones a raíz de esto:

    <\itemize-minus>
      <\itemize-arrow>
        <item>La matriz U buscada es la que resulta al aplicar la eliminación
        gaussiana a la matriz A

        <item><math|L<rsub|i j>> es el coeficiente que elimina el elemento
        <math|A<rsub|i j>>

        <item>Es imprescindible que los elementos de L en la matriz
        L<math|<mid|/>>U sean tomados con el signo que posean excluyendo el
        signo de la resta, es decir:

        <\itemize-minus>
          <item>Si la operación es de resta, tomaremos <math|L<rsub|i j>>

          <item>Si la operación es de suma, tomaremos <math|-L<rsub|i j>>
        </itemize-minus>

        <new-page>
      </itemize-arrow>
    </itemize-minus>
  </itemize>

  <\example>
    Ejemplo descomposición Doolittle.
  </example>

  Resolver el sistema <math|A<math|*x=b>>:

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|A=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|-1>|<cell|0>|<cell|1>>|<row|<cell|3>|<cell|2>|<cell|4>>>>>|)>B=
    <around*|(|<tabular*|<tformat|<table|<row|<cell|5>>|<row|<cell|8>>|<row|<cell|-7>>>>>|)>,x=
    <around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>>>|<row|<cell|x<rsub|2>>>|<row|<cell|x<rsub|3>>>>>>|)>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|A*x=b>|<cell|>>|<row|<cell|>|<cell|A=L*U>|<cell|>>|<row|<cell|>|<cell|L*U*x=b>|<cell|>>|<row|<cell|>|<cell|\<downarrow\>>|<cell|>>|<row|<cell|>|<cell|<around*|{|<tabular*|<tformat|<table|<row|<cell|L*y=b>>|<row|<cell|U*x=y>>>>>|}>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|U<rsub|inicial>=<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|-1>|<cell|0>|<cell|1>>|<row|<cell|3>|<cell|5>|<cell|4>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|2>\<rightarrow\>F<rsub|1>+*F<rsub|2>><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|0>|<cell|5>|<cell|3>>|<row|<cell|3>|<cell|5>|<cell|4>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|3>\<rightarrow\>F<rsub|3>-3*F<rsub|1>><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|0>|<cell|5>|<cell|3>>|<row|<cell|0>|<cell|-10>|<cell|-2>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|3>\<rightarrow\>F<rsub|3>+2*F<rsub|2>><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|0>|<cell|5>|<cell|3>>|<row|<cell|0>|<cell|0>|<cell|4>>>>>|)>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|L<rsub|inicial>=
    <around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)><long-arrow|\<rubber-rightarrow\>|Factor1><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-1>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>|)><long-arrow|\<rubber-rightarrow\>|Factor2><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-1>|<cell|1>|<cell|0>>|<row|<cell|3>|<cell|0>|<cell|1>>>>>|)><long-arrow|\<rubber-rightarrow\>|Factor3><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-1>|<cell|1>|<cell|0>>|<row|<cell|3>|<cell|-2>|<cell|1>>>>>|)>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|U=<around*|(|<text|<tabular*|<tformat|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|0>|<cell|5>|<cell|3>>|<row|<cell|0>|<cell|0>|<cell|4>>>>>>|)>\<nocomma\>,
    L=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-1>|<cell|1>|<cell|0>>|<row|<cell|3>|<cell|-2>|<cell|1>>>>>|)>,y=<around*|(|<tabular*|<tformat|<table|<row|<cell|y<rsub|1>>>|<row|<cell|y<rsub|2>>>|<row|<cell|y<rsub|3>>>>>>|)>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|-1>|<cell|1>|<cell|0>>|<row|<cell|3>|<cell|-2>|<cell|1>>>>>|)>\<cdot\><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|1|1|cell-rborder|0ln>|<table|<row|<cell|<with|math-font-family|rm|y<rsub|1>>>>|<row|<cell|<with|math-font-family|rm|y<rsub|2>>>>|<row|<cell|<with|math-font-family|rm|y<rsub|3>>>>>>>|)>=
    <around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|1|1|cell-rborder|0ln>|<table|<row|<cell|5>>|<row|<cell|8>>|<row|<cell|15>>>>>|)>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|<around*|(|<tabular*|<tformat|<table|<row|y<rsub|1>>|<row|<cell|-y<rsub|1>+y<rsub|2>>>|<row|<cell|3y<rsub|1>-2y<rsub|2>+y<rsub|3>>>>>>|)>=<around*|(|<tabular*|<tformat|<table|<row|<cell|5>>|<row|<cell|8>>|<row|<cell|15>>>>>|)>>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  \;

  Haciendo uso de la sustitución progresiva:

  \;

  \;

  <\equation*>
    y = <around*|(|<tabular*|<tformat|<table|<row|5>|<row|<cell|13>>|<row|<cell|4>>>>>|)>
  </equation*>

  <new-page>

  Continuamos resolviendo <math|Ux=y>:

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|2|2|cell-halign|c>|<cwith|1|-1|3|3|cell-halign|c>|<cwith|1|-1|3|3|cell-rborder|0ln>|<table|<row|<cell|1>|<cell|5>|<cell|2>>|<row|<cell|0>|<cell|5>|<cell|3>>|<row|<cell|0>|<cell|0>|<cell|4>>>>>|)>\<cdot\><around*|(|<tabular*|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<cwith|1|-1|1|1|cell-lborder|0ln>|<cwith|1|-1|1|1|cell-rborder|0ln>|<table|<row|<cell|<with|math-font-family|rm|x<rsub|1>>>>|<row|<cell|<with|math-font-family|rm|x<rsub|2>>>>|<row|<cell|<with|math-font-family|rm|x<rsub|3>>>>>>>|)>=<around*|(|<tabular*|<tformat|<table|<row|<cell|5>>|<row|<cell|13>>|<row|<cell|4>>>>>|)>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|x<rsub|1>+5x<rsub|2>+2x<rsub|3>>>|<row|<cell|5x<rsub|2>+3x<rsub|3>>>|<row|<cell|4x<rsub|3>>>>>>|)>=<around*|(|<tabular*|<tformat|<table|<row|<cell|5>>|<row|<cell|13>>|<row|<cell|4>>>>>|)>>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  Con el uso de la sustitución regresiva llegamos a la solución final del
  problema:

  \;

  \;

  <\equation*>
    x= <around*|(|<tabular*|<tformat|<table|<row|<cell|-7>>|<row|<cell|2>>|<row|<cell|1>>>>>|)>
  </equation*>

  \;

  \;

  \;

  El siguiente algoritmo ilustra \ la implementación \ de la descomposición
  de Doolittle en el lenguaje Python.

  \;

  <\algorithm>
    <\with|font|Andale|font-base-size|9>
      <\with|color|blue>
        def doolittle(A, b):

        \ \ \ \ """

        \ \ \ \ Implementación de la Factorización de Doolittle.

        \ \ \ \ 

        \ \ \ \ * Toma:

        \ \ \ \ A --\<gtr\> matriz de coeficientes\ 

        \ \ \ \ b --\<gtr\> matriz de términos independientes

        \ \ \ \ 

        \ \ \ \ * Devuelve:

        \ \ \ \ L --\<gtr\> triangular inferior de la factorización

        \ \ \ \ U --\<gtr\> triangular superior de la factorización

        \ \ \ \ b --\<gtr\> términos independientes (no los modifica)

        \ \ \ \ x --\<gtr\> solución final LUx=b

        \ \ \ \ y --\<gtr\> solución parcial Ly=b, Ux=y

        \ \ \ \ """

        \ \ \ \ 

        \ \ \ \ A = A.astype(float)

        \ \ \ \ b = b.astype(float)

        \ \ \ \ 

        \ \ \ \ n = A.shape[0] # n es el número de filas de A (ecuaciones)

        \ \ \ \ 

        \ \ \ \ # El algoritmo para Doolittle es el mismo que en la

        \ \ \ \ # eliminación gaussiana, solo que almacenamos los
        multiplicadores

        \ \ \ \ # en la parte inferior de la diagonal

        \ \ \ \ 

        \ \ \ \ # Crea una matriz identidad nxn donde almacenaremos los
        multiplicadores \ 

        \ \ \ \ L = np.eye(n,n)<new-page> \ 

        \ \ \ \ # ELIMINACIÓN GAUSIANA Ax=b --\<gtr\> Ux=c

        \ \ \ \ # Para las entradas que esten:

        \ \ \ \ # * En todas las columnas menos la última

        \ \ \ \ for j in range(0,n-1):

        \ \ \ \ \ \ \ \ # * En cada fila con índice superior al de la columna

        \ \ \ \ \ \ \ \ for i in range(j+1,n):

        \ \ \ \ \ \ \ \ \ \ \ \ # Si la entrada no es nula

        \ \ \ \ \ \ \ \ \ \ \ \ if A[i,j] != 0.0:

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ # Multiplicador, A[j,j] es el pivote,
        A[i, j] el término

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ mult = A[i,j]/A[j,j]

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ # A toda la fila de la entrada le
        restamos la fila superior \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ por el
        multiplicador

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ A[i,:] = A[i,:] - mult*A[j,:]

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ # _NO_ modificamos b

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ # Almacenamos cada multiplicador en
        la entrada que elimina \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ pero en L

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ L[i,j] = mult

        \;

        \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ 

        \ \ \ \ # U es A después de escalonar

        \ \ \ \ U = A

        \ \ \ \ 

        \ \ \ \ # Ly=b

        \ \ \ \ y = sustitucion_progresiva(L, b)

        \ \ \ \ 

        \ \ \ \ # Ux=y

        \ \ \ \ x = sustitucion_regresiva(U, y)

        \ \ \ \ 

        \ \ \ \ return L, U, b, x, y
      </with>
    </with>
  </algorithm>

  \;

  <subsection|Descomposición de Choleski>

  \ 

  Las formas genéricas de las matrices <math|L> y <math|U> son:

  \;

  \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ <math|L=<around*|(|<tabular|<tformat|<table|<row|<cell|L<rsub|11>>|<cell|0>|<cell|0>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|L<rsub|21>>|<cell|L<rsub|22>>|<cell|0>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|L<rsub|33>>|<cell|\<ldots\>>|<cell|0>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|L<rsub|n1>>|<cell|L<rsub|n2>>|<cell|L<rsub|n3>>|<cell|\<ldots\>>|<cell|L<rsub|n
  n>>>>>>|)>> \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ <math|U=L<rsup|T>=<around*|(|<tabular|<tformat|<table|<row|<cell|L<rsub|11>>|<cell|L<rsub|21>>|<cell|L<rsub|31>>|<cell|\<ldots\>>|<cell|L<rsub|n1>>>|<row|<cell|0>|<cell|L<rsub|22>>|<cell|L<rsub|32>>|<cell|\<ldots\>>|<cell|L<rsub|n2>>>|<row|<cell|0>|<cell|0>|<cell|L<rsub|33>>|<cell|\<ldots\>>|<cell|L<rsub|n3>>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|\<ldots\>>|<cell|L<rsub|nn>>>>>>|)>>

  \;

  \;

  En este caso, tomando una matriz <math|3\<times\>3> como ejemplo, las
  matrices <math|L> y <math|U> son de la forma:

  \;

  <\equation*>
    L=<matrix|<tformat|<twith|table-min-cols|3>|<table|<row|<cell|L<rsub|11>>|<cell|0>|<cell|0>>|<row|<cell|L<rsub|21>>|<cell|L<rsub|22>>|<cell|0>>|<row|<cell|L<rsub|31>>|<cell|L<rsub|32>>|<cell|L<rsub|33>>>>>>
    ; U=L<rsup|T>=<matrix|<tformat|<table|<row|<cell|L<rsub|11>>|<cell|L<rsub|21>>|<cell|L<rsub|31>>>|<row|<cell|0>|<cell|L<rsub|22>>|<cell|L<rsub|32>>>|<row|<cell|0>|<cell|0>|<cell|L<rsub|33>>>>>>
  </equation*>

  \;

  Y aplicando <math|A=L*U>:

  \;

  <\equation*>
    <matrix|<tformat|<table|<row|<cell|A<rsub|11>>|<cell|A<rsub|12>>|<cell|A<rsub|13>>>|<row|<cell|A<rsub|21>>|<cell|A<rsub|22>>|<cell|A<rsub|23>>>|<row|<cell|A<rsub|31>>|<cell|A<rsub|32>>|<cell|A<rsub|33>>>>>>=<matrix|<tformat|<table|<row|<cell|L<rsup|2><rsub|11>>|<cell|L<rsub|11>L<rsub|21>>|<cell|L<rsub|11>L<rsub|31>>>|<row|<cell|L<rsub|11>L<rsub|21>>|<cell|L<rsup|2><rsub|21>+L<rsup|2><rsub|22>>|<cell|L<rsub|21>L<rsub|31>+L<rsub|22>L<rsub|32>>>|<row|<cell|L<rsub|11>L<rsub|31>>|<cell|L<rsub|21>L<rsub|31>+L<rsub|22>L<rsub|32>>|<cell|L<rsup|2><rsub|31>+L<rsup|2><rsub|32>+L<rsup|2><rsub|33>>>>>>
  </equation*>

  <new-page>

  \;

  Igualando elemento a elemento ambas matrices obtendremos un sistema de seis
  ecuaciones con seis incógnitas, ya que tomaremos los elementos de la matriz
  triangular inferior de cada una de ellas (es indiferente tomar la inferior
  o la superior) y con ello bastará porque se trata de matrices simétricas:

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|A<rsub|11>=L<rsup|2><rsub|11>>|<cell|>|<cell|L<rsub|11>=<sqrt|A<rsub|11>>>>|<row|<cell|A<rsub|21>=L<rsub|11>L<rsub|21>>|<cell|>|<cell|L<rsub|21>=A<rsub|21>/L<rsub|11>>>|<row|<cell|A<rsub|31>=L<rsub|11>L<rsub|31>>|<cell|>|<cell|L<rsub|31>=A<rsub|31>/L<rsub|11>>>|<row|<cell|A<rsub|22>=L<rsup|2><rsub|21>+L<rsup|2><rsub|22>>|<cell|>|<cell|L<rsub|22>=<sqrt|A<rsub|22>-L<rsup|2><rsub|21>>>>|<row|<cell|A<rsub|32>=L<rsub|21>L<rsub|31>+L<rsub|22>L<rsub|32>>|<cell|>|<cell|L<rsub|32>=<around*|(|A<rsub|32>-L<rsub|21>L<rsub|31>|)>/L<rsub|22>>>|<row|<cell|A<rsub|33>=L<rsup|2><rsub|31>+L<rsup|2><rsub|32>+L<rsup|2><rsub|33>>|<cell|>|<cell|L<rsub|33>=<sqrt|A<rsub|33>-L<rsup|2><rsub|31<rsup|>>-L<rsup|2><rsub|32>>>>>>
  </eqnarray*>

  \;

  Extrapolando a una matriz cuadrada de orden <math|n>(para obtener un
  elemento cualquiera de la matriz triangular inferior):

  \;

  <\math>
    <around*|(|LL<rsup|T>|)><rsub|i j>=A<rsub|i
    j>=L<rsub|i1>L<rsub|j1>+L<rsub|i2>L<rsub|j2>+\<ldots\>+L<rsub|i
    j>L<rsub|j j>=<below|<above|<big|sum>|j>|k=1><above||><rsup|<rsup|<rsup|<rsup|>>>><rsub|><with|math-display|true|<with|math-display|false|>>L<rsub|i
    k>L<rsub|j k>\<nocomma\> ; i\<geqslant\>j;j=1,2,\<ldots\>,n;i=j,j+1,\<ldots\>,n
  </math>

  \;

  \;

  Para los términos de la primera columna:

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|L<rsub|11>=<sqrt|A<rsub|11>
    >>|<cell|>>|<row|<cell|>|<cell|L<rsub|i1>=A<rsub|i1>/L<rsub|11>>|<cell|i=2,3,\<ldots\>,n>>>>
  </eqnarray*>

  \;

  Para términos de otra columna, tomaremos la fórmula general y escribiremos
  en ella su último término, excluyéndolo del sumatorio:

  \;

  <\equation*>
    A<rsub|i j>=<below|<above|<big|sum>|j-1>|k=1>L<rsub|i k>L<rsub|j
    k>+L<rsub|i j>L<rsub|j j><above||><rsup|<rsup|<rsup|<rsup|>>>><rsub|><with|math-display|true|<with|math-display|false|>>
  </equation*>

  \;

  \;

  Si buscamos un término de la diagonal, <math|i=j>, y por consiguiente:

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|L<rsub|j j>=<sqrt|A<rsub|j
    j>-<below|<above|<big|sum> |j-1>|k=1>L<rsup|2><rsub|j
    k>>;>|<cell|j=2,3,\<ldots\>,n>>>>
  </eqnarray*>

  \;

  \;

  Si el término no pertenece a la diagonal:

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|L<rsub|i j>=<around*|(|A<rsub|i j
    >-<below|<above|<big|sum>|j-1>|k=1>L<rsub|i k>L<rsub|j k>|)>/L<rsub|j
    j>;>|<cell|i=j+1,j+2,\<ldots\>,n>>|<row|<cell|>|<cell|>|<cell|j=2,3,\<ldots\>,n-1>>>>
  </eqnarray*>

  \;

  Este <math|n-1 > se debe a que en la última columna el único elemento
  pertenece a la diagonal.<new-page>

  A pesar de ahorrarnos la fase de eliminación gaussiana con respecto a otros
  métodos de factori-zación, Choleski es un método que no se usa
  habitualmente debido a sus dos limitaciones:

  \;

  <\enumerate-numeric>
    <item> Se puede aplicar solo y exclusivamente a matrices simétricas, ya
    que <math|LL<rsup|T>>es simétrica siempre.

    <item>El método conlleva recurrir a raíces cuadradas y se evita utilizar
    Choleski cuando hay que hacer raíces de números negativos. Para que no
    haya que recurrir a las raíces, A debe ser definida positiva.
  </enumerate-numeric>

  \;

  <\example>
    Descomponer la matriz <math|A> por Choleski:
  </example>

  \;

  <\equation*>
    A=<matrix|<tformat|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|1>|<cell|2>|<cell|2>>|<row|<cell|1>|<cell|2>|<cell|3>>>>>
  </equation*>

  \;

  \;

  Tomamos la matriz vista anteriormente:

  \;

  <\equation*>
    <matrix|<tformat|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|1>|<cell|2>|<cell|2>>|<row|<cell|1>|<cell|2>|<cell|3>>>>>=<matrix|<tformat|<table|<row|<cell|L<rsup|2><rsub|11>>|<cell|L<rsub|11>L<rsub|21>>|<cell|L<rsub|11>L<rsub|31>>>|<row|<cell|L<rsub|11>L<rsub|21>>|<cell|L<rsup|2><rsub|21>+L<rsup|2><rsub|22>>|<cell|L<rsub|21>L<rsub|31>+L<rsub|22>L<rsub|32>>>|<row|<cell|L<rsub|11>L<rsub|31>>|<cell|L<rsub|21>L<rsub|31>+L<rsub|22>L<rsub|32>>|<cell|L<rsup|2><rsub|31>+L<rsup|2><rsub|32>+L<rsup|2><rsub|33>>>>>>
  </equation*>

  \;

  \;

  De aquí, igualando término a término sacamos las ecuaciones:

  \;

  <\equation*>
    <tabular|<tformat|<table|<row|<cell|1=L<rsup|2><rsub|11>>|<cell|>|<cell|L<rsub|11>=<sqrt|1>=1>>|<row|<cell|1=L<rsub|11>L<rsub|21>>|<cell|>|<cell|L<rsub|21>=1/L<rsub|11>=1/1=1>>|<row|<cell|1=L<rsub|11>L<rsub|31>>|<cell|>|<cell|L<rsub|31>=1/L<rsub|11>=1>>|<row|<cell|2=L<rsup|2><rsub|21>+L<rsup|2><rsub|22>>|<cell|>|<cell|L<rsub|22>=<sqrt|2-L<rsup|2><rsub|21>>=<sqrt|2-1>=1>>|<row|<cell|2=L<rsub|21>L<rsub|31>+L<rsub|22>L<rsub|32>>|<cell|>|<cell|L<rsub|32>=<around*|(|2-L<rsub|21>L<rsub|31>|)>/L<rsub|22>=<around*|(|2-1|)>/1=1>>|<row|<cell|3=L<rsup|2><rsub|31>+L<rsup|2><rsub|32>+L<rsup|2><rsub|33>>|<cell|>|<cell|L<rsub|33>=<sqrt|3-L<rsup|2><rsub|31<rsup|>>-L<rsup|2><rsub|32>>=<sqrt|3-1<rsub|<rsup|>>-1>=1>>>>>
  </equation*>

  \;

  \;

  Por tanto, tenemos ya la matriz <math|L> y <math|L<rsup|T>> en las que se
  descompone A según <math|A=L\<cdot\>L<rsup|T>>:

  \;

  <\equation*>
    L=<matrix|<tformat|<twith|table-min-cols|3>|<table|<row|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|1>|<cell|1>|<cell|0>>|<row|<cell|1>|<cell|1>|<cell|1>>>>>;L<rsup|T>=<matrix|<tformat|<table|<row|<cell|1>|<cell|1>|<cell|1>>|<row|<cell|0>|<cell|1>|<cell|1>>|<row|<cell|0>|<cell|0>|<cell|1>>>>>
  </equation*>

  <new-page>

  El siguiente algoritmo ilustra la implementación de la descomposición de
  Choleski en el lenguaje de programación Python.

  \;

  <\algorithm>
    <\with|font|Andale|font-base-size|9>
      <\with|color|blue>
        def choleski(A):

        \ \ \ \ """

        \ \ \ \ La matriz debe ser:

        \ \ \ \ \ \ \ \ * Simétrica

        \ \ \ \ \ \ \ \ * Definida positiva (para evitar números complejos)

        \ \ \ \ * Toma:

        \ \ \ \ A --\<gtr\> matriz de coeficientes\ 

        \ \ \ \ 

        \ \ \ \ * Devuelve:

        \ \ \ \ L --\<gtr\> triangular inferior de la factorización

        \ \ \ \ """

        \ \ \ \ 

        \ \ \ \ 

        \ \ \ \ A = A.astype(float)

        \ \ \ \ 

        \ \ \ \ n = A.shape[0] # n es el número de filas de A (ecuaciones)

        \ \ \ \ 

        \ \ \ \ # Aprovechamos A en el algoritmo en vez de crear L ya que los
        terminos no se vuelven a \ \ \ \ \ \ emplear

        \ \ \ \ 

        \ \ \ \ # Para cada columna

        \ \ \ \ for j in range(n):

        \ \ \ \ \ \ \ \ # Si la raiz es un número complejo, lanzamos un error

        \ \ \ \ \ \ \ \ try:

        \ \ \ \ \ \ \ \ \ \ \ \ # En los elementos de la diagonal

        \ \ \ \ \ \ \ \ \ \ \ \ A[j,j] = np.sqrt(A[j,j] -
        np.dot(A[j,0:j],A[j,0:j]))

        \ \ \ \ \ \ \ \ except ValueError:

        \ \ \ \ \ \ \ \ \ \ \ \ error.err("La matriz no es definida
        positiva")

        \ \ \ \ \ \ \ \ # En los elementos bajo la diagonal

        \ \ \ \ \ \ \ \ for i in range(j+1,n):

        \ \ \ \ \ \ \ \ \ \ \ \ A[i,j] = (A[i,j] -
        np.dot(A[i,0:j],A[j,0:j]))/A[j,j]

        \ \ \ \ # En los términos sobre la diagonal

        \ \ \ \ for j in range(1,n):

        \ \ \ \ \ \ \ \ A[0:j,j] = 0.0

        \ \ \ 

        \;

        \ \ \ \ return A
      </with>
    </with>

    \;
  </algorithm>

  <subsection|Matrices dispersas>

  \;

  Ciertas matrices simplifican los cálculos que tenemos que realizar para
  resolver sus sistemas asociados. Éstas reciben el nombre de matrices
  dispersas, en ellas el mayor número de sus elementos son ceros. El gran
  número de ceros permite reducir el espacio necesario para almacenar el
  sistema en el computador y de esta manera minimizar la memoria utilizada y
  el tiempo de proceso. Cuando el ancho de banda es razonablemente pequeño
  podemos hablar de matrices en banda:

  \;

  <\equation*>
    <around*|(|<tabular|<tformat|<table|<row|<cell|X>|<cell|X>|<cell|X>|<cell|\<nosymbol\>\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|X>|<cell|X>|\<circ\>|<cell|\<circ\>>>|<row|<cell|X>|<cell|\<circ\>>|<cell|X>|<cell|\<circ\>>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|X>|<cell|\<circ\>>|<cell|X>|<cell|\<circ\>>|<cell|X>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|\<circ\>>|<cell|X>>>>>|)>
  </equation*>

  <new-page>

  Existen diversos casos, entre los que distinguimos:

  \;

  <\itemize-dot>
    <item><strong|Diagonales<em|>>: con elementos no nulos en las diagonales
    principales de la matriz (tridiagonales, pentadiagonales...):
  </itemize-dot>

  <\equation*>
    <around*|(|<tabular|<tformat|<table|<row|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>>>>>|)>
  </equation*>

  <\itemize-dot>
    <item><strong|Simétricas>: el cómputo de éstas es más sencillo, pues los
    elementos son iguales a un lado y al otro de la diagonal.

    \;
  </itemize-dot>

  \;

  Para evitar almacenar todos estos ceros y aumentar la eficiencia del
  computo, existen métodos específicos para cada uno de estos casos que
  simplifican las operaciones. Lo explicaremos con el caso de las matrices
  tridiagonales. Estas son, como hemos dicho, matrices dispersas muy comunes
  en la discretización de ecuaciones diferenciales.

  Si la factorización <math|LU> correspondiente existe, los factores <math|L>
  y <math|U> deben de ser matrices bi- \ diagonales de la sigueinte forma:

  <\equation*>
    <around*|(|<tabular|<tformat|<table|<row|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|X>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>>>>>|)>=
    <around*|(|<tabular|<tformat|<table|<row|<cell|1>|\<circ\>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|X>|<cell|1>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|X>|<cell|1>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|1>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|1>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|1>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|1>>>>>|)>\<cdot\><around*|(|<tabular|<tformat|<table|<row|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|\<circ\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>|<cell|X>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|X>>>>>|)>
  </equation*>

  <\equation*>
    A=L\<cdot\>U
  </equation*>

  \;

  Basádonos en la descomposición de Doolittle encontramos que para una matriz
  <math|A> podemos encontrar dos matrices de esa forma:

  \;

  <\equation*>
    A=<around*|(|<tabular|<tformat|<table|<row|<cell|d<rsub|1>>|<cell|e<rsub|1>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<cdots\>>|<cell|\<circ\>>>|<row|<cell|c<rsub|1>>|<cell|d<rsub|2>>|<cell|e<rsub|2>>|<cell|\<circ\>>|<cell|\<cdots\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|c<rsub|2>>|<cell|d<rsub|3>>|<cell|e<rsub|3>>|<cell|\<cdots\>>|<cell|\<circ\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|c<rsub|3>>|<cell|d<rsub|4>>|<cell|\<cdots\>>|<cell|\<circ\>>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|\<circ\>>|<cell|c<rsub|<with|font-base-size|6|n-1>>>|<cell|d<rsub|n>>>>>>|)>
  </equation*>

  <\equation*>
    A = <around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|3>|<cell|4>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|2>|<cell|3>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|3>>>>>|)>\<nocomma\>,b=<around*|(|<tabular|<tformat|<table|<row|<cell|1>>|<row|<cell|2>>|<row|<cell|3>>|<row|<cell|4>>>>>|)>
  </equation*>

  <new-page>

  Almacenamos los coeficientes en tan solo 3 vectores:

  \;

  \;

  <\equation*>
    c = <around*|(|<tabular|<tformat|<table|<row|<cell|0>>|<row|<cell|c<rsub|1>>>|<row|<cell|c<rsub|2>>>|<row|<cell|\<vdots\>>>|<row|<cell|c<rsub|<with|font-base-size|6|n>>>>>>>|)>\<nocomma\>\<nocomma\>
    \<nocomma\>\<nocomma\>,d=<around*|(|<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|d<rsub|1>>>|<row|<cell|d<rsub|2>>>|<row|<cell|\<vdots\>>>|<row|<cell|d<rsub|n-1>>>|<row|<cell|d<rsub|n>>>>>>|)>,e=<around*|(|<tabular|<tformat|<cwith|1|-1|1|1|cell-halign|c>|<table|<row|<cell|e<rsub|1>>>|<row|<cell|e<rsub|2>>>|<row|<cell|\<vdots\>>>|<row|<cell|e<rsub|<with|font-base-size|6|n-1>>>>|<row|<cell|0>>>>>|)>
  </equation*>

  <\equation*>
    c = <around*|(|<tabular|<tformat|<table|<row|<cell|0>>|<row|<cell|3>>|<row|<cell|2>>|<row|<cell|1>>>>>|)>\<nocomma\>\<nocomma\>
    \<nocomma\>\<nocomma\>,d=<around*|(|<tabular|<tformat|<table|<row|1>|<row|<cell|4>>|<row|<cell|3>>|<row|<cell|3>>>>>|)>,e=<around*|(|<tabular|<tformat|<table|<row|<cell|4>>|<row|<cell|1>>|<row|<cell|4>>|<row|<cell|0>>>>>|)>
  </equation*>

  \;

  \;

  De este modo, para un sistema <math|100\<times\>100>, que contiene
  <math|10.000> elementos, encontramos que podemos almacenarlo en
  <math|99+100+99=298> entradas.

  \;

  \;

  El siguiente paso es eliminar las diagonales <math|c> y <math|d> aplicando
  las siguientes operaciones elementales en cada fila <math|k>:

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|F<rprime|'><rsub|k>\<rightarrow\>F<rsub|k<rsub|<rsub|>>>-<around*|(|<frac|c<rsub|k-1>|d<rsub|k-1>>|)>\<cdot\>F<rsub|k-1
    >\<nocomma\>\<nocomma\>;>|<cell|k=2,3,\<ldots\>,n>>>>
  </eqnarray*>

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|3>|<cell|4>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|2>|<cell|3>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|3>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|2>\<rightarrow\>F<rsub|2>-<around*|(|<frac|c<rsub|1>|d<rsub|1>>|)>\<cdot\>F<rsub|1>><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|-8>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|2>|<cell|3>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|3>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|3>\<rightarrow\>F<rsub|3>-<around*|(|<frac|c<rsub|2>|d<rsub|2>>|)>\<cdot\>F<rsub|2>>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|-8>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|3.25>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|3>>>>>|)><long-arrow|\<rubber-rightarrow\>|F<rsub|4>\<rightarrow\>F<rsub|4>-<around*|(|<frac|c<rsub|3>|d<rsub|3>>|)>\<cdot\>F<rsub|3>><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|-8>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|3.25>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|<frac|23|13>>>>>>|)>>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|>|<cell|U=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|-8>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|3.25>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|<frac|23|13>>>>>>|)>>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  De esta manera los coeficientes <math|e<rsub|k>> no se ven afectados por la
  transformación. Para terminar almacenamos en una matriz identidad los
  multiplicadores <math|\<lambda\>=<dfrac|c<rsub|k-1>|d<rsub|k-1>>> en la
  entrada antes ocupada por <math|c<rsub|k-1>> :

  <\equation*>
    L=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|<frac|3|1>>|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|<frac|2|-8>>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|<frac|1|3.25>>|<cell|1>>>>>|)>
  </equation*>

  <new-page>

  Así, acabamos de obtener la factorización que buscábamos:

  \;

  \;

  <\equation*>
    \ <around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|3>|<cell|4>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|2>|<cell|3>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|1>|<cell|3>>>>>|)>=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|<frac|3|1>>|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|<frac|2|-8>>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|<frac|1|3.25>>|<cell|1>>>>>|)>\<cdot\><around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|-8>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|3.25>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|<frac|23|13>>>>>>|)>
  </equation*>

  \;

  \;

  \;

  En la fase de solución resolvemos primeramente el sistema <math|Ly=b> que
  expresamos de la siguiente manera con su matriz aumentada:

  \;

  \;

  \;

  <\equation*>
    <around*|[|L<mid|\|>b|]>=<around*|(|<tabular|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>|<cell|0>|<cell|\<cdots\>>|<cell|0>>|<row|<cell|c<rsub|1>>|<cell|1>|<cell|0>|<cell|0>|<cell|\<cdots\>>|<cell|0>>|<row|<cell|0>|<cell|c<rsub|2>>|<cell|1>|<cell|0>|<cell|\<cdots\>>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|c<rsub|3>>|<cell|1>|<cell|\<cdots\>>|<cell|0>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|\<vdots\>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|0>|<cell|<with|font-base-size|8|c<rsub|<with|font-base-size|6|n-1>>>>|<cell|1>>>>><mid|\|><tabular|<tformat|<table|<row|<cell|b<rsub|1>>>|<row|<cell|b<rsub|2>>>|<row|<cell|b<rsub|3>>>|<row|<cell|b<rsub|4>>>|<row|<cell|b<rsub|5>>>|<row|<cell|b<rsub|6>>>>>>|)>
  </equation*>

  <\equation*>
    <around*|[|L<mid|\|>b|]>=<around*|(|<tabular|<tformat|<table|<row|<cell|1>|<cell|0>|<cell|0>|<cell|0>>|<row|<cell|3>|<cell|1>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|<with|font-base-size|6|-<frac|1|4>>>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|<with|font-base-size|6|<frac|1|3.25>>>|<cell|1>>>>><mid|\|><tabular*|<tformat|<table|<row|<cell|1>>|<row|<cell|2>>|<row|<cell|3>>|<row|<cell|4>>>>>|)>
  </equation*>

  \;

  \;

  \;

  \;

  Debemos tener en cuenta que <math|c> ya no contiene los coeficientes
  originales, sino los multiplicadores usados en la descomposición.
  Resolvemos <math|y> mediante sustitución progresiva:

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|y<rsub|1>=b<rsub|1>>|<cell|>|<cell|>>|<row|<cell|y<rsub|2>=b<rsub|2>-y<rsub|1>c<rsub|1>>|<cell|>|<cell|>>|<row|<cell|\<vdots\>>|<cell|>|<cell|>>|<row|<cell|y<rsub|n>=b<rsub|n>-y<rsub|n-1>c<rsub|n-1>>|<cell|>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|y<rsub|1>>|<cell|=>|<cell|1>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|y<rsub|2>>|<cell|=>|<cell|2-3\<cdot\>1=-1>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|y<rsub|3>>|<cell|=>|<cell|3+<frac|1|4>\<cdot\><around*|(|-1|)>=<frac|11|4>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|y<rsub|4>>|<cell|=>|<cell|4-<frac|1|3.25>\<cdot\><frac|11|4>=<frac|41|13>>>>>
  </eqnarray*>

  <new-page>

  Una vez que tenemos <math|y> continuamos resolviendo el sistema <math|Ux=y>
  en este caso mediante sustitución regresiva:

  \;

  \;

  <\equation*>
    <around*|[|U<mid|\|>y|]>=<around*|(|<tabular|<tformat|<table|<row|<cell|d<rsub|1>>|<cell|e<rsub|1>>|<cell|0>|<cell|\<cdots\>>|<cell|0>>|<row|<cell|0>|<cell|d<rsub|2>>|<cell|e<rsub|2>>|<cell|\<cdots\>>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|d<rsub|3>>|<cell|\<cdots\>>|<cell|0>>|<row|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<vdots\>>|<cell|\<ddots\>>|<cell|\<vdots\>>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|\<ldots\>>|<cell|d<rsub|n>>>>>><mid|\|><tabular|<tformat|<table|<row|<cell|y<rsub|1>>>|<row|<cell|y<rsub|2>>>|<row|<cell|y<rsub|3>>>|<row|<cell|\<vdots\>>>|<row|<cell|y<rsub|n>>>>>>|)>
  </equation*>

  \;

  \;

  \;

  <\equation*>
    <around*|[|U<mid|\|>y|]>=<around*|(|<tabular*|<tformat|<table|<row|<cell|1>|<cell|4>|<cell|0>|<cell|0>>|<row|<cell|0>|<cell|-8>|<cell|1>|<cell|0>>|<row|<cell|0>|<cell|0>|<cell|3.25>|<cell|4>>|<row|<cell|0>|<cell|0>|<cell|0>|<cell|<frac|23|13>>>>>><mid|\|><tabular|<tformat|<table|<row|<cell|1>>|<row|<cell|-1>>|<row|<cell|<frac|11|4>>>|<row|<cell|<frac|41|13>>>>>>|)>
  </equation*>

  \;

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|x<rsub|n>=y<rsub|n>>|<cell|>|<cell|>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|x<rsub|n-1>=<frac|y<rsub|n-1>-e<rsub|n-1>y<rsub|n>|d<rsub|n-1>>>|<cell|>|<cell|>>|<row|<cell|\<vdots\>>|<cell|>|<cell|>>|<row|<cell|x<rsub|1>=<frac|y<rsub|1>-e<rsub|1>y<rsub|2>|d<rsub|2>>>|<cell|>|<cell|>>>>
  </eqnarray*>

  \;

  \;

  \;

  <\eqnarray*>
    <tformat|<table|<row|<cell|x<rsub|4>>|<cell|=>|<cell|<frac|41|13>\<cdot\><frac|13|23>=<frac|41|23>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|x<rsub|3>>|<cell|=>|<cell|<around*|(|<frac|11|4>-4\<cdot\><frac|41|23>|)>\<cdot\><frac|1|3.25>=-<frac|31|23>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|x<rsub|2>>|<cell|=>|<cell|<around*|(|-1+1\<cdot\><frac|31|23>|)>\<cdot\><frac|-1|8>=
    -<frac|1|23>>>|<row|<cell|>|<cell|>|<cell|>>|<row|<cell|x<rsub|1
    >>|<cell|=>|<cell|<around*|(|1+4\<cdot\><frac|1|23>|)>\<cdot\><frac|1|1>=
    <frac|27|23>>>>>
  </eqnarray*>

  \;

  \;

  \;

  En los casos de matrices tridiagonales la complejidad computacional para
  las sustituciones regresivas y progresivas es de <math|O<around*|(|n|)>>
  mientras que en las matrices usuales lo es de
  <math|O<around*|(|n<rsup|2>|)>>. Pero, ¾qué quiere decir esto? Como podemos
  observar, las sustituciones en el ejemplo anterior son lineales, su
  complejidad no aumenta por mayor que sea el número de incógnitas, algo que
  sí ocurrió en el primer ejemplo con la eliminación gaussiana.<new-page>

  El siguiente algoritmo muestra la implementación en Python de una rutina
  del algoritmo de Thomas para la descomposición de matrices tridiagonales.

  \;

  <\algorithm>
    <\with|font|Andale>
      <\with|color|blue>
        <\with|font-base-size|7>
          def tridiagonal(c, d, e, b):

          \ \ \ \ """

          \ \ \ \ * Toma:

          \ \ \ \ c,d, e --\<gtr\> vector con la subdiagonal, diagonal y
          superdiagonal

          \ \ \ \ b --\<gtr\> términos independientes

          \ \ \ \ 

          \ \ \ \ * Devuelve:

          \ \ \ \ L --\<gtr\> triangular inferior de la factorización

          \ \ \ \ U --\<gtr\> triangular superior de la factorización

          \ \ \ \ b --\<gtr\> términos independientes (no los modifica)

          \ \ \ \ x --\<gtr\> solución final LUx=b

          \ \ \ \ y --\<gtr\> solución parcial Ly=b, Ux=y

          \ \ \ \ """

          \;

          \ \ \ \ # Los coeficientes de los vectores pasan a expresarse como
          float

          \ \ \ \ c, d, e = c.astype(float), d.astype(float), e.astype(float

          \ \ \ \ b = b.astype(float)\ 

          \ \ \ \ 

          \ \ \ \ n = d.shape[0] # n es el número de filas de A (número de
          ecuaciones)

          \ \ \ \ 

          \ \ \ \ # FACTORIZACIÓN

          \ \ \ \ # En esta fase construimos U, que contiene d y e

          \ \ \ \ # Así como L, compuesta por la identidad más c

          \ \ \ \ 

          \ \ \ \ # En cada fila desde la segunda

          \ \ \ \ for i in range(1,n):

          \ \ \ \ \ \ \ \ mult = c[i-1]/d[i-1]

          \ \ \ \ \ \ \ \ d[i] = d[i] - mult*e[i-1]

          \ \ \ \ \ \ \ \ # Almacenamos los multiplicadores en c

          \ \ \ \ \ \ \ \ c[i-1] = mult

          \ \ \ \ \ \ \ \ 

          \ \ \ \ # RESOLUCIÓN

          \ \ \ \ # Por comodidad construiremos L y U de manera completa para
          la resolución

          \ \ \ \ # Esto no es un gran inconveniente puesto que el grueso de
          las operaciones

          \ \ \ \ # ya las hemos realizado usando solo las diagonales

          \ \ \ \ 

          \ \ \ \ # L\ 

          \;

          \ \ \ \ L = np.eye(n,n)

          \ \ \ \ 

          \ \ \ \ # Para los elementos de la diagonal inferior (i, j) =
          (1,0), (2,1), (3,2)...

          \ \ \ \ for i in range(1, n):

          \ \ \ \ \ \ \ \ \ \ \ \ # Copia el elemento i de c: c[1], c[2]...
          nunca el 0 del principio

          \ \ \ \ \ \ \ \ \ \ \ \ L[i,i-1] = c[i]

          \ \ \ \ 

          \ \ \ \ # U

          \;

          \ \ \ \ U = np.eye(n,n)

          \ \ \ \ 

          \ \ \ \ for i in range(n-1):

          \ \ \ \ \ \ \ \ # Para los elementos de la diagoanl copia d (todos)

          \ \ \ \ \ \ \ \ U[i,i] = d[i]

          \ \ \ \ \ \ \ \ # Por encima de la diagonal copia todos los de e
          menos el último (0)

          \ \ \ \ \ \ \ \ if (i!=n):

          \ \ \ \ \ \ \ \ \ \ \ \ U[i,i+1] = e[i]

          \ \ \ \ 

          \ \ \ \ # Ly=b

          \ \ \ \ 

          \ \ \ \ y = sustitucion_progresiva(L, b)

          \ \ \ \ 

          \ \ \ \ # Ux=y

          \ \ \ \ 

          \ \ \ \ x = sustitucion_regresiva(U, y)

          \ \ \ \ 

          \ \ \ \ 

          \ \ \ \ return L, U, b, x, y
        </with>
      </with>
    </with>
  </algorithm>

  <new-page>

  <section|¾Directo o iterado?>

  \;

  Ahora que conocemos gran variedad de métodos (tanto iterativos como
  directos) para resolver sistemas de ecuaciones lineales, se nos plantea la
  siguiente duda: ¾qué método escoger? Para matrices pequeñas, no hay grandes
  diferencias entre métodos (hablando de tiempo de procesamiento y volumen de
  operaciones). Pero al trabajar con sistemas grandes hay notables
  diferencias entre usar un método u otro. En estos casos, la elección de un
  método determinado dependerá de las propiedades de la matriz (simetría,
  número de condición...), además de los recursos computacionales
  disponibles.

  \;

  Muchos programas informáticos (como es el conocido Matlab con su
  <with|font-family|tt|\\> o Octave con el comando
  <with|font-family|tt|linsolve<with|font-family|rm|>>) analizan la matriz A
  y, dependiendo de las características antes mencionadas, escogen el método
  idóneo para resolver ese sistema.

  \;

  Vamos a analizar los costes computacionales de métodos iterados y métodos
  directos al resolver distintos tipos de sistemas lineales:

  \;

  <\itemize-dot>
    <item><strong|Matrices llenas>: Trabajando con un sistema no simétrico y
    cuya matriz <math|A> está llena, el mejor método para resolverlo es
    aplicar una de las descomposiciones descritas anteriormente, ya que si lo
    comparamos con el método iterativo GMRes (Residuos Mínimos Generalizados)
    sin preacondicionamiento, el tiempo de cáculo del método directo es
    menor. Por ello, antes de aplicar con éxito un método iterativo hay que
    llevar a cabo un preacondicionamiento.\ 

    \ \ \ \ \ \ \ \ \ <image|<tuple|<#89504E470D0A1A0A0000000D4948445200000280000001A30802000000337F33710000000373424954080808DBE14FE00000200049444154789CEC9D797C14F5FDFF5FB377AEDD6CB2392081042209208828E05D0F3CF0D62AFEAA56ADF5AC558A47455004410D2A6215A3B5D6AFADD6DADA4AABA8786B3D902B418104722D4892CD6EEE6C924DB2D7FCFE184DE972240BBB9F9977783FFFF0E1F24926AF4C76F63D9FCFBCE739922CCB6018866118462C3AB503300CC330CCE10817608661188651012EC00CC3300CA3025C80198661184605B800330CC3308C0A7001661886611815E002CC300CC3302AC005986118866154800B30C3300CC3A80017608661188651012EC00CC3300CA3025C80198661184605B800330CC3308C0A700166188661181530A81DE060282F2FFFE28B2F42A190DA41A24392244992C2E1B0DA41A243892DCB32AD27574A92A4D3E9C2E130C71600C7168C4EA723774882666C9D4E07E0D8638F3DEEB8E362BE71920578CD9A352FBEF8E209279CA0BC9465D96C369B4C2675531D189D4EB773E7CE9A9A9AD34F3F5DF98B924092248FC753565676FAE9A75B2C162A478E24495EAFF78B2FBE38FDF4D393929208C56E6F6FFFF4D34FCF3AEB2CABD54A28764F4FCFE79F7F7EC20927A4A5A551890D20140A7DF8E187C71E7B6C565616ADD89F7EFAE9840913468F1E4DE8845E96E52FBFFC72C488114545451A8F1D0804FAFAFA94F333F38E1DDF7EF34DED5D77C5A3004326487171F12DB7DC22CB72E8479473588DF3DE7BEF5D7FFDF57EBF5FED20D1B169D3A62BAEB8A2BDBD5DED20D1B173E7CE0B2EB8A0B1B151ED20D151595979CA29A7ECDAB54BED20D1E176BB2FBDF4D21D3B76A81D243A7C3EDF4F7FFAD30D1B36A81D243AFAFBFBAFBEFAEA4F3EF944ED20D1110A85EEB8E38ED75F7F5DED2083130E8743A1902CCBA19D3BE5F3CFBFC3E1B8F3CE3BE3F18348CE80014892841F170768A124278412985C6C05A2B1C9A15CA7503B45D450CC4C17429F243FBC9FFBFB754F3C810913FCE9E9527CAE78D22B607421FA21C5300C132B642A4BFDE1306419975E8AFBEE931213E3149BEA0C786F3A3B3B77EDDAA5D9CE2CBD5E5F5D5DDDDCDC5C56566630A8B3DB9392920A0A0AD4FAE9CC10E1B3346650E8BE49C8247FE30D0483F8F9CF11CF9306929FC566B379EFBFE27FFEF39F471E79242F2F4FC01F78EF5EBEBD3B9CF7FE1ABFDF1F0804962F5FAECA5BD0E7F30583C1575F7DD5E17044F58DB9B9B93FFFF9CF131212E2142C4EA4A5A5FDF297BF4C4949513B4874646666DE7AEBAD6969696A07898E9494946BAFBD36333353ED20D161341AAFBBEEBAD1A347AB1D243A0C06C395575E396EDC38B58344872449975C72494E4E8EDA4186C0E79FE3D967B178B1F24AAFD7C7A9C997640136994C7BD7309FCF3775EAD4E2E2E2785F189665F99B6FBEC9CCCC2C2C2C542AAE24498D8D8D151515279E78A2C562D9E7D72828F7F3C435DE3ED1E974BB76EDBAEFBEFB0E6285202323E3CC33CFD47893F9DE58ADD6F3CE3BCF6C36AB1D243A6C36DB45175D949494A47690E848484838FBECB395373F21F47AFD39E79C63341AD50E121D3A9D6EE6CC99E4620338E9A49308ACC0B5B460E54AFCF29738F34CE51FF47A7D9CF6B6E6F7C5909124C96432A5A6A6C67B7E190A85FEF4A73F9D7AEAA9C71E7BECC03FAE5BB7EEE9A79F3EE9A4936C36DBFEBE465D5252520EEED4241008D4D6D64E9A3429E691E28ADFEFAFAAAA9A3871A25EAF573B4B140483C1EFBEFB6EDAB469E4CE786A6B6B0B0B0B69C59665B9A6A6263F3F9FDC194F6D6D6D6E6EAED56A553B4874ECDEBD3B333353F990D4287E3F4C262C5800219F78C3A7008B44B9F169CF7F0987C3C160F0C05F431493C9545454A4768AA831994CE3C78FA7557D01188D468AD51740515111B93999244985858504E6647B316EDC388AB1C78C19A3E943B2AF0FCB96E1E8A371C925627E2077413383100C06EBEBEBD54E11354A6C72E740C160B0BABA3AE2648E04F5F5F51463373434F4F7F7AB9D226A5C2E576F6FAFDA29A2C6ED76FB7C3EB553EC8770182FBD8475EB70D451C27E26BD7328EAF8E0FB33FEDC80065DDCCE7E64C83331F3349C1693AD296BFB31D99448E8C6B6582C643A45F7609F9D19DA876E6C8A16044DC7AEAAC29A3578E0018C1D2BEC677201164D0081529456A232AE05B80005B1DA9A5EAFCFC8C888D5D684A1D7EB1D0E87768FF6FDA0D7EB478E1C492E36808C8C0C4DAF2EEE0787C3416EE51C407A7A3AC52568BBDDAED137496727B2B2F0CC33183346E48FA5F72724812CCBC160709F1FA356589FC6D321C4F77E653362D6FDEBF7FB2B2B2B274F9E1CAB0D8AC1EFF7EFD8B163D2A4491A3DE0F7432010282D2D9D316306B9E97B656565515111ADD8B22C575555E5E7E7272727AB9D253AAAABAB478D1A45AE09CBE974666565A5A6A6AA1DE47F696CC4030FE0C61BF1E3F30584C105F820E9EDEDEDEDED0D040200CC66734E4E4E7F7FFF8E1D3B945B212B2B2BEBEAEAC6ECEB644A8294044A2D974A3793DA29A2C66432916B810660341AA74F9F4EAB8C298C1F3F9EDC545292A4A2A2228A53C9A2A22272EF6D000505059A8BDDDD8D254B6034428D3906BD779E1630994C2FBFFCF2A79F7EAA68BB4F3BEDB4BBEEBAEBA28B2E9A3F7FFEF1C71F6F341AD7AF5F7FF2C9279F72CA296A278D01C160D0E572E5E5E5A91D243A9426ACBCBC3C5ACBB9A150C8E97452EC7175B95C393939146367656591BB83D9E572391C8EC4C444B5834487C7E3494D4DD5D64D5F1B37C2EBC5E38F438D551062478B16D0EBF50B172EF4783C8A52439665E5009E376FDE29A79CB271E3C67038ACFCBFB6DE67078B24499A3B691D029224919B9029188D468A6D417ABD9E626CA27BDB6834D23AB35430180C1A8A1D0EA3BE1E53A660E54AA8E49EE3027C304C983061C2840911FF6832994E3BEDB4D34E3B4D8D447144A7D3A5A7A7AB9D226A94D81A3ADA87864EA7CBCECE26171B00C5BD0D202D2D8DE2899ADD6EA7789DC266B369686F7FF30D962FC78A15821BAFF684DE0173700483C1F6F6F6B6B6B63D6F550C8542CA45DC88AF547C8DA150C8FF23814060402129CB722010F0EFC180DF31140AB5B7B7B7B6B652BC21727F28262CB553444D2010A8A9A9D1ECC339F6473018DCB265CBDE6F4BED535B5B4B2EB62CCBB5B5B5146FA8753A9DDDDDDD6AA7889ABABA3AADC4AEAAC2922538E71CA87A71EDB098016FD8B0E1E5975FDEBD7B77381CCEC9C9B9F1C61B8F3FFE78006FBEF9E6BBEFBE3B7FFEFC812623A7D3B964C992F3CE3BEFF2CB2F7FFAE9A7D7AF5F6F3299940BBD471C71C42DB7DC929393B36EDDBA952B570E9CEC87C3E1B3CE3AEBFAEBAFDFB973674949494D4D8D2CCBD9D9D9B7DE7AEBD4A95355FB9D63079BB044C2262C91B0094B301A32616DDA84134EC0F5D743D5651B7A7FC268D9B871E36F7EF39B33CE38E3BAEBAE03F0F6DB6FDF71C71D7FF8C31FA64E9DBA7DFBF6BFFEF5AFD3A64D1B28C01F7FFCF15FFFFAD7FCFCFC7038FCCD37DFA4A7A75F79E595E170B8B5B5F5D9679F6D696979EEB9E776EDDAE5F178E6CD9B67341A9569716E6E6E5F5FDF430F3D643018162E5CA8D7EBFFF5AF7FDD7BEFBDAFBCF2CA881123D4FCE56381D2CDB4CF8E6E2D43B4094B3161516CCDADAFAF1F356A14B9D80D0D0DD9D9D9149BB0323232C83561B9DD6EBBDDAE72734C4F0FAAAA70E1853099A0F6C35A881D2DD1120C064B4A4A4E3EF9E4254B9628675E53A74E952469DBB66D53A74ED5E9743366CCD8B871A3CFE74B4C4CECEBEBFBE69B6FA64C99A234654892347EFCF8534F3D55D9545757D7ABAFBEAA2C696667679F7EFAE97B9EEFBB5CAEAD5BB7AE58B14279FAC2E8D1A35B5B5B9B9A9A864101A6AB94221A9B4D5822A11B9BD699A582FAB165192FBD84B56BF1873FA85E7D31EC0BB0CBE5AAAAAABAE9A69B94EA1B0804743ADD030F3CA01C72E17078EAD4A94D4D4DE5E5E5D3A74FAFAEAEF67ABDC71C73CC8040D8E7F37577772B1783B76DDBA6581D24496A6D6DDDB46993B23A0D203F3FDF66B38D1E3DFAB1C71E6B6E6E3EE69863468E1CF9F4D34F533CB0F7864D582261139660D8842512F54D58EFBC837FFE13CB96411B0E137A7FC2A8686B6BF3FBFDB9B9B900BABABA962D5BB66BD7AE70383C63C68C3BEFBC53966587C3E170383EFBECB3E9D3A77FF9E597CA05A1817EABBFFFFDEF5BB66C01D0D8D8D8D3D3F3F2CB2F03D0E9745BB76E7DE08107944FC970383C77EEDC0B2FBCF0F1C71F7FF1C5175F78E185AEAEAE912347CE9E3DFBF2CB2FDFC727694F0F4A4AB07B37C2619C761ACE3F1FCF3E8BBA3A0038FF7C9C7A2A9E7D16BB7703C00517E0273FC1CA9507337AFEF938F7DC98EC43366189844D582261139660543661C9321A1A70E79D38F1447502ECC5302FC0CA43703D1E4F5E5E9EC562B9E4924B7C3EDFE79F7FBE69D326A5CAEAF5FA534E39A5A4A4C4E3F17CFDF5D7D75E7BEDBA75EB067A9867CE9C79EDB5D786C3E1AEAEAEC71F7FFCA38F3E9A3C797228149A3163C6CA952B0766C056AB3510086467673FF6D8635D5D5DB5B5B56BD6AC59BC78B1CD663BEFBCF32233190C983C19393990658C1903A311471D85DC5C001835EABFA300727361301CFC688C60139648D8842512366109464D135643039C4EFCF297D0D29F5B4351E2C1C89123478C18F1C1071FCC983143F96803F0D5575F0DDC2F110A858E3EFAE86030F8E69B6FF6F5F54D9B36EDEBAFBF1EF8F651A3461D7DF4D1CAFF9795956DDDBA55F9FF848484ACACAC3D3F6ED6AF5FFFE28B2F2E5FBE3C353575EAD4A993274FDEB265CBE6CD9BF75180CDE6C8B969FC5EC602366189844D58826113964854336179BD78F0418C1881934E52B7ED390262474BB4242424DC78E38D8B162DCACECE9E356B965EAFFFF4D34FDF7CF34DE5BE1A599665594E4D4D9D366DDA934F3E79DD75D7A5A7A70FAC3F2B5F30F0FF2693A9B9B9391C0E4B92E476BBDF7FFF7DE5B34696E58C8C8C1123465455559594945C73CD35168B65DBB66DDF7FFFBDD2774D1D36610986A89B894D5822611356148442F8DDEFD0D686E2624D555F0CFB020CE0BCF3CEF3FBFD2FBDF4D21B6FBC61B158468F1EFDE0830FEEDEBD1B407E7EBEF235E79C73CEFAF5EB67CD9A0540B9DF4692A48913278E1A356A603B93264DDAB871637373F3C891238D46E30B2FBCA0FC7B28149A3265CAC30F3FFCE8A38F3EF5D4535F7CF1855EAF0F8542D75C73CDCC993305FFB2F1804D582261139660D8842512754C588100B2B2F0F0C3C8CC14FDA30763F814605996FD7E7F4747C7DE9F02679F7DF6B469D31A1A1A4C26D3E8D1A32D164B2010F07ABD175D741180CECECE238E38E2A5975E321A8D9D9D9D175F7C3180EEEEEEDB6FBF5DA7D37576762A1B39EAA8A31E7FFC7183C13079F2E4575E7965CFEDEB74BA9E9E9E2953A6AC5CB9B2BEBEDEEFF7676666666565F5F5F56944B2A3D3E9BABABA06BABBA34231614D9A3429E6A9E28A62C2227719583161517471D4D6D6161616D28AAD98B0F2F3F3C969DB9D4E676E6E2EB926ACBABABACCCC4C9BCD26EE477EF5157C3EDC728BB89F180DC3A7002726266EDEBCF9965B6ED9E78292244903B71EC5358652FE95C5EDB8FEA068F1F97CE170F820AA119BB044C2262C91B0094B30A24D585BB762D122DC7493B89F1825F4FE84FBE3D4534FCDCBCBD3ACFB5792A4AEAEAEF6F6F6D1A347AB559B9392920EE20600366189844D588261139648849AB05A5BB16811CE3A0BB3678BF8710705B1A3E500D86CB62953A6A89DE240F4F6F6767575656AEF3AC481A1AB94221A9B4D5822A11B9BD699A582D0D83A1DAEBE1A679F0D0D2F830D9F02AC7DCC6633B9F901D8842516366109864D58221164C2EAEFC70B2F60DA345C7659DC7FD6A141EF38A78BD7EB753A9D6AA7881AC584A5768AA8514C589ABD24B13F141316B9E7FA01A8ACACF4FBFD6AA7880EC584D5D3D3A37690A8A9AEAED6CA73FDA2C1E9747ABDDEF8FE0C59C6FFFD1F56AF06856903BD7328BAD86C3672C63BB0094B2C6CC212099BB00423C284B5691356ADC2E2C518372EBE3F2816F00C581C3E9FCFE3F1A89D226A141396DA29A24669C28A77D37BCC514C5803325442B85C2EA2B1FBFBFBD54E11352E974B23B7384685C7E3F1F97C71FC013E1F7273B17CB9766CCF07860BB038743A1DC5736D36610986A89B894D58226113D63EA8A9C19D77A2BB1B53A680C8DF94DE9F902E269349E81DE831824D582261139660D88425129BCD16AFD8CDCD58B408A9A93F3C8D8608F40E18BA747777D7298F0E248562C2523B45D428262C724D588A098B6213566D6D2DB9D88A098BE25AAED3E9A4D88455575717AFD8EFBD07B319F3E783D4BDD1F45644E962B55AC919EFC0262CB1B0094B246CC2124C5C4C5881005A5B316B16CE3F1F6A3D69F860E119B0387C3E9FDBED563B45D428DD4C6AA7881AA24D588A098B6237537D7D3DC5D80D0D0DDC84250CB7DB1DFB26AC37DEC08205484880C311E32DC71F2EC0E2D0E974146736749552446313356199CD668AB1D9842592D8C7FEFC733CFF3C66CF06B5E75228E8172F5EAC7686A8D9B46953797979414141434383CBE572B95C8140C066B3F9FDFE6030A8D7EB7B7A7A8C46E3C04B9FCF673018541FEDEDED4D4A4A0A87C38140403BA9061D553EA16459D654AA4147038180C160309BCD9A4A3594D1E4E46425BCA6520D3A0AC06C366B2DD5A0A38A4E596BA9061D557ACE0D06434F4F8FC160E8EFEF1FF8E28197CA53DA8C46A3764695F34B9FCF77E85B0E8542BA70B8FBF7BF379E7966FF45170543A158650E8542EDEDED1515154A7171BBDD1F7EF8615A5A5A3C1E2F4BEF1C0A804EA7DBBC79737171F1B265CB962D5BF6E8A38FBEFDF6DB7EBFBFB5B5D5E3F10483C15DBB76050281D6D656B7DBADBC547D34140A7DF7DD775555556D6D6DDA493594D19E9E9EB56BD76A2DD5A0A31E8F67EDDAB57D7D7D9A4A35E8687D7DFDFAF5EBABAAAA34956A28A36BD7AEF5F97C5A4B75E0D19D3B776EDBB66DF7EEDD4D4D4DDA493594D1CD9B37EFDAB52B140A29A36EB7DBED76FBFDFE9A9A1ABFDFAFCD974D4D4DDF7CF34D4B4B4B6D6DEDA16FCA5D5616282FAFBDF452FFCF7EE6F6786298B9A9A969F3E6CD8F3EFAA8525F8A8B8B376EDC18A7F506496B4FCD1B0A2525255BB76E7DE6996706AEF0190C863D5B126459DE735949232F43A1902CCB033935926A282FFD7EBFB29CABA954077E29CB723018341A8D9A4A35E84BE5B1D611EBA2AAA71ACACB813789A6520DFA52990C0D3C455423A9067DA9ACA2E9743A4DA51AF4A5127BE0E1B007BD29B9BD1D77DE29151662C102EC41AC328742A181967E9D4E3777EE5C9BCD565C5C8C584372060C40AFD79B4C26CB8F443404465CD4D1C8CBBEBEBE3D4D581A4935E8CB6030D8D8D8A87A8C685F864221A5094B53A9067D190E879D4E67C4DD53AAA71ACACBC6C6C6E01E4D581A4935E84B97CBE5FF5161AD9D5483BE6C6C6CECEBEB533D46B42F9B9A9A7A7B7B0F7553FDFDD2B26592DF8F1B6FC4FF12ABCC7ABD7EA0B8984CA6F8359C532DC0146113964824366189854D582239AC4D583D3D4849C1D2A5A0F668D7BDA1570FE8C2262C91B0094B3014F736D88425169BCD76A87BFBE38F919585FBEFA7229B3C30F40E18BAB0094B246CC2120C9BB04472989AB03EF9044B96A0A36378545FF00C58246CC212099BB004C3262C911C8E26AC1D3BF0C823B8E1069C724A4C43A909CF80C5C1262C9104D9842516366189E4B03361C9328C46DC761BAEBC32D6A1D4840BB038D8842512BAB1899AB0E82AA588C6A678C5FD2063B7B4E0B1C76032E1F2CB41F0A03E00F41631E862369B29AE1AE9F5FA8C8C0CB553448D5EAF77381CE43EA4F47AFDC89123C9C506909191416EC11F80C3E120B7720E203D3D9DE28789DD6E8FFA4DD2D78765CBE0762325253EA1D484DE714E17AFD7EB743AD54E11357EBFBFB2B252ED1451E3F7FB77ECD841AE092B100894969692EB66025059593970432D156459AEAAAAEAE9E9513B48D4545757536CC2723A9D5EAF37BAEFF9E73F515585871F26F7A4A3A140EF1C8A2E369B2D393959ED1451A37433A99D226A4C26D3C48913C9CDC98C46E3F4E9D3292E9E8F1F3F9EDC545292A4A2A2228A53C9A2A22272EF6D0005050551C49665F4F763C60C1C771CF2F3E3184B3D78062C0E9FCFB7A7098B0AC160D0E572A99D226A883661854221A7D349B19BC9E572118DCD4D58C2F0783C5134617DF821EEBF1F393918372E9EA1D4840BB038D8842512366109864D582219FE26AC8D1B515C8CA95341F0D6CDA143AF1ED0854D58226113966028EE6DB0094B2C433561050278ED355C7209AEBA2AFEA1D484DE014317366189844D58826113964886B309ABAD0DCDCD983F1FB7DE0A82A77451C1336071B0094B246CC2120C9BB044326C4D58DDDD58B8108585F8CD6F44855293617E7EA129D8842512A24D586CC2120C9BB044328809ABAF0F8F3F8EA626CC9E2D30949A700116079BB0444237369BB044423736C52BEE83C46E69414707962EC5C8910243A909BD450CBAB0094B246CC2120C9BB04432DC4C58B28CD252646763F9F261269B3C30F48E73BAB0094B246CC2120C9BB04432DC4C589F7D8679F3E0721D56D5173C0316099BB044C2262CC1B0094B24C3CA84B56D1B962CC12F7E811933D408A5263C0316079BB04442B4098B4D588261139648F66DC2F2F970EDB5B8FA6A3512A90CBD533FBAB0094B246CC2120C9BB044324C4C581E0FFEF52FCC9E7D18CE7D15E8FD09E9C2262C91B0094B3014F736D88425169BCDF6DFD8DDDD78F861AC5F7FB85DF7DD137A070C5DD8842512366109864D5822190E26AC175F445D1D962E1D960FFA1D22F45644E9C2262C91B0094B306CC212096D1356388C6010279D848B2E426EAEDAA1D48467C0E260139648883661B1094B306CC21289DBEDF67577E3B5D7B07225A64F474181DA8954860BB038D8842512BAB1D9842512BAB1295E71371A8DBA77DEC10B2FE0E8A34170B7C71C7A8B187461139648D884251836618984AA092B1030FCE31FB8EB2ECC9CA976164D40EF38A70B9BB044C2262CC1B0094B24244D581ECFCE5DBBBC8B17E3E28BD58EA215B8008BC366B31510BCE6C1262C91903661918BAD98B028B646161515A5D06A1EAEAAC2ADB7167476A61E7514A81D95F1830BB038D8842512A24D586CC2120C9BB044D0D0807BEFC5A4499EF1E30FF438C2C30F7A5711E8C2262C91B0094B306CC212093113565515264FC6BC79869E1E8A7B3B7ED0AB077461139648D88425188A7B1B6CC28A375D5D58BB16279C80934F86D168331828EEEDF841EF80A10B9BB044C2262CC1B0094B24344C58FDFD58BE1C7FFE3364194623224C580CCF8045C2262C91B0094B306CC212090D13D64B2F61ED5A9494E0C795BF1F4C58CC8FF00C581C6CC21209D1262C366109864D58F12214C2A85178FC7114160EFC9BDBEDE626AC3DD1FC39D430824D5822A11B9B4D5822A11B5BD357DCDF7D17CDCDF8C52F22FE59EBB185C3FB421C66B3D96EB7AB9D226AD8842512366109C6E170503C514B4F4FD76EECCF3EC3638F615F9D9B76BBDD6C368B4FA459E81DE77461139648D884251836618944BB26ACFA7A3CF9247EF94B5C78E1DE834EA7D3EBF58A0FA559A82E41F7F6F6B6B4B40C5CE14B4A4AD27E7F93D56A4D4E4E563B45D4103561198D468A262C83C1307DFA7472DD4C00C68F1F4F2EB662C222D0CDB4178585855A7C6F7776222909C5C5D84FDBE6D8B163B5187B2F7A7B7BBBBABA94FFD7E9743E9F2F4EF545BF78F1E2786C37AE949595BDFEFAEB1B376E7CF7DD77DF7DF7DDD5AB57B7B5B54D9D3AD5ED76B7B7B7272525555454D8ED76B7DBDDDADA9A9C9CBC7DFBF69494148FC7A3E2687272F2860D1B42A1505F5F5F4B4B8B46520D65343939B9ACAC2C180C6A2AD5A0A38D8D8DE5E5E55959593B76ECD04EAA038F7A3C1E8FC7D3D8D8D8D8D8989A9AAA9154431CFDFAEBAF1D0E47535393A6521D78B4A2A2A2A3A3A3B3B3B3ABAB4B3BA986325A5E5EDEDDDD6DB55A2B2A2A525353EBEAEA3A3A3A121313B76EDD9A9A9ADAD0D0D0D1D161369BB76DDB9696962660B4BCBCDCD6D9699837AF3F3D3D346DDAD68A8ABDBFD7E5726DDFBE3D2929A9AAAACA6EB7AB9E797FA35D5D5D6565658B162D7AEFBDF7DE7DF7DD77DE79E79B6FBE993265CA19679C11F35A26C9B21CF38DC69B929292B56BD72E5EBC7860066CB7DB33333343A1902CCB0683C1EFF79B4CA63D5F1A8DC67038ACEE684747475F5F5F666666381CD64EAA4147753A5D4343C3C891238D46A376520D3ADADFDFEF76BB73737343A19076520D3A1A0804EAEAEA727272121212B4936AD051BD5EFFFDF7DFE7E6E64A92A49D5443196D6E6E4E4D4DB5582C7ABD5E3BA9061D6D6868484D4D4D4E4E565E2A975AF47A7D201010FFD26030F4EFDE6DBAEF3E293B5B7EE8212925659FA9C2E1706363A3DD6E371A8DAA673EC04B4992BABABA06B4C13A9D6EC99225A3468D7AF4D147635ECBA816E08A8A8A929212B5834487F2F16AB158D40E121DB22CF7F5F5252424A81D243A6459EEEFEFA7B8B77B7A7A929292C8B5E6F6F6F652ECDFEEEBEBA3D89AABB9D86BD6E0830FF0E083484B3BC057F5F5F5198D4612ABD07B3267CE9CA4A4A4E2E2E2986F59337FBFC300366189241008545757936BC262139648D88415037A7AB061034E3E198F3E7AE0EA0B3661ED05BDEE03BAB0094B246CC2120C9BB044A21513563088952B515E8EE79E4362E2A05FCE26AC0878062C0E366189844D588261139648B462C27AE9257CF209E6CDC3D01E4ECC26AC08B8008B834D5822A11B9BE2955450564A118DADFE05E060103A1D1E7A0893260DF13B34115B4B686011E3B0C16C366B62D5284AD8842512366109C6E170905B3907909E9EAEF287C9471FA1AF0F37DD14D537D9ED768A6F92F841EF38A70B9BB044C2262CC1B0094B242A9BB03EFF1C8B1621FA77299BB022A03721A38BCD66631396304C2613451396D1689C3E7D3AC5C573366189A4A8A848B5F7766D2D1E7B0CBFFA152EBD34DA6F2D2828207748C6159E018BC3E7F30DDCDC4D886030E872B9D44E1135449BB042A190D3E9A4D8CDE472B988C6E626AC28E8EA82D58A458BF0B39F21FA6BE71E8F879BB0F6840BB038743A1DC5736D4992289EB44A92446E42A660341A29B605E9F57A8AB189EE6DA3D1A842A34079396EBF1D2D2D38FE781CD4C165301828F637C40FDE17E230994C369B4DED1451A3D3E9D2F7F564318DA3C42677B4EB74BAECEC6C72B10150DCDB00D2D2D2289EA8D9ED76D1D729AAAB316F1EC68DC3983107BD0D9BCD46F1F24AFCA077C0D0854D5822090402353535E49AB0D8842512366145C1471F61F264DC75170E41EFCA26AC08E8AD88D2854D582261139660D8842512A1262CB71B8D8DB8F65A180C87527DC126ACBDE019B038D8842512A24D586CC2120C9BB006A1BD1D0B1762D52A24241C62F5059BB0F6820BFF62F11A0000200049444154B038D8842512BAB1D9842512BAB1455C71EFEDC5830FA2B71777DC8158CC5CD9841501BDB517BAB0094B246CC2120C9BB04422C884D5DF8F238FC4851722333326DB63135604F48E73BAB0094B246CC2120C9BB044127713565F1F5E7C11B5B5B8F556E4E4C46AAB6CC28A80DE848C2E6CC212099BB004C3262C91C4D784E5F763C50A7CF6194E3D35B61B661356043C0316079BB04442B4098B4D58826113D63EF8F8637CF515962F4761616C37CC26AC08E89DFAD1854D582261139660D88425927899B08241747662D2243CFD34C68D8BF9E6D9841501EF0B71B0094B246CC2120CC5BD0D3661ED892CE38D37F0E083484B8B47F5059BB0F682DE014317366189844D588261139648626FC29265FCED6F78EE395C7209E2D6AAC226AC08E8AD88D2854D582261139660D8842592D89BB0FAFAB0650B162CC05967C572B3FF0B9BB022E019B038D8842512A24D586CC2120C9BB00060DD3AECDA85C58B71EEB931DBE6BE601356045C80C5C1262C91D08DCD262C91D08D1DB32BEE5F7E89050B505707B3F9201EF11B156CC28A80DEDA0B5DD8842512366109864D5822899909EBBBEF70FFFDB8E69AB8AE3C0FC026AC08E81DE77461139648D8842518366189243626AC70186633EEBC13BFF845BCE7BE0A6CC28A80DE848C2E6CC212099BB004C3262C91C4C084F5DD77F8EB5FF1DBDFE2D24B63146A70D8841501CF80C5C1262C91106DC2621396600E5313564D0D162E444A0A525262176A70D8841501176071B0094B246CC2120C9BB044724826AC6010CF3F8FA38EC26F7F0BB339A6B906814D5811D0AB077461139648D88425188A7B1B87A109CBE34120803BEE407ABAE0EA0BC066B351DCDBF183DE014317366189844D5882611396480ED284D5D8887BEFC5871F223F5FF0E2B3029BB022E019B038D8842512366109864D582239181396C7837BEE417A3A66CF8E4FA8C1611356043C0316079BB04442B4098B4D5882398C4C58ADAD38F2482C5AA4CADC57814D5811700116079BB0444237369BB0444237761457DC5B5AF0C73F222B0BF3E743D57E0E366145C0FB421C66B3D96EB7AB9D226AD8842512366109C6E170503C514B4F4F1F6AECD656CC9F8F8D1B05982607C56EB79B85777E69197AC7395DD8842512366109864D582219AA092B1CC633CFA0AB0B8B17C7EF218343874D5811D0EB3EA00B9BB044C2262CC1B0094B24433261F5F52118C42597202B0B234608C935086CC28A8067C0E260139648883661B1094B30C3D684D5DD8D254BF0C61B983A1523478ACA35086CC28A800BB038D8842512A24D5820EB6632180C146313DDDB8398B07A7AF0D043282FC799670A0C35386CC28A40BF78F162B533444D5959D9AA55ABB66FDFFEDE7BEFAD59B3E6BDF7DE6B6B6B9B3061425B5B5B676767424282D3E94C49491978B973E7CEA4A42475471313139D4E677A7ABAD7EBD54EAAA18C5AAD56AFD7EBF3F934956A28A37D7D7D292929BB76EDD254AA41475353531B1A1A92939335956AD0D1C6C6469BCDD6DEDEAEA954071E753A9DA9A9A95D5D5D5EAF573BA98632DADDDDDDDBDBAB7CAA2427277B3C9EAEAE2EB3D95C5353939A9ADAB6766DE8934FA4254B9C404A4ACA9EA356AB55C597BDBDBDC9C9C9CAA78A765245BCECE9E9F9EEBBEF1E7FFCF1356BD6AC59B3E6FDF7DFFFFCF3CFC78F1F3F73E6CC98D732920578C3860DF5F5F5175E78616E6EEEA851A37273730B0A0A727373655936180C168B25140A2525250DBC0C87C389898900541C4D4848503E9B1C0E875EAFD748AAA18C1A8DC6EAEAEA9123476A2AD5A0A37EBFDFE974E6E4E400D04EAA41476559DEBE7D7B464686622DD548AA4147CD66F38E1D3B94FE6DEDA41A7454B94E919494949494A49D544319ADAEAE4E4A4A4A4D4D1D18351A8D090909E18E8EC4FFFC27347EBCEED24B8DA3468542A1E4E4646574CF4D198D46B3D91C0E87458E4A92B47BF7EEE4E464B3D9AC9D547B8F2A77A6499234EA476A6A6A468E1C198F022CC9B21CF38DC69B9292928A8A8A929212B58344872CCBA15088E22A74201020D75F03B2B1FD7E3FC5C5F3603048F4BD4D71F13C180CEEE3E9173D3D58B204D5D5F8FDEF9199A952B403B1EFD89A67CE9C39494949C5C5C531DF322FC78B834D582221DA8445D7845557574731365113564343C33E9AB09E7D16E5E578E2096D565FB0096B2FE89DB1D2854D5822A11B9B4D5822A11BFB7FBA998241844238E1045C76190A0AD4CB35086CC28A800BB038CC6633C5353A366189844D588271381C14AF53A4A7A7FFF7C3A4BF1FCF3C83EC6C5C738DAAA106C76EB7537C93C40F7AC7395DD8842512366109864D5822F9AF09ABAF0F2B5660ED5A1C779CDAA106874D5811D09B90D1854D582261139660D8842592FF9AB02A2AB0752B8A8B5158A876A8C1611356043C0316079BB04442B4098B4D5882216AC26A6C6CEC6D6BC3BA75183B16252520728ACC26AC08B8008B834D5822912489DC844C81A89B89E2ED2520BBB70DA190F4BBDF61F9728442A0F38C3536614540AF1ED0C564322976055AE874BA74559F217A7028B1C91DED3A9D2E3B3B9B5C6C0014F73680B4B4347A276AE1F08855ABB07E3D962F57F7F9BED162B3D9E8EDED7842EF80A14B7777775D5D9DDA29A2261008D4D6D6AA9D226A0281404D4D0DB926AC6030B865CB168A4D58B5B5B5E462CBB25C5B5B3BC8530DB446288440A03531B1FF914770D4516AA7898EBABABA213D45F1B08167C0E2B05AAD4949496AA7881A93C9545454A4768AA8517AC7C82D9E1B8DC669D3A6516CC22A2A2A2237B99124A9B0B090D285A1FE7E949460F4E8B45B6E513BCAC13066CC187287645CE119B038D8842512A24D58744D58F5F5F51463533261F5F5E1C927F1FEFB282AAAAFAF27367107C026ACBDE0022C0E366189846E6C3661898452EC0D1BB06D1B9E7A0A932713ED666213560474D65EE8C3262C91B0094B306CC28A235E2FB66FC7E4C978F659A4A521C284450736614540EF38A70B9BB044C2262CC1B0092B5E747763E9523CFB2C4C26A5FA624F131629D8841501BD7328BAB0094B246CC2120C9BB0E282DF8FE2626CDF8EDFFD0E7BB470FED784450A366145C0336071B0094B24449BB0D88425184D9BB082410483183F1E2B56E08823F61C71B95C149BB0D8841581864FFD861D6CC212099BB004C326AC18D3DA8AC71FC78517EEF3194746A39162A300D1DEB1F841AF1ED0854D58226113966028EE6D68D684D5D282F9F3D1D585B163F7396EB7DB295EA760135604F40E18BAB0094B246CC2120C9BB062C9071FA0BF1F2B5660E4C87D8E3B9D4E8A4D586CC28A8067C0E260139648D88425183661C586E666B8DDB8E0029C7F3E5253F7F755E3C68DD356ECA1C126AC0878062C0E366189846813169BB004A32D13566323EEBE1BAB562125E500D517649BB0D8841501176071B0094B247463B3094B241A8ADDD68679F39090803BEEC06057D3892AA588C68E1FF41631E8C2262C91B0094B306CC23A24FC7E048338FD745C78E1806DE300B0096B7840EF38A70B9BB044C2262CC1B009EBE0A9A9C1DD77A3BD1DD75F0F876328DFC126ACE101BD7328BAB0094B246CC2120C9BB00E92EA6ADC7D37264C406EEED0BF894D58C3039E018B834D582221DA84C5262CC1A86CC29265AC5E8D638FC5830F229A5B24883661B1092B029E018B834D582261139660D88415351515F0FB71D34D3099603647F5AD6CC21A1EF0BE10079BB044C2262CC150DCDB50D184555A8AB973515A8A949468AB2F289BB028C68E1FF40E18BAB0094B246CC2120C9BB0A260EB56DC730F2EBE18D75E7B701B6013D6F080DE8A285DD8842512366109864D58434296E1F723250577DF8D73CEC1C1EE3136610D0F78062C0E366189846813169BB00423DA84F5E18758B0006969B8E08283AEBE20DB84C526AC08B8008B834D5822A11B9B4D582211175B96F1CE3B58BA14C71E8B43BE1D91A8528A68ECF8416F11832E6CC212099BB004C326AC41E8EAC2279FE0CE3BF1D39FE2904B3E9BB08607F48E73BAB0094B246CC2120C9BB0F64B208055ABE072E1D14771E9A5875E7DC126ACE102BD7328BAB0094B246CC2120C9BB0F64D7F3F5E78016FBE89679E414242ACB6CA26ACE101CF80C5C1262C91106DC262139660E26EC2FADBDFB07A35962FC7942931DC2AD1262C366145C0336071B0094B246CC2120C9BB022E9E9416F2FA64FC771C721D66B486CC21A1ED0AB077461139648D88425188A7B1BF13361B5B7E39147909686050B62BF71CA262CA2A7C57182DE01431736618924180CD6D6D6926BC2A26BC2A2B8721E2F13567B3B162C406323AEB926C65BFE915DBB76A9FF14C5E861135604FAC58B17AB9D216A4A4B4B3FFEF8E3EEEEEE75EBD6AD5FBF7EDDBA755EAF372F2FAFB3B3D3E7F399CD6697CB959898E8F57ABBBBBBCD6673636363424282D7EB5577B4B9B979E4C891DDDDDD9A4A35E8684A4A8A5EAFEFEDEDD554AA4147BBBBBB8D46637272B2A6520D3AEAF3F9468F1EDDD2D2A2A9544319EDEDED4D4949D15AAA4147B3B3B3FBFBFB63B5E5AEAE2E9FCF67F2781AD7ADB32C5AD49D9ADAD3D3138FDF4892A4502864B15894D1B6B6369FCF673299EAEBEB1313133B3A3A7A7B7B8D466343434352529276460D06434A4A8ACBE5D254AA88D1BEBEBE9A9A9AD75F7F7DFDFAF5EBD7AFDFB871E3279F7C929F9F3F73E6CC98D732AA3360BFDFDFB9077D7D7D6A271A044992141316B9EB64144D58922429B1C9CD8043A1504D4D0DB9A924689AB064598E6113964EA79377EC083FF5143233A5850B75B9B9F1EB01549AB0687D984892A498B0B41F7BCFFAD2D1D111BFFBEB245996E3B4E941090683E170F8209A204A4A4A2A2A2A4A4A4AE2142C4EF4F6F6767575656666AA1D243A42A190DBEDCEC9C9513B48748442218FC743EE7A6A2814DAB56B577E7E3EB9C63797CB9595954531767A7ABA39FAE711ED83F272DC771F264FC6830FC26289C106F78FDBED4E4D4DB5C4F9A7C49CA6A6A694949484D8DD8E25863973E6242525151717C77CCBEA3461B9DDEE3FFDE94F9B366DEAEFEF2F2828B8EAAAAB66CC98A14A1291B0094B247ABD9E625B105D1396C3E120577D11431396CF87A79FC671C7E1AEBBE25D7D01A4A5A551FC30611356042A1CE73E9FEFFEFBEFDFB871E345175D74EDB5D79ACDE67BEFBDB7BCBC5C7C12C1B0094B246CC212CCE16BC292656CDB86F676CC9F8F7BEE4162628CD21D0836610D0F543887723A9D6EB7FBF9E79F1F3D7A3480CB2FBFFC9E7BEEF9F8E38F8F3CF248F16144C2262C91B0094B3087A9094B79C4C2934FE2D14771E289B18B36086CC21A1EA8B3D225CB72C4B56772C6A283804D5822611396600E5313D6DB6F63D932FCFAD738FEF8D8851A1C36610D0F5498018F1D3B362727E7AEBBEEBAF8E28B131212CACACA366DDA74DD75D7894F2218366189844D588239EC4C58C120C261D86C58B20471B841E5C0B0096B78A0423D484C4C7CF8E1875F79E595D5AB57F7F7F71716163EF1C413471D7594F8248261139648D88425188A7B1B076DC2EAEFC7CA95B05870FBED710835386CC21A1EA873C0A4A6A61E73CC31471E79E4840913264F9EAC5C0C1EF6B0094B248140A0A6A6865C13165D13566D6D2DB9D80769C2EAEAC29225F8E413FCE427F1C935384EA7936213169BB02250A1000783C1279E7862C18205CDCDCD9224BDFEFAEB37DF7C33C5CA142D56AB75CC98316AA7881A93C9545454A4768AA8517AC7C82D9E1B8DC669D3A6519CDC141515918B2D495261616162B47DCB4E273C1EFCEE77506FDD6EDCB8712929296AFDF48366CC983156AB55ED141A428502EC743A3FFEF8E3A79E7AAAA4A464D9B2657FFBDBDF929292DE7DF75DF14904A398B0D44E1135144D5820DB84150C06ABABAB2976335134610168686888A209ABA1017FFF3BC68EC5CA9550F5AC9468139662C2523B858650A100FBFDFEF4F4F471E3C6292F535353C78E1D1BDF47726A039D4E476E8A004092248E2D0C49922C160BC56E2693C934CC63EFDC89BBEFC6DAB53018A0B6CBC9643251BCE24E3476FC50615F8C1D3B362323E3C9279FFCF6DB6FABABABFFF297BFAC5BB7AEB0B0B0AEAECEE3F1A8A8C68C3766B3D96EB7AB9D226AE89AB01C0E07B9A39DAE092B232383DC823F0087C331A413B5CE4E2C5982BC3C2C59A27AF505909E9E4EF1FCD26EB7C7C6FA395C50A10B3A140A85C3E17FFEF39F9F7EFAA9C9646A6B6B9365B9B8B8381C0E4F9B36EDD1471F8DFA920C11BC5EAFC7E321773D5531614D9E3C59ED20D1A198B0264D9A44AB2A2826AC19336690FB78ADACAC247719583161E5E7E71FC89023CB703A61B361CE1C141622294960C0FD525D5D3D6AD42872D7539D4E675656566A6AAADA41B4823AB7213DF8E083F3E7CF5726BBCAFA4F30189465393131919C5E7CE8B0094B246CC212CCF03461C93256AFC673CF61D9324C9D2A30DA20B0096B78A04201D6EBF5FDFDFD9B376F1EB84544A7D39D76DA6914D739A3C2E7F3757474907BAC9062C2CACBCB533B4874284D58797979B496731513D6B871E3C8395B5C2E574E4E0EC5D8595959FB3DEF7FFD75BCF002EEBC53C586E77DE272B91C0E07B9C5428FC7939A9A9AA48D55042DA0C2D1D2DCDC7CFBEDB787422187C3A14C828D46E3E4C993877D0166139648D8842598E166C252EE69B658B074A98AF7FBEE0F36610D0F54A8070D0D0D494949CF3EFB6C464686729708D18FF86861139648D88425188A7B1BFB336179BD58B1029326E1F2CBD50835386CC21A1EA870C08C1831223D3D7DE7CE9DBD7B40EE7ECD83804D582261139660868F09CBEDC6BDF762FB761C738C4AB906874D58C3031566C04A03FDCF7FFEF3815B818D46637171F1A44993C4871189D56AA578F1834D5822216DC22237B9514C58911786366D82D188DFFD0E2346A8946B70287609001833660CB94332AEA8F027ACA9A9D9B265CB82050B0A0A0A946BC03A9D6ED4A851E29308C6E7F3B5B7B7E7E6E6AA1D243A946E2672124DA24D588A09EB501F52AB06F5F5F5A3468D2217BBA1A1213B3BFB8726AC6FBF454D0D2EB800679E096DDF8EE172B9323232C83561B9DD6EBBDD4E711E122754385A64591E3B76EC65975D76B8DD0DC6262C91D08DCD262C91FCD7CDF49FFF60C9125C7411CC6668FE1721AA94221A3B7EA85080F3F2F252525256AC5871C2092728FFA2D3E966CC9841D112151566B399DCFC006CC2120B9BB004F38309ABB6168F3D86ABAEC275D769BFFA02484F4FA7F86162B7DB29BE49E2873A262C005F7CF1455959190059968D46636E6EEEB02FC06CC212099BB00443D18405A07ACB96BC502879DC382C5F8EA2221079B7B0096B78A0420156A6BFDDDDDDADADADC9C9C966B339212181DC717B10B0094B246CC2120C451316BABA0ADF7CD3F0FDF72829C1C4896AA7890236610D0FD459E92A2D2DBDEDB6DBAEB8E28A575F7DF5C5175F7CF5D557293EC82C5A7C3E9FC7E3513B45D428262CB553440DD1C7112A262C8A8783CBE52216DBE7C3830F767EF55560DE3C505B7E23FA38428FC7C38F23DC13150A705B5BDB238F3C3265CA949FFDEC67FDFDFD279D74D26BAFBDF6D5575F894F2218366189844D58822166C2F27A1108E08413824F3D25919AFB2AB0096B78A0C2BED8BD7BB7C160F8D5AF7E9597972749D289279E78E699679696968A4F2218366189844D5882A1B4B7376CC0ADB7A2AE0E575C914AAD4B4081AE098B62ECF8A1C20163B55A7B7B7B77EEDC094092A4DEDE5EA7D339EC3BB0C0262CB1B0094B30644C581F7E88BBEFC68C1918370EC03E4C58146013D6F0408515D13163C6CC9A35EBEEBBEF36180C7EBF7FEBD6ADE170F8BCF3CE139F44306CC212099BB00443C384150AA1A606B7DF8ECB2F571A9EF761C2A2009BB086072AFC092549BAEDB6DB8E3EFAE8F5EBD7FBFDFEFCFCFC59B366391C0EF14904C3262C91B0094B305A3761F97C78F9654C9C885FFD0AC0C0CDBEFF63C2A2039BB08607423F9B2A2B2BFFFAD7BFB6B6B6FEFDEF7FDFBC79B3D96C4E4949696D6D7DFDF5D71B1A1A44265105366189846E6C3661C59E96162C5C88F7DE43662624694FD586A663EF1FA24A29A2B1E387D0D3D59E9E1E97CBE5F7FBEBEAEABEFFFEFB81BF84C160A07819265AD884251236610946D326ACF7DE437B3B9E7F1EA347478C381C0E022BE77BC126ACE181D03F614A4ACA71C71D3762C488F9F3E78BFCB91A814D582261139660346AC2DAB4093E1F2EBD14975E8A949488415996ABAAAAF2F3F3C91972D884353C107AA2BD71E3C67FFCE31F227FA2A6B0D96C0505056AA7881A36618984B4094B5BB1C361BCF516EEBA0BF5F54849D9BBFA029024A9A8A888E225C9A2A2A2947DFD461AA7A0A080E2AD98F143F44A97F2FC41792F04C75005366189844D5882D19C096BED5A3CF30CE6CCC1CF7E7680AF72B95CFDFDFDC242C50A36610D0F842E41EBF5FAFFFCE73F37DF7C7344C535180C77DD75D7B871E34486110F9BB044C2262CC168C884D5DE0E8F07858578EE3914161EF8E94644F7369BB0860742EB812CCB090909D9D9D97B166059960D0683B616AFE2039BB044C2262CC168656F373460E142381C78E41164660EFAE5696969144FD4E89AB028EEEDF821B40087C3E11933662C59B244E40FD50EDDDDDD4D4D4DE426FA8A096BD2A4496A07890EC58445EE32B062C2A2E8E2A8ADAD2D2C2C5439B6CB8539739093837BEEC1103EE86559AEADADCDCFCF277719D8E974E6E6E6926BC2AAABABCBCCCCA4380F8913A2574429AEF6C40A366189844D588251D984150EA3A3033A1D7EF633CC9AB5CF96ABBD9124894D58226113560442978CA64D9B76F9E5978BFC899AC2E7F3B9DD6EB553448DD2CDA4768AA821DA84A598B0B4D5CD3434EAEBEB558B1D08E0955770CF3D3099307BF610ABAF42434303376109C3ED767313D69E082DC08585853FF9C94F0E7D3B92243537377FFBEDB7656565656565A5A5A54A85088542CA4780DFEF8F7829CBB2EAA3C160D0683486C3614DA51ACAA85EAFD760AA414725499265596BA90E3C1A0A85CC66B3D6520D3A3AD0D5A1422AAF572E2E0EBEF452F08A2BE4D4D468B7AC1C92CA433BB4B0278738AAD3E90632CBB21C0C0695BF82965F2A87A424499A4AB5F7CB5028D4D2D2525A5AAAD4976FBFFDB6A9A9294E6BB7FAC58B17C763BB71A5B4B474D5AA55B5B5B55F7FFDF5D75F7FFDE5975FF6F6F61E7DF4D11E8FA7B3B3332929A9B2B2D26EB7373535B5B7B727272757555559ADD6A6A6267547ABAAAAB2B3B35B5B5BDBDADAB4936AD0D1B4B434AFD7EBF57A35956AD0D19696169FCF67B7DB3595EAC0A3CDCDCDEDEDED1919193B77EED44EAA218EEEDAB52B2D2DADB9B959E4BE4A321AABBFFBCEE674365D7555D791472646BF6587C3D1D1D1A1A93D3994D1CECE4E9FCF979C9C5C5959999A9ADAD0D0E0F57A1313132B2A2A5253531B1B1BBD5EAFC562D9BE7D7B5A5A9A76467B7B7B53525276ECD8A1A95411A3DDDDDDDBB66D7BFAE9A7D7AE5DAB94984D9B364D9E3CF98C33CE88792D9328DE835B5252F2EDB7DFAE58B1626081D16C366B5FA7DEDEDEDED4D444EE7AAAA2949A3C7932ADEBF77EBF7FFBF6ED471E7924AD4B657EBF7FC3860DD3A74F379BCD6A67898E2D5BB68876719495E14F7F92EFBC533AD82785C8B25C5E5E4ED184555E5E9E9B9B4BAE9BA9B2B2928409CBEFF70FACF0EB74BA7BEEB9272D2DADB8B838E63F88D267D39E984C26722298D4D454729901984CA6091326D0AABEF8D18445ABFA0230994C14AB2F80091326886BC29265BCFB2E962FC785174A595907BD19C58445EE4D02A0A8A88862375341410189D8269369CF53C9F81D8F1AB86FEFB0814D582209D26CC26213D690E8EFC7DAB5B8F556CC9D8B437B241F9BB044C226AC08E89DFAD1854D5822611396600499B09A9BF197BFE09C73F0D04330180E6CB91A0A44F7369BB08607BC2FC4C1262C91B0094B3022F6764D0DE6CE456929AC56188D875E7DC1262CB1D86C368AB1E307BDE39C2EDDDDDD7575756AA7881AC584A5768AA8514C58CAAD1A840806835BB66C0904026A07899ADADADAF8C69665BCFA2A468FC6B3CF223737469B946B6B6B29AEE53A9DCEEEEE6EB553444D5D5D1DC5D8F183DE8A285DD8842512366109268E26AC60101F7C80BC3CCC9D0B8B050909B1DA309BB004C326AC0878062C0E36618984681356904D5811747561D9323CF1047A7A60B7C7B0FA2AB0094B246CC28A80DE39145D743A1DC5998D24491C5B189224592C168A6D412693292EB1FFF2179496E2996770D451B1DF78FC62C71993C944B1518068ECF8C105581C66B399E2AA915EAFCFC8C8503B45D4E8F57A87C341EE68D7EBF523478E24171B404646468C5717BFFB0E66332EBA08975D3694070B1E1C0E87836213567A7A3AC50F13BBDDCE4BD07B42EF38A78BD7EB753A9D6AA7881ABFDF5F5959A9768AA851045EE49AB0028140696929C526ACCACA4AC55A1C034221FCED6FB8E30E6CDF8E9C9CF8555F5996ABAAAA7A7A7AE2B4FDF8515D5D4DB19BC9E9747ABD5EB55368087AE75074B1D96CE48C77F8B19B49ED1451A398B0C89D6E1B8DC6E9D3A7535C3C1F3F7E7CCCA692FFFE377EFF7BDC7B2FCE3B2F361BDC0F6CC2120C1513963078062C0E366189846813D6E16EC272B9B07327A64CC1EF7F8F0B2E40FC97E2D9842512366145C005581C6CC212099BB004130313D6BA75B8F1467CF0018E3802A2165D88EE6D36610D0F785F88834D5822611396600E756F7FF515EEBD17679F8D6BAF8D5DA8C161139648D8841501BDE39C2E6CC212099BB00473F026ACAE2E34362233134B9762CE9C437CB84254B0094B306CC28A80DE8A285DD8842512366109E6204D583B7762C9128C1B87050B505818875C07824D5882611356043C0316079BB04442B409EBF032616DDD8A5FFF1A6969B8E186F8841A1C366189844D5811D03B87A20B9BB0444237F66161C2EAEB434F0F0C065C7F3D2EBC10164B3CA31D083661898468ECF8C105581C6CC212099BB004138509CBE34171316C362C5E8C0913E29C6B10D884251236614540EF38A70B9BB044C2262CC10CD584555B8B5FFF1A5D5DB8EEBA983CD0F75060139660D8841501BD7328BAB0094B246CC212CCE026AC4000BDBDF0FB316B16AEB80256ABA868FB854D5882611356043C0316079BB04442B4096BD89AB094A70A3EFC308E380237DEA885EAABC0262C91B0092B022EC0E260139648D88425980399B05C2ECC9D8B2D5B70F5D5D0D81F85E8DE6613D6F0805E3DA00B9BB044C2262CC1EC7B6F8742E8ED457737264FC65557C5EFB946070D9BB04462B3D928EEEDF841EF38A70B9BB044C2262CC1ECC384D5D383952BB17429F2F23077AE06AB2F9BB004C326AC0878062C0E366189844D5882893461353561D122ECDE8D850B6136AB97EB40B0094B306CC28A8067C0E2601396488836610D0713394BB493000020004944415456388CDE5E747460CC18BCF8228E3F5EED6807824D582261135604F4CEA1E8C2262C91D08D4DDB84E5F3E18F7F447D3D962CC16F7FABFA9DBE83C2262C91108D1D3FB8008B834D582261139660323333756D6D58B2043535B8FF7E15ED9251C1262C91B0092B027AC7395DD8842512366189440E852A376F0E34372327077FFC234E3E59ED4443824D588261135604F4CEA1E8C2262C91B0094B1C7D7DD2CB2F8FAFAAD23FF208EEBB4FED3451C0262CC1B0092B029E018B834D582221DA8445CF84D5D2827BEFC55B6FD54F991222B896CB262C91B0092B027AA77E7461139648D8841577C261F4F5A1A3039999B8EB2E93C92411BC744D666FFF2F6CC21A1ED0AB077461139648D884155F7C3EFCE10F70B9B06409EEBF1F9264EFED25107B2FD884251236614540EF80A10B9BB044C226AC38E272E137BFC1679FE1D24B61B128F71AEDC384A579D8842518366145C0336071B0094B246CC28A0B81007A7AD0D3838913B17429B2B30746224D581460139660D8841501CF80C5C1262C91106DC2D2B409ABAD0D4B97E2B1C7909F8F3BEFDCB3FA624F131629D8842512366145C005581C6CC21209DDD81A3561399DB8ED36D4D6EEEF9182749552446353BCE24E3476FCA0B7884117366189844D5831A3B7173E1F02019C792666CFC67E1A0933323228AE2EB2094B246CC28A404BC77934F87CBEE6E6668FC7E3F178DC6E77575717807038AC2C392AAD375A7BD9D6D6A698B034956AD0977EBFBFA2A242F977EDA41AF4655F5F5F7979793018D454AA415FF6F5F59596962AAB8BAAA70A87C3686890EFBD37BC6205C68D936FB80136DB3EBF5896E5F2F2F2FEFE7ED53347F532180C565656767575692AD5505E565656767676EEF337D2EC4B59966B6A6A3A3B3BB59FB9B7B7D7F323CDCDCDF173A5E9172F5E1CA74DC78FB2B2B2D75E7B6DDDBA756FBFFDF6DB6FBFFDD65B6FB5B7B71F73CC311E8FA7ADAD2D3939B9BCBCDC6EB7373535292FB76FDF6EB55A075EAA355A53533366CC98E6E6664DA51A74D4E1700402818E8E0E4DA51A74B4A5A505406A6AEA8E1D3BB4936AD0D18E8E8E828282DADA5AD55359ADD6AA55ABEC0F3ED81E08B45E7D75624E4E4545C501BED7ED763B1C0EEDECC9A18CEED8B1232F2FAFB3B3B3BDBD5D3BA98632EAF7FB7D3E5F4A4A8A325A5F5FDFD9D9999898B86DDB36BBDD5E5757D7D1D1919090B06DDBB6B4B4348D8CD6D7D7CBB29C9696565E5EAE9D547B8F7677776FDCB8F1FEFBEF5FBD7AB55262BEF9E69BA38F3EFA8C33CE88792D9364598EF946E34D4949C9FAF5EB1F7EF8E1F08F2D36292929E9E9E9A15048966583C1E0F7FB4D26D39E2F8D4663381C5677B4BDBDBDA7A767E4C891E170583BA9061D952469F7EEDDA3478F361A8DDA4935E8685F5FDFEEDDBB0B0A0A42A19076520D3A1A08049C4E677E7E7E6262A25AEF6700E1D6569DDF1F6A6F37545484CF3D1789893A9DEE00DFABD7EBABABABC78C19A3D3E934B2278732DADFDFDFD8D8E870382C168B76520D6574E7CE9D0E8743A9C446A3519953EAF5FA4020A0D997E170B8BEBE3E3D3DDD64326927D53E5FF6F6F6B6B6B62AC545AFD72F5CB870C48811C5C5C531AF65540B70454545494989DA41A2A3B7B7D7EBF5666565A91D243A42A1506363636E6EAEDA41A223140AB9DDEE11234668EB7AEA608442A19D3B77AA7CB7C677DFE1D14771CC3198376FE8DFD4D0D0909D9D4DEE0A9FCBE54A4F4F379BCD6A07898EC6C646BBDD6E21F2C8A9013C1E8FD56A4D4848503B4874CC9933272929291E0598D2671375D88425129D4E97969646ABFA420B26AC2FBFC4DCB998320537DD14D5F751DCDB601396586C361BC5D8F183DE014317366189844D58515357879D3B919585A54B71DF7D484B8BEABBD984251236610D0FE835B2D3854D5822611356148442F8F0433CF30C2EB904B7DC82C2C283D8069BB044C226ACE101CF80C5C1262C91B0092B0ADE7A0B8F3D86ABAFC62F7E71D0DB60139648D884353CA0770E4517366189846E6CA126ACCD9B61B1E0E8A3F1C20B38B4750EBA4A29A2B1295E71271A3B7EF0BE1087D96CB6DBED6AA7881A366189449C09CBEBC573CF61EE5CECD881B1630FB1FA82B2098BE2899A72338FDA29A2C66EB7936B388F2BC43E9E48E3F57A1513162DFC7E7F6565A5DA29A2C6EFF7EFD8B1835C13562010282D2D15D1CDF497BFE0FDF7B174292EB92426DBABACACF4FBFD31D994306459AEAAAA8A9FE7287E54575753EC66723A9D5EAF57ED141A8297A0C561B3D9929393D54E11354A3793DA29A2C664324D9C3891DC9CCC68344E9F3E3D8E939B9E1EAC5E8D8913F1D39FE28A2BE070C46AC3E3C78FA7D88455545444B19BA9A8A888DC7B1B40414101C5D8F18367C0E2F0F97C1E8F47ED1451130C065D2E97DA29A2866813562814723A9DF1EA66AAACC4DCB9F8CB5F100E233B3B86D51780CBE5A2D884E572B9B8094B181E8F879BB0F684DEA91F5D743A1DC5736D4992289EB44A92446E42A660341A63DF16140E4396F1C61B484BC3D2A5118FF28D097ABD9E6237535CF676FC311A8DE4FA1B00180C068AB1E307BD7A401736618944894DEE688F8B09ABB616AFBC82CB2FC7DD77C368DCE7D37C0F1D8A7B1B6CC2128BCD66A3B8B7E307BD03862E6CC212099BB000201CC65B6FE1E69BD1D585CC4C2426C6A9FA824D58626113D6F08067C0E260139648D88405E5936ECB16DC7C337EFAD3F8955E05366189844D58C3039E018B834D582221DA84151B13563088D5AB71FBED6869C1FDF7E3FFFDBF78575FB0094B2C449BB0D8841501BD7328BAB0094B2474631FAA09ABA7078F3F8E2FBEC04D3761C40888BA2E4B5729453436C52BEE4463C70F2EC0E2309BCD14578DD8842592433261F9FD70BB919484AC2C3CFF3CC4DEBD4DD784456EE51C407A7A3AC50F13BBDD4EF14D123F887D3C91864D582239EC4C582E17162EC4A245D0EB71DB6D82AB2FD884251636610D0FE89D43D1854D582239BC4C583B77E2CE3B919585F9F3919A1A9F6883C0262C91B0096B78C0336071B0094B24449BB0A23661B95C58B70E4949F8CD6FF0D45307F728DF98C0262C91106DC2621356045C80C5C1262C910C7F135630888F3EC24D37E1DD7761B7E3F4D3919818FF74FB854D58226113D6F0805E3DA00B9BB0E24E7333BEFD16E9E99838516FB1646666923BDAA330616DDC88279FC4ECD9B8F24A0177190D0A9BB044C226ACE101BD03862E6CC28A17A1100201D4D5E18E3BB06205962EC5F6ED01A7F3FB975E0A353480D42AF4E026ACFE7EAC5A857FFD0B471E89175FC40D37A83BF11D804D58226113D6F08067C0E2601356ECE9ED455919FEF94F1C7924AEBC12BFFD2D0A0A100CC26A35969616AC59A37BEB2D4C9D8ABBEF467232743A687ED2308809CBE9C4934F62FB76FCF6B7B05A61B58A4D7720D884251236610D0F78062C0E3661C50C59466F2F4221AC5C89458B9096869FFC04494938F658A4A6C2E180C9149C366DD7D2A5A1871EC231C7C06CC66BAFE1DA6BB16205366FD6F29C78BF26ACDE5E0483F8F65B2427E3E59771EEB96AA43B106CC21209D1262C36614540EF1C8A2E6CC28A01A11076EEC4BFFF0DA7138B17E3E28B71D555C8CDDDFB0B259DCEEC70482346E0B8E300E0DC7361B5E2CB2FF1AF7FA1B0107FFF3B9A9A306912264F465E9EE8DF62FFECDB84555A8A679FC5FFFB7FB8E4125C7C31343987A0AB94221A9BE21577A2B1E307176071B009EB90E8ED85D1884D9BB06811F2F270D965B0D99099B9BF2F8F34618D1C89D9B371D965F0FB613261C4085457E3CF7FC60927E0D65BF1F2CB08063171228E3A0A5959827EA3FDC4FE1F1356388C3FFD092FBF8C59B3306D9A30AFE441C0262C91B0096B7840EF4F4817AFD7EBF178B47B3D753F2826ACC99327ABF3E36519F5F5F8E8237CF411AEBF1ED3A6E1A9A7306EDCA07DBF8A096BD2A449FF73C0EB74B05800E0DC7371EEB9E8ED45380C8301999958BB169F7F8E73CEC135D7E0C5179194840913307E3C1C8E78FE7A91040281B2B2B2E9D3A79B743A5455212707696958B60C279E086D4FD42A2B2B8B8A8A34B45832041413567E7E3E39434E7575F5A851A3AC5A6A02180A4EA7332B2B2B5525578C06E1022C0E3661454777377A7A603663E9527477E3C20B71ECB1484B435ADA50BE7B4826AC84841FFE67F66CCC9E0D9F0FA11024092929282BC3BFFF8DEBAEC3D967E3C517919585F1E331610252520EF9173B1046A371FAB1C71A77EEC4FFFD1FB66DC38A15B8E492B8FEC458C1262C91B0096B7840EF9D47179FCFD7D1D1919393A37690E8504C5879222F94BADDF8E823BCFD36C68FC7FDF763D122A4A7FF30731D324AEF585E5E5E14D79C06EEE7B9E106FCF297E8EC84C98440006633BEFC12FFF807EEB8039327E3F5D7919383091370C41131BF0528E8F7D7AE5F3FEEF9E70D2346E0892754345B458BCBE5CAC9C92157CC5C2E5756569625CA7797EAB85C2E87C391A88D3BD0868EC7E3494D4DA57833489C2076B490864D5883E0F3E1FBEF31660CDE7B0F1F7F8CCB2EC369A7C162C1419DB21CAA094B92FE2B559E3307E1303A3B61B1C0EB45208077DEC1DFFE86F9F391968677DE415E1E264EC4D8B18724C46869C11B6F48CDCDC68B2F4671317273B5A0D7183A6CC212099BB08607F4EA015DD884B55FDADBF1EF7FE3FDF7110A61F9725C7925AEBCF2BFEBC30785123B6647BB4E07BB1D001212306F1E02017476C26A457D3D3A3AB06E1DFC7E3CF618FAFBF1D967282CC4114760F4E8282AE8860D58BA14168BEEE69BB3C78ED5A7A468FC8AEFDEB0094B246CC21A1E700116477777775353D3B871E3D40E121D8A096BD2A449B1DF746727366EC4A8510885B071232EBA08A79F8E112362527B0281404D4D4DBC1E886434FED09C35762C162F86DF8FB636A4A5A1AA0A0D0DF8F4532424E08927E072A1B4144545282C4476F63E6E1FEAEBC3575F213717160B6EB801679E19349BB76CDC7820178756A9ADAD2D2C2CA4155B3161E5E7E7935B14753A9DB9B9B9E49AB0EAEAEA32333329CE43E204176071B009EBBFF4F7E3D557B17A358241CC9D8BB3CEC233CF20A6EBF34AEF98A0C5739309D9D900306912962DFBA17D2C2303BB77A3BC1CEFBC831123B06C192A2A505383891331660C1C0E6CD880175E407D3D162EC44F7E82A38E02600428565FB0094B2C6CC21A1ED0FB13D2C5E7F3B5B7B7E7EECB1AA165946EA63163C6C4605BCDCDF8FC73F4F4E0B2CB100EE3C61B71D2493F7435C7FAD3E4609AB0624572329476F7134EC0F1C7A3BB1B5E2FEC76F4F561ED5ABCF106264CC0030FE0830F505888471EC1C8917BC6AEAEAEA6D89A5B5F5F3F6AD42872B11B1A1AB2B3B3293661656464906BC272BBDD76BB9DE23C244E103B5A4873F89AB014F7C5AA55F8C31F60B1E0F2CB9190809B6F8E51C07DA315819772539372F3D25967E18C33D0D101BF1F361BEEBD17164BC47AFBBE4D5814A0AB94221A9BE21577A2B1E3071760711C7626AC4000D5D5F8E8236CDF8E050B30762CE6CFC7B1C742C8CDD091262C8DA0D763A0A36D5F5D6691262C3AB0094B246CC21A1ED03BCEE9E2F57A9D4EA7DA29A246316145F10DE1301A1AD0D989F272CC9B878A0ACC9A058703471F8D534F15537DF1A3092B140A89F971B1221008949696927BAE1F80CACA4ABFDFAF768AE8504C583D3D3D6A07899AEAEA6A8ACFF5733A9D5EAF57ED141A82DE39145D86BF092B10C0975F62F56A9497E337BFC1CC992829C1C89131BFBE3B148664C2D21E46A371FAF4E99A583C8F12366189844D58C303AA3360599695FFCAB21CD6F0D3E5F6C4E7F3793C1EB553448D62C23AD057F4F4FC2052F6F9F0DE7BC8C8C0638F61E64C582C183D5A95EA0B20180C36343450796F0C100A859C4E27C5E7FAB95C2EA2B1293E8EB0B1B1B1AFAF4FED1451E3F178A83C8E301C0E2BF5053F969B78A05FBC78719C361D3FCACACA56AD5AB563C78E356BD6BCFFFEFB6BD6AC696969993061424B4B4B6767676262627575B5CD666B6D6D6D6F6F4F4C4CACADAD4D4A4A6A6D6D557774FBF6ED090909FDFDFD9A4A75E0D19A9A9AE4E4E4EFBFFF3E1C0E0F8CB6B7B77BBD5E8BC150535B9BF2C10786A54BC31F7E18B4D96A3332922EBAA8FDA8A3BA92932DC9C9EAFE46CDCDCD0D0D0D5959594EA7530B7B7288A36D6D6DC160B0B5B5D56AB56A27D55046BFFBEEBBECECECF6F6764DA53AF0684D4D8D24493E9FCFE7F32524246824D5A0A3CA21E9F7FBAD566B7575B5D56A6D6C6CF47ABD168BA5B2B2D26AB57A3C9EAEAE2EB3D95C555565B3D93432DAD4D4E476BBAD56EBAE5DBBB4936AEFD19E9E9E2D5BB62C5FBEFCFD1FF9FCF3CFC78F1F3F73E6CC98D732920578C3860D0D0D0D175F7CF1A851A3468F1E3D6AD4A8A2A222C5436B369B955EA7848404BD5E6FB158065EAA3E6A3299AC56ABD96CD654AA41471313131312129293937F183518745555E67FFFDBF4CE3BC6E9D3137A7B75932661CE1CE9F4D38D164B425292DE6030994CAAFF460683212525252929C968346A644F0E7134252545D9E79A4A75E05193C994909060B55A8D46A376520D3A6A341AAD566B4242C29E5FAC7AAA41472D168BF23EB1582C035F9C9090A0FC46CA4BE58F623299121313B5339A9C9CAC7C92682A55C4A8724F9A5EAF1FFD23D5D5D523468C88470196E237B98E1F2525251515152525256A07898ECECE4EA226ACEAEAEA09E3C6492E171C0EAC5F8F65CB30762C66CDC2AC59D13E2341184AEF18B9CBC0814060234D13567979F9B871E368C59665B9A2A282A2096BFBF6EDB9B9B929717E3657CCA9AEAEA668C29A33674E525252717171CCB74CAFFB802E444D5886BEBEC2D25269C50AB8DD58B810C71C833FFC01B9B96A5DDC1D22424D58B1C3683452ACBE000A0B0B2936611135611D71C4111463B3092B02AA4D5814F1F97C6EB75BED14FFBFBD338F8EAB3CEFFFF7DED917CD2ACD4833DA46B22C2F92AD18B0C1B1131C6A48520A6149E200294BC392742140A00DFD35216988DD368D53821352DA9CC3715C4E62C08981E026C426F4D810AF78D53A5A47D22C92665FEFCCBDBF3FDEA028C218C9D2DC99D7793FC7C74733779667963BCF7DDEFBBC9F776EA4D33873063FFA11DE78430C8723AFBF8E2BAFC477BF8BCB2E83C582C6C632CFBE78D784455D13163161D1D8CDE4F3F9680C7B747494C626ACB1B1B1743A5DEA28E68DDFEFA7A5094B1ECAFD67F452820213563C8E540A4623FEF99F71EC181A1BD1DE0EB73BFFE493A0CDA0592E26AC79C24C5832436FD834DA5A280DBB78B0042C1F9A7236619D3C897DFB70E8103A3AF0F8E3F8F4A7F1C003A8AB8342A1006C0E47A9E39B37656AC2FA2098094B6698094B4E98096B16F4EDE7F4525E26AC4201E3E378F555FCE84788C570F4288241DC771FBEF8456834B8EC32343692E5F3E66DC22A0F98094B6698094B4E9809EBD280BE63287A290B13562E876010555578E30D6CDF0EAD161B3782E771F7DDE0B8F32EC43B0F135639C14C5832C34C5872C24C589706AC02968F129BB02627F1ECB3F8ABBFC25FFF35FAFAB06A15B66EC54F7E82471E81D1089E3F6FF6C55C4C586509A54D58CC842533949AB0286DC2A2C884250FF41DFAD10BCFF3B21E6B8B2282419C3E8DC387F1B18FC1E1405F1FAEBD16EBD6A1A9094A256A6AE6F2301CC7D178D0CA711C75051941A552D1D816A45028680C9BD2775BA552D1D828A0542A690CBB78B0042C1F6AB55A8E19E88904FAFAA0D1A0AA0A8F3F8E8909AC5A05B319CDCDD8B6EDFDCADC0BC0F3BC7D7A053D7A206153B7B7F33C5F5D5D4D5DD800687CB701D86C361A0FD4AC562B8DE729CC66338DEF76F1A06F87A197442231323252948716042412C8E5F0CC33F8FCE7F195AFE0D021582CF87FFF0FBB76E15BDFC28A15002E22FB021004C1EBF52E72C0C5471084BEBE3EEA9AB0F2F9FCA953A7686CC2F27ABDD4852D4992D7EBA5712CB7BFBF9FC626AC9191111AC32E1EAC02968FA298B03A3BB17F3F8E1C4143031E7B0C3535B8EF3EAC5A05A7134A259A9A16FE0C6AB5BAB5B575E18F2333CC842533ADADADD41537F49AB05A5A5A680C9B99B066C12A60F9581C13562A85B367B17327B66F473C8E830771E60C366DC26DB741A7C38D37E2139F80DBBD88A62AD2CDB4588F261B943661311396CC3013969C3013D62CE83B86A2978B3761E572F0F9303888CB2FC79B6FE2FBDF474D0D366E8452893BEFC4DD77A3980795F42AA5280D9B99B0E484DEB0693CE34E69D8C5832560F9989F092B93412804BB1D8383F8D77FC5D8185C2E2C59820D1BD0D181EA6AD96CCC0A85A2AAAA4A9EE75A4498094B6698094B4E98094B362448392E674051D6D1A16F3FA7970F3661A5D3BF17653CF924EEBA0B7FF337387306562B6EBE193B76E0873F447D3D2C1699572262262C3961262C3961262C99A1C28425414A233D80815FE3D7DFC577EFC49D7B8D7B8B74DC40DF3114BD9CC784258A902464B378ED35BCFD36060670D75DB8E20A188DF8DCE7B07225EAEBA156E3861B4A1432C04C58F2C24C5872C24C583253B626AC1C7253981AC040273A4FE0C4699CF6C19740C20453139ACC79338AF3D5A6EF9B472FE9743A1A89D4B85C281470E2040E1FC6E9D3F8E847F1F18FE3E449D8EDD8BC19975D06BB1D0F3E58EA60FF003161353434943A90F9419AB01A1A1AE81ACE25262C1A7B5CC7C6C6DC6E378D613B9D4EAD565BEA40E6C7D8D8586565A55EAF2F7520F3231008582C967258165D8418477C14A3DDE83E86636770A617BD9398D440E382AB0D6DB7E09636B42DC112071C5F497DA5602CCA581A657B0BAD4812BC5EEEEDB7F937DFC4FAF5F8CC67F0E28B8844D0DE8E8E0E582CF8C6372E6E92AE0C301396CC50EA6662262C396126AC8B2085D404267AD0730EE78EE3F8399CF3C32F4070C2B9044BB6604B073A5AD0E286DB0823873F7C2B8AF70D6109B8680402E8EEC6E9D33018F0D9CF62D72EF5D9B3668F072D2DD0E9F0F5AF43ADC6F477B18C7F0298094B4E98094B6698094B4E643661155098C2D40846CEE0CC099C388BB3031888236E84B1010D1BB0A1031DCBB1DC038F1966559146992F084BC08B472482EE6E74762297C36DB761F76EBCF61A3C1E5C7D35341A3CFA683C910845A32D2D2D0040CF90173161B5B5B5953A90F9414C58D49D0626262C1A5D1C5EAF77E9D2A574854D4C588D8D8DE530283A2FFAFBFB6B6B6B4D2653A903991F2323230E87A378465E32B0EC87BF0B5DA771FA144E75A2730A531CB85AD42EC3B24FE293ABB1DA034F35AAB528FD8F304BC00B201E477F3F3A3B118D62CB16BCFC329E7F1E2E17AEBC124A25FEF22FF1F9CFC364FA7D75ABD79B753AA3CD56EAA0E70D3361C9093361C9093361C94C314C5839E4FCF00F60E00CCE1CC7F12E748D60248FBC0596255872136E5A8555CBB0AC16B52698F8329BF843DF47581A24091C877018EFBC83FE7E8442F8C217F0F6DB78FA69545561CD1A88223EF5295C7F3DCCE6DF0F2CBFA7C64DA552E170B8B6B6B604F12F00D2CDE4F1784A1DC8FCA0B4098B98B0686CCDF5F97C757575D4853D3A3A5A5D5D4D631356555515754D587EBFDF6AB52E70BC81742C0F63B8073D6460D90B6F1C713DF40D68588335F7E09E76B4D7A1AE12952519589E3B94ED2D322149C8E5A054221CC66F7F8BDE5EF8FDF8F297313080A79F46652556AC8042814D9BB0762DAC56CCEDC0FFE24D5825855EA514A5613313969CD01B365D4796848B0BBB80421861D2B1FC0EDE398773A46359055535AA9761D9B5B8B61DEDCD6876C06184F1831FB16C6009189024249388C761B52216C3AE5DE8ED45348A471E8142817DFB505D8D356B6036E3C31FC6BA75D06AFFD03C359F43B9F999B0CA0666C2921366C2921966C29293399AB00A28C4101BC5681FFACEE0CC199CE942D704264488D5A86E42D3166C6947FB122CA9435D052ACA6D6079EED0F7112E1449422C8650085353F07890CD62FB76F4F74310F0F8E3A8AD453C8E0F7D080D0DF0786036E3873FFC23EDD4028AAA582C160804A83B9F4A4C58EDEDEDA50E647E1013565B5B1B5D598198B0D6AE5D4B5DF9DEDDDDDDDADA4A57D8C484D5D8D838DB9053F6F4F6F6D6D5D551D784D5DFDFEF743A2D16CBACEB49F3D438C6FBD0770EE74EE2640F7AC6312E4224A77249F3542B5AEB506782A9CC0796E7CE259D80B359F03C4411274E6064043E1F3EFC61B8DDF8EA57110840AFC7830F62F56AAC5D8B1B6E407535EAEAA0D7E36B5FFBA30759BC5AE43C262C1A60262C3961262C3961262C99993661155020EDCA5E784FE3F4399CEB446708A11C7256583DF06CC2A676B493E6A9F23F957BD1D0F7CD3B3F9108A6A61089C0E180D98CE79FC7B973080470DB6DB8EA2A3CFB2C0A05389D502860B7E3B1C76036C36482D10885029FFDAC3C31A652A94824E276BBE579BAC58299B0E48499B0648699B0E481D4B8E7E2E7C6F4635E8DF7244E7AE11DC5681E79134C8D68DC888D1DE8588665F5A8B7C0520E73846480B2BD85C0719CD4DB8BFFFC4F0C0D61FD7A6CDC88C71F475F1FB45ADC7107FEFCCF214958B2049B37A3A303763B9E7E1A6AF51FD6EC2BD194569EE7A9FB79023361C90EA56E2666C29293F237619DB7C61D358EE615791B6C8D68BC0A5791094275A8AB4295069A52875C02E8CB0700789EC7D818BABAE070A0B2127A3DBEFC6568B53018505101B51AF7DFFF4777D0E94A14E91FA156AB8B3703BD783013969C301396CC3013D6625140218AE838C67BD14B3C18EFAD71971496B4F3EDCD68B6C2AA4359FC2C97162A1370A150E03EF2117CF7BB7FB86AE9D2D28533571289443018FCBD098B1E98094B4E98094B4E98096B21E4908B20427A95CFE2EC699CEE47FF0426F2C8DB606B40C37B6BDC3E5F5F5555158D754891A0320103652D4F7E3F4C261375FB3998094B5E98094B4E98096B5EE4900B213486B12E7475A2F31CCE79E19DC4A4020A33CC4BB0E413F8C40AAC68414B031ACE7B1EB7B1B191BA5DB2A8D0F7CDA31766C292134A9BB098094B669809EBFD902025910C233C80815EF49EC1994E740E62308E3800321FF756DCBA122B97626935AA6DB0293F28A12C8A09EB5282B2BD856A98094B4EE80D9B99B0E484DEB017FDC892342A071018C25017BACEE26C37BA7DF0C511D7425B8DEA16B46CC2A6E558DE84A61AD45CC47C5C4A055EC5832560F960262C3961262C9961262C3959141356069928A23EF80630701667BBD0E5853784501A69030CB5A86D41CB4DB869199635A2B10635061816E89C9AA309EB4F07FAF201BD3013969C301396CC3013969C5C84094B849844328000912A77A1AB0B5D43180A23CC83B7C0421A95576265339A1BD168836DE1197716EF67C2FA93852560F960262C3961262C9961262C39998B092B8DF474814B326E2F7A4981AB81A606354D68DA800DCBB0CC038F1B6E2BACC5164E4D9BB01804FA4F660E1400001D7249444154BE79F4C24C5872426913163361C9CC2563C222E28B718CFBE0235DCA5E787DF04D614A09A519E67AD45F85AB566045339A3DF0D860AB408502B2A6C3402060B1585813D63494ED2D54C34C5872C24C5832C34C5872A2502A125C620A534318EA473FA96EBDF04E60228BAC010637DCCD68DE844DAD686D46B3134E1B6C25372A2B954ABA0E888B0D7DF9805E98094B4E789EA7B1098B5E13168DEF36E831610910C208FBE11FC46017BA7A5C3DC43315475C0DB50D360F3CD7E2DAE558EE81A7010D36D8F4D097DB3A7D66B3998A775B36144F3CF144A9639837C78E1DDBBF7F7F3A9D3E7CF8F09123470E1F3E1C8FC7EBEBEBE3F1782A95D268347EBF5FAFD7938B6AB53A1008E874BAD26ED56AB5DDDDDD914844ABD52693C932896A2E5B150AC58913270C068346A3299FA83E70EBE4E4E4C993276B6A6A82C160F944F5815B2391C8D9B36701188DC6F2896A2E5B0F1E3CE8743A53A954594575E1AD7EBF7F68684814C542A150F2A81289443A9D56ABD5A15048A1510433C181DCC069F5E95F4BBFDEC5EDDA811D4FE1A91FE3C7BBB3BBBBF9EED064A83E5DFF29CDA7AE0F5CFF15DD573E17F9DCADE95BAF575FEF0AB95A75AD8842CC886A957A7C7C5CAFD7472291743AAD52A94A7B311A8D9E3D7B965CAFD3E9CA24AAF75ECC66B35EAFF7673FFBD99123478E1C3972F4E8D1DFFCE6370D0D0DD75C73CDA2E7325A2BE0542AE5F7FB2549022049524D4D8D24498220E4F3794992D2E9B4288AD3173399CCCC8B25D92A8AA25AAD76B95CC964B27CA29ACBD6CACACAA6A6264110CA2AAA0FDCCA719CC7E3E179BEACA2FAC0AD9224AD59B326180C96555473D95A5757A7502852A954594575E1ADD96CB6A5A525954A65B359999F9764FD42A12049522A934A8889BE5CDF487E24668C1D481D889AA3FD8AFE201F9420E9389D038E6634AFC5DA56B1D59AB02E372D2F8805ADA875724E9FE0AB916AA68429511245518CC7E356AB359BCD0230180CE9745A92A45C2E477E274918E4A2288A326FCD66B36EB7DB6834FA7CBEF289EABD5B799E27F9859C9BE0382E954A152991712487D1C58E1D3BCE9D3BB763C78E5207323F92C924A526AC9191111A4D58232323D43561E5F379329F87BA7681C1C1C1DADA5A1AC396DF8445FA9347313A84A15EF476A3BB0F7D7EF8934872E0AA505587BAA558DA8AD6A5585A8B5A071CB366040D0F0FD3B51C21C1E7F3D168C2FABBBFFB3B83C1B075EBD6457F64CAF616AA61262C39A1376C4A4D5894763315DB842541CA223B85A9208224DDF6A2B71FFD631823FDC94618EB51DF8EF65B70CB122C6944A3030E134C175E9EAFFC97233C2FCC84350B9680E58399B0E48499B0648699B0F0AEEC2286D828464730D287BE1EF4F4A37F1CE34924F3C89B6176C1E581E71A5CD38A560F3C4E38EDB0AB31BF83C5453161C90F3361CD82BE8F905E98094B4E98094B66FE044D5822C434D221844873721FFA7AD13B80013FFC71C44975EB86BB052D9FC0279AD1DC800637DC15A830C0C0614165F74598B0CA0166C29A054BC0F2C14C5872C24C583273C99BB00A2824900823EC836F18C3BDE8ED439F17DE208229A4387076D85D70B5A1ED66DCBC044BC822B8A4BA5D60BA7D2F7331619521CC84350B9680E58399B0E48499B064E612336191741B44D00F7F3FFABDF0F6A06718C37EF8D348ABA136C15487BACB701959AB809CBB35C2A8834E9EB0696CC26226AC5950B6B7500D3361C9093361C90CA5262CB55ACDF15C06992492442C3588C16E740F627010831398C820A382AA1295B5A8BD1257B6A0A5052D35A871C06181A5546E294A9BB098096B16F4E5037A61262C39216153B7B7D36BC2A2E5DD26A5ED242643080D6378B066B01FFD4318F2C33F810901820E3A3BEC0D68B81A57B7A2B5118D442C6584F1C29DC97262B55A693C4FC14C58B36009583E12894430186C6969297520F3431004AFD7DBD6D656EA40E68720087D7D7DD49D06CEE7F3A74E9DBAFCF2CBA9FB79F57ABD4B972E2DABB0254849241348F8E11FC1C8207E9F6B87311C46388D340053C1E4E49D0D5CC3E5B8DC034F339A5D7055A1CA08A3CC0B15CC8BFEFEFEDADA5AEA9AB04646461C0E078D7548916009583E4C26138D273FD46A35759DDB78B7778CAEEC0B40A552D1987D01B4B6B696B6B829A090422A8860082172D676BAB48D2002400F3D715C6CC2A616B4D4A2B616B50EDE61E00C8BBEF06DB1A1B14B0080C7E3A16E972C2AF47D84F4924AA5283561F97C3E1A4D58343661E5F3F9DEDE5E1A4D583E9FAFAEAE4E9EB0050849249348FAE11FC3D80846A64BDB094CA491E6C0D96073C145A60035A1A91EF555A8AA429516DA99A5EDD0F090C569E1B5347D49008C8D8D55555551D784E5F7FB693461150FCA7672AA61262C39A1376C4A4D5845524AE5914F2135818930C2A3181DC0C020068730348EF1494CC6115740A185D60E7B1DEA3662630B5A1AD050873AD293AC85F6C25380286D79A354294569D8C5832560F960262C3961262C9959B8092B8B6C1249B2AAFC18C68631DC8FFE118C9055E5B3C88A108D303AE070C2B91EEBEB51EF81C70DB71D763BEC7AE82FE2ACEDE29AB0648399B02E0DE8FB08E98599B0E48499B06466EE262C091269459EC0C4242687314C26FF0C6230800099F9A384929CB2AD45EDD5B8BA094DB5A875C3ED84D308A31EFA4599FFB3401356096126AC4B039680E58399B0E48499B064E6BC262C095206991452114446313A8E7132863C8291318CC510CB2003C0024B15AADC70B7A1AD010D1E786A506387DD069B16DAE2B547CDCB8455563013D6A5017DDF3C7A61262C39A1B4098B52139604C937EEB3BBEC71653C8C7008A1210CF9E023FF07119CC044165935D47AE81D70D4A3BE031D4D6872C3ED86BB0A550694A615F9FD4C58650E33615D1AD0B493D30E3361C9093361150911620AA90C325144FDF0071018C5E820064F194F25F804995F9B434E05950DB62A54B9E05A8BB5F5A827B24652D7AAA12E93693F65FE6EBF1FCC847569405F3EA01766C2921366C25A2022C43CF231C4A630154698CCF621FF8F639C5C99434E0DB5061A2BAC369DED32EE320F3C75A8AB46750D6AACB0EAA0D3415726B9F6BCD86C361A0FD49809EBD2802560F960262C396126AC39424ED3A69126EDC70104C6313E84A1318C8D612C80401CF12CB200F4D0DB61AF4425B158B8E16E404315AA2CB05825ABD7EB5DD1BA42ADA2292B4892E4F57A1B1B1BA91B146526AC4B039680E58399B0E48499B0662141CA234F961C08234CEC8CD375ED2426A73095424A09A5061A33CC35A8F1C0F3117CA40E754E38AB514DCED4EAA0D3E23D674C39AC6C5D495D71C371DCD2A54B693C31445D97008199B06641DF47482FCC8425279436612DDC84355DD126910C20404ED38E60840C1DFBE127BDC7051488BF82AC62BB0EEB6A515B8F7AB2C80F597B4001C5DC17B295D384B5888C8E8E565757D3D884C54C58970094ED2D54C34C5872426FD87334611550C82117432C8C7014D1318C91793E23180920402ADA34D23C780D3426989C70BAE15E8335F5A877C145741615A82015EDC2578C2F9209ABD8D01B365D4796044AC32E1E2C01CB073361C909BD26ACBABABAE9613A014206990C326471F8094C841022B936841069864A22294090201960B0C16683AD16B5EBB0CE05971BEE6A545B61B5C156810A25940B4FB4EFC7C24D58258199B0E48499B06641DF47482FCC8425271499B00A280810628845119D10265E3FF97A55475558151EC3D838C6430845118D209245560105994A6B83CD09E76AAC9EF64339E0A844A501062DB48B52D1CE97B99BB0CA0766C2921966C29A054BC0F2C14C58725256262C09520EB999B5EC24262730315DCBFAE1273D5039554EB84CD0F25A0B2CC40FD58EF61AD454A3DA0D77252ACD309B6136C1A482AAAC16AC3DAF09ABCC61262C996126AC59D0F7CDA31766C29213999BB02448224401421CF118624924C308071018C3D80426C8F49E08226184E388E790534239B3965D85552EB85C7059F296704FF8C32D1FB6AAAC5A6875D02929D949C7C6C6DC6E3775C98C99B0E48499B06641D9DE4235CC8425278B6EC29A55C54E60620A5353989AC0841FFE20826184830846114D215540818C18EBA1B7C06285B51295CBB1BC0A550E385C70D9603B6F2D5BE00A43DAA106BEA1ACAADBB9A0502868EC6662262C396126AC59D0970FE88599B0E4E4224C58A48ACD231F473C820899324BA6F104112459765615AB824A059509262BAC55A85A8335A4BBB80A5524E95A61252765E7B8A800CFF30E8783C61F291ABD6360262C796126AC59B0042C1FCC842527F97CBEBFBF7FDAC5514081CCDB211D4F196422884C629224D410422184263149FE8E229A408254B14A288D309A61B6C0E2806339963BE02059D60E7B052A0C309861D641A78062E1CE45F94D588B85D7EB5DBA74295D61331396CC3013D62C5802960F66C2BA301224F2870871FA0F112207AE804212490992042985541E790002841C72000A2890515F0031C45248C5104BAA9291A591BC221F4124830CB14FC410232BD14611CD225B40410DB5124A2DB415A8B0C062877D355657A39A54B1C4BC688555038D061A1D74C5EE2E2E9E09ABD8B4B6B65257DC301396CC3013D62CE8FB08E9855E13D6C8E8486D632D078E9C07250992D4947877160D499F5964E388933B4A906288911C0920875C1A6932CC1B45942451922FC9C386112629368E3879E4041209246626600024D7AAA19EAE503970492401A8A116212AA05040A11135854CA15259A9E25415A8D0426B838DAC1040CAD92A5455A1CA0CB30106238C2698D4502F4A15BB10166EC22A15CC842527CC84756940D9DE42358B62C27ABF32916C4A20319DA50408000A28649021570A10D248935B4A90C86A36E44148D508809C0115214A90A2886690C973F921D5900926F25C24772AA0C8229B4186074FE6B072E078F064981700E92122D95A038D16DA020A79E435D028A1CC22CB8337E0F7FBA10106259412243DF4E489145054A0C20A2B07CE0C33910F1B6098DE6A8699881275D0A9A106A082CA0C33074E0FBD1E7A4EE262E958B5A15AC92949662DAA8662B198BB09ABDCA057294569D8349E71A734ECE2C112B07C68341A3246479262061932594584984082A4C63CF229A4484E9D2E1349212841122090DB0388232E40E0C091DCC98113212691245BD3480B1034D04890D24893F423404821C58153434D6E2F41229D44E4EF0A549022520DB50E3A32FC5BC15768AA3400F4D01B6070C2A982CA0A2B0F9E076F84510515D94AB22300051436D84882942069A1D54003803C35B9BD124A3DF424234E2760F298E441A6FFB8C8ACA940CE9253F3948DE52A140A97CB45E38F143361C90933615D1AD0F711963F649495FC23A71BC9A2AADD99EE9E688FA246318AD100025144C3084F179122443DF43CF83CF2A4B7368B2C07CE0003C9407AE85550CD2C1395509232D10DB709263DF40034D058602199CC0C3399454ABA704978D3E523B948EA45F237A91401F0E0C91D397010D0D3DDD3DED6AEE494E5BCB0EB2C72B95C6767271526AC99088270ECD8B1B56BD752771A9899B0E48499B02E0D5802FE000408E41C27D12C90BFD3482790482195443285541AE928A271C489323085541CF1041231C4124890525580A0D42BCD7A33596AA619CDC420489A690190B153521DAAA022C3AA0A28A61330196B5DE432712EA8B16AD92A15475995A056AB57AE5C4957F605A052A968CCBEA0D68445E39A956026AC4B052A13B0288AF3BD0B39EB395D98A690CA21974432875C16D934D269A4C30827902013405348851126A3BB1964C8695172AF041264B6A8089107AF828A148B3AE848A3AC1966238C6EB85BD062879DACA55A894AC59422ED4F5FB6E2B2E921592A48A5527D7D7D6D6D6D748D8B66B3D973E7CEB5B5B5D195153299CC891327D6AC59A3D150F30D01502814CE9D3BD7DADA4A573793244967CF9E6D6A6AAAA8A828752CF3A3B3B3B3AEAE8EBA52D2EBF5DAEDF6CACACA5207323F2449BA88A43317A84CC0E9743A2B65E38867911521123F11B948FE278BA1269124352869269A2E55C9DFE45E78775937BC3BEEAA86DA082329462B50A181C60967231AC95C14728D15561D74165848C6D5424BB482C41D48DA9178F0B3AAD203270FBCBCF7E58F7EE7A3741D037ABDDEA79E7A6AFBF6ED74FD480583C1EF7CE73BDFFBDEF7E85ACA696C6CECC9279F7CE69967E8EA960F87C3DBB76FFFA77FFAA7E6E6E652C7320F72B9DCF7BEF7BD071F7CB0A3A3A3D4B1CC0341107EF0831FDC7EFBED1B366C28752CF34092A4E79E7B6EDDBA7537DE7863A963991FF97C3E9BCD16E391A94CC03CCFBF2ABDDA8D6EB2101B294FF3C8935E5F0D34D32990D49A64962711264CCB89ACB092AE5A3DF43AE82A50A187DE0C3319FE554249569E21ED4B8B127626938946A392242DCAA3C9462E978BC562453A002C1E854281C6B0F3F97C2C162B140AA50E647E88A2188BC5F2F97CA903991F9224C5623141104A1DC8FC9024291E8FE772B95207323F48D8E974BAD481CC1B5601FF11922455A2F2A3F828295249369D5992AAA0D240435A7949022629990347FE95FA15D004C77134CED360C80CFB92302E0CF72EA50EA48CA03201170A850DD8F02D7CABD481CC0FF6E593194ADF6D4AC306B591531736BDBF2494865D3CA84CC01CC70D0E0EBEF2CA2BD3C3022A95AACC1B47799E3F7EFCB8CFE7FBCD6F7E43D1043E9EE7BBBABAFC7EFF1B6FBC41D1540D8EE3C6C7C743A1D09B6FBE69B7DB6919F6E7386E7878381C0E1F3C78D0EBF55214F6D4D45420103874E890CFE7A3256C00D96C36180CFEEE77BF8BC7E3149DAD1004617C7CFCF8F1E33CCF5374B64214C5A1A121A3D1E8743ACB3C6C4110A647F8799EF77ABDCB972F2FC6137114ED2DD3BCF8E28B3FF8C10F66665C9EE7CBBF47379FCF0B82A0D3E94A1DC8FC28140AD96C56A7D3D175F42A8A622693A131EC743AADD3E9CAFFFB3C134992D2E9B456ABA52B6C00A9544AA3D1D0D51709209D4EAB542A8A0EE509994C46A15094FFC4045114671E90A5D3E92D5BB63CF0C0038BFE44542660511467F54D50F12A4826A022D459701C95DF1316B69CB0B0E584D21F138AC29E75E0AE542A8B719446E5978FC16030180CDAA16CBC88C16030188C4B039680190C0683C128012C0133180C0683510258026630180C06A304B004CC6030180C4609600998C16030188C12C0123083C1603018258025600683C160304A004BC00C0683C16094009680198C8B471084502814080402814028149A36A48AA21889448A679C8F46A3D3B2785114FBFAFA0281C0BC1E612E1116FB55CC249D4EC7E371199E88C1281F580266302E9E63C78EDD7AEBAD77DF7DF717BEF0853BEEB8E3FEFBEF3F71E204806030F8F77FFFF7A3A3A3C578D25C2EF7C4134F1C3D7A945C3C7AF4E8134F3C31313131AF070904020F3FFCB0CFE75BE06D2E82E1E1E1AEAEAE5957BEF2CA2BDFFFFEF7991997F12705658B6930186545241249A7D3FFFEEFFFEE7038C2E1F0CE9D3B1F7DF4D1E79E7BCE6EB76FD9B2C566B3919B89A228491291B9E7F37985423153F55E2814388E9BB58E503E9F9FB9C617599E85AC7EA3542A6FBEF9E6A6A626009224F5F6F6DE77DF7D2B57AE9C797752B69E571F2F8A22C771B95CAEAFAF2F9BCD5E208659B72131CC0A7EE6C3BEDF6B9424A950284C5FB377EF5EAFD7BB7DFBF6E9FB4A92D4D1D1E1F178E85ABA8AC158202C0133180B42AD56D7D7D73B1C8EFAFA7A8FC7B365CB967DFBF66DD9B2656464A4A3A3E37FFFF77FE3F1F8C99327C7C7C73FFEF18FA7D3E9FFFBBFFFABACACFCE217BF58575797CD6677EFDEFDDBDFFE56A552DD78E38DD75D77DDE0E0E05B6FBD2508C2C183070D06C3FDF7DFDFDADAFAF6DB6FFFF4A73F0D87C32B56ACB8F7DE7B4D26D3E8E8A8CBE51245F1A5975E7AFDF5D7552AD5F8F8F82DB7DC924C265F79E5159D4E77E0C00141106EBFFDF68D1B37CE8CF6D0A143BB76ED1204A1A5A585245D41107EFAD39F4EC7B079F3E6F32E29B877EFDE7DFBF6A5D3E99696967BEFBDB7AAAA6A7AD3BE7DFB1289C4FBBD46127C241271381CF7DE7BAF5AADDEBF7FBFCFE7FBD5AF7EB576EDDA5FFEF2973CCFBFF3CE3B1B366C502814D96CF685175E181818202BDDBA5CAEBBEEBA8BBAB502198C39C286A0198C45C36432AD58B1E2F4E9D3131313FFF55FFF353939F9F2CB2FEFD8B1E38A2BAE68696979E8A187CE9E3D7BF3CD371F397264F7EEDD0076EDDAF53FFFF33FD75D775D7B7BFB37BFF9CDB7DE7ACBE7F37DED6B5F1B1E1EFECC673E333131B163C70EBFDFFFF5AF7FDDE974DE7AEBADFBF7EFDFB3678F288A3B77EEECEBEB7BEDB5D7B66FDFBE71E3C6F5EBD76FDFBEFDD5575F4D2412DBB66D3B70E0C00D37DC60B7DBB76DDB36F3C46A5F5FDFA38F3E6AB55A3FF9C94F1E3A74281008F03C3F2B8683070FCE7A510A85A2B3B3F35FFEE55F56AF5EFDE94F7FFAADB7DE7AFEF9E767DEE017BFF8C5795FE30B2FBC108D46BFF18D6F582C96DB6EBB2D1C0EFFC77FFC875AADB6582C66B3D9E170C462B16DDBB6EDD9B3E7F2CB2F3F73E6CC9E3D7B388E73B95C2D2D2DB5B5B5AFBCF2CA891327584DCCB88461153083B198E8F5FA4020204912C77164ADD9ABAFBEFA861B6E686F6FDFB367CF1D77DCD1D6D6D6D9D9190E8793C9E44B2FBD74CB2DB7FCD99FFD593E9F3F7DFAF46BAFBDB679F366ABD57ACF3DF7B85CAE4020F0EAABAFC662B1582CE672B9D6AF5FBF6CD9328D4643960ACFE7F33FFFF9CF6FBAE9A67BEEB9070049F6AB57AF56A954B7DF7EFB95575E69B55A7FF7BBDFA552A98A8A0A12DB8103079C4EE73FFEE33FEA743A9BCDF6D0430F45A3D1F7C630AB681645D1E1707CFBDBDF5EB56A552693696868989C9C9CF5AACFFB1AA7A6A6341ACD638F3DB662C50AA55279FAF4E963C78E399DCEF6F676AD56DBD1D1313C3CCCF3FCDFFEEDDF6ED8B0E1E9A79F06A052A9366DDA04E0BFFFFBBFEBEBEBBFFAD5AF9EB71C67302E0D5802663016935028545959A9502824492269D8643201E0795EA3D1A8D56A006AB59AE3B84C26333939F9F39FFF9C149DC160D0E3F188A268B7DB8D4623008EE34451ACAFAF7FE8A18776EEDCF9939FFCA4B9B9F94B5FFA92D3E9042008423018BCF6DA6BC9F37A3C9EFDFBF7E772B98A8A8AE973CFB3CA479FCFD7DCDCACD3E900343434545454A4D3E95931D4D5D5BDF745711CF7E69B6FFEF8C73FE679BEA7A7E7BAEBAE9BB5F5FD5E23C771DDDDDDCF3DF71CC771E3E3E395959598B11EBB2449A4149EF574BFFCE52F7FF6B39F6DDBB6CDED762FE0A36030CA1D9680198C053133C97576761E3F7EFC9BDFFCE6CCBA6D66BE9979A54AA5B25AAD77DE79E7C73EF6B142A140AAC368343AF3661CC745A3D1E6E6E69D3B778E8E8EEED8B1E3DBDFFEF633CF3CC3719C52A9B4D96CC16090DCD2EFF75B2C960B9F2E75381C870E1D120441A5528542A1743AAD56AB67C560B7DB67DD8BE7F9DDBB771F3B766CEBD6AD8D8D8D4F3DF554269399759BF3BE46854271E8D0A1E79F7F7EEBD6ADAB57AFFED5AF7EB577EFDEF7BBE3F4EB3D7EFCF8534F3DF5C8238F7CE8431FBAC06B61302E01D8F00E83B12082C1E033CF3CB37DFBF6AD5BB77EE94B5FBAEAAAABAEBEFAEA997367CF3BB546922493C9B461C386175F7C716060E0D8B163FFF66FFF168944789E27A533B90DC771C160F0E1871FDEB76F9F42A1D068347ABD9EDC46A5525D73CD352FBCF0C2810307DE78E38D175E78E19A6BAED16834B3D2FCCC27DDB061434F4FCFB3CF3E7BF4E8D1A79F7E3A1C0E5B2C968D1B37CE8AE1BDD10A824052FBE1C387F7EDDB373E3E9E4AA566BD9CF3BEC67C3E2F499252A9ECEEEE7EF1C5177D3EDFE4E424CFF39148E4BDE3D8002291C83FFCC33FF03C1F0A8576EDDAB577EFDE442271E1F79FC1A017C5134F3C51EA18180C5A110421168B45A3D1A9A9A96C367BFDF5D73FF0C0030683A15028643299B56BD78AA2D8D4D4D4D4D4248A22B9C66030A4D3E9CACACAD6D6D6B6B636AFD7BB7BF7EE93274FDE72CB2D7FF1177F21088252A95CBB76AD52A9CC6432068361D3A64D0A85E2A5975E3A70E08056AB7DF8E187ABABABA3D1E8EAD5ABD7AF5F1F8BC576EFDEFDF6DB6F6FDEBCF9AEBBEEE2797EFA5948F25BBB76AD46A321D13A9D4E87C3F18B5FFCE2CD37DF5CB972E5860D1BAEB8E28A75EBD6F5F5F5CD8C61BA8C9E8EB9B5B5F5D4A953AFBEFA6A2010B8F2CA2BBBBABA5A5A5AA6C787E3F1787373F3795FE3C68D1B0381C09E3D7B7A7A7AAEB8E28A6030585151B162C58A37DE7843A150B4B5B565B3D9E9DBDBEDF6E6E6E6C1C14183C1303A3A3A3232128D46D7AC59A3D7EB4BF3E9321845866333DF198C12228A62341A55A954E4BCEF7991242991480882603299C854E099778FC7E3A49E9E63BF522A95CAE572336F3F9718044188C7E3068341AD56C762319D4E47CEF57E20854221168B91DA3D1E8F2B954A9D4E178BC5944A25CBAC8C3F71FE3F1C5DA687D9F49D250000000049454E44AE426082>|png>|495px|324px||>

    \;

    <item><strong|Matriz de pequeña anchura de banda>: Si <math|A> es una
    matriz de pequeña anchura de banda, los mejores métodos a aplicar son los
    algoritmos de resolución de matrices n-dia-gonales (tridiagonales o
    pentadiagonales por ejemplo) implementados en los programas que resultan
    de combinar métodos iterados y directos. Pero distinguiendo entre estos,
    es más eficaz el método iterativo tal y como se puede observar en las
    gráficas (sólo si se aplica un preacondicionamiento al sistema). Como
    método directo hemos elegido Cholesky y como método iterativo, el método
    del gradiente conjugado (PCG) con preacondicionamiento ya que está
    especialmente diseñado para matrices simétricas.

    \ \ \ \ \ \ \ \ \ <image|<tuple|<#89504E470D0A1A0A0000000D494844520000026C000001A1080200000053697F850000000373424954080808DBE14FE00000200049444154789CEC9D797C13D5FA87BFD99A365DD3A62DD04229D0967D13CB26C876455094EB8A8002A2E0055104BCB208E2C2220AE8055CF082022E2882175CF0279B2C2A82800B50A06D28B44D9B16DA344D9336DBFCFEC8B572599B36B3E4CCFBFCE1C7619A99377326F39E73E69D67141CC7812008822008FF518A1D0041100441042B944409822008A29E501225088220887A42499420088220EA09255182200882A827944409822008A29E501225088220887A42499420088220EA09255182200882A827944409822008A29EA885DFE5891327F6EDDBE7F17884DFB5C028140AA552E9F57AE5E0565428140A85C2EBF58A1D881028954A8EE3E4D3AC32F9B2B26A56595D9ABA75EBD6BD7B779EB62F4212DDBE7DFB7BEFBDD7B3674FDF22C7715AAD36242444F848F8C6E3F17CF7DD7737DD7453626222DB27AB52A93C7BF66C4E4E4EFFFEFD954AC6A7373C1ECFEEDDBBDBB469D3AC5933B63B0D0A85C26C361F3D7AB47FFFFEA1A1A16C9FC31CC7EDDFBFBF71E3C6191919CC37ABD56ADDB76F5FFFFEFDC3C3C3D96B5697CB555D5DAD50287C8B070E1CB8EBAEBB984AA26EB7BB7FFFFEEFBCF34EED99EAEBED0A1F09DF381C8ED1A3473FFBECB337DF7CB3D8B1F0CEF6EDDB376DDAF4E69B6F6A341AB163E117A7D3F9E8A38F3EFAE8A303060C103B16DE3972E4C892254B5E7BEDB5989818B163E117AFD73B75EAD45EBD7A8D183142EC5878272F2F6FCA94290B172E6CD4A891D8B1049E4BA713944AE5C48913DD6E377FBB13218902F0A54CE6872C4CF60CAE8F0CBF32DBF81A540ECD2A9F6F5A0BAB5FF6B25119DF5F93F1342605583D5309823DD89BDB24F8469C91E895545454E4E5E531566D54535363B158B2B2B2D46AB5907759C2C3C35BB66CA9560BDAB8ACCEC95F15F97C53B9412D4BF88B084954ABD55E79A6EEDDBB77C182052929297E9DC42A958AE3B8DAFCD490E23A5FAD5A3D3E781D388ED368345F7CF1C5575F7D15D82D5F07BBDDEE76BB376CD860301804DB2980D6AD5BDF7FFFFD2A954AC89D8A825AAD7EE8A187D2D2D2C40E4408929393478F1E1D1616267620BCA35028860F1F9E949424762042101B1BFBE8A38F4646468A1D8810A8542A5E0B574548A221212157664ABBDDDEA54B97458B16D5FD46A9CBE5DAB3678F56ABEDD3A78F52A9542814478E1C898888C8C8C8F02B8F2A140A9BCD76F0E0C1CCCCCCC8C8488EE302D81BF53D1E10A8ADDD10A5529997973773E64CE1C7F44D9B366DDCB8B11C3AF24AA572E0C081CCD74FF9888F8F1F34681093C5F357D2BB776F81E76FC4222A2A6AE8D0A15AAD56EC408440A552F1FA6B95CA19A35028424242626262EA7E15CECACA9A33678E4EA7FBEAABAF929393016CD9B2A565CB96F52885B5DBED3B76ECC8CCCC3C7AF4A8D96C0EEAF2BCC8C848512AB66C365B4949894CC667B9B9B9C9C9C95151516207C23B2E972B3737B77DFBF662072204E7CF9F4F4848888E8E163B10DE713A9D67CE9C69DBB6AD1CA68EF8462A49B41EECD8B1A365CB9676BB7DDFBE7D23478E04E0F1787C53B21CC71516165EBC78B159B3662A954AA7D3A9D56ABBDD6E341A01A4A6A68687877BBD5E9BCDA6542A8B8A8A1A376E3C73E6CCD8D8D803070EE4E6E60E1B36CC37335C5E5E5E5A5A9A9292121A1A9A9B9BABD56A5BB468E13BED2EDB9AA8474212444545C9E738A4A5A5C964C812121292919121761402919A9A2A93A4121212D2BA756B997C59BE09D60B415555D5AE5DBB1E7CF0C18282826FBFFDF681071EB8F4A2F6C5175FBCF3CE3B515151515151D5D5D5F3E6CD8B8B8B7BFEF9E7CF9D3BA7542A1B356AB470E1420073E7CE55ABD556AB75DAB469AB57AF1E3E7CF8EEDDBB0B0B0BB76DDBA652A9BEF9E61B9D4E979F9FAF56AB5BB56A55545474EEDCB9B163C78E1F3FDE6C36CF9B37AF766B0B162C68DCB8B178074312D8EDF6F2F272DF9400F3984CA6F8F8789D4E277620BCE376BB0B0A0A525353C50E44088A8B8BF57ABD1CFA82BE664D494961FE39430108D624FAC71F7F9495950D1C38B0B0B0F03FFFF98FD1684C4F4F07A0542A8B8B8B57AE5CF9D8638F0D1B36ECB3CF3E7BE59557AAABABD7AD5B77F1E2C5D5AB572B148AA953A7AE5FBF7EE4C891FBF6ED1B356AD4FCF9F3ED76FBA953A7525252060E1C98939373CF3DF7FCFBDFFF3E75EAD4C71F7FCC71DC3DF7DCD3A54B97F9F3E7AF5DBB76D7AE5D63C78EBD6C6BEBD6AD9B3973E66511DA615F8775852854F2F61C11076E2006F6433F9EB6EF174AA5522677CE00848484C8E4EAE3BBCF2276140241CD4AD483604DA2DF7DF79DCBE5DABF7F7F555595C562D9BF7F7F6D123D7DFAB44AA51A3264486464E4E0C183D7AF5F5F5D5D7DF8F0E161C386356BD60CC0F0E1C3BFFCF2CB7BEEB9272E2EEEDE7BEF4D4C4C3C77EE9CCF3E181111A1D3E9B45A2DC771EDDAB54B4D4D753A9D494949DDBA750B0F0F6FD7AEDDA14387AEDCDAD6AD5B5D2ED765F7AE5D701DC191D338CD6B126D89963C6DDC5FB45AAD4C663801C4C5C5C9E4CBAA54AAF8F878B1A31008BD5E2F93194E954A65301864D263E09BA0BC10949797EFDDBB373131F1E79F7F562814C9C9C9DF7EFBED9831637C4549555555F85387A4D168341A8DD7EBADA9A9A92DD30F0D0D75381C5EAFD7B7F65A7BA9FD395DF60424C77157DDDA651F8F42D49B78D3037EAB64B5904A7D9DD56A359BCD32B97F969D9DDDB46953391416399DCED3A74F77E8D041EC4084C06834262626322F3804E0743A4F9D3AD5BE7D7B99741A78252893E8912347EC76FB9A356B9A376F0E60FFFEFD93274F3E73E68CAF1AA879F3E6555555E7CF9FEFD0A1436E6E6E7171B156AB6DD9B2E5912347EEBFFF7EDFC79B376F7EC3D98C6B3D9A121212D2A2458B1B6E4D014538D8BFB9524B747474444484D85108444646864CAE3EBE0A14B1A31088962D5BCAA759A9343750046512DDB56B57E7CE9D7DB3A9003A77EE9C9494F4FDF7DFABD56A8542D1BA75EBBE7DFB3EF7DC73BD7AF53A7DFAB4DBED56A9540F3DF4D0B469D366CC9801E0F0E1C34B962CF10D436B8599BEA7572322228E1F3FFEE38F3F5EFA689146A3F18D6B954AA55AADF66DEDD9679FADDDDAE2C58BE5F07CE4F5B1DBED168B4526CFAA9B4C2683C12093C22293C99492922276204260369B636262A8B088F08BE04BA21CC73DFCF0C3973E0D191919F9E69B6FAA54AAC18307878686BADDEEFBEFBFBF63C78E172E5C183972A4C964D268349D3B775EB972E5EEDDBB398E1B33664CC78E1D6B6A6A962D5BE6AB264D4C4C5CB66C5993264D860D1BE6743A6B6A6AEEBEFBEE418306F992EB82050B9A346902A073E7CE8D1B37562A95DDBB77BF6C6B621E1169E0EB61881D8540D4F6AB9847A150C867BCA256ABE5D3AC32B1850840F05DF5140A45DBB66D2FFB475F55918FB2B2B2A54B97F6EFDFFFD65B6FFDFAEBAF1312127C63D68E1D3B5E9AEDB45A6DED62EDFF8786864E9A34E9B2DDB56BD7CEF7FF313131B5F74B2EDB1A1112122287A7D47DE8F57A9914372A95CAB8B838B1A31088E8E86899A4165FB3CAA4C7C0370C1EC4D8D8D8279F7CF28F3FFE58B972654545C50B2FBC701D45A4DBED76FEC965C5411E8FC762B19495955DF92E3A87C371E1C285CACA4A7AE7432D369B2D3F3F5FEC2804C26834DA6C36B1A310029FB148EC2804223F3F5F3ECD9A9393C3D80B3FC422F846A275A157AF5EDDBB7777B95CD77FF0CB6AB5BEFCF2CB050505BEB7AC4446463EF2C823BD7AF50270E6CC9977DE79273B3BDBE572A5A6A64E9932C537FCB5DBED9F7DF6D9D75F7F6DB3D9D46A758F1E3D1E7FFCF1848404E1BE9B542163119390B18849C8581440181C89FA50A954A1A1A1D79FAFA8AEAEDEBF7F7FC78E1D1F7BECB13163C6A854AAE9D3A7171414984CA6A79F7EDAEBF5CE9E3D7BDEBC794AA572DAB46925252500DE7CF3CD7FFFFBDFC3870F5FB870E1C489137FF8E1873973E65457570BF5B5A48BDD6E2F2E2E163B0A8130994C0E8743EC2884C0578122761402515C5C6CB7DBC58E42087CCD2AE4FB19194616BDE9EBA056ABBB76ED7AEBADB70268D7AEDD9D77DE99979777F4E8D1888888575E79C5F7CC465A5ADAF4E9D37373732F5CB8B065CB96D75F7FDDF7F75DBA74494D4D5DB66C595151914CBC68D7818C454C222BB50D352B510FE49E440154555555555579BDDE5F7FFDB5BABA5AA954EEDFBFBF5FBF7EB54F3DC6C7C7AF58B1222C2CEC830F3E484A4ACACCCC04E0F57ADD6E775A5ADABFFEF52F99BC51E8FA90B18849C858C424642C0A20B2B8105C87EAEAEA050B16BCF7DE7B5EAFF7C2850B23468C68D5AA95C562B9AC22D157775A5050909898E87315FDF2CB2FAB56ADF2783C0A8562F2E4C93D7AF4B87CD3555558B50AE7CFC3EB45BF7EB8E30EAC5C095FE9CD1D77E0D65BB17225CE9F07803BEF44DFBE58B1A23E6BEFB8034386F07984EA0A198B98848C454C42C6A20022F724AAD168EEBEFBEE5EBD7A793C1E83C1D0BA756B97CBA5D56A2F2BD23B72E4487878787C7CFC8913276A6A6AB45A6DF3E6CDC78E1DEBF178962F5F9E9797779524AA56A34307242581E3909A0A8D061D3BC2F79293A64DFF5A0B2039196A75FDD74A0332163109198B98848C450144EE4954A55275E9D2A56FDFBEB5FFA2D1683A74E8F0E38F3F8E1933C6F7D098D56A9D3B77EEDFFFFEF7CCCCCCB56BD79E3C79B24B972E090909090909172E5CB0D96C57D71569B5978F11F95B9400642C621232163109198B02081D415C59A23672E4C893274F2E5BB6ECFCF9F32693E9DD77DF2D2B2BEBDFBF7FD7AE5D7BF6EC3977EEDC03070E9494949C3C7972F1E2C5E7CE9D23E71FC858C428642C621232160510B95CF5AE8A4F0778A590A543870E0B172E7CF3CD37BFFBEE3BA552A9D56A5F7EF9E556AD5A01983F7FFE1B6FBC3167CE1C9D4E171212D2BF7FFF59B366C9A7F2E23A90B18849C858C424642C0A20B24EA27ABD7EF9F2E557ED680F1830E0E69B6F2E2828E0382E3939B9B684242121E1E5975F2E2A2A2A2F2F8F8F8F4F4C4C2469910F9BCD5652529296962676204260341A2F3D2B18C6672C6ADFBEBDD88108417E7E7E4242821CFA823E6311DD160D08B24EA200AED3F18C8C8C6CD3A6CD95FFAE52A992939393FFACE8A1B95C1F642C6212321631897C8C452E172C1635AF57A6E01ECE3B1C8E43870E7DFEF9E73B76ECB870E182EF1F0B0A0A4A4B4BAFFF418EE38C46636565655DF6C2715C5E5E5E79797943C3651A32163109198B98443EC6A2B7DFC6E6CD114A258FDD85204EA266B379DAB469B367CFFECF7FFEB364C99271E3C69D3C7912C0BFFEF5AFCF3FFFFCFA9F753A9D73E6CC3974E8505D76E476BB172D5AB467CF9E0004CD2E642C621259A96DA859D9A36D5BB468610778BCE916AC678CD7EB7DE38D37CACACAD6AE5DBB6EDDBACF3EFB2C393979C992255EAFD766B3391C8EEAEAEAD2D252A7D3E9FB7B8EE32A2A2A2E5CB8E072B97C8B56ABB576ADC3E1282D2DBD746C61B7DB4B4A4AAAAAAA6AFFD827C8E538CEE974BADDEEDA4E1CC77157BEE6458668B55ABD5E2F76140211171727936B90DC8C4532B18FC9C758346810FAF5ABE175CC1DACF775F2F3F3F7EDDBB778F162DFBB42F57AFDD4A9530F1C38E0743A954AE5E1C38767CC98919797D7AA55AB79F3E6C5C4C47CF8E1879B376FE638AE79F3E6CF3DF7DCA5D78543870EAD5CB9D26AB5464646FADC43070E1C78E79D776C365B6868E8B469D3BA76ED8A3FEF7D7EF0C1075EAFD760301415154D9C3851A1506CDFBEFDDCB9734F3CF184CC6F8E92B18849C858C4240C1B8B4A4B71F1222E1584F07D650ED69E484E4E0E80962D5BD6FE4B4646C6F8F1E3434343DD6EF7D9B3671F7EF8E1175E78E1E8D1A3070F1EFCE9A79FDE7EFBED71E3C6BDF2CA2BA5A5A5CB962DF38D1D954A656969E94B2FBDD4BD7BF7D75F7FBD43870E2FBFFCF2B973E7DE78E38D76EDDA2D5FBE3C3D3DFD8B2FBEF0B9FDDC6EF79A356B76ECD8D1AF5F3FBD5EFFF9E79F979696BADDEE8D1B37AA54AA2BDBC9E5C24F3FE1A79FE072C168C4CE9DB058AEB2D6E9C4A953F55CEB72F17168EB497474F4A5CDC136191919D779492D4BC8CD582487D25CB06B2CAAA8C0942978FA690859C112AC49D4E57229148ACB2A247DEF9855281443860CE9DEBD7BE7CE9D9393932B2B2BF7ECD9939999397CF8F08E1D3BFEE31FFFF8F5D75F2F5EBCA85028944AE5B163C72C164BA74E9DAAAAAABA76ED7AE1C2859C9C9CB0B030A3D1585454346EDCB8193366F812E4871F7EB878F1E2912347B66CD9B253A74EA1A1A1C78E1DCBC9C931994C83060DBA3242AB15336762E64CD86CD8BC19A347232BEB2A6BAD56AC5953FFB5D2C16EB79BCD66B1A31008591516994C26B1A31008B3D94C8545418ACB859327C171E8D50B932641C849A2609DCE4D4848703A9DE5E5E5B52FC4CECFCF5FB162C5D34F3FAD52A97CF36C1CC7F91EE2BC78F1626C6CACEFCFF47ABDEF8EA92F35DA6CB6B2B2B28F3FFED8B7D8AE5DBBA4A4A4975E7AE9DD77DF5DB870617575F5881123468F1EED72B9C2C2C2060D1AB479F3E6810307464747676666EEDEBD3B2929293D3DFDAA52B4A8282C5B0600919178E001F4E881B66DAFB2363A1A1326E0AEBBEAB35652B389642C6212321631097BC6A2F7DFC7EBAF63ED5A3CF594D0BB0ED6AB5E7A7A7AE3C68D376DDA346BD62CDF8FFCEBAFBF3E78F0E0CC99336B73A70F8542919292F2FBEFBFBBDD6EB55A9D9797171E1E1E1111E1FBB3D8D8D8A64D9BCE9F3F3F3E3EBEB8B878DBB66D5AADF6C89123D3A74F8F8C8CFCE28B2FDE7CF3CD01030668349AE1C387F7EFDF7FD4A8519B376F1E3D7AF480010366CD9AA556AB9F79E699AB5E65341ADC74D37FFF3F250597E5D94BD7A6A5E1324541DDD74A0732163109198B98843D63514A0A264C80285290604DA2111111D3A74F7FF6D967CD66738F1E3DCE9D3BB765CB96A953A7C6C6C65EA610E2386EC890219B376F7EF5D557535353D7AE5D3B74E850BD5ECF719CD7EBBDF9E69BE3E3E35F7EF9E54183067DF9E5971E8F67F8F0E19F7CF2C9AE5DBBEEB8E38E43870E356BD6CC37AE552A954D9A34993871E25B6FBDD5BB77EF2E5DBA68B5DA8A8A8A9E3D7B8A740CA405198B98848C454CC29EB168F060DC761B4429EE54CD9F3F5FE05D1E3E7CB8B4B4F48E3BEEB8F41F4F9C38919F9F3F64C890BA5752A5A4A474EFDE3D2F2FEFD75F7FE538EE89279EB8EBAEBB944A654C4C4CDBB66D131313150A455C5C5CDBB66DD3D2D2DAB56B77F4E8D1ECECECA143878E193346ABD51A0C86F6EDDB1B0C869B6FBE393737F7D8B163696969CF3CF34CA3468D3A74E8909393F3FBEFBF2726264E9D3A352929293636B65DBB76B1B1B1AD5AB54A4C4CF409FF7EF8E1878E1D3B0E1B368C8783547F2C16CBF6EDDBEFBAEB2E815F4CA6D56AA3A3A359EADB5E87989898B0B03039D463AB542AF9BCAA3A3A3A5A3ECD1A1B1B1BD4F75F2A2A909F8F4B6749AED56EDBB76F0F0909B96AE54A4090CA41E438AEB4B4F4F0E1C37E9DC12A956AD8B0616EB75BA552A954AA63C78E711C171616E672B90E1F3E0C40AFD75B2C96C3870F6B349AFBEFBFDFEBF56A349A93274F721C97989868369B8B8A8A944AE5E0C183DD6EB746A331994C0505054AA572F8F0E11E8F47AD565B2C965F7EF9A5763B0A85A269D3A6E5E5E5DF7EFBEDD1A347C78D1B77F4E8515F419314502A95050505B5CFBF0A89DD6E2F2F2F4F96CCFB4D79C56432C5C7C7CBE45568050505A9A9A962072204C5C5C57ABD5E0EF6CA607F159ADD8E193370F62C366E84C12072305249A28D1A35AAACAC7CF5D557C50EA44E783C1E8BC5A2D3E976ECD8B16BD7AEEBFCA542A110D850EF76BB9B356B26FC33E3642C6212F9A86D40CD1A0C783CC8CB437C3CDAB6C5ADB7420A53EF5249A27DFBF6EDD9B367B0BC11C5E3F1545555454646DE70DC5C5D5D2DFC2F53947CA6D56A837A76C82FE2E2E264F265E5662C92C9C475F01A8B366FC68B2FE25FFFC233CF881DCA9F48E542E07B6DA7D851F8415DE67C388ECBC9C9494D4D0D0D0D152024712163119390B1884982D7581415853BEF44BB7662C771095249A24CA25028323232643264898E8E16B894494432323282EEEA533FE4662C924FB3066969AEAF0A5752436829C5C2222693A9A6A646EC2884808C454C42C622260922635175350A0BFF5A5428A495414149946F341A8D1C2AE641C6224621631193048BB1C8E5C2A24578E491FFC9A3524316678C88C4C6C606C5C9DA70C858C424723316C9AA59A5DC63E0381417A3A6066161B8ED3648F92D8BD23D880CC0715C6E6EAE4CE6FD6C365B7E7EBED8510884D168B4D96C624721043E6391D85108447E7EBE7C9A352727473A0FB85FC9AE5DB8FB6E7CFF3DFEF94FCC9801293F922D97F93751502814E9E9E93299E48C8A8A92C353EA3ED2D2D264D2AC21212132A9B806909A9A2A93B96B5FBD9894BFACC7838E1D919E2EB93BA05722F900839CC2C242F914161517178B1D8540C8AAB0A8A0A040EC2804A2B8B8980A8B24C26DB7E1ADB7909E2E761C75809228BF848484C8A7B04826F793406A1B46A1661511B71B172EA056B7A35020588A496471C68888C16090DAC9CA135AAD562FE5BBFF01252E2E4E26CD2A37635170295FEA8DD48C451E0F56ACC0A85138774EEC50FC472A079149388E3B73E64C555595D8810881D56A351A8D62472110D9D9D932A940F1198BC48E42208C46A3D56A153B0A21F0198B245258545E8E9A1A381CE8DC59122E5C7F914571845890B18855C858C424642C129E9F7FC69C39983C19FFFC27BC5E04E3FC0E8D44F9858C454C22ABC2223216B187740A8BAC56C4C42025056A75506650D048946FC858C424642C6212321609CF8001E8D50B41FD709C2CCE18112163119390B18849C85824001E0F2C96BFAA7055AAE0CEA0A024CA2B642C621532163109198BF8C6E3C19A35183D1A67CF0ABC671E91CBFC9B2890B18855C858C424642CE215AB151A0D4A4BD1B42958AA41A49128BF90B1884964555844C622F610BEB0E8B7DFF0D043F8E61B3CFB2C962F474282607BE61D59F4A645848C454C426A1B26A166E58F0B17A050202929584B70AF0325517E31180C32292CD26AB53299E10410171727932F2B3763914CA673853716F5EB87CC4C44460AB643E110A7DB65B158B2B3B34FFF49494909008FC7E376BB01389DCECB16398E0BC6B56EB7FBC489135555552E974B3A51F1B1D6E572555454646767FB26882412157F6B4F9C3861B55AA516151F6BED76FBA953A7A416154F6BB3B3B3CBCACA04DEAFEF42E176BB398E136611406565655656567575357F3B72B93C15155C4DCD7F1739CE1D1121C417F4783C168BA536B9646767979797F33A1DA89A3F7F3E7F5BBF2A478F1EDDB469D3F1E3C777EDDAB56BD7AE1D3B76D86CB62E5DBA98CDE68A8A8AF0F0F0D3A74FEBF5FA929292F2F2F28888883367CE44454595949404DDDAD2D252954A151B1B2BA9A8F8587BFAF46983C1E072B9AC56AB74A2E26F6D4949494242C2850B17241555C0D79696965A2C9666CD9AE5E4E448272AFED6D6D4D4381C8EC8C84821F71B131353585868B55A753ADDC993276362628A8A8AAC566B6868685656566C6C6CC0D76AB5DAD3A74FA7A5A599CD669EF65B5050B87A75C5D2A5BAF0F093AD5AC59A4C265EBFD1A56B6D36DB6FBFFDB678F1E2DDBB77EFDAB56BE7CE9D870E1DEAD8B1E380010378CA680AAEF6811DA158B56AD5912347962C59527B5B3B3C3C9CC9C24E8EE3CE9D3BD7A851A3D0D050B163E19DAAAA2A8BC59294942476204270EEDCB9F8F8789D94DF141C20DC6E77616161B366CDE4706BBFB0B030262686C96BD165B85CAE82828266CD9AF1317D6DB743A9C4D2A5C8CEC682055C5292D0678EC3E1A8ACACF4FDBF52A99C3973667C7CFCA2458B78DA9D38F775C2C2C20C068328BB1612DFDD7B395C7D20336391AC2A50542A954CCE61F9188B944A254F32B5336730772EEEBD17D3A7C3EB854E27C29913161616161656BBC87767572E573DB12063119390B18849A2A3A365F26BE5CF58545808B319313190C1ECDB7F9145B74B2CC858C42A642C62123216359C3E7DB0650B6EBB2DE01B962E3412E5113216B10A198B98848C45F5C3E9844603DFDCB05A8DD8D8806C3568A09128BF90B18849C858C424642CAA07BB77E3B1C770E64CC3B714ACC8A2372D22B22A2C92C96D42C8ACB0889A953D02D2AC6E37001C3E0CB319F218C05F1D4AA2FC42C622262163119390B1A8EE984C78F555F4EE8DC993F1F8E3B29BC2BD145974BBC482E3B83367CE545555891D881058AD56A3D128761402919D9D2D930A14A7D379FAF469B1A31008A3D168B55AC58E42089C4EE7A953A71A52589497871F7E80C7838808596750D0489457140A454646864C862CD1D1D1112CBDDFE8BA646464C864C8E2AB40113B0A8168D9B2A57C9AB56DDBB60DF9B29999D8B60D8989010C2A58A19128BF984C26F9141699CD66B1A31008591516994C26B1A31008B3D94C8545D7C1E5FAEBFFD56A346922EB5BA1B55012E5179EB420124456C6228D46239F0A14990CCE2027639142A1F0B756E3E0414C9E8CAC2C9E220A62E472D5130B32163109198B98848C4557C5EB8542811F7E40561678D033043DB2E8768905198B58858C454C42C6A22B2929C1ECD9D8B4091326E0F3CFD1BEBD00D105193412E5113216B10A198B98848C455772F62CFEEFFF909181C848365FA9DD706824CA2F642C621259151691B1883DEA5E5874D34DD8B60D8F3C224050C10A25517E2163119390DA8649A8597D5C3ACBAB56A36953AAC2BD1EB2386344C46030C8E41AA4D56AF57ABDD85108445C5C9C4C9A556EC622AD562B761442701D63D1EFBFE3996770F2A4F041052B944479848C45AC42C6222691B9B188E30060F76EFCF003E471D10A0CB2288E100B3216B10A198B9844CEC622AB156FBF8DD4548C1D8BFBEE4372B288D105193412E51732163189AC0A8BC858C41E571616E5E662C306E4E7233A9A32A87FC862902422642C6212321631899C8D45EDDB63CB16A4A4401E97AB402297AB9E5890B18849C858C424B23216190C0685E2AF1E834683F47411230A6264D1ED120B3216B10A198B98443EC622B7DBBD6BD799175F741F3F2E7628C10F25511EF1198B743A9DD88108415454546A6AAAD85108445A5A5AA43CF42D723316454545891D851068349A828236EBD7AB0B0BC50E25F8A124CA2F642C621259151691B188251C0EAC5F8F4D9BDC5DBBE66FDDEAF9DBDFC40E28F8A124CA2F642C621252DB30891C9AF5EC592C59825F7E414282B67D7BE6BFAE10506111BF180C0699942A68B55AF954E7C6C5C5C9E4CBCACD58C47C29725A1A3EF8006969AAB0B07899F4EFF986FA213C42C6225621631193C8C158A4D1A05B378485B9B2B2B2EAF22A34E286C8A2372D16642C62153216310993C6A2D2527CFA29FAF747BB767FFDE395C66EBB85DA000020004944415422A2DED048945FC858C424B22A2C22635150B37327962CC165B309757F151A7143643148121132163109198B9884256391DB8D6FBE8152898103F1D967B8E9A6FF597BA5B188A8378C9C3192858C454C42C62226898E8E66A659CF9FC7BC79D8BE1D3131E8D103975D847CCDCA4C8F415CE820F208198B58858C454CC292B1A86953AC588179F370D55E81CBE5CAC9C9A1C2A2802097F93751F0198B6432C9191515151E1E2E761402919696269366959BB18899B96B8D067DFA5C73ADAF5E8C992F2B2E3412E51732163189AC0A8BC8581414582C58BF1E274FD6E98FA9B028805012E517321631891CD4363EC858142CECDA85397370EC589DFE5856CDCA37B29892121132163109198B9824188D456E37F6EC81DB8D5B6EC1FAF5E8D9B34E9F52A954068321787B0C92820E228F90B18855C858C424C1682CCACFC773CF61E3464447A37F7F8486D6E9534EA7F3D4A9535458141064D19B160B3216B10A198B9824188D45C9C978ED35B46E5DD7F4E9838C45018446A2FC42C6222691556111198BA48C468381039194E4DFA7A8B028805012E51732163109198B9824288C455555D8B8B1AE55B8D7828C450144EA674CB043C62226216311930485B168CF1ECC98819F7F6ED046C8581440E820F208198B58858C454C22656311C7E1A79FB06307BA75C3DAB578E081066D8D8C4501442EF36FA240C622562163119348D95854588869D3D0AC19DE7F1FB7DDD6D0AD91B12880D048945FC858C424B22A2C22639114484CC4BC7958B8103A5D00B6468545014416BD69112163119304B5DAC62F64A5B69172B36A34183224605B9355B3F20D25517E2163119390B1884924652C72B9B0772F9A36051FB3E9642C0A20741079848C45AC42C622269194B1E8C0018C1B87AFBEE265E3642C0A20B2E84D8B05198B58858C454C2211635176364A4A909181458B3078302FBB20635100A19128BF90B1884964555844C62221292BC3942978E925E874183D1A3C4DA55361510091C5204944C858C424642C621229188BA2A2307E3C52531113C3E35EC8581440E472D5130B32163109198B98243A3A5AF45FAB5A8DFBEFE77D2F642C0A20741079848C45AC42C6222611C558E4F1E0A79F909323E84EC95814402889F288CF58A40BC8D3D192272A2A2A353555EC2804222D2D2D323252EC2884406EC6A2A8A82881777AF830468DC2C68D82EE948C4501849228BF90B1884964555844C6229EC8CBC3C1834849C1F3CF63EC58C1760B50615140A17BA2FC42C6222691B2DA26B0C84A6D2364B35A2C78FA69D86CF8EC333CFAA830FBFC0B59352BDF5012E51732163109198B98444863514404468C40D3A6888D156687FF03198B02081D441E216311AB90B18849843416A9D578E821DC720B4499A82263510091456F5A2CC858C42A642C62125E8D455E2F7EFD15D1D168D992A73DF801198B02088D44F9858C454C22ABC222321605845F7FC5881158BB96A7CDFB0715160510590C9244848C454C42C62226E1C95854540493094D9A60CA14DC7967C0375F1FC858144054F3E7CF177897478F1EDDB2654B5656D637DF7CB37DFBF66FBEF9A6ACACAC4D9B3665656515151561616146A3313232B276F1ECD9B3E1E1E141BAD6E1704445459D3D7B565251F1B1362222A2B2B2D26EB74B2A2A9ED61615154547475B2C164945C5D3DAE8E8E8828202A945C5C75A9BCD66B7DB753A5DA0B6ACD3E97EFF3D77D6ACC80D1B6A860CA91832446BB1E4E974BA4B3F1B111161369B2B2B2BB55A6D4E4E4E545494008BB9B9B9717171656565369B4DC8FD0AB0585555F5DB6FBF2D59B264FBF6EDDBB76FFFF6DB6FBFFFFEFBD6AD5B0F1C3890A78C2642123D74E8504141C1B061C39293939B366D9A9C9CDCB265CBE4E4648EE3D46A756868A8C7E3090F0FAF5DF47ABD3E5F41D0ADE538CE6834C6C6C6AAD56ADFA214A2E2632DC7712E97CB6432356AD448ABD54A242AFED69E3E7D3A363656ABD5AA542AE944C5C75AAFD79B9F9F1F1717171E1E2E9DA8F8581B111171F6ECD9D0D0D09898188FC713A82D739C57A90CBFED366F870E8AD050EDB5B6ACD1682E5BD46AB55EAF37222222E06B434343ABABAB4D2693EF1C166CBFC2ACF53D55A850289AFE494E4E4E93264DF84BA20A8EE378DAF4B558B56AD5C9932757AD5A25F07E45C1ED76AB542A39CCE8721CE7F1786432A32B9F6605E072B96432F547CDCA244F3DF5547878F8A2458B78DABE2CEEEB88484141817C0A8BE4632C2A2C2C944F6111198BFC253B1B79790DDF0C8F50615100A124CA2F642C621232163149409AF5D429DC7F3F56AC80E0737C7E20AB66E51B594CBE8908198B98848C454CD240635159198A8A101B8B11233064883816853A42C6A20042079147C858C42A642C629286188BAAAB317B361E7F1C1E0F66CE44A74E810D2DC090B12880C8A2372D16642C621532163149438C451A0DBA75C3ADB7223131B041F102198B02088D44F9858C454C42C622266988B148A5C2F8F178E82104C5DD1B2A2C0A209444F9858C454C42C62226F1D758949F8F4B2B9783E8874EC6A200228B0B8188C4C6C6CAE4640D0909898E8E163B0A81D0EBF532296E542A9571717162472110D1D1D1756FD6B367316A145E7D15C1389CF335AB4C3A827C43079147388ECBCDCD95C9BC9FCD66CBCFCF173B0A81301A8D32292C72B95CB9B9B962472110F9F9F97569569B0DD9D9080B439F3E183102C198895C2E574E4E0E15160504B9CCBF898242A1484F4F97C92467545494CF0C2707D2D2D264D2AC21212119191962472110A9A9A9379CBB763AF1C20BF8F1476CDC88575E09A629DC4BF1D58BC964A25EC1F35C411076A2828AC2C242F91416C9C75824ABC22232165D8A5A8DB4348C1983C4C460CDA0904F61517939D6AC89F8EE3B5E27AE65D19B161132163109198B98A42ECDAA5462C2042814419C412193663599F0DC73A8AE76180C617CEE879228BF90B18849C858C424D73216959480E3FE7A009481EE13CBC6228B055F7D05AF17C387E31FFF40A74EEE59B3781D73B378102503198B58858C454C725563515111C68DC38B2FC2ED1625285E60D658B46B17C68DC3D6AD484C4454147AF502FF851AB2E84D8B05198B58858C454C7299B1A8A6066633B45A6464E0B6DBC0D2EF9835635179390E1CC04D3781E3306A14060F4664A4603BA79128BF90B18849645558244F6391DB8DA54B316204AC56BCF61A6EBF5DDCD0020C3B8545D5D5F8F4538C198375EB60B361D020DC779F9019143412E51B32163109198B98E45263914A85E868DC71071213C1DE0160C1585451018B055A2D7EF8010F3E883BEF8448B217B95CF5C4828C454C42C62226898989A9ED082A1478E209000C665004BBB1A8B2123B76E0E38FD1B62D9E7F1EAFBF0E517F8CC1791083043216B10A198B98E4F8F173797995B58B2A159B1914C16B2C7238E0F5E2DB6FB17E3DEEBD17D3A6212444DC0C0A1A89F20A198B58858C45EC71F122962C691115A55AB54AF4CB32EF049FB1C866C377DF61CB163CF924860CC1A041D0EBC58EE9BFD048945FC858C424B22A2C62DE58E476A3B4141C078DC6DEA78F4B0EBDA3202B2CB2D9307B36DE7D17FDFA2123031111D2C9A0A09128DF90B18849C858C40C5E2FD6AEC5471FE19D77F0FAEBAEE868AD1C1A36389AB5BA1ABB77232F0FA346E1C107D1AA9534DF784E49945FC858C424642C620685020E076EBA09F1F18889899649DF28088C45BFFF8EC58B6136E39147A0D3A1776FB103BA26123E88C10F198B58858C45CCA05060D2242C5E0C8301B9B9B9571A8B9844BAC6228703BB77C36884CB853E7DB07E3DC68C81B4C721B2E84D8B05198B58858C45414D75356A6AFE7AAAB0F6127D99B18861A4682CF278B07B37DE7F1F252598370F7DFBE2A69BC48EA94ED048945FC858C424B22A2C62CC5864B7E38517307D3AAE7CE9D9A5C622B6915661517535CE9D83CD869D3BD1AD1BD6AF47DFBE62C7E407B218248908198B98848C45C108C7A1AA0A2E172E5C409B365771E15E6A2C621BA9188B6A6A70F020D6AF875A8DD75EC32BAF487CE6F6AAC8E5AA2716642C6212321605235F7E8977DFC5820558B50A6AF55592687474B44C7EADE21B8B5C2EA854F8F9672C5D8A810371DF7D888A122D9886218B6E975890B18855C858148CE4E52132127A3D4243AFFE4A96FCFC7CF934AB68C6A29A1AECDD8BC993F1F5D7E8D60DFFFE379E7E1A4949224412206824CA23642C621532160523132660FCF8EBBD5F3235359599B9EBEB239AB1C8E5C29225D8B9134386E0E69BA1D341A7133A86404323517E21631193C8AAB028788D452ED7FF540F8586DEE00DCDC5C5C55458C40B3535D8B307CB96C166C3DFFE86B56B3173261A351268EF3C238BDEB48890B18849C858247DAAABF1DA6BC8CFC7B265A8E3B357D4ACBC603462F1629C398361C3A0D1A0470F81F62B149444F9858C454C42C6228963B7C3E9444E0E9A3645DDD3A25EAF97C974AE10C622B71BC78E41A783568B4E9D306B16525379DC9D78C8A2DB2516642C621532164999EFBEC3A851C8CBC3CA95983BD78F9B6E46A3918C4581E1D8314C9B86D9B3919D8D56AD307932AB19143412E5153216B10A198BA4CC993300101181C848FF3E48C6A286E272213F1F8D1B63CF1E2426E2996718CE9DB5D048945FC858C424B22A2C0A3A63D1F8F158BF1EAD5AF9FD41321635648B387408D3A661CE1C949561CA14CC9E2D870C0A4AA27C43C62226216391A4F078706997262CCCEF31A80F3216D507970B3535387D1A8B16A171632C5C88264DA0D1401ED73DD0742EDF90B18849C858241D9C4EAC5A853367B064493D73672D642CF20F5FE9D0FAF5E8D8110F3F8C77DE4142827C72672DB2E8768905198B58858C4512A1BA1A0E078E1E854EE74715EEB52063911F78BD78E71DCC9A85264D70DB6D080D4562A20C33286824CA2B642C6215321649811F7EC0CA959831032B5640AB455858433748C6A21BE376E3C811ECDA853163D0B72F860C41CB963C04184CD048945FC858C424B22A2C92ACB1E8F7DF515A0AAD16313101C8A02063D10D319BF1DC7378FE79A8D5888C44C78E9441D19091A8DBEDF67ABDF2299CA91F642C621252DB4881B163F1E083888D0DD806A959AF8E6FF4E9F1A0654BB46B87499328775E4A7D92687171F1071F7CF0CB2FBFD4D4D4B46CD972E4C891999999018F8C0DC858C424642C12058E83CB85DA8B7F58586006A0B590B1E82AFCFE3B56AFC61F7F60DC38F4EA85471FE53FBA20C3EF6E97DD6E9F3367CEE1C387EFBAEBAE471E7944ABD5FEF39FFF3C71E2041FC1053B642C62153216098FC7830D1BF0ECB3B058F8DA05198BFEC2ED4676361C0E1C3B06BD1EEFBD873163040C3098F0BB376D341A8B8B8BDF7EFBED66CD9A01B8EFBEFB66CC98B173E7CE76EDDAF1105E7043C62256216391C0F89E45DCB9134A25388EAFBD90B108003C1EFCF107D6AD434E0E5E7F1D8F3C028E0B40E933BBD4E7D0701CC7FDEF892CDC2B75820D32163189AC0A8B443716FDF61B264D425616962EC58A15D0EBF9DA91DC8D456E37EC761417E3F5D7111989A54B919606858232E8F5F17B90D4A2458BA4A4A469D3A6DD7DF7DD616161478F1EFDE5975FC6D048FF1AC8A7F08A8C454C220563D1E1C3F8ED3700E0FBE6AC7C8D451E0F8E1FC7071F203616CF3E8BE5CB111747B9B38EF87DD5D3E974AFBCF2CAFAF5EBBFFCF2CB9A9A9AF4F4F4D75E7BAD63C78E7C04C700642C6212321609C9430F61E8503469C2FB8EE46B2CDAB409AB56A17B77FCFDEF080D4568A8A8D10519F5193AC4C4C474EDDAB5AAAACAE170B46DDBD6777394B8129FB1A879F3E672B010D86CB6929292B4B434B1031102A3D1989C9C1C1515257620BCE33316B56FDF5EC89D721CDC6ED4A6B3F07008F303CACFCF4F484890435FD0ED761B737232140AF537DF60D83074ED8A55ABD0BE3D8D3EEB81DF87CCED76BFF6DA6BB367CF2E2D2D5528149F7CF2C9840913E4E37BF30B9FB14857F7F7190633515151A9F278690380B4B4B4C8067A5A8304E18D455E2FB66EC5ECD93C56E15E8BD4D45439748C00A86B6AD2376F564F99828B17111989F47474EC4819B47EF87DD48C46E3CE9D3B972F5FBE6AD5AAC58B176FDCB8313C3CFCEBAFBFE623380620631193C8AAB048486391C7839A1A6CDD8A3367E0740AB6DBFFC2BEB188E370F224F6ECF1D8EDC50E8777D1222C5A84E464B1C30A6EFC9ECE753A9D717171B5B3763131312D5AB490499EA807642C621252DBF041763656ADC2430F61D122683410FE562CE3CD7AEE1CD6ACC19E3DB8FD7645CF9EEAA953919848A3CF86E3F7116CD1A2457C7CFCD2A54B7FFDF5D7ECECEC0F3FFCF0E0C183E9E9E9F9F9F966B399E3EF19AEE0C46030C824B568B55A3D7F0F1F488CB8B8389934AB90C6A21F7FC4AE5DB0D9D0A891081914805EAFD76AB522EC9857380E8585B0D970FC38CACBB174299E7B4E151A1A1B1BCB728F4140FC1E897A3C1EAFD7FBF9E79FEFDEBD3B2424A4ACAC8CE3B8458B1679BDDE6EDDBA2D5CB85026B700EB82CF58D4BC7973395808AC56ABD96C96EC1B3F024B767676D3A64DE570FFCC672CEAD0A18300FBBAE71EF4ED8BE6CD05D8D5D5311A8D898989313131A2451070CE9EC5A79F62FF7ECC9A852143307830D46AFC692C6ADFBEBDE8CF2F31407D1E7199376FDEAC59B37C834EDF5CA5DBEDE6384EA7D385526DF42590B18855C8581428BCDEBF261423231BFA56ED06C28EB1C8EB454D0D5C2EBCF61A00BCF002BA748152597BACAF672C22FCC4EFEBBB4AA5AAA9A93976EC58AD7751A954F6EBD74F3A966A49613299121313E5D0B7B0DBED168B25292949EC4084C06432190C06394CBAF88C452929297C6C7CCF1EECDD8BA79FE65142E41766B339262626B81F48E3389C3B878F3F46551566CFC6BC79888DC515B71E7CF56229292934A3DB70FC4EA2A5A5A54F3EF9A4C7E331180CBEC1A846A3E9D0A10325D1AB42C6222621635103F17AE176E3934F909B8BC71F974A1265C158B4772F5E7E1929299830016161D77AC0F6726311D100FCBEEA151616868787AF5CB9323E3EDEA75E9482184CB290B18849C858D4108A8AB07A356EBF1D73E742A98474262F82D858949787CF3F478F1E68D9122FBD846EDD70DD0AA9CB8D454403F0FB20366EDC382E2EEEECD9B38E4B2001FD55F1198B64F240A1CD66938F73C36834CAE455683E635160B7B9772F3EFC1026139A3695500605909F9F1F7CCDEA72E1ADB730762C4E9E845E8FA64DD1BBF7F533280097CB95939373BD57A11175C6EF91A8AFB87FF4E8D1B58F8A6A349A458B16092C060B0A7CC622994C7246454505F7CD247F484F4F97C9EC0B1FC6A2A143D1A9132458C79D9A9A1A4CCD5A58881327D0BD3B743ACC9B875B6EB9F2DEE7B5F0D58B05D3979530AAF9F3E7FBF5813367CEAC59B3E6C9279FBCEBAEBB7AF7EE7DCB2DB7F4EEDD3B2323A3EEB533BFFCF2CB4F3FFDA4D56A8F1F3F7EE2C489E3C78F575757376AD4A8BABADAE9746A349A8A8A8A909090DA45ABD5AAD1686A6A6A826E6D7575F5D9B367C3C3C3ED76BB74A2E2696D4D4D4D4141415858985AAD964E543CAD3D73E64C585898C7E39154547CACADAAAA2A2E2E562A950DDEB2D3E572FACE8DC8C890C8C86A974B5ADF57ABD5E6E7E7BBDD6E9D4E27705476BBDDE572A9D56A8BC5121212E270385C2E974AA5F24575D9DAEAEA6AA7C914B26183FDC51755D5D5F6CC4C77D7AEAA56AD2C959537FC6CEDDA0B172E949494A8D56AB7DB5DC7FD06CB5AB7DB7DFEFCF9EFBEFBEEC48913274E9C3879F2E48E1D3B9A34693270E040BFD363DDF07B90C4715C8B162DEEBDF7DE7A3F4DA5542A8B8B8B7FF8E1075F5D12C7714EA7B363C78E56ABD5ED766BB55AB3D91C1E1E5E5959E9743AB55A6D49498956AB0DBAB5A1A1A156ABB5BABA9AE338B3D9ACD3E9A410157F6B0D06437575B5EFCC964E543CADB5DBED1CC7492D2A3ED6DAED76B55A5D7B3ED76FCBC78F6BBFF8C23A76ACBB4D1BF1BFD175D6721C575555A5D7EB85DCAF4EA72B2F2F07A0D1688A8A8A743A9DC562016030188A8A8AC2C3C37D6B7D3FABB08A8AF2CA4A2E2B2B3C2BCB3A6992FACE3B2D562B5756969090709DCF5EB9E5E2E2E28888088BC5E2EB1EF9F55989AF55A954BEFCE2ABE8542814454545BC56772AFC750CD9EDF6993367C6C4C4F4ECD9D3F72F4AA5323333B3EEB69A55AB569D3871E2ADB7DEAA4DA20CDFDFF6F537E550A0EBF57A3D1E8F2648EB32FC443ECD0AC0E97436A48ACAE3C1D34FE3D0216CDC88162D021857E0F18D69247A393299B0650BB66DC3638FE1FEFBE1F1A061F7896A6A6AB4ECE999FEC4EBF5D626D12953A64444442C5AB488A77DD5C7580460DFBE7D478F1E05C0719C46A3494E4EF64BF956FBF56AFFCB24642C62153216D585B232AC5F8F5EBD307D3ADC6EA9675048D658E43393AF5881BC3C4C9F8E3E7DA050343083326F2CBAB427C4778AF1BB25222323972D5B66B3D92E5EBC181111A1D56AC3C2C26452EEEF2F642C62153216D5857DFBB07C391213919919D8A0F84272C6A292127CF1054E9CC0DCB978E619444420407E0F32160590FA5CDF8F1C39F2E69B6F9E3E7DFAA1871EE2384EAFD78F19334626F378FE42C622262163515DE8D70F9F7F8ECE9D031E145F48CB5874EA14FEF94F444662EC58C4C420A0175832160510BF93685959D982050B7AF7EEDDA54B979A9A9AFEFDFBCF9933A765CB96FDFBF7E723BE60473E77CEC858C4240D51A9C4C4E0E69B031B0EBF48C258545282AD5B919C8C9B6FC633CF2033F35AD6A18640C6A200E2F71973FEFC79B55AFD8F7FFC23252545A150F4EAD56BD0A041478E1CE12338062063119390B1E8AA9C3881E5CB5156C66B443C121D1D2D72B37EF1051E7E18DF7E0B9D0E0603FAF7E72383828C4501C5EF83181515E57038CE9E3D0B40A150381C0EA3D1289F1749FA05198B58858C4557E2F562F56A7CF0014A4BF90E8A2F443316959561E74E9497C3E5C2840958B70EB7DECAEB0EC9581440FC9E7F4B4D4DBDFDF6DBA74F9FAE56AB9D4EE71F7FFCE1F57A870E1DCA4770C10E198B58252D2D4D26CD5A17635145053EFA08DDBAE1E9A73171A21455447544046391CD866DDBF0D967888941DBB678E00161764BC6A200E2F78540A1504C9A34A973E7CE3FFFFCB3D3E96CDEBCF9EDB7DF6E3018F8088E010A0B0B1B356A2493C2A2F2F2F2E4E464B103110293C9141F1F2F93C2A2828282D4D4D4EBFCCD810378F555CC9B87F1E3058B8B178A8B8BF57ABD407DC1B232389DA8ACC4810378E411DC761B042C6EA7C2A200E247123D7DFAF4912347060F1EBC7DFBF60B172E68B55AAD567BF1E2C54F3EF9E49E7BEE914959A6BF848484C8A7B04826B70901848484C8E4EAA350286ED8ACBD7BE3D34F83A90AF75A08D4AC160BBEFE1A1F7F8C810331752A962FBFA12F3EE0D4A559893AE24712ADAAAA32994C4EA7333F3FFFDCB973B5679B5AAD96C96DBF7A603018645258A4D56A6532C309202E2E4E265F56A552DDF055C13131E8D1439870F845AFD7F33BC3E97040ABC5DAB5D8B50B2347E28E3BA0540A9F4101A8542A83C120938E20DFF87121888C8CECDEBD7BE3C68D67CD9AC55F402C41C6225691B9B1282F0FDF7D87FBEE436CAC5871F1028FC6228B055F7D85DDBB316B16468EC4D8B1E21E3BE68D4542E247123D7CF8F0C18307FBF4E9C35F348C41C6225691B9B1E8DD77B179336EBE99B524CA97B1C864C2F4E9A8ACC4C89168DC58C87B9FD7828C4501C4BFE17CAD32FE32F8898D054C26538D4F7DC93A76BBDD6C368B1D8540984C2699DCC2F0198B7CFFEF7060D3261C3D8AB163B161033A751237B4C063369BED767BC03667B160C3067CF209743A4C9880F5EB3172A4143228FE2C2CF27ABD6207C2027E0C92542AD5DEBD7B274C987059D654ABD5D3A64DAB7D47377129642C6212791A8B7EFA09D3A661C60C3CFDB4B841F145208D45BB7661C50A848460C204C4C440624237321605103FAE7A1CC7858585356AD4E8D224CA719C5AADA642AF6B41C6222691A7B1A86B57BCFB2E6EB945DC8878243A3ABAA1BFD692121C38805B6E8142813163306810222303145D2021635100F123897ABDDECCCCCC975E7A89BF6818C3672C6ADEBCB91C2C04369BADA4A44426131246A3313939590E85453E6351FBF6ED01C4C4806DAB4A7E7E7E4242423DFB82D5D5D8B205EBD743AF47972E183020D0D105129FB1886E8B0604FFE6DF6432331928C858C42A3231165DBC88EFBFD7DC728B2C2AAE516F63515919AC5668B538760C1326E06F7F93E6E8F352C8581440FC18CE77EBD6EDBEFBEEE32F1426292C2C944F61517171B1D85108844C0A8BD6AEC5534F7976ED924BB3161717FB575864B1E0A38F307A34DE7B0F090958BC18F7DC23FD0C0A2A2C0A287EF4A6D3D3D3D3D3D3F90B8549C858C4246C1B8BDC6EECDF8FD8580C1982F47445A74E7219AFF8D1AC0E074242B06D1B366DC2A851183A144135AA23635100617F4A4A5CC858C4246C1B8B8E1DC3B87178E411BCF412DAB757399D723163D7C9585459899D3BF19FFF60D2240C1F8EBBEE021F72069E21635100A183C8233E6351555595D8810881D56A351A8D62472110D9D9D90CBF0AAD654B2C5E8C7FFC03F8D3582476440261341AAD56EBF5FEA2BC1CD3A763CD1ADC761BDAB6455454306650FC692CA257A10504667BD352808C45ACC2B6B12836162346FCF7FFAF6A2C62956B1A8B2A2BF1DD77309B317A34468E44BB76B8914F58E290B12880D048945FC858C4248C1516555662C70E94955D65D5A5C622E6B9BAB1E8F0618C1B87D5AB111D0D9D0EFDFA057B0605151605144AA2FC42C6222661CC58B47E3DC68FC7E1C3575975A9B18879FEC758E47060E74E9C3D0B85024387E2C30F316A145839C3C9581440183927240B198B98840D6311C7E1975F1016863E7D101787ABBE5AE2526311F3C4C4C468341A783CD8B307EBD6C162C1DCB9C8CC44B76E62871660C8581440E820F288CF58C4D2BCDF75B0D96CF9F9F96247211046A39181C2A21327F0F0C378FF7D74E8801123A0D35DE56F7CC622C1431387F35959D6DF7E83C381FDFBD1BB37D6AE4566A6D841F182CF58448545018146A23C42C6225661C358D4A4099E7D16B7DE8AEBDC7008090991C53B621D0EECDF9FFAEF7F2B1313F1EAAB78FE79303D8144C6A2004223517E21631193B05158141B8BF1E3D1AAD5F5FEC6578122544462505303B71B3FFE8837DE30B768E1983A153A1DDB19145458145082BE372D71C858C424416A2C723870E8103A76845E5FD78FB0ACB6A9A9C14F3F61FD7AFCFDEF1834089D3A69BC5E653048FB1A0ECBCD2A38C17721082E0C06834C4E56AD56ABAFFBB539C8898B8B0BC666FDE8238C1A857DFBFCF8884AA58A0FFE273AAE82D389850BB16811BA7441F7EE080B83C1A0D7EBB55AADD8910901198B02081D441E216311AB04971A8E557F0000200049444154B188E3F0DB6FC8CAC2CD37E3C51771EBAD7E7C96356391D3893D7BB074292A2B317428D6ACC194294848F0ADBCB1B18815C8581440683A9747C858C42AC1652C3A750AA34661C0002C5F8E4E9DFCFB2C53C6A2EC6C2C5E8CDC5CDC7D37C2C2D0BDFB65EBAF692C620E321605101A89F20B198B9824B80A8B1213316912264FAECF8B46583016B9DD387408A74EC1E542A74E78FF7DF8AA87AEE0EAC62216A1C2A200228B41928890B1884982CB58141B8B4993EAF9D9A037161D3982F7DFC7993378EA29DC7927DAB6BDCEDFFE8FB18869C85814406471C68808198B9844E2C622970B3FFF8CF2F2006C2A588D452E17F2F260B763D72E34698277DFC51D77DCF043D1D1D1526ED60042C6A20042079147C858C42A1237166DDD8A071EC0CE9D01D854F0198B5C2E1C3A84A79EC273CFC16AC5B46998350BA9A9D7334AFC497E7EBE949B358090B12880C865FE4D14C858C42A923516198DF07A9196861933D0BF7F0036184CC622B71B0A054E9DC28B2FA26B574C9D8A8404F833D84A4D4D0DEEB9EB3A43C6A20022C50B014B141616366AD428343454EC4078C76EB79797972727278B1D8810984CA6F8F878DD556DB3E271F62C468E44C78E58B5CAEF2ADC6BE1AB40494D4D0DCCE678C2E5C2B163F8E00374EF8E071FC4BBEF2229A92E43CFCB282E2ED6EBF572E80BFA9A3525258566741B0E25517E2163119348D358141D8D7BEF45BF7E8194D60587DA66F56A6CDC887EFDD0A70F424351DF9E9C349B950F82A35983044AA2FC623018645258A4D56AA539C3C90771717112FCB2B1B178F6D9006F53BAC6228F077FFC815DBBF0D043E8D9130306A075EB7A8C3E2F45AFD7CB6486938C4501840E228F90B1885524622CE2389C39838A0A1E77215163D1850B78FE79CC9801BB1DA1A1E8DA156DDA343083828C4544BD905C6F9A25C858C42A123116EDDE8D4993307B36C68CE16B17D23216793C387E1C6E371A3542932658B91219190DCF9DB590B188A8073412E51732163189E8C622B319F9F9888BC37DF7F9E7C2F51709198BB2B2F0DC7378F2491C3982A4244C99D2F0F9DBCB206311510F643148121132163189B8C6A2E2628C1B87B838BCF71E5E7925B079E472C4371679BD387F1E0909D8BB175E2F56AE44FBF63CED8A8C45443D90CB554F2CC858C424E21A8BC2C29099899E3D111ACA6F0685B8C622AF173939F8F0431C3D8AD75EC3F8F1502AEBE3FFAD33D1D1D132F9B592B12880D041E4113216B18AB8C6A2E868CC9F8FDB6FE73D83422C6391D70B970B0505983B17555558B000E9E9D06878CDA0206311512F6824CA23642C6215E18D457979888D4554D47F1705BB4520B4B188E3909D8DF5EB111383C993F1DA6B68D204421D6A321611F58046A2FC525858289FC2A2E2E262B1A31008810B8B0E1CC0B061F8F453C176F817BE0A14E1F6F7C51778FC71582C183810616168D64CB00C0AA0B8B8980A8B087F91C5204944C858C42482A96D2E5C80C381C8480C19C26F15EEB510486D6334E29B6F70FBED68D306AFBF8E2E5D84CC9DB590B188A8079444F9858C454C228CB1A8B4148F3F8EB030AC5983575F156E0AF752783716D96C58BD1ADBB7A35D3B68B568D58AC77DDD08321611F5800E228F90B188558431168584A05D3B3CF0801055B8D7824763516E2EF6EF87D309AD162FBF8CD75F47D3A6BCECA8CE90B188A80772193A8802198B58451863517434EF8F81DE105E8C45797958B70EFBF763C00074EF8EC99303BCFDFA42C622A21ED048945FC858C424FC15161517E3D221AEE8F7D303692CE2389C3B87CA4A1C3D8A0B17B07021FEF94F48E9CE1C198B887A4049945FC858C4243C198B8E1EC5F0E158B72EE01BAE3F813116F94CF92FBC80C71EC36FBFE1EF7FC7F2E5C8CC14A57AE83A90B188A807D23A89D9838C454C1270635155151C0EA854E8D8113D7A0470C30DA5A1C622AF170E075C2E2C5E8CD0502C58802E5DA050482D7DFA206311510FE820F208198B5825B0C6A2CA4A3CF30C264F46F3E678EB2DDC7453A0361C00EA6F2CF28D3EE7CDC38B2F42A3C1820578F34D646606F28DE181868C45443D90627F9019C858C42A81351629148888406626743AC98DD0EA6F2CFABFFFC3E2C568DF1EE3C641A743309C1B642C22EA81C47EB2CC515858D8A851A3D0D050B103E11DBBDD5E5E5E9E9C9C2C762042603299E2E3E3753A5D40B6161181254BA052895F467425BE0A94D4D4D4BA7EC068C4679F61D020B46E8D65CBD0B1A3E4FA05D7A6B8B858AFD7CBA12FE86BD69494149AD16D3841737E0729642C629286AB6D2A2AA0D1A0360B4B36D1F8A1B6713AB17A35B66E45EBD6888941F3E668DE9CDFE0020D198B887A20D5DF2E2B90B188491A682CCAC9C1D4A9183000D3A60530285EA893B1282707B9B9E8D50B7A3D5E7E19DDBA49B753705DC85844D403710EA2DD6E2F2D2D359BCD66B3B9B8B8B8B2B21280D7EBF53DB7E4BBDDCDC0A2C7E3C9CACAAAAAAA9254547C2C7ABDDE8A8A8A9C9C1C8EE3A413157F8B5959599595951CC7F9FBD99A1A545470D5D5D068BC6DDA78A4F38DAEB5E870384E9D3AE576BBAF5CCB719CC764C2A2459EF1E3B91F7FF42A9518350A3D7A78140A497D85BA2FE6E4E49497978B18C665C799BF45BBDD7EEAD429A7D329F07E855974381CE63F292D2DE5DB19A79A3F7F3EAF3BB892A3478F7EF4D147070F1EDCB66DDBB66DDBB66EDD5A5E5EDEB56B57B3D95C565616111171E2C409BD5E5F5252E25BCCCACA8A8A8AAA5D0CAEB500E2E2E24E9E3C29A9A8F8581B1F1FEF743A2D168BA4A2E2696D7171716262A2BF9F2D28B8F8CE3BFA77DFAD7EF041F4E953DCA851457878B844BED1B5D65A2C96A64D9B666767D7AE8D8C8C3C9595155D51519C9F5F7EF870E4AFBF9E1E3C3872E2C4D28A8A8B172F4A21E6FAAD8D8D8DADAEAE76381C9191910247555050505151A1D3E98E1F3FAED7EBF3F3F32D164B5858D8F1E3C7636363F9587BF2E4C956AD5A1517170BBC5F01D6DA6CB6C3870FCF9933E7CB2FBFF4A5989F7EFAA973E7CE03060CE029A3297C43072159B56AD5CF3FFFFCCA2BAF78FFF465444646C6C5C5793C1E8EE3D46AB5D3E90C0909B97451A3D178BDDEA05BEBF178F2F2F2929292D46AB56F510A51F1B1D6E572D5D4D4949595252525A9542A8944C5DFDA9C9C9CC68D1B878686FAF5599B8D7BFE79756222A64F8756EBF57ABDD2F946D75AEB72B98A8B8B9B346952BB566536BB3EFA48F3EDB79E499370F7DD6AC0A354AA542A067EBFE7CF9F8F8E8E8E8E8E1672BFBE2B0300954AE572B9045854ABD555555566B3D9F76B156CBF822D3A1C8E8B172FFA928B4AA59A3B776EE3C68D172D5AC453461327899E3C7972D5AA5502EF57144C26535C5C9C56AB153B10DE71381C56AB35313151EC4084A0A8A848AFD7D7A3E8DAE18046134C770C3D1E4F515151727232380E0E07944ABCF8224A4A30660CBA77075B27B6D96C8E8A8A0A0B0B133B10DEF1356B93264DE4705BF4A9A79E0A0F0FE72F8906CFAF393821631193D4DD58545505950AB5D936E8AECF4AA5D210170793099F7E8AAC2CBCF20A9E7906515160F1A92D321611F5800E228F90B18855EA682C2A2CC4134F60E54A083EDD13303C1E4FCEA64D18370E870FE3BEFBA0D7232181C90C0A321611F58246A23C42C62256B9A1B1C8E3417535AC569495212545B0B8024A6929B66E55356D9AD1BF3F9A3747B76E08905C42B290B188A8073412E597C2C242F9BC0AADB8B858EC2804E2FAAF4273B9B07225264E84C1808F3FC6BDF74A51457403366DC2D8B1D8BBD7131151E8F1A06F5FE6332880E2E2627A151AE12FB218248908198B98E4FA6A1BB71B67CEC06080568BA82821E36A302525F8F55774EF0EAF17932661C00045488846367D23321611F5809228BF90B18849AE6F2C0A0BC3ABAF42A309AADAD5CA4A7CFA29366D42E3C6E8D4090F3EE8FB6715706363112B90B188A80774107984E3B83367CEF0EDCB900856ABD568348A1D85406467675F5681525303A7F3AFC58888E0C9A0A5A5309B6132E1D0214C9880152B70C9734A4EA7F3F4E9D32246272446A3D16AB58A1D8510389DCE53A74E5161514090CBD04114140A454646864CC667D1D1D111111162472110191919970E594A4A307F3E5253317D3A82A9735F52826DDBB06913860FC7134F60D5AA2B5FF6E9AB4011253AE169D9B2A54C46A22121216DDBB695C997E59B20FAC507252693493E854566B359EC2804A2B6B0C8E381C3018B0546230C06B1C3AA3B3535F078B06E1DBEFE1A132762D4282814577D5DB6DBED36994CC207280A66B3990A8B087F91C5204944341A8D7C0A8B6432E606A0D168944AA5C783D5ABF1E38F58BA149F7C82E8E86018865A2CF8FA6B7CFF3D66CFC6B8719838F1FAB54F0A85423EE315B55A2D93DB840A854226B51A022097AB9E5890B188497CC622A713274E20220221218889113BA6BA70FE3C66CD82D389871E42E3C6757126F8D43602842605C85844D4033A883C42C62256F1198B4243B16811962D937C06B558F0E187D8B81151519838116BD6E09E7BEA681D72B95CB9B9B97C072811C85844D4031A89F208198BD8C3E50280F4F474DF246764A4C8F1DC981D3BB06205004C98809818F4EDEBD7A743424232323278094C7A90B188A8073412E5173216B1447939E6CCC11B6F203FFF7AC6224960B1E0DB6F515A0A970B234660C306DC79673D36E3AB40097874D2848C45443D90C5204944C858C4061C07B71B172FE2C8110C1F2EED0A949A1A6CDF8E0D1BA054A2552B0C1DDA908DC94A6D43C622A21E5012E51732163100C7E1F3CFB163075E7A099F7E8A981878BD06297E59AB159595502AB17B37EEB90777DE8906977AA9542A3216B107198B02081D441E2163111BB8DDD8B70F562B542A180C50ABAF622C1299CA4A6CD9823163F0EEBB3018F0FAEB1835AAE11914642C621432160510E9F5A619828C456CA0D1E0A597A052FDF544E565C62231713AA1D160EB567CF821EEBB0F77DF7D556742BD2163119390B12880D048945FC85814A478BDB8B4EA42AFFF1F27C1F55F8526100E07BEFD1653A6E0D75F71C71DD8B0018F3D86404FBD92B18849A8B02880C862902422642C0A461C0EBCF516004C9D8AAB76D67DC62281A3FA1FAC563CFF3C7273F1F7BF233595BF2755C958C424642C0A208C5CF5240B198B820E8E436929B66E459F3EF078AE9E447DC622C143031C0EECD98382023CF820EEBD17AD5B5FFAC6153E2063119390B12880D041E4113216051D7BF660C60CA854F8F8633CFF3CAE95287DC6226143030E1DC2B87178EB2D4444202202B7DECA770605198B18858C45018446A23C42C6A2E0C2E3C1975FE2F7DFE172A179F3EBFD655A5A9A70CD5A5989FDFBD1A60DBC5EDC761BEEBC13090902ED9A8C458C42C6A2004223517E21635110A15261F66C7CFCF10D3228042B2C72B9B0752BC68CC1AA55282B438F1E78F451213328C858C4285458144064314812113216491C8E0380DA26AAE33B417957DB58AD282D456C2C0E1CC0E0C1B8E79E8097DDD61159A96DC85844D4034AA2FC42C62229535D8DF5EB61B7E3C927E157EC7171717C7DD9AA2AFCDFFF61C306242763F1622C5C18D8E73EFD858C454C42C6A20042079147C85824712E5CC0860D387F1EFE1658F0622CAAA9F9AF1BE9FDF7317428E6CE4578B8B81914642C621432160590201B3A0417642C922C070FE23FFFC1942978FF7D346A04ADD6BF8F07D858E47060EF5E7CF209468F46DFBEC8CC84649E2A2163119390B12880D048945FC8582441BC5E6CDE8C030750538356AD508FD41FC8C2A2EA6ACC9F8F575FC54D37A16B5784874B2783828C458C42854501441683241121639104512A3163063C1E346952CF2D04C0585453831F7FC41F7F60EC580C1F8E2953909CDCA00DF203198B98848C45012438AE7AC10B198BA449032D050D3516E5E460C9129C3B877BEF85568B9E3D1B140D9F90B18849C8581440E820F208198B2482D3898D1BB172255CAEC06CB09EC6A29A1AECDF8FE3C7E172E1E69BB1762D264CF0FB7EACB090B18849C85814406824CA23642C9208172FE2EDB7919101B73B30E5AE7E1B8B380E3FFE88B56B919B8B69D370D75D68D3260071F00F198B98848C45018446A2FC42C62271F9FD77BCF8223C1EBCFBFFED9D79781455BAC6DFAAEABDD34B92268140200B614D0CA32CC28082A82C2A2AE088A257441174C6194119C7D904970157AE2833DEEB8C0E1711914D101437362F8B0B8BA2AC019424644FEFFB52F78FCFDBC608084D577752757E4F9E3C9DEE5A4E5575EAADEF7CDF79CF7FE19967A0D72767B3E751581408A0A2023E1F366F466121FEFD6F8C1B979C46A404E658244B5861511251449094469863517A59BE1C1B3660E244F4ED9BCCCD9E93B54D28849D3BB178317C3EBCF0027EFF7BA8D5686F5F064559DB30C722460230119516E658945E7EFD6BDC7927BA774FF2667FC6B12812812862FF7E3CF514860EC52DB72027A7DDC927C11C8B6409732C4A22EC244A08732C4A3B7979C957509CC5B12812C1E79F63E64C2C5F8ED252BCFA2A1E79048585ED5441C11C8B640A732C4A226D2E749013CCB128C544A3F8F0439C3C892953CE3815685238BD6351348A975EC2FAF5183912975D06AD161D3B4AD88894C01C8B6409732C4A222C129516E658944AEC763CFB2C3EF800528F2AFA51615124824F3FC5534FA1A101C386E1E597F1C823E8DA55DA16A40AE658244B5861511251449094469863516AA8A8C0BA75B8E9263CFB2C3A7582D4AE0F3F3816D5D4E0A9A7B0772FAEBC123A1D2EB944DA1DA71CE658244B9863511261222A2DCCB128352C5B86A54B71F9E52952B16C8B45B56F1FD46A74EC88EEDD71EFBDE8D1A3FD263ECF02732C9225CCB12889B0932821CCB128654C9982E5CB71F1C529D9D9FEFDC17BEFC5430FE1C00174EE8CDFFC063D7BCA5241C11C8B640A732C4A222C129510E6589432F2F3919F2FF13EA2519C3C89DC5CECDC69EADA157FFA134A4A24DE65FA618E45B2843916251116894A0B732C920251C4279FE0B5D790A2531B8D62DF3ECC9E8D071E405515EEBEBBF2AEBBFCF9F9728D3E5BC21C8B64092B2C4A224C44A58539164981D389279FC49B6F42F2BEB76814A110AAAAF0D863E0383CF104BA7707CFABB45A855C564559DB30C722460228A2A7318D30C7A2E472EA14DE790763C7E2F1C761B349397DB528E2C8112C5E8CCC4CFCE63758B8109D3AE1FFBBBF7EC6B1484630C72259C21C8B92083B8912C21C8B92CEB26598370FC78E61C00014164AB9A7B7DEC2AF7F8D701863C742AF47972E68717B3DA36391EC608E45B28439162511453C4DA70BE6589474264EC4E0C11834489AAD8B220E1FC63BEFE0861B505A8AE79E4369294E179A9CDEB1488E30C72259C21C8B92088B44A585391625976EDD3064C86975ED8271BBF1E49398360D274FC26040DFBE282F3FD39ECE632AB4760E732C9225ACB028892822484A23CCB1E802F9EA2B1C38801B6F84569BF46D03004411870EA1A9093D7BC260C033CFA07F7FFCDC81FCE05824779863912C618E45498489A8B430C7A20BC1EBC5A38FA2A101975F8E4E9D92BB6D004055155E7F1DEFBD87316330783066CD3AC7F53233331552DCC81C8B6409732C4A22EC244A08732C4A18BB1D6FBC81E666CC9A857FFC23D90A2A8A38750A3E1FF6ECC1A95378E6193CF4D079F5111F3F7E5C218545CCB1489630C7A224C2225109618E4509F3E69B78E209BCF20AC68E4DD6260100A2886FBFC5F2E5D8BE1D7FFA13AEB90663C6E0FC838F929212855C56E658244B986351126191A8B430C7A2C4183D1AAFBD86912393B53D2016433008870373E7E2C409FCE52FE8DF1F8290808242618545CCB1487EB0C2A224A288A7E934C21C8B12A3B03079C3404511DF7D8737DE80C7833FFE1173E6A06347E87417B249666D234BD86565248022BE3169C466B329E4CBAAD56A333333135EFDF871AC5B278D17EEA64D983A15478F62EC58180C2828B8400505909D9DAD90CBAA34C722AD5455E06D0BE6589444D8499410E658748E0402983B1773E620990EF6DF7D87E79FC7E79FA3A8088F3D86975FC6D0A148D25D833916C912E658C44800D69D2B21CCB1E867F17AB1650BCACB71C71DD0EB93349D592884FFF91FBCF926BA76C5983149ED1AFE1EE658244B986311230158242A2DCCB1E8ECAC5E8D69D3B06B17AEB80283075F70A0585585CD9B11082016C31FFF887FFC03BD7B5FD8164F8FA20A8B986391FC60854549441141521A618E456767C810BCF002C68CB9E0DD373662D932BCFB2ECACB317020EEB9E782B77836145581A29C788539163112409833674E8A77B97BF7EE77DF7DB7B6B676EBD6AD5BB76EDDB2658BCBE52A2E2E763A9D3E9F4FABD59E3A75CA6030B85C2E8FC7A3D56A6B6A6AF47ABDCBE56A8F9F4622918C8C8C9A9A9A36D52A893EF5FBFDA150E8ECEBEA74BADADADAF8A779793A9BADCE64D226B05FDA94D6E1703537FB3EFD54BB63C7A9EBAE334C9FEE0A87A53E5EBBDD6E3299DC6E771BBC0AC9FDD4EBF59A4CA686868636D52A893E0D87C3C16050A7D3A578BFCDCDCD3E9F4FA3D1545555190C0687C3E1F7FBD56A757575B5D16894E8D3CCCC4CB7DBEDF7FB53BC5FA93F0D0402070E1C78E59557B66DDBB675EBD66DDBB66DDEBCB9B8B878643207CCFD88F43C7691455C1CDD05574BB64DC8B1C8E7F3C93E18E538CEE3F19C3C79F2678FB4A646DCB831EAF78BF4A7288A095737885555B1175EE0A64EC5FFFE2F2EBB8C7BE92561E448C93C767FC4891327BC5EAFEC2F2B94E458C4F3FCC99327DD6EB7422EEBD1A347E55A58D4525FAC56ABD485F49C288A92EEE0A72C5AB4E8C081038B162D4AF17ED342241211044109FF96248767EFD10D87316B16B66CC1AA55E8D123F13D211804C77DEFAB7BFBED183C3835DA194739971540381C5648D71FBBACB2E4B7BFFDADD1689C376F9E44DB574402208D54555529A7B0E82C8E45A1103EF9040D0DB8F65A3CFD348A8A12DDCDA95358B8107FF8037C3ECC9C89458B307C788A1514407575B5720A8B986391FC608545498489A8B430C72262FD7ADC720B3EFA08A34661CC989F9D6AEC0CECDD8BE9D3F1D557B8F14698CDC8CDBD70DB84C450546191426C25C02E2B23215875AEB4D86C3685F49968B5DAB3F4E59695E1D14771DD75096DFAD429AC5E8D9E3D515E8E3FFF19FDFAA53EF46C457676B64286FF2ACDB14821A5C8CCB12889B0932821CCB1284E4909A64DC379DB0246A358B204FFF11FD8B913562B7272306850DA1514CCB148A630C722460228E2693A5D28D9B1C86EC78103E8DF3F51C9ABAAC29E3DB8EC32A85478F0410C1F0EBD3E594DBD709863912C618E458C046091A8B428D3B12812C1934FE2AEBB505171FE1B6A6EC64B2F61CA14BCF71E6231DC720BC68C69530A0AE65824539863112301141124A511A53916C562D8BB179D3B63F870F4EF8F9292F3D9447D3D44117575F8E61BCC9E8DCB2E6B6BDA1947AD562B249FC41C8B6409732C4A224C44A5252B2B4B215F568D46939595B56913A64DC3C30F63C68CF359B9BE1E6BD762CD1A4C9C883BEFC4C28589CD959D323233331552DCC8F37C767676BA5B91222C168B42FE5BE9B22AE489416AD8499410722C5248BF1F39161516E2B7BFC5B871E7BC9ACF874804AFBC82AD5BF1C0039834091CD7C61514C0F1E3C7155258A41CC72200959595CAB9AC151515ACB02829B0485442388EEBD1A387420A8BCC66B3D16854A93073E6B9AD505F8F356BB06B17E6CEC5F4E93018603048DBC4E4515252A290CBAAD1687AF6EC99EE56A488C2C24285F45D53BD98420E566A58242A2DD5D5D5F22E2CF27AB1670F82C19F712C6ACD8913983E1D1F7C801B6E406E2E6CB676A4A050586111732C921FACB0288928E2693A8DC8DBB12816C3820558BA146FBC81BE7DD53F9F266C68C09A35C8CCC4D55763D62C9497C36C4E494B930CB3B69125ECB232124011DF983462B3D964F96515451C3C88A6269495E18107D0B327D46A75E6D9CD14DE79079327E3FDF761B3C162C1B061ED544101646767CBF2B2FE14A5391669DB8095470A608E4549849D440991B163D1AE5D183F1E4B97E2FAEB71CF3D3018E0743A4FEF5864B763E346343642A5C28C19F8F7BF316244CADB9B649863912C618E458C0460DDB9122263C7A20E1D70F3CDB8E61A00A0EEEA568E4500E0F7E3EDB7B174292C16F4EA853163D2D05069608E45B284391631128045A2D22257C7A2EEDDF1E8A33FF25268E9580487039595686CC4D6AD9834097FFF3B0A0AD2D14CA950546111732C921FACB02889C830486A53C8C6B128144245058A8B7FF0C26D7558E458048F071F7E88D75F475919FEF2172C5C0839E60E9963912C618E458C0450C437268DC8C3B14814F1DFFF8D8913B177EF1997D188A2D56CC6EAD558BC18E3C7E377BF8320C85241C11C8B648AC56251D46555C81383D4B0932821F2702C3A71024D4DC8CBC3EDB7E3F4D931B71B6BD684A64E756DDB8671E3F0DA6B983CF9FCA73D6B4F30C72259C21C8B1809C0BA732544068E45FBF661EA54DC7C3366CF0680D33CB93636E2E1875159A9BFE926DDA041B05A53DEC634C01C8B6409732C6224008B44A5A5BD3B16994C183102A34681E77FACA05E2F56ADC2BFFE058D06B7DE8AD75FF7DE7A6BB5329EE2A1B0C222E658243F5861511251C4D3741A69EF8E45C5C578FA69B47E60DDB70FCF3E8B8606DC71070C068C1C0980F7FB15924F02B3B69129ECB232128089A8B4D86CB6F655581489A0AA0A79793F9404FDA0A07E3F3EFB0C2525F0FB316204C68D430B2F1BAD56AB901E4E00D9D9D90A3958A5391629A4879339162511761225A43D3A16BDF926C68DC3679FFDF8DD68141F7D847BEEC173CFA1AE0E8307E3AEBBF0E37BABCBE53ABD63911C618E45B2843916311240114FD3E9A27D3916D5D642A783D188B163D1A3C7FFBFEBF3A1B111160BDE7F1F438660E2449C212E398D63917C618E45B284391631128045A2D2D25E1C8B0E1DC2A44958B408E3C6E1C9279193030483F8F863DC7D379E7A0A8280279EC08C19675250B4722C923B8A2A2C628E45F28315162591F61124B55FDA8B63915A8D5EBD30620404010887011E5BB660E1428C1E8D0913700E21E6F78E45CA803916C912E658D4DE89221A453484500491082261842388340BCD4618A5DBA952EE7AE9A2BD3816151763E142A811C6D61D78FD754C9C882143D0AF1F7273CF710B1A8DC662B148DAC8B603732C9225168BA55DFCB75E38EDC2B12886980831865814512FBC41047DF00511A4175E789D703AE174C3ED86DB0BAF030E0F3CF47E18613FFC3EF80208D467D43F8807A56B2713510921C7A2828202A351C2E7A00410457CF9250E1CC0F8F1D0E9BE7F53230631772EB66FC79831B8E822984C3099CE7D9B1E8FA7BEBEBEA4A527BD7C397EFC78972E5DCCE1EEBA0300001DEF49444154ED763ED473871C8B4A4B4BD3DD9054505959999393A3846741722C4A7D5A9402C41042514429520C20E082CB09A7175E0F3C6EB89D70DA61B7C34E7F3AE0F0C147F219422886580CB120820204FA31C2A8834E0FBD165A134C66983BA15326324D301961B4C2BACCB72CAA95B0848A89A884B44DC7A2681481009E7C12B5B5B8FC9791CE6215B66E457333A64EC5A851B8EB2E1415B576973F07CC66735B7B56900EE658244B9863D1B92342A43031865808213FFC7EF8830806100820E087DF09A7071E3BEC3EF83CF0B8E022B1F4C1E7863B845000010F3C24A85144D550ABA0E2C069A1D5436F80C10AAB19E62214596031C39C894C238C26980C30E8A0B3C062843103191A685450D10F6D84FF71ADCFEEF06E51235EF0393B238AB811A491EAEAEA8E1D3BEAE2E15EBAF9F863BCF30E1EBA3FF8F02D75A6928E795FBE8F975E446E2EC68E855E8FCB2F4F78CB3E9FCF6EB777E9D22589AD6DB39C3A75AA43870E068321DD0D911CAA40292C2C4C774352416D6D6D6666A6129E05A95E2C3F3F3FDEA31B432C1E23522A3184900B2E9243D248175C5E782946A4D8D1075F339A49350308D04648560508246C2698B4D06AA135C268843107398528244534C090894C1248030C144D1A61D443AF875E80C083E7C07168D365254C44A5A5AD39167DB83EF8CDA29DC17D4BFAE7B8316F1E06F4C78B2FA2B0F0C2A75BE1795E216942306B1B99228FCB4A31623C9B4879411F7C2184289BE887BF1EF54785A32698282E6C994DA41891128AA48831C4B4D0929E69A0D1416780C108A305162BAC1DD131139919C8A0C0510F7D0632F4D09B61CE408601068A0EE361A21A72CB3A33119596F43A168922FC3E511B7409D527B17D3B060E9C7D5B16821F670F19812143D0AD1B04019D3A25655FCCB1489630C7A2B60045784104298F184638DE47EA879FF4CF030F69A11D76EA298D078B0104420891AC0611E4C1730217CD895A792B251435D050EF682E72ADB09A60CA40860926134C14231A60D042AB8186BA520D30B40C13DB78A428358AB811A40B722C2A282848B10B4163235C35DEAEEE6F5EDBD869FDA71DE6E3D1DEDC21141561F0E0ECF202F49BF31333DC24E072B9EAEAEA14923F3B7AF4687E7EBE120A8BC8B1A8ACAC2CDD0D4905C78F1FCFCDCDB54A3C1351CB6C221591525F28491DA9A3030E3BEC6EB85D7035A3D9051755DCD0026EB82388506D0EC5882469545FA3832E0B5906180A506081250319D4774A61A21E7A0B2C4258A83E58DDAF6F3FBD4AAF865A804099459E39079C3F4C442524A58E453E1F6A6A208A0E6BC13D5362EE6F6ADEECBB8833DCD6A9305F7BDD745C6C456EEEF7F3B048F3ACCD1C8B6409732CFA59284CA43C62FCB71B6E1F7C4E38A92B958661B4CC26FAE1B7C31E5750EA38152106105041254050436D828974D10CB305967CE453D12905886698A90095BA58A91E470FBD061A1EFCCF641335B8A8EF450AE94D911A7612A5E5D4A953B9B9B9492F2C8AC5E0F78986A0FDEB7D91B7B6E45CDDFCE6B0BA95703870CD35FA7BEE9F3001A63BBB655CF6E2144BC6541578BE7772F77E5A7C3E9FC3E1E8DCB9730AF695764E9D3A65B3D914525874EAD4A96EDDBAA5BB21A9A0AEBECE6C311B8C867836919288944DF4C21B40A019CD2484D4896A87DD0B2F69242D4CAA49A21845540B2D159DAAA1D6424B5DA3D465DA011D289B48BFE947071DA9A301068A0ED550273D4C8C4422959595DDBA7593410E38ED30119596243B16F9FDF0F9448BF5EF2FC6D6BE1978C1F8D7EFA2DD36FA66975D5688BBEF468F1EC8CBD3EA5493EFFC7EE749DBEF39C01C8B64497B772C0A23DCCAC2C60FBF1BEE781E91FE2451ACD055702A2E82483C9B4843FB0144110D22C881E3C1ABA0A231187AE8D5505B6031C0908B5C4A1F5242D1020B6519298948D9442A3D6D0BD944B93A16A505A5DCF5D2C585381689223831E66C0C6FDAAEB5547E7D45E35B387810361B377FBE5E6F2C1BA8335CFFC0D5A55983D5B05806A5FD4A32C72259D2A61C8BE2A9C41862141752E447A5A4CD68A6D0906A6D1C7050B9A9175E5A3888206513294C54434D8AC881A38E501890ABCA35C154808278AF2965134932294034C3AC81265E74AA818646FDA7FBF49C07EDC2B1A8BD90EE5BAFAC49D0B1281A85207CBE23FCEF25C2CDDE57336B0EFCE1C063D714072E1F65106EBF1DBD7B232363EA740100C77507D046EE70CCB1489648EA5824426C954D0C21E481279E4D24FDA36CA20B2ED2457A414335A8E894D62545A45422A50969307E6774A6D090865E64218BFEA418918630EAA137C278E2E4898E391DB3ADD900E45D719A2EC72259C2445442CED1B12816436525DC75BE5E8DFFABFA72372A2BF1D043B5951DBFFA4A187B55F9A0A97D579875F985FD85CCFE3F6C59E2962700732C9225E7E858D4726C620C31EA08F5C24BD9442A9F2121A401FB5E7829708C671369192FBCE45F43D944EAF9544145F5352698ACB0E620A718C55658B3906586D90C33892559BED1480C1AE91FF7B239C783ED55D44B100479CB2771E18E458C388AB811A491B3381639ECE2C68DE850F7CDC5956FFF7AD39D1E0F5696AFB6F5B261C408D86CA3C71BAEB81606C3008EC345A96FF7F9C31C8B640665137D115F555D55C72E1DC3080711A4B11664FF4D45A7A48B71773712C5B8031C004A490288CB2159D2A8A022FDB3C1668185BA4FC9EC343E4E3F5E744AD9442AAEA184A21487AC28C7A2AAAA2A5658941498884A8B56ABA5AF692884E68668B6BF4A7DE208BEF906C3865572173DFE5771745EE097D75A7E3353A3EFD6C17CF10B3069694535D0BE12FFCCB1A8CD420122FDA6F18854711AB7396D39483FDE6B4AD94417EF6A323569A1F5C043D9C4082234B290223C923A3DF456580D30E4233F031971A7D37836915EB4CC26C6C726B69D6C62FBBAAC1782A28CA8A48689A8844422B0DB3B9DF8A26940F3FB4FBF5BF6F65745FFCC79BE5F7625BA7707CF97F452AF7A3B9A9BD75F97D97FF4F76B68D3DADE0B823916A50CCA02B6AC386D69734AC942175C545C432F283AA4A21B124E0E1CC59A618449115B65138D307642A7EE5C77BD4E9F8D6C238C59C8A2489146F4C78B4E2952A40051BA303105B459C7A2A4230882CD6653C81383D428E5AE971AC26170A1A0AAB116870FC36874751F78FF7DBC78C2B172D8AE3EF905FA81C60E23FF8C12038C46003AA0575FF9FCC732C7A2846959744A1DA1944DA4CA1A8A11E33343917F0DFDC40B53E3A3F50150461000F5851A60A0D0D0065B3EF2A9B3D404930516AAA6A1054C30D138FD56D9C4503874E4E811854C85961AC7A2B64028143A74E8506969A9421E1A248589E885E272A1A136DAC57D70FB2EE1850F7ADF1DFCE775FC0668B5B8E106CBA0214FCCE38CFA4273EF05E3B5F46595AD0DA9A21C8B7AF5EA7596A7F87880189F3D912245524472AB891BB951A129092445935465C38123BB540E5CDCBF86623E52C1B8F1375981C76D4E294C54434D5E364618298F98588CA8A8A9D012732C6A8F68341A569A9B2C988826442884DA5A78BDB1A2EEF3FE1C5ABB3ABABCF865B1435F83A1B7F9FAD1183E063939C8C810802E5D2A3B74E8A0D2B695A9D0A443968E452DB389F10AD22082D58E6A8D4913D5449D7052741840804491B4908A6E68CE617A41912215D7A8A01221D2E87BF2AF31C09087BC1294D0CC1854684AEE363436833A5A299B98CA54A2B21C8BEAEAAC562B2B2C629C174C44CF09AF17DAA0ABF13BEF3F37742AAEDB714BE38B6868407939FFE8A3C3AFD4F6BE58DF79C4BCB23CDD701E8250DC72454110DAD45468D2D12E1C8B5A4D9A483FF16C622B9B5392432A43A57891BA4F45887EB39F57F111446894BD00C10C73BCFBB4E5A4893436913A517F9A4DA4D70284369B4D6CEF8E45E7854AA55288A830C7A224D2D6EF7AE9241A85CB05B379C37BFCF3CF8933F14A77D5B7EF363E7DCDC51D6337DDCCF7E985CE9D61328D1A474B9B80D3840617E258D4BE48BD6351CB8189F15186644C4363309C705289A91BEEF864C2647C4AF66F5483134184B643031301D0007C924312BF3CE491F737759C0A51C1CA5B4DC2F73346917CC6CB73E43469629B722C921A8BC5A290FF56E65894449888FE802822ECF2EFDAA7F37CD77475C352D5FEBDF0FBF1C413067D7151412CFBEA09254354EB0C3A6B6611AF2A3AB70D26E458D43E498A6311CDEE14AF3B6D954D24D923696C46735C14699022D59DC60772D0387D01028D4AA46C2275937642A7B8CD29BD431DAAF149138D3092889EC9E6F4F07787F3F2F24C26D3059FB6B68EA48E456D8DCACACA9C9C1C25B85732C7A224A278118DC5C0F3DF5584FFFB5F428F9AADE3EC8B1FDBFF57DEA01B74A52BFB8A2B505A8AFCFCE1DDF9CB47F03C5F00C0763EDB3E47C72279D0CAB1A8D5A489247234009F2245B2FC26FDA31E54AAB5A1C0916A53E3D9C428A23C780AF20050F94C0632C8B6A60BBA64218B2687A20CA2165AF27533C1A4863A6E734A2F2E7C368CA2A222855C564515161516162A44549863511251C48DA0150D0DF8F668B8976397E9E81E1C3C885B6FF59A2FDDB53D9ADDBBB379FA2D0B6D39869C0C6BFE5FE29DB31C90705AF32C8E45ED8B96D9442A3DA54913A9D73480803BE66E8A34C554B1F85C51F1E985E346E13439540CB110425462234030C1A4859606EC6720C3065B010A5A661369AE288A26A9E39482CB739A37511A94E0584450054A616161BA1B920A98631123019422A2A110366D82EB40D575CED7E76DBE72DDF1D255E5EF95F70AE2D24B5154D4BBB366F53AD198D14350F5E893D4FD6A349AB65658D4D2E6B4E5A4894104430851369106E95380D8329BE8828BB289D4B34A15A7944DE4048EE3B9783691C6265A61ED888E64F94D72484332C807353E3691C2C478A4D806EB6B5AC1AC6D6409BBAC8C0490A78846A37038600C36EB2A8F62FF7EE4E67A078E7AEE89A8C11DBDFA06ED4D77184675D1150F9C8BCCEF8B0838C06295E4C66DB3D95253AA108F0EE92784100DB720158CCF7DE18187C6639022C6274D0C20C081239B530AEC68D244123C35D464674A63138D30FE349B2844052122646A334944A9D734BD93264A477A1D8B528920081D3AC87670732B9863112301E47323104554558A95C7C3BFF07CB271B3F6892D431F362CFD95F503E4E5E19A6BCC59AA7FBCAACA3077B3E4CE1CFCFD2D5D726D1345F1C89123050505E7EB422042041077B1A18462BC768622451AA7EF828B5E9064D2407E8A2629954825A324693AE8685805295F3774A361FB719B53238C3AE8C8CBC60C336513C92895E2C5B364131D6E477D7D7D5E8FBC0B3D6BED81E43A16B56542A1D0E1C387CBCACAD2DD9054C01C8B1809D08E453412412C18D6F89DA8A880C7230EBDECF9A7B9F56FF957F5FF30AF7BD9E8D1437B8CB80597DC068B053C2F00DD7BA4BA851CC7F5EEDD3BFEB84739458A14238890D9B71B6E72B1693527064D2C4CF1627CEA44EA800D2144BA188F14C9DABB333A5B60A1C9A168CC3EA9637C6C222D497311277D60A2A21C8B7AF6ECA990BB0F55A0A4BB152942518E457DFBF655C8C14A4D1A4434168B25BC6E388CDA1A31D35359FDB5FDF1B5170DB06FFA1DB710D128060FE67FF9CB5B6FD75E7783A9E892C73332D58380F3ACA53D6FE2D5A711447CF0C523451AB06887DD014763B4D1C7F9DC9C9B0666C4159142460A16A9BE265E774A733FD178C4CEE8DC133D2DB050E929F5A952D4688699E693A260912245498FF7ECD8EDF6BABABADEBD7BA7B10D29E3E0C183F9F9F94A08597C3E5F4545456969A912BAFE8E1D3B969D9D6DB3497BDF680B0483C103070E9496962A615CAC288A17223A3F4B1A6EBB7EBF5F14C5F3584114E170A0A1015DBBAE58129DFB94EEC9CC65FD3AD545C4C7CDBF2C13473FCE1574436626787EC0205A21F1FF7652C4B8EB69CB3914E3A32F5C7035A39944912245B2B3898B62BC1F551085A69AA66E1DBAD90C361A6ED1155DADB092405A602175A44ED4562E36ED6E4E8C7DFBF6AD5DBBF6F9E79F97FDE36D381CFEFBDFFF3E79F2E4A14387A6BB2D9273ECD8B1850B172E58B040F6836245515CBC78F1A04183AEBFFEFA74B74572EAEBEB9F7DF6D9FFFCCFFF5442C23B1289048341E9B69F9E48F4EC221A8D420C47224DCE551F5B3DC7EAEE687A5EF7ED2168B578E6991E7DBB4C9FC1975D36A37B5FD5FFA88D1A8D11385B12AE65B0485DA6F1F91429588CFB9DFAE0B3C34E32E9863B6E94EA85378A2889227584523F2A999A52276A6FF4A6BE534A31C6EB6EB441ED03731F9875FFAC4B7F7129AD9EDE60515282C1A0DBED3EBFC7A3F689288A6EB73B140AA5BB21A920140AB95C2E491FE4DB087459FD7E7FBA1B920AA2D1A8422E2B6419899E118F073ADDF1EF5473E6E092FA0F6F17DE58513B2FA3A371D27597E86E9B88A22274E8D0BF88EB3F043198FC0886E074214C1EDF2484945CA4B462339A1D70D09BF48282C5F8384511624B458CD7A01A61CC456EBC06B565BC48C9455A386E67739660318080DEA9B746AD19504AB2902133388E6B6B63B42482FB7FD2DD10463B239D221A0B478E1C150EEF0F0D77BF6339BC23F8ED61FF7D538E77FEC5C1B0D7363C76E09AA137DBBE099A7DEB8DA28BDBEBC6361A9E41C12299C051F50D4DA61845343ECA9006EFD3145166988B514C5A98852C0A16A9128716884F8E4135A8EDA807B54DA19C1B90728E546928EAB22AEA6025250D22CAF3FCAE5D4D7FBE67ED88A6250B765CB9A9BEE77D7D1E0D5F72E0EB015C63F82B9753E5FD5DE0843AFC5F117FA826143D1515210A3141880A6A51CDC5386D54AB896974511DCD8C91CBE55A45AB85B3648A3F4CA668E00C7AE80DA241E0041E3C27723CC7F33C2F0802F5378AA2E885D7237AEA50D7B20732B9BD91C160B0BEBEFED34F3F75BBDDF2EE39E1797ECF9E3D5555551F7FFCB1EC075086C3E19A9A9A3D7BF6F03C1F8D46D3DD1C09E179FED0A143B5B5B55BB66C917DE9752C16FBEEBBEF323232727373E57D59398EABA9A9696868D8B66D5B7676B6FC5230E170389E6DE179FED8B16392163C72A93F832B56AE78F889E78D7A219FF747F91C3FAF87D5096D1854B81B03C771107FF4A0C48BBC200A02044EE48498F0BD34B658805EC705927EB7852F87CFE7D36AB5B2AFB501108944C2E1B05EAF4F77435281DFEF57ABD5B27F5C00108D4683C1A05EAF5742E012080404415042C16A2C160B040272BDACB158AC65D0E2F7FB274D9A3463C60C89769706118D44A327ED4D3A63CCC8EB7548C454B62DA8E339C2716938C369A1E5738CEC51DAC12AE748C12EAB2C68F570A052A9A48B64E47C1E190C0683C19014F90FA06630180C064322988832180C068391204C44190C0683C1481026A20C0683C160240813510683C160301284892883C160301809C24494C16030188C046122CA6030180C468230116530180C062341988832944B381C6E6868A8ABABABABAB6B68680887C3F47E2C1673381CD2B9903B9DCEB841762C16ABA8A8A8ABAB3BAF2D9C4B0BA53E8A96F8FD7EB7DB9D821D31186D0D26A20CE5B27BF7EE891327DE79E79D77DF7DF76DB7DD367DFAF4BD7BF702A8AFAF7FF8E187ABABABA5D86928149A3367CE175F7C417F7EF1C51773E6CC696C6C3CAF8DD4D5D5CD9A35ABAAAAEA0297498093274F1E3A74A8D59BEBD7AF7FF1C5179987284381C87F1A0A06E34C381C0EBFDFFFDC73CFE5E4E4D8EDF6254B96CC9E3D7BF1E2C5D9D9D993264DCACACAA2C562B198288A64601D8944044168696F1D8D46398EE3F91F3D8F4622119EE7E36FD2B41234EB8B4AA51A3F7E7C5151110051148F1E3D7ACF3DF7F4EDDBB7E5EA143E9ED6323B168B711C170A852A2A2A82C1E059DAD06A196A43ABC6B7DCEC998E5114C568341A7F67DDBA75C78E1D5BB060417C5D5114FBF5EB57585828CB2941188CB3C34494A168341A4DD7AE5D737272BA76ED5A58583869D2A48D1B374E9A34A9B2B2B25FBF7EEFBFFFBEDBEDFEF2CB2F6B6A6A468F1EEDF7FB3FF9E4139BCD76EFBDF7E6E7E70783C1152B566CDDBA55AD565F7FFDF5A3468DFAF6DB6F77EEDC190E87B76FDF6E341AA74F9FDEB367CF5DBB762D5FBEDC6EB7F7E9D367DAB46966B3B9BABA3A2F2F2F168BAD5EBDFAA38F3E52ABD535353513264CF07ABDEBD7AFD7EBF59B376F0E87C393274F1E366C58CBD6EED8B163E9D2A5E170B8A4A48484331C0E2F5FBE3CDE86ABAEBAAA959412EBD6ADDBB871A3DFEF2F292999366D5A870E1DE21F6DDCB8D1E3F19CE918A9F10E8723272767DAB4691A8D66D3A64D5555551F7CF0C1C08103DF7DF75D9EE7F7EDDB3774E850411082C1E0CA952B4F9C384133ADE6E5E54D99324509F30032940CEBCE6530BEC76C36F7E9D367FFFEFD8D8D8DFFFCE73F9B9A9ADE79E79D458B160D1830A0A4A464E6CC99DF7CF3CDF8F1E33FFFFCF3152B560058BA74E91B6FBC316AD4A8B2B2B2C71E7B6CE7CE9D5555557FFDEB5F4F9E3CF9AB5FFDAAB1B171D1A245B5B5B58F3EFA686E6EEEC48913376DDAB466CD9A582CB664C9928A8A8AF7DE7B6FC18205C3860D1B3264C882050B366CD8E0F178E6CF9FBF79F3E671E3C6656767CF9F3FBF65A2B1A2A262F6ECD999999963C78EDDB163475D5D1DCFF3ADDAB07DFBF656072508C2C183079F7AEAA9F2F2F29B6EBA69E7CE9DCB962D6BB9C0DAB56B4F7B8C2B57AE743A9D73E7CEB55AADB7DE7AABDD6E7FE18517341A8DD56AB5582C3939392E976BFEFCF96BD6ACE9DFBFFFD75F7FBD66CD1A8EE3F2F2F24A4A4ABA74E9B27EFDFABD7BF7B2D894217B5824CA60FC80C160A8ABAB134591E3389A7071F8F0E1E3C68D2B2B2B5BB366CD6DB7DD565A5A7AF0E041BBDDEEF57A57AF5E3D61C2842BAFBC321289ECDFBFFFBDF7DEBBEAAAAB323333A74E9D9A9797575757B761C30697CBE572B9F2F2F2860C19D2AB572FAD564BD305472291B7DF7EFBC61B6F9C3A752A0012ECF2F272B55A3D79F2E44B2FBD343333F3D34F3FF5F97C269389DAB679F3E6DCDCDC3FFDE94F7ABD3E2B2B6BE6CC994EA7F3A76D6815BCC662B19C9C9CBFFDED6F175D74512010E8D6AD5B535353ABA33EED313637376BB5DADFFFFEF77DFAF451A954FBF7EFDFBD7B776E6E6E5959994EA7EBD7AFDFC99327799EBFFFFEFB870E1DFAD24B2F0150ABD523468C00F0AF7FFDAB6BD7AE8F3CF2C869C36206434E301165307EA0A1A1C166B30982208A2249A9D96C06C0F3BC56ABD5683400341A0DC7718140A0A9A9E9EDB7DFA6E0AFBEBEBEB0B030168B65676767646400E0382E168B75EDDA75E6CC994B962C79FDF5D78B8B8BEFBBEFBEDCDC5C00E170B8BEBEFEEAABAFA6FD1616166EDAB429140A994CA6782EB65518575555555C5CACD7EB0174EBD6CD6432F9FDFE566DC8CFCFFFE941711CB76DDBB6575F7D95E7F923478E8C1A35AAD5A7673A468EE30E1F3EBC78F1628EE36A6A6A6C361B5ACC592D8A2285A4AD76F7EEBBEFBEF5D65BF3E7CFEFDCB9F3055C0A06A37DC04494A1685A0AD5C18307F7ECD9F3D8638FB58C9F5A6A46CB37D56A756666E61D77DC71C5155744A3518AD29C4E67CBC5388E733A9DC5C5C54B962CA9AEAE5EB468D1DFFEF6B7975F7E99E338954A959595555F5F4F4BD6D6D65AADD6B3A70F73727276ECD8110E87D56A75434383DFEFD76834ADDA909D9DDD6A2D9EE757AC58B17BF7EE79F3E61514142C5CB8301008B45AE6B4C72808C28E1D3B962D5B366FDEBCF2F2F20F3EF860DDBA75675A317EBC7BF6EC59B870E1830F3EF88B5FFCE22CC7C260C806D6D9C25034F5F5F52FBFFCF282050BE6CD9B77DF7DF70D1E3C78F8F0E12DC7569E76D886288A66B379E8D0A1AB56AD3A71E2C4EEDDBB9F79E61987C3C1F33C85B0B40CC771F5F5F5B366CDDAB871A320085AADD66030D0326AB57AE4C8912B57AEDCBC79F3962D5B56AE5C3972E448AD56DB4AAA5BEE74E8D0A1478E1C79E59557BEF8E28B975E7AC96EB75BADD661C386B56AC34F5B1B0E87499E3FFBECB38D1B37D6D4D4F87CBE568773DA638C4422A228AA54AAC3870FAF5AB5AAAAAAAAA9A989E77987C3F1D33E61000E87E30F7FF803CFF30D0D0D4B972E5DB76E9DC7E339FBF96730DA3BC29C3973D2DD0606233D84C36197CBE5743A9B9B9B83C1E0B5D75E3B63C60CA3D1188D460381C0C0810363B1585151515151512C16A3778C46A3DFEFB7D96C3D7BF62C2D2D3D76ECD88A152BBEFCF2CB0913265C77DD75E17058A5520D1C3850A552050201A3D13862C408411056AF5EBD79F3669D4E376BD6AC8E1D3B3A9DCEF2F2F2214386B85CAE152B56ECDAB5EBAAABAE9A32650ACFF3F1BD90800D1C3850ABD5526B737373737272D6AE5DBB6DDBB6BE7DFB0E1D3A74C0800183060DAAA8A868D98678381B6F73CF9E3DBFFAEAAB0D1B36D4D5D55D7AE9A5870E1D2A292989F7B5BADDEEE2E2E2D31EE3B061C3EAEAEAD6AC5973E4C891010306D4D7D79B4CA63E7DFA6CD9B2451084D2D2D26030185F3E3B3BBBB8B8F8DB6FBF351A8DD5D5D59595954EA7F3E28B2F36180CE9B9BA0C464AE0D8F86806236162B198D3E954ABD594073D2DA2287A3C9E70386C369B69A868CBD5DD6E37C5B5E75883E3F3F942A150CBE5CFA50DE170D8ED761B8D468D46E372B9F47A3DE53E7F966834EA72B9288676BBDD2A954AAFD7BB5C2E954AC5D491C10013510683C160301286E544190C0683C14890FF03A23397DBDA48C5470000000049454E44AE426082>|png>|495px|324px||>

    <item><strong|Matriz de banda ancha>: Siendo A una matriz de banda ancha,
    los resultados son muy parecidos, a pesar de que dicha matriz tendrá
    muchos más elementos no nulos (a pesar de que sigue siendo parcialmente
    hueca). El mejor método para resolver el sistema es en estos casos el
    método iterativo. De nuevo hemos elegido los mismos métodos para
    factorizar la matriz: el algoritmo especial para matrices simétricas
    (combinación de métodos directos e iterativos), el método de Cholesky y
    el método del gradiente conjugado (utilizando como preacondicionador una
    factorización incompleta de Cholesky).\ 

    \;

    \ \ \ \ \ \ \ <image|<tuple|<#89504E470D0A1A0A0000000D4948445200000278000001A90802000000917FDC7A0000000373424954080808DBE14FE00000200049444154789CEC9D777C5455FAFF3FD3D3EBA440022184241808024A50F82952FC222865052C88028B2B6B451157CA82ECA280A8348115112C4B93BE808B2B620114A47F95D0128640924903924C924932EDFEFE18CDF20DC594DBE69CE7FDF2E58BE4CEDCFBCC3D93FB9C73EE73DF4723080208822008829006ADD2011004411004CB50A2250882200809A1444B1004411012428996200882202484122D411004414808255A8220088290104AB4044110042121946809822008424228D112044110848450A2250882200809A1444B1004411012428996200882202444AF7400FF25333373EFDEBD6EB75BE9402447A3D168B55A8FC7C3C38A0E1A8D46A3D1783C1EA5039103AD562B08023FCDCAC987E5AA59B9BA34DD79E79DDDBB7797E1582A4AB4BB76ED5AB162C5DD77DFEDFD51100493C964341A958D4A0ADC6EF7575F7D75C71D77C4C4C4B0FD85D66AB5172E5CC8CECEEEDDBBB756CBF8F489DBEDFEE69B6F6EBBEDB6D6AD5BB3DDB1D06834454545C78E1DEBDDBBB79F9F1FDBDF614110F6EDDBD7A2458BD4D454E69BD566B3EDDDBBB777EFDE818181EC35ABD3E9ACA9A9D16834003C1ECDB7DFFE3062C443DC255A97CBD5BB77EF0F3EF8A0EEDBECED352B1B95145457578F1A35EAB5D75EEBD6AD9BD2B148CEAE5DBB366EDCB868D12283C1A0742CD2E27038FEF8C73FFEF18F7FECD3A78FD2B148CED1A347E7CD9BF7CE3BEF848585291D8BB4783C9E975F7EB9478F1E8F3DF698D2B1484E4E4ECE8B2FBE387BF6ECD8D858A563119FBA6909AD569B9B8B071F9CEA72C93481AAA2440BC09B56991FFA30D97BB8351C7E64B6F136280FCDCACF27AD83D50F7BEDC82D3616696955804E9E43339ED2D40CABDF6682600FF6E65139C7604058582DE092E770EA1AD15E4F7979794E4E0E631552B5B5B5656565A74F9FD6EBF572DEF5090C0C4C4A4AD2EB656D7456E7FF6F083F9F9437A86589E6A0A2446B3299AEFF367FFFFDF76FBDF556424242A3BEE83A9D4E1084BA1CD69CA2416F0D5E13DE780B044130180C5BB76EDDB973A7B87BBE0576BBDDE572FDF39FFF349BCDB21D1440FBF6ED478C18A1D3C93445A3207ABDFEF1C71F4F4E4E563A1039888F8F1F356A94BFBFBFD281488E46A3193A74685C5C9CD281C8414444C41FFFF8C7E0E060A503910A87035555080F07009D4E275BB1AD8A12ADD168BC3E9BDAEDF62E5DBACC9933A7E1376E9D4EE7B7DF7E6B3299EEB9E71EAD56ABD1688E1E3D1A1414949A9ADAA85CABD1682A2B2B0F1E3C989191111C1C2C088288BD5AEFA31162EDED77D16AB539393993274F967F6EA055AB562D5AB4E06140A0D56AFBF6EDCB7CCD9797A8A8A87EFDFA31F950C0F5F4ECD953E67920A5080909193870A0C964523A10A9D8B60D9F7C82254BD0B62D743A9D6C7FAD6AFFF668341AA3D1181616D6F02BF5E9D3A7A74D9B161010B073E7CEF8F878005BB66C494A4A6A4289AFDD6EDFBD7B774646C6B163C78A8A8A7CBAEC30383858912AB3CACACAE2E2624EC679E7CF9F8F8F8F0F0909513A10C9713A9DE7CF9FEFD8B1A3D281C8C1A54B97A2A3A3434343950E44721C0EC7B973E7D2D2D2589D82CAC94158D8AF235A39517BA26D02BB77EF4E4A4AB2DBED7BF7EE1D39722400B7DBED9DFE1504213F3FFFCA952BAD5BB7D6E9740101017ABDDE6EB75B2C16008989898181811E8FA7B2B252ABD5161414B468D162F2E4C9111111FBF7EF3F7FFEFCA04183BCB3D0A5A5A52525250909097E7E7EE7CF9F37994C6DDBB6F57E35EBED4DD133A10A424242F8390FC9C9C99C0C7D8C46636A6AAAD251C844626222AB89A71E46A3B17DFBF64C7ED8DA5A582C78E6190090FF9134D62E0A5555557BF6EC79F4D147F3F2F2BEFCF2CB471E79E4DA0BDFD6AD5B3FF8E0839090909090909A9A9A193366444646FEF5AF7FBD78F1A256AB8D8D8D9D3D7B3680E9D3A7EBF57A9BCD3671E2C40F3FFC70E8D0A1DF7CF34D7E7EFEF6EDDB753ADDBFFFFDEF808080DCDC5CBD5EDFAE5DBB8282828B172F8E193366DCB8714545453366CCA8DBDB5B6FBDD5A2450BE54E862AB0DBEDA5A5A5DEA905E6B15AAD5151510101014A0722392E972B2F2F2F313151E940E4A0B0B0303C3C9C87FEA2B759131212D87BC6F2DB6FF1CA2B58BA148A3CE5CE5AA2FDE5975FAE5EBDDAB76FDFFCFCFC6DDBB6592C96949414005AADB6B0B070C992254F3FFDF4A04183366CD8F0E69B6FD6D4D47CFAE9A757AE5CF9F0C30F351ACDCB2FBFFCD9679F8D1C3972EFDEBD4F3CF1C4CC9933ED76FB993367121212FAF6ED9B9D9DFDF0C30F7FF4D14767CE9C59BB76AD20080F3FFC70972E5D66CE9CB96AD5AA3D7BF68C1933A6DEDE3EFDF4D3C99327D78BD00EFBA7F8341FF95AC99EAD1220F445DFFB709F44FB6F145AAD96933B79008C46237B57A81BE2BDA7A374143241CDCA007A3DFAF48152F73A584BB45F7DF595D3E9DCB76F5F5555555959D9BE7DFBEA12EDD9B367753ADD800103828383FBF7EFFFD9679FD5D4D41C3E7C78D0A041AD5BB7063074E8D01D3B763CFCF0C3919191C3860D8B8989B978F1A2D7041914141410106032990441E8D0A1436262A2C3E1888B8BBBF3CE3B0303033B74E870E8D0A1EBF7F6AF7FFDCBE974D6BBDFEE84F3288E9EC55949136D129224DA796331994C9CCCA602888C8CE4E4C3EA74BAA8A828A5A39089F0F070266753AF47A7D399CD66267B157DFBA2572F2855AAC8D445A1B4B4F4FBEFBF8F8989F9E9A79F341A4D7C7CFC975F7E397AF4686F21555555157ED34E190C0683C1E0F1786A6B6BEB1E51F0F3F3ABAEAEF6783CDEAD373B4ADD9F5CBD27440541B8E1DEEABD3D04218BB0C80D69AB7F4D504BDDA0CD662B2A2AE2E47E5E565656AB56AD78288672381C67CF9E4D4F4F573A1039B0582C313131CCCB2601381C8E3367CE74ECD891BD8E8546A35896056389F6E8D1A376BB7DE5CA956DDAB401B06FDFBEE79F7FFEDCB973DE0AA6366DDA5455555DBA74293D3DFDFCF9F38585852693292929E9E8D1A323468CF0BEBD4D9B36BF3B7372B3C7728C4663DBB66D7F776F1A6802C1FECD9E3A424343838282948E4226525353D9BB42DD106FD58CD251C8445252123FCDCA70C9B182309568F7ECD9D3B97367EFCC2D80CE9D3BC7C5C57DF7DD777ABD5EA3D1B46FDFFEDE7BEF7DFDF5D77BF4E871F6EC5997CBA5D3E91E7FFCF18913274E9A3409C0E1C387E7CD9BE71DCED6094EBD4FF70605059D3C79F2C71F7FBCF6D12B83C1E01D1F6BB55ABD5EEFDDDB6BAFBD56B7B7B973E7F2F0FCE8ADB1DBED6565659C3CEF6FB55ACD663327C55056AB35212141E940E4A0A8A8282C2C8C8AA17C0E8F076BD620321203072A1C093B89561084279F7CF2DAA745838383172D5AA4D3E9FAF7EFEFE7E7E772B9468C18D1A953A7CB972F8F1C39D26AB51A0C86CE9D3B2F59B2E49B6FBE110461F4E8D19D3A75AAADAD9D3F7FBEB74A36262666FEFCF92D5BB61C346890C3E1A8ADAD1D326448BF7EFDBC09F8ADB7DE6AD9B22580CE9D3BB768D142ABD576EFDEBDDEDE943C23EAC0DB0B513A0A99A8EB7B318F46A3E167DCA3D7EBF96956968C2BB9B978E71D0C1E4C89563C341A4D5A5A5ABD5F7A2BA1BC5CBD7AF5BDF7DEEBDDBB77AF5EBDBEF8E28BE8E868EFD8B753A74ED7664493C954F763DDBFFDFCFC9E7BEEB97A87EBD0A183F7DF61616175F76FEAED8D301A8D3C3CE9EF253C3C9CD5A2CD7A68B5DAC8C848A5A39089D0D05096D2CF2DF0362B1BBD0AB71B5151983F1FB7DDA674285CADDE131111F1C20B2FFCF2CB2F4B962C292F2F7FE38D376EA1F474B95C8EDFA857D0E476BBCBCACAAE5EBDEA72D55FF9A1BABAFAF2E5CB151515B4D6471D959595B9B9B94A472113168BA5B2B252E928E4C06B86523A0A99C8CDCDE5A759B3B3B31958C44510F0D14778E71DF4EC0935DCB6626744DB107AF4E8D1BD7B77A7D379EB07E36C36DBAC59B3F2F2F2BCABEB0407073FF5D4533D7AF40070EEDCB90F3EF8202B2BCBE974262626BEF8E28BDE61B4DD6EDFB061C3175F7C515959A9D7EBEFBAEBAE3FFDE94FD1D1D1F27D36B54266282621331493306386B2D9B07D3B1212A0923F478E46B45E743A9D9F9FDFADE7466A6A6AF6EDDBD7A953A7A79F7E7AF4E8D13A9DEED5575FCDCBCBB35AAD13264CF0783C53A74E9D31638656AB9D38716271713180458B167DF4D14743870E9D3D7BF6F8F1E37FF8E18769D3A6D5D4D4C8F5B1D48BDD6E2F2C2C543A0A99B05AADD5D5D54A472107DEAA19A5A39089C2C242BBDDAE741472E06D5639D7EE9488D0502C5D8A9933957CA4E75AD491EED5875EAFEFDAB56BAF5EBD0074E8D0E1A1871ECAC9C93976EC585050D09B6FBEE97D5E253939F9D5575F3D7FFEFCE5CB97B76CD9F2EEBBEF7A5FDFA54B97C4C4C4F9F3E717141470E2A8BB0564866212861542D743CDEA8BB469A37404D74089F6A6545555555555793C9E13274ED4D4D468B5DA7DFBF6DD77DF7D754F85464545BDFFFEFBFEFEFE9F7CF2495C5C5C464606008FC7E372B9929393172F5ECCF06A530D87CC504C4266282661D80CA52C5C5C149A404D4DCD5B6FBDB562C50A8FC773F9F2E5C71E7BAC5DBB76656565F52A2DBDF5B47979793131315E27D4912347962E5DEA76BB351ACDF3CF3F7FD75D77D5DF755515962EC5A54BF07870DF7D78F0412C59026FB9D0830FA2572F2C59824B9700E0A18770EFBD78FFFDA66C7DF0410C1820E5196A286486621232433189AF9BA12A2B61B1A07D7BA86D584E89F6C6180C86214386F4E8D1C3ED769BCDE6F6EDDB3B9D4E93C954AFF8F0E8D1A3818181515151999999B5B5B52693A94D9B3663C68C71BBDD0B162CC8C9C9B941A2D5EB919E8EB838080212136130A053277817B769D5EABF5B01C4C743AF6FFA56754066282621331493F8BA196ADD3ACC9F8FF5EB71FBED4A87F27FA1447B63743A5D972E5DEEBDF7DEBADF180C86F4F4F41F7FFC71F4E8D1DE87EA6C36DBF4E9D3FFF0873F646464AC5AB5EAD4A9535DBA74898E8E8E8E8EBE7CF9726565E58DB5502653FDB1A6743FAA003243310999A198C4D7CD50515178EC3124272B1DC775F8E4D99487EB4BEF468E1C79EAD4A9F9F3E75FBA74C96AB52E5FBEFCEAD5ABBD7BF7EEDAB5EBDD77DF3D7DFAF4FDFBF71717179F3A756AEEDCB9172F5E24FF22C80CC52864866212DF3543555662E3466464E08D37A0C28E2E2F57C046E155335E2FBE494F4F9F3D7BF6A2458BBEFAEA2BAD566B329966CD9AD5AE5D3B003367CE5CB870E1B469D30202028C4663EFDEBDA74C99C24FB5C82D2033149390198A497CD70CB57B375E7E191F7E88962D950EE54650A2BD01E1E1E10B162CB86187BD4F9F3EDDBA75CBCBCB1304213E3EBEAEEC253A3A7AD6AC59050505A5A5A55151513131312487F2525959595C5C9CACC2D91C09B0582CD77E2B18C66B86EAA8D43ADAF2929B9B1B1D1DCD437FD16B86F2C5DBB4E9E9983307BD7A291DC74DA0447B636ED1810D0E0EBEED46F64C9D4E171F1F1FFF5B1512CD1B7B2133149390198A497CD70CD5AE1DDAB5533A889BE37B53040DA1BABAFAD0A1439B366DDABD7BF7E5CB97BDBFCCCBCB2B2929B9F51B0541B0582C1515150D398A2008393939A5A5A5CD0D9769C80CC5246486621266CC506A83C1445B54543471E2C4A953A76EDBB66DDEBC7963C78E3D75EA1480C58B176FDAB4E9D6EF75381CD3A64D3B74E850430EE472B9E6CC99F3EDB7DF8A1034BB90198A49585208FD2ED4ACAAA5BA1A4EA7D2413400D6BE3D1E8F67E1C28557AF5E5DB56AD5A79F7EBA61C386F8F8F879F3E6793C9ECACACAEAEAEA9A9A9A92921287C3E17DBD2008E5E5E5972F5F763A9DDE1F6D365BDDD6EAEAEA9292926BC72876BBBDB8B8B8AAAAAAEEC55EA1B120080E87C3E572D575060541B87E791F0E31994CE1E1E14A472113919191BE759D6A32BC99A138B1BCF99619CA6EC7D4A958B408EA1F81B3763F29373777EFDEBD73E7CEF5AE351B1E1EFEF2CB2FEFDFBFDFE17068B5DAC3870F4F9A34292727A75DBB763366CC080B0B5BBD7AF5E6CD9B054168D3A6CDEBAFBF7EEDB5E3D0A1434B962CB1D96CC1C1C15EC7D3FEFDFB3FF8E083CACA4A3F3FBF89132776EDDA15BFDD8BFDE4934F3C1E8FD96C2E2828183F7EBC46A3D9B56BD7C58B17FFFCE73F737EB396CC504C42662826F12D335471317EFE192929507FC740F5013692ECEC6C0049494975BF494D4D1D376E9C9F9F9FCBE5BA70E1C2934F3EF9C61B6F1C3B76ECE0C183070E1CF8C73FFE3176ECD837DF7CB3A4A464FEFCF9DE31A856AB2D2929F9FBDFFFDEBD7BF777DF7D373D3D7DD6AC59172F5E5CB87061870E1D162C58909292B275EB56AF67D1E572AD5CB972F7EEDDF7DD775F7878F8A64D9B4A4A4A5C2ED7FAF5EB753ADDF559D6E9C481033870004E272C167CFD35CACA6EB0D5E1C099334DDCAAAAB994D0D0D06B9B836D5253536FB1C8314BF06686E2A1E4183E6586BA7C197E7E58BB1663C6281D4A03602DD13A9D4E8D4653AFF2D3BB8EB146A319306040F7EEDD3B77EE1C1F1F5F5151F1EDB7DF6664640C1D3AB453A74ECF3EFBEC891327AE5CB9A2D168B45AEDF1E3C7CBCACA6EBFFDF6AAAAAAAE5DBB5EBE7C393B3BDBDFDFDF62B11414148C1D3B76D2A449DE24BA7AF5EAB973E78E1C39322929E9F6DB6FF7F3F33B7EFC787676B6D56AEDD7AFDFF511DA6C983C199327A3B2129B3763D4289C3E7D83AD361B56AE6CFA56F560B7DB8B8A8A948E4226B82A86B25AAD4A472113454545540CA52A1C0EBCF106264D427030FCFD958EA601B036751C1D1DED70384A4B4BEB165DCFCDCD7DFFFDF7274C98A0D3E9BC737A8220781F72BD72E54A444484F765E1E1E1DE3BB8DEF459595979F5EAD5B56BD77A7FECD0A1435C5CDCDFFFFEF7E5CB97CF9E3DBBA6A6E6B1C71E1B356A94D3E9F4F7F7EFD7AFDFE6CD9BFBF6ED1B1A1A9A9191F1CD37DFC4C5C5A5A4A4DC5050171282F9F3012038188F3C82BBEE425ADA0DB68686E2996730787053B6AA6AE692CC504C42662826F1153394C301BD1E3D7BAA5102754358BB02A6A4A4B468D162E3C68D53A64CF15E08BEF8E28B83070F4E9E3CB92EBF7AD168340909093FFFFCB3CBE5D2EBF5393939818181414141DE97454444B46AD56AE6CC99515151858585DBB76F37994C478F1E7DF5D557838383B76EDDBA68D1A23E7DFA180C86A14387F6EEDDFB89279ED8BC79F3A851A3FAF4E93365CA14BD5EFFCA2BAFDCF04A6430E08E3B7EFD774202EAE5E26BB72627D79776367CAB7A2033149390198A497CC50C15148479F37CE0D66C1DAC25DAA0A0A0575F7DF5B5D75E2B2A2ABAEBAEBB2E5EBCB865CB96975F7E392222A29EAA4910840103066CDEBCF9EDB7DF4E4C4C5CB56AD5C08103C3C3C30541F0783CDDBA758B8A8A9A356B56BF7EFD76ECD8E176BB870E1DBA6EDDBA3D7BF63CF8E083870E1D6ADDBAB5777CACD56A5BB66C397EFCF865CB96F5ECD9B34B972E2693A9BCBCFCEEBBEF56E81CA80B3243310999A198C487CC50BE5506AE9B3973A6D231FCCAE1C3874B4A4A1E7CF0C16B7F999999999B9B3B60C08086D7EE26242474EFDE3D2727E7C489138220FCF9CF7F1E3C78B056AB0D0B0B4B4B4B8B8989D16834919191696969C9C9C91D3A743876EC585656D6C08103478F1E6D3299CC6673C78E1DCD6673B76EDDCE9F3F7FFCF8F1E4E4E4575E79253636363D3D3D3B3BFBE79F7F8E898979F9E597E3E2E22222223A74E8101111D1AE5DBB989818AF7CF1871F7EE8D4A9D3A041832438494DA7ACAC6CD7AE5D83070F9679D13A93C9141A1AAAFE3EB228848585F9FBFBF35067AED3E9F8590E3D3434949F668D8888E0E45ECFAE5DBB8C46E30D2B694447ED27541084929292C3870F37EA5BAED3E9060D1AE472B9743A9D4EA73B7EFCB82008FEFEFE4EA7F3F0E1C300C2C3C3CBCACA0E1F3E6C3018468C18E1F1780C06C3A953A70441888989292A2A2A2828D06AB5FDFBF777B95C0683C16AB5E6E5E569B5DAA14387BADD6EBD5E5F565676E4C891BAFD68349A56AD5A9596967EF9E597C78E1D1B3B76ECB163C7BC45586A40ABD5E6E5E5D53D1F2C2776BBBDB4B4345E35EBE34A8AD56A8D8A8AE26499BCBCBCBCC4C444A5039183C2C2C2F0F0701E4CA22A5F26EFD429ECD98351A3E0734FE6AB3DD1C6C6C6565454BCFDF6DB4A07D220DC6E775959594040C0EEDDBBF7ECD9738B576A341A99571D70B95CAD5BB796FFB97B32433189CF29849A0335AB1A1004FCF39FF8E20B3CF410255AB1B9F7DE7BEFBEFB6E5F5909C7ED76575555050707FFEEF8BBA6A646FEBF5E45729EC964E264260A40646424271F963733142793E4AA354309029C4E3CF924060C409B364A47D378D47E51F02EFBAA74148DA021F34B8220646767272626FAF9F9C91092B290198A49C80CC524AA35439D3881C58B316912EEBD57E9509A84DA132D9368349AD4D4544E863EA1A1A132975F29486A6AAADAAE5012C19B198A9F665567C9F18F3F2233136A9DD5FE7D543745C00956ABB5B6B656E928E480CC504C4266282651AD19EAA9A7B06E9DAA579CBD355C0CAA5488C160E0E1690190198A51C80CC524AA35430507C3A725E2BC5C01D5464444843ABFD0A24366282621331493F88A19CAE7A013AA0082209C3F7F9E9339C6CACACADCDC5CA5A390098BC5525959A9741472E03543291D854CE4E6E6F2D3ACD9D9D92A1100B8DDF8E927B071838212AD0268349A9494141EB4060042424238D11A00484E4EE667993C4E2AC901242626F250498EDF6ADC547253E07FFF174F3C81EDDB958E430C28D12A437E7E3E3FC5508585854A4721135C1543E5E5E5291D854C141616523194FC848763D4283CF080D2718801DDA35506A3D1C84F311427B72D410A2146A1669519B71B9F7F8E56ADF0C61B60E332C9C5B7478598CD66357CA165C0643285FB9C30ADA944464672D2ACBC99A17C4B9BD364546286CACEC6DFFE86BD7B19C9B2A044AB0882209C3B77AEAAAA4AE940E4C066B3592C16A5A39089ACAC2C4EAA66BC6628A5A390098BC562B3D9948E420EBC6628C58BA1E2E2306F1EC68E55360A31A1A96305203314AB90198A49C80C25334141183244D910448646B4CA40662826E1AA188ACC50ECA1AA622896A044AB0C648662123243310999A1E4E1EA555CBDAAD4C1A585972BA0DA2033149390198A49C80C250335359832050E07962E057B8A012EBA696A83CC50AC426628262133940CD4D440A341F7EE0C6659D0885611BC66284E26544342421AB2462F1B24272773D2ACBC99A138992757CA0C959585D252CC9F0F56FF7A6844AB0C64866212AE8AA1C80CC51E8A1443555763FA744C9B0687C387579CBD358CF61F540F99A1988414424C42CD2A297A3D1E78006633C2C2643EB27C50A25506B3D9CC497985C964E264361540646424271F963733142753C78A98A10C068C1923E70115808B6E9ADA203314AB90198A49C80C4534132E7ADF6A83CC50AC4266282621339414B8DDA8AD65B3C6F87A6844AB0C64866212AE8AA1C80CC51E721643EDDC89F1E3C149A124255A652033149390198A49C80C2505870FA3A2027CAC8A4453C70A416628262133149390194A5CAAAB61B5E29557E07482932534B9E8A6A90D3243B10A99A19884CC50E2B26913860D83D58AD858498FA3226844AB00648662153243310999A1C445A7439F3E68D346D283A80B1AD12A0399A19884AB62283243B1873CC5508F3D8679F3101C2CE941D40517BD6F15426628262185109350B38A8B560B3E4EE77FA144AB0C648662123243310999A144C1ED061F67F10670D6AF5007648662153243310999A19ACFA54B98360DA74E89BE63DF808BDEB7DA203314AB90198A49C80CD57CBEFB0E9B3763E850D177EC1BD0885619C80CC5245C1543F163862A2E2EA662A8262308282DC5C081D8B00177DE29E28E7D09DDCC9933958EE1578E1C3972E0C00193C974F2E4C9CCCCCC93274FD6D4D4C4C6C6D6D4D4381C0E83C1505E5E6E341AEB7EB4D96C0683A1B6B6D6E7B6D6D4D4949696868484D8ED76F54425D15600151515DE3BB5EA894AA2AD0505052121216EB75B555149B1D5FB024110541595145B4D26D3952B57341A4D404080CC51D9ED76A7D3A9D7EBCBCACA8C46637575B5D3E9D4E974DEA8A4D85A5A5AEA76BBB55AADCBE51265CFB5B5B5C78E399F7BCE101A6ABBFF7E53757595CC9FA86EABCBE5BA74E9D2575F7D95999999999979EAD4A9DDBB77B76CD9B26FDFBE32643715CD5E6AB5DAC2C2C21F7EF8411004008220381C8E4E9D3AD96C3697CB6532998A8A8A0203032B2A2A1C0E87C9642A2E2E36994C3EB7D5CFCFCF66B3E9743A9D4E575454141010A086A8A4DBDAB2654BAD56EBFDF6AB272A89B63A9D4EAD56ABB6A8A4D85A5B5B1B1616565858E8FD3EAB242A89B6EA743ABBDDEE76BBE53C6E404040696929006F072E2020A0ACAC0C80D96C2E2828080C0C94626B7171717C7C7C7979B9D7C5D8FC3D9797979F3E0D8FC7DFCFAFC4E552E013D56DD5E974DEFCE27DDC43A3D1141414C8F6E887C69BD5D4C0D2A54B333333972D5B569768592DA91704E1F4E9D30909093C981CCACBCB8B8B8B939393950E440ECE9C3913171717CCC113820E87E3DCB9731D3B76543A1039C8CACA8A8E8EE6C124EAAD7113F736ADDB8DF2728487430DCF337A3C9EBA44FBE28B2F060505CD99334786E3AA68440BA0EE14D4FD9F49341A0D3F0A21AECC504949499C342B99A198440A33944E87880811F7D72CAE1DBCC99962D81C32AA1F3243310957C5506486620F3997C9E30A4AB4CA406628262185109350B3361687039F7E8A23479ABF2746E0E2DBA342CC663327D72993C914CEC952584064642427CDCA9B19CAC4C7BAA96299A18E1FC71B6FE0D021518262014AB40A40662856213314939019AA51389D484EC6C28578F451B1E2F279B828DC501B648662153243310999A11A4E4505DE7803B7DF8ED1A3458CCBE7A111AD3290198A49B82A86E2C70C55545444C5500D2427077BF742350F8DAA052E06552AC46030F0530CC5C9D81D80C160E0A76A8693411E00BD5ECF4FB31A9AB7AA585A1A366F4674B4581131022F5740B5111111D1CC2FB4AF60341A7978D2DF4B78783827C5505AAD36323252E928642234349493BF566FB336A757A1D3212141C48818818B6E9ADA1004E1FCF9F39CCC31565656E6E6E62A1D854C582C164E8AA19C4EE7F9F3E7958E4226727373F969D6ECEC6C2996C9E31C1AD12A8046A3494949E16442952B33143FC22F32433149D3CC508280DDBB111E8E6EDD248ACBE7A111AD3290198A49B82A862233147B34AD18EAC205BCF20A366F0619A56E0617BD6F15426628262185109350B3DE02B71B6633A64CC1DD77838F93D41428D12A83D96CE6A4BCC2643271329B0A20323292930FCB9B198A93A9E3C69AA16A6B317F3ECC668C1B4759F656D0B951003243B10A99A19884CC5037C36AC5962DB87285B2ECEFC045EF5B6D90198A55C80CC52464861063DEE80000200049444154BA19AD5B63CD1AC4C64A1A140B503F4419C80CC5245C154391198A3D1A5B0CA5D321250521219206C50294689581CC504C42662826213314D14C78B902AA0D3243310999A19884CC50F5387C181A0DEEBC539EA058808B6E9ADA203314AB90198A49C80C752D85859830011F7C00A753B6B87C1E1AD12A0099A15885CC504C4266A86B090EC6B871E8D2057C0CF2C58146B4CA40662826E1AA188ACC50EC71EB62288F071F7D84356B30660CBA76953934DF8612AD3290198A494821C424D4AC5E8A8AF0F1C738774ECE8818818B692E1542662826213314939019CA4B4C0C962F474C0CF8381962C245374D6D90198A55C80CC5246486F2A2D5A2634770D3BF12132E7ADF6A83CC50AC42662826213314D14C6844AB0C64866212AE8AA1C80CC51E372C863A7102478E4010940A8A0528D12A0399A19884CC504CC2B319AAB818132660C9127A6AB659F07205541B6486621232433109CF66A8C0408C1C892E5DC0C7F75A2AB8E8A6A90D3243B10A99A198844F3354DD53B34F3F8D8C0CA523F3716844AB0064866215324331099F66A8A222AC5A85EEDD958E89096844AB0C64866212AE8AA1C80CC51ED71643799F9A7DFD757A6A5604B8E87DAB103243310929849884CF66D56A919EAE6C38EC40895619C80CC52464866212AECC505151519CF42AE4844EA80290198A55C80CC524FC98A19C4EE7C68D593FFD74AB65F28826C045EF5B6D90198A55C80CC524FC98A1CACBF5CB97DF9690A0EDDC192693D2D130048D689581CC504CC255311499A1D8C36874DF734FFEF8F11ECAB2E2C2C5A04A8590198A49C80CC5243C98A15C2EAC580140F3E73FEBE3E2948E863918FFF6A8163243310999A19824343494F9662D28C0679FE1E2456D787818F3BD0AF9A113AA0064866215324331090F66A8962DF1F1C778F965674ECEF99B2D934734195EE6F4540599A15885CC504CC283194AA743FBF6008C9191BC14F4C9098D689581CC504CC255311499A1D8E386CBE411CD8712AD3290198A49F85408310FABCD2A08F8F24B1C3AF4DFDF70D5AC72C2E0B7C727309BCD9C7CA14D26537878B8D251C84464642427CDCA9B19CAC4E2F32E172EE0D557B165CB7F1775D7E97466B399C95E85B2D00955003243B10A99A19884493394D389C8484C9982F1E35137B9E67038CE9C3943C550A2C345E186DA203314AB90198A49D83343555460D62CDC761BC68CC1B5B7B08C46635A5A1A631F560DD0885619C80CC5245C15439119CA77B974097BF6C0ED46BD42112A8692082E06552A84CC504C4266282661CF0CD5BE3D366F466C6CFDDF6B341A4E443A32C3CB15506D90198A49C80CC524A1A1A18CFDB5EA7468D3E606BFF7362B63BD0A3540275401C80CC52A648662121ECC505E9C4E677676361543890E8D681580CC50AC4266282661C30C555B8BD5ABD1A913BA75BBE96BBC356E0C7C58B541235A652033149370550C456628DFE2E851CC9A85A3476FF51A2A8692082E7ADF2A84CC504CC2AA42E87AB8520831D0ACE5E5484DC5B265E8D9F3562FE3AA59E5C4B7BF3DBE0B99A19884CC504CE2EB66A873E7F0C413D8B70F0307E2D68589648692083AA10A4066285621331493F8BA192A3F1FD5D5377898E77AC80C25113475AC006486621532433189AF9BA17AF5C2EDB7A321F34A648692081AD12A0399A19884AB62283243F90A5A2D2222EA4BA06E0815434904255A652033149390198A497CD40CE57436FA2D64869208DFFBF6B00199A19884CC504C121A1AEA73CD7AF62C264EC4C9938D7B1799A124824EA80290198A55C80CC524BE6886FAF65B7CFF7DA307B5648692085EE6F4540599A15885CC504CE25B66A8DA5AE4E763F870F4EE8D9494C6BD97CC501241235A652033149370550C45662875B279331E7E18172F2235B5410550D742C5501241895619C80CC5240C28841A08570A21DF6A56AD16BD7AA16DDBA6BC97AB6695132EA6B95488D96CE6A418CA643271329B0A20323292930FCB9B19CA8766531F7904C386A1695717324349049D5005203314AB90198A497CCB0CA5D53631CB82CC5092C145EF5B6D90198A55C80CC524EA3743391CA8AEFE1D8F714320339444D0885619C80CC5245C154391194A3D7CF209C68D43F3FFCEA8184A2228D12A0399A19884CC504CA2723394D389AC2C4445A1F93347648692085EAE806A83CC504C42662826090D0D55ED5FEBB973282EC68C1900D0FCE7D5C90C251174421580CC50AC4266282651AD19AAAA0A53A7E26F7F83DB8DE060117648662889A011AD0290198A55C80CC524AA3543198D78F8614445212C4CAC1D92194A126844AB0C64866212AE8AA1C80CA5380603468EC4FDF78BB6432A8692084AB4CA40662826F12D855073E04A2144CD4A3413DDCC9933958EE1578E1C3972E0C00193C974F2E4C9CCCCCC93274FD6D4D4C4C6C6D6D4D4381C0E83C1505E5E6E341AEB7EB4D96C0683A1B6B6D617B76AB55A7F7F7F9BCDA6AAA8A4D86A3299044170BBDDAA8A4AA2AD2E97CBDFDF5F6D5149B4352828A8AAAA4A6D5149B155ABD57A3C1EF98F6BB7DB9D4EA75EAF2F2B2B331A8DD5D5D54EA7D360306465B96A6B755A6DD5F55B753A5D7979B9C964BAE17B1BB2352424C4E17048B16765B7BA5CAE4B972E7DF5D557999999999999A74E9DDABD7B77CB962DFBF6ED2B437653D1FD24AD565B5858F8C30F3F08820040100487C3D1A953279BCDE672B94C2653515151606060454585C3E130994CC5C5C52693C9E7B6FAF9F99597979F3C79F2CE3BEF2C2E2E564954126D2D2929090A0A3A77EE5C7272B27AA2926EEB912347BA76EDEA72B9541595145B2B2B2BCBCACA828282541595145B838282CE9E3D1B1010D0AE5D3B398F1B1010505A5A0AC0603014141404040494959569B5DA9212FD638FD5DE738FE195574A0D06CDB55B0198CDE6828282C0C0C0EBDFDB90AD972E5D723A9D5151517ABD5EDC3D2BBE55A7D379F38B772A51A3D1141414C836ADA8F1663535B074E9D2CCCCCC65CB96D5255A86A76B5C2E974EA7E361F6D83B9CE5A444889F6605E01D5D291D851CA8AA592F5FC6BC7978F041F4EA25C9FED96E568FC75397685F7CF1C5A0A0A03973E6C8705C7565B2BA53A0D16818CEB2E0AC188ACC50EC416628F9A9A9C1D2A538710273E6E0DE7B253904F3C5505AADD69B5FF05BBA91E9B8B21D89B8160399A158C440662816518919EAE449CC9F8F9327A1D3357AA1D90642662889E0E50AA836C80CC524648662129598A1D2D2F0D967484F97F010648692083AA10A4066285621331493A8C40C1510809E3D111222E121C80C251134A255003243B10A99A19844B56628D121339444D0885619B82A862233147B90194A1EAE5CC1C71F43B633CD7C31945250A255063243310929849844C166DDBC19D3A7E3DC39990EC755B3CA0917D35C2AC46C36ABA1BC42064C261327B3A90022232339F9B03A9D2E2A2A4AE92864223C3C5CFED954B71B361BFAF6455C1CFEDFFF93E9A03A9DCE6C3673D25994133AA10A2008C2B973E7AAAAAA940E440E6C369BC562513A0A99C8CACA5243D58C0C381C8EB367CF2A1D854C582C169BCD26F341B76FC7C89170BBF1E083906D90E97038CE9C3943C550A2C345EF5B6D68349AD4D4544E863EA1A1A14141414A472113A9A9A99C149278AB66948E4226929292646E5641C0850B88884044849C8785D1684C4B4BE3E43B2C2734A25506ABD5CA4F311499A1D883CC5092A2D1E0F9E7B16C19CC66390F4BC55052C1C5A04A8590198A49C80CC5248A98A14C26984C321F93CC5052C1C545418590198A49C80CC524A1A1A1F234ABD30965E7B9C80C251174421580CC50AC4266282691C70CE57462C102FCF5AFA8A991FA50B78881CC5092C0CB9C9EAA203314AB90198A49E431435555E1C001B46F0F05A7E4C90C251134A255063243310957C55064861291E3C761B562F9724C9B0605EF2951319444889F685D2E97C3E150CF7AF2EA84CC504C4266282691BA592F5EC4D34F63D932444440D947E1B86A563911739AABB0B0F0934F3E3972E4486D6D6D5252D2C8912333323244DC3F4B90198A49C80CC524529BA14242307A347AF786E2DF1D324349846827D46EB74F9B36EDF0E1C383070F7EEAA9A74C26D35FFEF297CCCC4CB1F6CF126486621532433189D466A8F070BCF492B40BCD361032434984683D288BC5525858F88F7FFCA375EBD600860F1F3E69D2A4AFBFFEBA43870E621D8219C80CC52A64866212F9CD504A4166288910738A4010847AB766E9A6FACD2033149370550C4566A8E6505383FDFB21BB41F977A0622889106D50D5B66DDBB8B8B88913270E1932C4DFDFFFD8B163478E1C193D7AB458FB670C3243310999A198440A33D4B66D78FD752C5F8E071E1077C7CD82CC501221DA15302020E0CD37DFFCECB3CF76ECD8515B5B9B9292F2CE3BEF74EAD449ACFD330699A19884CC504C121A1A2AE25FAB20C0ED465212264CC0DD778BB5577120339444887942C3C2C2BA76EDDAA14387DB6EBB2D3D3DDD7BB396B81E3243B10A99A198445C33D477DFE1F9E7D1B225264E84DABAA064869208D112ADCBE57AE79D77A64E9D5A5252A2D168D6AD5BF7CC33CFF073856D145E3354404080D281C8414848486262A2D251C8447272727070B0D251C8016F66A890901051762508F8EA2B6467439D378EC80C2511A2255A8BC5F2F5D75F2F58B060E9D2A573E7CE5DBF7E7D6060E0175F7C21D6FE1983CC504CC255311499A19A8046834993F0E9A768D95294FD890C1543498468F7681D0E476464647272B2F7C7B0B0B0B66DDB72924B9A0099A19884CC504C226EB3AAF9D63657CD2A27A27D7BDAB66D1B1515F5DE7BEF9D3871222B2B6BF5EAD5070F1E4C4949C9CDCD2D2A2A2223633DCC6633275F6893C9141E1EAE741432111919C949B3F2668632356F6D58B71B3E71DF93CC501221DA88D6ED767B3C9E4D9B367DF3CD3746A3F1EAD5AB8220CC9933C7E3F1DC79E79DB367CFE6E4966443F09AA1DAB469C383C9C166B315151571723F2F2B2BAB55AB5662DDCF53335E3354BA1A6C46D263B158626262C2C2C29AF6F6DA5ABCFF3E4C263CFF3C549EC2BC66A88E1D3BD26D5A7111F3F19E1933664C9932C53B78F5CE8BBA5C2E4110020202FCFCFCC43A100390198A55C80CC524CD3443151763D326753D2F7B33C80C2511A25DEB753A5D6D6DEDF1E3C7EB4AC3B55AED7DF7DDC7CFFC52A3B05AAD3131313CF43FEC767B5959595C5C9CD281C881D56A359BCD3C4CDE78CD500909094A0722074545456161614D5856591070F4286263B17A356262D43E9CC56FC550090909347B2C2EA225DA929292175E78C1ED769BCD66EFA0D66030A4A7A753A2BD21648662123243314993CD50870FE38927F0C20B983041F4A02481CC501221DA15303F3F3F303070C99225515151DEEA70AEFE141B0B99A19884CC504CD2643394D98CA79EC2D0A1A247241564869208D14E688B162D2223232F5CB8507D0DF43CD60D213314AB90198A499A6C866ADB167FFD2B7C687E9DCC501221DA88D6FB60C3A851A3EA1EA535180C73E6CCE9D8B1A358876006AF198A9309D590909026DCDCF251929393396956DECC504D9E9CF3AD1B4464869208D12E0AD9D9D93FFFFCF3D4A953939292BCF768B55A6DAB56ADC4DA3F63E4E7E7C7C6C672520C555A5A1A1F1FAF74207260B55AA3A2A2382986CACBCBE344AE595858181E1EDEC0FE625111CE9EC55D77C117EF2150319444889668054168DBB6EDB061C39AFCB4195790198A49C80CC5240D6F56970B6FBF8D3D7BB06D1B7CB113C255B3CA89688936212121383878FEFCF977FFB6F29356ABCDC8C8E0C70AD428CC663327C55026938993D954009191919C7C58DECC500D994D75B9E076A3674F6464C047972E2333944488698602B077EFDE63C78E011004C16030C4C7C753A2BD1E3243B10A99A198A4216628A7130B17A2AC0CD3A7C377EF0891194A22444BB4DEE16C6565E5952B578282824C2693BFBF3FCD42DC103243B10A99A198A42166A88A0AECDD8B4E9DE0D37FD66486920831BF14478F1E5DB468D1D9B3671F7FFC714110C2C3C3478F1ECDC90469632133149390198A491A62868A88C0871F2238D8B7132D154349846867F3EAD5AB6FBDF5D6EDB7DFFED8638FD5D6D6F6ECD973CD9A35FBF7EF176BFF8C416628262133149334D00CD5A2057C7DEE86CC501221DA45E1D2A54B7ABDFED9679F4D4848D068343D7AF4E8D7AFDFD1A347C5DA3F6390198A49C80CC524A1A1A1376C564140793958B2F290194A22443BA1212121D5D5D5172E5C00A0D168AAABAB2D160B5542DD103243B10A99A198E46666A883073172240E1C903F22A9203394448836A7979898F8C0030FBCFAEAAB7ABDDEE170FCF2CB2F1E8F67E0C08162ED9F25C80CC52A648662929B99A17273E1F1202242FE88A482CC501221DA4541A3D13CF7DC739D3B77FEE9A79F1C0E479B366D1E78E001B3D92CD6FE1983CC504C42662826B9DE0C75F62C8E1DC3830FE27FFE072C197AA8184A2244389B67CF9E5DBB76ED952B573EFFFCF3E3C78F9B4CA6E0E0E02B57AEAC5BB72E3F3FBFF9FB67123243310999A198A45EB33A9D78F75DCC9F8FCA4AA6B22C386B56391161445B555565B55A1D0E476E6EEEC58B17EBBE917ABD9E93DB904D80CC504C42662826A967863218306E1C3C1EB46CA96050924066288910E1A2101C1CDCBD7BF7162D5A4C9932A5F97BE3013243B10A99A198E47A33D45D7729188E8490194A224448B4870F1F3E78F0E03DF7DCD3FC5D710299A15885CC504CE2354309828FAD79D704C80C2511E24C1178D7C513AE43949D3389D56AADADAD553A0A39B0DBED4545454A47211356AB9593DB255E3394D251C84471717151917DF162FCF083D2A1488CB718CAC3D2A3C1EA408441954EA7FBFEFBEF9F79E6997A9955AFD74F9C38B16E1D78E25AC80CC52464866212A3D1F8E38FDAF7DEC31B6FA0674FA5A39112324349840857404110FCFDFD636363AF4DB48220E8F57A2A60BB19648662123243B187C381C2C2881E3D349F7F8EDB6F573A1A89213394448890683D1E4F4646C6DFFFFEF7E6EF8A13BC66A8366DDAF06072A8ACAC2C2E2EE66462C362B1C4C7C7F3500CE5354375ECD851E9402467DD3ABCFDB6F0F1C79ADF16DA6619AF198A6ED38A8E38737A9CCC828A0599A15885CC50EC111C8CE1C37569694AC7210BFC98A10408D5BAEA40C8746912618AE0CE3BEF1C3E7C78F3F7C315F9F9F9FC14431516162A1D854C70550C959797A7741472F0F0C318372E5FABAD523A1039E0A418AA0C657331774BD016AD4EA64972117ADF292929292929CDDF0F5790198A49C80CC524FEFE1CD5B8B1DDAC02844338340BB38EE0887FADBFC628D345988B692E15426628262133141BFCF4138282D0A1C3AF3FD63343310CDB66281B6CABB06A3EE6C722761556EDACD9E9D6C9B44E119B2754E578CD5055555C4C46D96C368BC5A2741432919595C5C932795E3394D25148C2C993183306EBD7A3EE290A8BC562B3D9140D4A26BC66282697C93B81134FE1A959983504433663F3400CD4CB38CEE4A2F7AD36C80CC52A6486F26904011515888AC2B3CF62D0A0FF7AA0BC66284543930926CD5095A85C8DD5F3302F18C11FE2C341186484DCD3E334A255063243310957C550EC99A17EFC112346E0F469BCF412AE5D00B0A8A8C86EB72B17977CB0570C751AA79FC133D330AD377A6FC6E66118267F96058D689582CC504C4266289F2637177A3DE2E2EAFF5EAFD7F3D3ACCCD48E54A37A0336CCC66C2DB48BB0683886FB41B1F5BF79B902AA0D3243310999A17C9A61C3D0BF3FC2C3EBFF3E34349493BF5666CC50D9C89E8BB95BB17520064EC1943428FC1CB4CF9F505FC46B86E2648EB1B2B232373757E92864C262B170520CE53543291D85C8180C37C8B200727373F969D6ECEC6C9F2E86AA41CD5AAC1D8AA1DFE3FB3998B31CCB15CFB2A011AD2290198A55C80CE573141642AF87D97CABD7242626B2374F7E437CDD0C9585AC7998B7055BEEC7FD5331B5133A291DD1AFD0885619C80CC5245C15433160862A2CC41FFF8877DEC1ADAB7F0A0B0BA9184AE5D861FF0C9F0DC5D06FF1ED5CCCFD081FA927CB8246B44A416628262133940FE17241A7437A3A1E7C10B76E346A56957306676663F64EECEC8FFE5331351DE94A47541F4AB4CA40662826213394AF909585F9F3F1F4D3983BF7F75F4C6628D562877D0336CCC11C00EFE1BD47F1680002940EEA06F8CC0965093243B10A99A17C85A34771E204349A5FFFBB3564865227A771FACFF8F3444CEC866EDBB06D2CC6AA33CB8246B48A40662856213394AF306408EEBD172D5B36E8C56486521BBE3290AD8346B4CA40662826E1AA18CAA7CD50FEFE0DCDB2203394CAF805BFFC097F9A888919C8D88AAD6A1EC8D6C1C5A04A8590198A49C80CA5664A4A6030202CACD16F2433944A2847F967F86C2116FAC16F3EE63F8247D49F62BD70F1ED5121648662928888085F2CDA6C023E6786CACBC3983158BCF8BF6BF2349CB0B030AE9A5585BD0A01C24FF8691446FD0D7FBB1FF76FC3B63118E32B5916806EE6CC994AC7F02B478E1C397AF4686464645656567676767676764D4D4D5454544D4D8DC3E130180CE5E5E546A3B1EE479BCD6630186A6B6B7D6E6B7575F5C993274343436B6A6AD41395145B2B2A2AEC76FB850B17424343F57ABD4AA2926EEBE1C38783838301A82A2A29B65656565EB870C16432A92AAA1B6EB5D96C3A9D3137B7E6E041C7238FE823222AF47A7DC3F7ECE7E7979999E9F178424242CACBCBE5FC4476BBDDE974EAF5FAB2B232A3D1585D5DED743A753A5D7979B9C964127DAB5EAF2F2929C9C9C9F1F7F777BBDDB21DF7D65B0D0643BE237F997ED944F744A7D3F98EE69DD1E5A35BF9B5F2BEB8E17B76B95C8585853FFEF8A337B9582C96DDBB77C7C4C4F4EDDB5786ECA6A2393DAD567BFEFCF90D1B360882004010849E3D7BA6A6A6DA6C3697CB6532998A8A8A0203032B2A2A1C0E87C9642A2E2E36994C3EB7D5CFCFAFA2A2223A3ADA6432E5E4E4040404A8212A89B6161515C5C7C7474646969696464747AB242AE9B6868686FAF9F9A92D2A29B6D6D6D6262727E7E5E5A9FCF3FAF9F9EDDB57F4E597FEC38757BCFDB6333EDE949353D4AA55AB46EDD96C36BBDD6E97CB25E7270A0808282D2D056030180A0A0A020202CACACA0098CDE6828282C0C040D1B7EAF5FACB972FB76BD7CEFBA36CC7BDD9569BCDE6826BAF7EEFE4CAC905A682475C8FFCA9EA4FB705DD965D901D1610D6D83DEB743A6F7EF1DEB3D36834595959E9E9323D71AB119A3093220D4B972E3D79F2E4D2A54BEB6EC5EB743A566F645EBC78312626C6CF4FB1D52464A3AAAAAAB4B4343E3E5EE940E4E0D2A54B66B33920C06766B49A8CCBE5CACDCD4DBC763139B5B264093EF904AB56A153534D41F9F9F96161613C9844BDCD9A9090A086D9E302142CC2A24FF0497BB49F82297DD1B7994BB50B8250F7E49256AB7DE9A597828383E7CC992346B0BF838A46B400B4BFA174209263E0A9188A93FB5BE0AC18CA579A75E4480C1880A4A4A6EF819A55669C707E892FDFC25B9770E9793C3F1EE3A311DDFCDD6A349A6B0B33E56C5375255A7E2033149390194A8544442022A2597B2033949C64216B01166CC4C66EE8361FF3EFC25D5ADF2FDAF5F90FE08B90198A55C80CA512AC5688F83C3399A1E4A112951FE3E3A118FA25BEFC2BFEBA066B7AA007035916946815C16B86E2E1960F80D0D0D0A4E64CDBF914A9A9A9DEAA63E651B319EAE851FCE10FD8B041B41D26252571F2889A52662801C2511C1D8BB19330A9333A6FC3B60998108E1B2D0EEC9B50A255063243310999A1144710E0F12025059D3B8BB64F324349CA655C7E1B6FFF017F3887734BB0640556A86A853B51E0E27E920AE1AA188A93DB96E0AC6A4685B72DBFFB0E5F7C814993B0722544ACE921339444B8E0FA16DFCEC6EC4C648EC2A897F0521BB491EDE872C2CB15506D90198A49C2C3C3D550B429032A3443B9DDD8B1039999F078C4CCB20042434339F96B95D30C95839CC558BC1AABD390B6166B7BA19701CC9E642EBA696A431084F3E7CF7332C7585959999B9BAB74143261B158382986723A9DE7CF9F573A8AFF834E87C993F1C92768D142E43DE7E6E6F2D3ACD9D9D952174355A37A2DD60EC1904DD8F42A5EDD888DFDD08FE12C0B1AD12A8246A3494949E164423524248493B22F00C9C9C99C34ABD1684C4D4D553A8AFA48F4C0516262A20AE7C9A5C05BE326DD871520FC8C9FE761DE97F8B20FFA4CC6E42EE8C2465DF1AD61FF13AA93FCFC7C7E8AA10A0B0B958E4226B82A86CACBCB533A0AB8DDB058E070487B94C2C2422A866A3E5770E53DBC3714434FE0C47B78EF137C7207EEE021CB8212AD52188D467E8AA138B96D09C06834F25335A38666DDB913438762EF5E698F42CDDA4C9C707E85AF1EC1236FE3EDC118BC1DDBC7604C207899E8024D1D2B0599A19884CC50B2E1764310A0D7A3674FDC769BB4C722335473B0C0B2188BD7626D47745C8DD57DD087EDDBB137848B6E9ADA203314AB90194AAEA3E3830F30752AEEBD178B16212E4EDAC39119AA69784D4F8331782BB6FE057FD9800DFDD19FC32C0B1AD12A82D70CC5C9D027343434282848E928642235359593A18FB266A8CA4A7CFD359292A0D389FC24CF0D494A4AE2A75945314379E0398CC3EFE09D6FF1ED0378E035BC763B6ED7808B9B65378446B4CA40662826E1AA184A4133544404962DC3CC99906741423243358A4214BE89378763B805966558B6022B3AA333CF591634A2550A3243310999A16443F487656F0199A11A480D6A7661D73B78C702CB688C7E012FB4422B11C3F35D78B902AA0D3243310999A1A4E3F265582CE8DA15F277DBC80CF5BB781F905D80053BB1F32EDC3507737AA26733D76967092EBA696A83CC50AC42662889A8A9C1E4C978F1451417CB76CCFF4266A85B5384A279983704438EE0C8DB78DBEB53A42C7B2D742E1480CC50AC42662829282D855E8F5EBD3060006263E539E6FF81CC5037A30635FFC17FE6619E05969118F9025E4844A2A411FA2834A255063243310957C550F298A12E5CC0A85158B9124F3E8961C3A0C8AD5232435D8F77AE783CC63F8DA7C311FE393E9F877994656F0617BD6F1542662826218590E85456C2CF0FE9E9321CEAA650B3D6A304252BB17239960722702EE68EC0881084C8109EEF42895619C80CC5246486129D8E1DF1D967323DC67333C80C5587B7AEF85DBC6B81E5093CF13C9EA7516C43E0A29BA636C80CC52A6486121D8D0681815076F687CC50000408C770EC693CFD27FC291CE1EBB17E2EE652966D205CF4BED50699A15885CC50CDC7E9C48E1D888AC23DF748B1FBA64066282BAC2BB0E2237C1486B0B7F136CD1537161AD12A0399A19884AB622889CC50999978ED35ECDE2DC5BE9B08CF66A82A54ADC19A2118B21CCB476282D988B10000200049444154E44EEC1C877194651B0B17832A154266282621335473282FC72FBFA07D7B2C5B863BEE1077DFCD824F33941BEE8338381FF3BFC377BDD17B3116672043072E46F6A2C3CB15506D90198A49C80CD5643C1E2C5C88B56BB17123FAF71771C722C09519CA5B0C750117FE817FFC13FF8C47FC122C198CC15C2D1F2B3A5C74D3D40699A15885CC504D46AB454606A64D835C1A8C46C08F19CAE5721D3E77F803D7078330683DD63F87E7FE857F3D8EC729CB36131AD12A0099A15885CC50CD61C00071F7271A9C98A19C707EAFFF7EEE6D734FE84F0CC08057F04A1774E17CD51DB1A011AD3290198A49B82A866ABE194A10E0133546CC9BA13CF0FC8C9F5FC00B8FE3F1627BF1479E8F5660455774A52C2B1694689581CC504C420AA146F1F5D718370EB23C8EDB2CD86ED67CE4CFC2AC4118B4177BA70BD3D7D7AE1FA219E2073FA5E3620A2EA6B9540899A19884CC500D441000E0E8515CB9A2C0B2778D8555335439CAB760CB622C2E46F11378623CC6B7D5B4758639391903C809B3DD34354366285621335443B0DBB16409366FC673CF61F56A2425891B9AF8B0678672C0B11BBB1FC5A393302915A95BB0652EE62621C9E9749E3E7DBAB1CBE411BF8BEA3B932C4266285621335443B058B07C39468EC4B06108F105F3014B662801C22FF86511166DC7F634A4ADC4CAFEE8EF0F7FEFD69B99A1886642235A652033149370550CD56433546A2AD6AEC584090A1B8C1B0E3366A85CE4BE89370761D08FF8713AA66FC196A1185A9765D19865F28846C1C5A04A8590198A49C80CD5100C0674EA246E38D2C28019EA0AAE6CC2A625587205574661D4B378F686EB015C6B86224484972BA0DA203314939019EA86783C38781066335252240D4A2A7CDA0C5585AA7FE3DFEFE3FD3338D31FFD5FC48B77E08E9B9914BDCDEAEBBD0A1542275401C80CC52A6486BA21C78EE1A9A7B06E9DA41149888F9AA11C70ECC19E9118F92C9E0D46F06AAC5E8995B7F6153B9DCEECEC6C2A86121D1AD12A0099A15885CC50F5A8A8404101E2E23071221E7A4886B824C1E7CC501E78FE17FFBB044B7660471292DEC7FB0FE1A16004FFEE1BBD356EBEF5617D021AD12A0399A19884AB62A8DF3543B95C78F34D3CF9249C4E3CF71C5AB7962734F1F12D33D4399C7B1DAF0FC6E09FF0D30CCCD88EED8FE3F18664595031946470D1FB562164866212B61542D7D21033944E8776ED90988898187982920A5F69D60214ACC19A0FF1A1038E71183716631390D0A83D8822FC22AE8712AD3290198A49C80C752D1A0D9E7EFAD77FF834EA374395A2740BB62CC3322BACC3317C3CC677408726988A753A9D77993C2982E4193AA10A40662856213394CB856B4F8046E3F35916EA364355A16A2BB63E8C875FC7EB2948D9844D0BB0A0233A366D3D0087C371E6CC192A86121D2E7ADF6A83CC50ACC2B919CAE9C4E2C5C8CCC4820560E9912E759AA11C70FC881F1763F15EECED866E9FE0937EE8D7CCC500C80C251134A255063243310957C550F5CC502E176A6B919909B3198CDD15519B19CA03CF711C7F16CF3E8A47ADB02EC4C2CFF1F94378A8F94BEE503194447031A85221648662126ECD5067CE60C1028C1E8D850B6134C28FAD35D6546586CA46F687F8701DD68520642AA68EC4C828347D19A57A90194A2278B902AA0D32433109B766A8A34771E810468EF48D45021A8B4ACC505658FF897F7E8C8F6B50330EE3C6604C1BB411F710648692083AA10A40662856E1D60CF5873F60C70EF4EAA5604412A2B819EA322E2FC5D28118B8100BEFC7FD3BB1730666889E65416628C9A011AD0290198A55B835430504202040C170A4454133D4155CF917FEF5113ECA46767FF45F8AA5DDD15D2FD9759BCC501241235A6520331493F0530C959787152B349C54B92962862A47F9E7F8DCFBDC4E1CE2D663FD4AACEC899ED265595031946470D1FB5621648662125F5108359F8F3FC6CA95FA2E5D7CDEFAD410646ED64A54EEC6EEA5587A0227EEC6DD6BB0E65EDCDBFC8AE28640662889A044AB0C64866212E6CD504E27BEFE1A919178F451E1EEBB6B3332D82A2FBE09B299A1ECB0EFC6EEE5587E0887BAA1DB2AACEA833E4190EF3174324349049D5005203314AB306F863A7102CF3D879D3B9190E08C8DCDE6E45E9E0C66A81AD4ECC6EEA7F0D4388CAB46F5122CF91C9F0FC66039B32CC80C25192CF7BE550B99A158857933546A2A162DC25D77C1646AD032796C20A919AA1AD5FBB0EF437CF83DBE4F42D27B786F288686429927E2C80C251134A2550632433109F3C5502121183C18D1D1373043318C446628071C5FE3EB27F1E41378220F7973317707768CC668A5B22CA8184A32B81854A910324331097B66A8DA5AFCF0033A764474F4FFF97D3D3314DB886E8672C07108875660C52EEC6A8BB67331770886986116F1104D83CC5012C1D445C18720331493B06786DAB409A346E1BBEFEAFFBE9E198A6D424343C56A56071CFBB1FF4FF8D3700CCF44E66CCCDE811DE3304E0D59166486920C3AA10A4066285661C90C75EE1CCE9C41D7AE78EB2DFCCFFFD4DF5ACF0CC536A298A1AE4DB1BFE097E998BE133B9FC6D3229A8A9B0F99A1248297393D554166285661C60C75F122468F465A1AFEF10FDC76DB0D5E50CF0CC536CD3443D54D14FF07FF698996D331FD613CDC022D448C502CC80C251134A255063243310933C5501111183912CF3F8F9BCD987AAB66E40D4A319A6C86BA7E14FB6FFCFB793CAFCE2C0B2A86920C167ADFBE0899A1988419335470305E7CF1562FE04A21D48466AD41CD3EECFB181F7F836F543E8ABD16AE9A554E28D12A0399A198C477CD502E178E1F476222CC0D2BCAD1E97451512ABAB928298D3243D57B2EF66FF8DB100C8945ACA4118A0599A124824EA80290198A557CD70CF5EF7F63F870ECDCD9D0D73B1C8EB367CF4A19918A68A019CA6B77AAF75CEC788CF7952C0B324349864FF6BE7D1D3243B18A2F9AA1B2B2E072212909132660C08086BECB5B3523655C2AE277CD5095A8FC1EDF7F8C8FBDA358F53C17DB58C80C25115C5CEB5588D56A8D8989F1F363DFC96EB7DBCBCACAE2E2E2940E440EAC56ABD96C0EF09DA559BDD5C5C9C9F8F04374E8D088377ACD500909099285A6228A8A8AC2C2C26E583C6F836D0FF6ACC08A43389486B4B9983B188355F5C44EA3F01643252424D0ECB1B850A2550632433189CF99A1C2C3F1E8A3E8D9132653E3DE4866A8CBB8FC15BE5A89953FE3E774A42FC1920118A0A03D5114C80C2511BC5C01D50699A198C4E7CC5021219830A1296FE4CD0C75ED5F6B210A7762E72AACCA467606325660C57DB82F0C610A462816648692083AA10A4066285651BF19CAE1C08103282969EE7EF834435DC4C58558380003A6615A2BB45A83359FE3F3A118CA46960599A1248346B40A4066285651BF196AFB76BCF20A66CFC6934F366B3F5C99A112DA24E4E8729660C91AAC2943D9FDB87F11166520C30FACD55890194A22547D516098FCFCFCD8D8584E8AA14A4B4BE3E3E3950E440EAC566B5454940A8BA10401C78F43AF475A1AA64CC1030F347787DEAA99C4C44431A2532F2EB84EE3F41ADD9A4DDA4D4E381FC2436331B6333AEB19BD7252319444B0F975513F64866212D59AA1B2B230762C7AF4C0E2C5484B136187CC2B841C701CC1917FE29F3BB1D34FEBF7301E7E124FA6214D0796477BCC37AB5250A25506324331896ACD50B1B178E925FCBFFF07B1BE740C9BA1AA507500073EC6C77BB0270A51CFE2D921B543520DA97AAD1A5B565CC80C251174421580CC50AC929D9DADCE62A890108C1B07116FAA3269862A43D9466C7C148F8EC4C80BB8300333FE83FF4CC554C34543A54D8DCD2A3A64869208DDCC9933958EE1578E1C3972F4E8D1C8C8C8ACACACECECECECECEC9A9A9AA8A8A89A9A1A87C3613018CACBCB8D4663DD8F369BCD6030D4D6D6FADCD69A9A9AC0C0C0C0C0409BCDA69EA824DA1A1818E8E7E7E772B9541595445BB55A6D505090C3E150362A9BCD565969F8E20B6D68A82B24445B5E5E2EFA715D2E577474745555950A5BA1515B2B2A2A0C064391A6683DD6FF057F59E15811A38979B9FAE5BF38FED2CFD00F1530180CDE3B0246A351E698ED76BBD3E9D4EBF565656546A3B1BABADAE974EA74BAF2F27293C924C5D68A8A8A162D5A381C0E998F2BC35697CB555858F8E38F3F7A938BC562D9BD7B774C4C4CDFBE7D65C86E2A9A0CD16AB5E7CF9FDFB061832008000441E8D9B3676A6AAACD6673B95C2693A9A8A8283030B0A2A2C2E170984CA6E2E26293C9E4735BFDFCFCBC83BCF4F4F4E2E262954425DDD68888889C9C9C162D5AA82A2A89B69E3871A26BD7AE4EA753D9A84A4A4AB66EF59F3F5FBB6C99B3654BAD14C7F55EB93C1E8F0A5BA1815B3D1E8FC164D85FB0FF7FDBFCEF26D3A63CE4DD837BFE6CFFF303FE0F085582CBE5729BDC050505494949D9D9D9818181EDDAB59333E6808080D2D252000683A1A0A0202020A0ACAC0C80D96C2E2828080C0C94626B5E5E9EC964F2F3F3D3E974721E5786AD3A9DCE9B5FBCC5311A8D262B2B2B3D3D5D9EECA6F1663535B074E9D293274F2E5DBAB46E35449D4EC76AC590D56A8D8C8C3435D6C7E383545757DB6CB6989818A5039183C2C2C2B0B030058BC9ABABB173275AB7464404B2B3D1BB37248AC5ED76171414F86E31B913CE5FF0CB5AACDD8EED76D80760C09378F2664FEC141515858484F8FBFBCB1FA7CC789BB565CB964CDEA61504A16E565CABD5BEF4D24BC1C1C173E6CC91E1D02A1AD102D0FE86D281480E99A198242C2C4CD9A2CDE3C7F1DA6B78E6194C9D8AE464090FE4BB66A84A54FE801F5663F537F8260841C330EC113C928EF45B3CB153CF0CC5306C9BA1341ACDB5B58A727E4C364FA8CA213314AB286E86EAD811AB56E18517243F902F9AA18A51BC1AAB8761D8288C3A8773AFE3F5FFE03FB331BB0BBADCFAB9D83A3314F390194A22D435A2E5043243B18AFC66284180CBF5DF87764242D0A78F1CC7F521339400E1022E6CC196F5587F0997BAA1DBFB78BF1FFA357C19BBC4C4444E6449648692081AD12A437E7E7E6D6DADD251C881DD6E2F2C2C543A0A99B05AAD724E54783CD8B2052FBF2C82BBB8B1781542721FB591D4A2F6088EFC057FE98FFE0BB1301DE9EBB06E23363E86C71AB5586C6161A1DD6E972E4EF5E06DD6BA2A19422CB81854A910324331899C66A8CA4AE8F5D8B307252570B9E439E67F51B942E80AAEECC3BEB558BB1FFB83113C02231EC1231DD0C180A6DC6A55ADF04B7454DEACBE0B255A6520331493C86686DABD1B8B1763DA34BCF926F47A8484C870CCFF833ACD501E782CB0ECC4CEF5589F8DEC74A44FC7F48118D81AAD35687ABF363C3C9C93D954324349049D5005203314AB646565C9533563B5C268447030222214C8B2509F19AA1AD5FBB17F0226F447FF77F16E0A523EC5A7DBB0ED593C9B8084E6645900168BC566B38915AA9A21339444F032D450151A8D2635359593715E686868505090D251C8446A6AAA3C439FC71FC7F0E150B0C8CC5B35A3D8E1AFA10845DFE09B355873088762113B0AA38661581AD2445C60272929899311ADD1684C4B4BE3E4C3CA0917D77A1562B55A636262385926AFACAC2C2E2E4EE940E4C06AB59ACD66D197C913049C3F0F8F072929BFFEC66884B2B7D25C2E97D56A4D4848502C00B8CEE1DC366CDB888D56583BA3F33B78E77EDCDF022D9A397EBD9EA2A2A2B0B0301E8AE769993C89A044AB0C0683819F62284EC6EE00BCBA63D1777BEE1C9E780277DC81254B445B7EA79968341AA5C63DE5283F8883EBB0EE1B7CA383EE7EDCFF381ECF404620A44A847ABD9E93C4A3D16838A91D91195EAE806A83CC504C121E1E2E62D1A620E0D831E4E5A1470F8C1E2DE62277CD477E3394002117B9BBB06B3DD69FC4C94424BE88170763701292A45E869DCC504433A144AB005E33549B366D78988CAAACAC2C2E2E4E96D407A81A2C164B7C7C7C8848E549A5A578ED35188DB8F75EBCF8A228BB140DAF19AA63C78E321CAB06353FE3E78DD8B8033B6CB0DD8DBB9761591FF489844C993E3737373A3A9A87FEA2D70C45B769458712AD0290198A55C43543858561C60CB46881F070B176291AF298A14A50F21DBE5B87750770200C618331780446A423FD86EA7FE9203314D14CB8B8D6AB90FCFCFCD8D8584E8AA14A4B4B7D7799974661B55AA3A2A29A530C65B7C3CF0FDEA93BAD16F7DD27566822E3AD9A494C4C9462E7B5A8CD44E60EECD88EEDB9C8ED888E7FC3DF0660403CE2452F746A08858585E1E1E13CF417A9184A2228D12A0399A198A4990AA1AFBFC6B26578FD7574EF2E625092209142A81085DFE1BB4DD8740007FCE0773FEE7F1B6F672023044A3C2CFC1B6486229A09255A652033149334CD0CE5F1E0C2054447E3E245B85C10FBE1204910D70C6587FD244E6EC3B61DD85184A2DB71FB344CEB8FFE8948D4AA40AA436628A299D00955003243B14AD3CC50BB76E1A187B079339E7A0AEBD6213D5D8AD04446143394079E5CE47E8A4F4760C4600CDE822D7DD0E7737CBE155B9FC37349485243960599A18866C3CB50435590198A559A66868A8DC5F0E1E8D91306838A1EE0B935CD344355A0E2388E6FC5D65DD85586B23B71E76CCCEE877EADD04A91BBB0B786CC504433E1E25AAF42C80CC5240D37430902FE7F7B771E1F557DEF7FFC75CE6C99994CB6C94E12B288610F4B12760514F58A822BB5CAAF2ED7FD562DB66A5BB58A57456D15A5DAEAC35BAD17D1ABA22882A015501050596411124216B6405692D932FB39BF3F661A42440443B6C9F7F9E00F32DBF99E4CE67CE67BBEDFF3FEB68ED18F1ECDA851F4AE21FB9F970C15245841C5677CF6011FEC62570A299771D94C66165060A2E79E3117C95042078942DB3D443254443A956428A793D75F272A8A9B6F3E565C7BDDDFC2E9264335D2B8918DEFF3FE1AD604088C67FC02169CC339A9A4F6C02E6C3B22194AE8A0BE7204EC69443254443A793294D78BC74343030B1772FEF90483F4DE6F20A7980CE5C55B42C9C77CFC311FEF635F1E79B771DBC55C3C9081060C5DD0CE33422443091DD46B3FE8BD9948868A54274986B2D978F0411C0E5E7C9177DF2535B51757597E2A194A4139CCE12FF9F2033ED8C84613A6A94CFD6FFEBB98E2787A5EFAC64F11C9504207F5E6CF7AAF2592A122D54992A1240949A2B0108381ECECAE6D5627F8B164A8269A36B169294B57B1EA28478733FC211EBA800B72C8D1D05B8FDD22194AE8A03E71ACEF81443254446A970CA528B49E848B89E1B9E7D06A7BDF70EC09B54B866AA16517BB96B37C052BAAA8CA24F30AAE98CEF4020A3A6F519D2E2392A1840E1285B67B8864A888D41A21A428AC5ECD975F72F7DDB4E63A44D2309F24495151517EFC9554AE66F552966E67BB19F364263FCCC36318934862CF9FE5748A443294D041A2D0760F910C1591AC56AB2469EBEAB05878F75DCACBB9F146CE5C80524FA1A0D4686A36A66D5CC292F5AC0F122CA2E8099E98C2944C327BEF29E21F2392A1840EEA2B47C01E25940C959D9DDD17921CEC767B6D6D6D17ACF4D2139495ED5DBE3C73E9D298BFFD8DC71E43A389A82AABA2D653BF894D2B58B19AD58D34E693FF6B7E7D0117E493DF8B66119FAECACACA949494B8B8B8EE6E48A70B25430D1D3AB48F7CB1E832A2D07603910C15A9060D1AB871A3346102C9C9A4A676776BCE9C269AB6B2F5133E59C5AA6AAAB3C9BE8CCBFE83FF18C1080B96EE6E5DA713C9504207F589637D0F2492A12286CF87561B9EF4545D5D3D6B566274B429328E540E1CDFF3FD0A567CCAA7FBD8974CF254A65ECCC58514C606630F571FB664457E95452443091D260A6DF710C95091E1ABAF78E925EEBA8BF1E301743A9DC120F7F62AEBC4594AE96A562F63591965F1C44F64E2433C544C7132C9A1294E41827DE7582C92A1840E8AD823600F2792A17A359F8FDDBBC9CE66DF3E1A1A8E454F9C3C19AA8773E12AA57415AB3EE3B35DEC32611ACFF83BB8631293D2486B37C5E91493A122834886123A4814DA6E2092A17ABB254BB8EF3E9E788259B3983183D624A8932443F558ADFDD74FF97437BB0D188A297E9227CFE19C6CB27F6C0AF1C993A1228C4886123A4814DA6E2092A17ABB2143F8C31F98360D8301439BC9B6274986EA69DAF55F43F5F5099E98C4A4FEF4D7F313FDF21F4B868A4822194AE8A0DE7150883C2219AA175114F6EF2736968484F02D438772C2BE5CBB64A81EC88EBD8CB21FF65F2732319B6C1DA77A82B45D32546413C95042078942DB3D443254AF105A3576F56AEEBA8B7BEEE1F6DB7FE2F13D3642A889A6DDEC5EC5AA7FF1AF72CACD984731EAD4FBAF3FD4A722847AECDB7AC6F5A9B7B52B8942DB3D443254CF77E810FFF8071326D0AF1FD75ECBB9E7FEF453AC566BCFD95915B581861DEC58C5AA55ACDACFFE78E28B28BA833BC6312E838C53EFBFFE9046A3498AA4308E9312C9504207F59483429F2292A17A859212DE7987CC4CCE3F9F871F3EA5A7ECDDBB373333B37B2743292875D46D61CBBFF8D75AD656539D42CA78C6DFCFFD6318934AAAF64C7CEA7D3EDF9E3D7B860D1BD6F197EAF9443294D041A2D07603910CD533290A706CBD9D499358B182D34ADAC8CFCFEFAE239407CF010E6C62D31AD67CCDD775D46590710EE74C635A2185ADD7BF9E29A1593367F0057B32910C2574509F38D6F7402219AAA7397890575FA5B0901933C2B74445D1BFFFE9BDC8E1C387131313BB72325433CDA5947EC5575FF2E54E76FAF09DC55933993999C92318D1794BE8040281C3870FF73FDD5F50EF2492A1840E1285B67B8864A81EC2E361D72E5252A8ACE4E38FC9CAEAD0ABE974BA2E384205081CE1C876B6AF66F50636EC639F19F30846FC8EDF8D635C3EF9D174FA29044992FA4EBF472443091DD4738F80914D2443F510AB5773FBEDFCE637FCD77FB16C1969691D7AB54E4D8672E1AAA472231BD7B276339B9B694E236D1CE3EEE5DE228AFAD1EF674C1EFED94432544412C9509D4414DA6E2092A17A8EA14379F249264FC66038BDE1D8133AE3C95041820D347CCFF7EB58B796B57BD90B0C64E02FF9E564260F65680209DDB2BEBA48868A482219AA938842DB0D44325477A9AB63C50A468E64F8F0F02D5959CC9E7DC65EFF4C254379F1EE63DF26367DC997DFF04D2DB556AC45145DC7756318934BAE896ECEC410C9501149244375923E71ACEF81443254570A06397890C444D6ADE3E187993BF758A13DB33A920C15207094A3BBD9BD918DEB58B78B5D0102B9E44E67FAB99C3B9CE1A9A4CAF494737A22192A2289C9509D4414DAEE2192A1BAD292253CF4100F3FCCF4E92C59C2A0419DB5A1D38D105251EDD82BA8D8CCE6F5ACDFC6B61A6A62892DA0E07EEE1FCFF83CF262E8894B14F4A90821910C25749028B4DD43244375A5FEFDB9FE7AC68E252E8ED1A33B7143A7980CE5C2759083DBD8B69EF5DFF26D35D55AB46771D60C668C65EC3086A5937E4662253A8F48868A48919C0CA52878BDB8DDC4C4E072B17DBBAEAA4AEAAAC4951EFD618E542219AA539597F3F9E75C7411D9D9E15B8A8A282AEA8A4D9F2419CA8FBF9AEA5DECFA9AAF37B2B19CF200817EF42BA6780213463022934C33BDE6E4A448868A48BD3B194A550906F1F9D0EBF17A2929A1BE9E8606264FC6ED66C1026A6B5155E6CE4592F8DBDFF46565724141D7344D14DA6E2092A13A83C3414505F9F92C59C22BAF3070E0B142DB65DA2543F9F0D5535F42C9D77CFD355F9752EAC0914AEA0846CC62562185A133C3DD326DB88344325444EA05C9507E3F5E2F5151280AA5A5D4D561B3515484A2F0D7BF525F8FD3C9030F101FCFB3CFA228A4A45058487C3CE79E4B42020909F4EF8FD9CC9B6F3AEFB9273A18EC9A56F789637D0F2492A1CE2C55E5F9E779E30D162E64F66CA64FA75BAE27AAA9A989B3C6B5185BF6B067339BBFE2AB5DEC6AA6398EB8210CB9933B0B291CC8C004127AF899E19F2492A12252F74F86529470AF54AB4555D9B3878606EAEB193D1A8B85050B387810B79B7BEF253D9D79F30804B05AC9CB232383C2424C26AC56F2F3B15878E515F47A0C0642B361AEBEFAB80D69B552177E9FE8DD9FF6DE4B2443755C3048EB274592983081EC6CF2F34948E868EEC4E9F2E33FCAD14A2A976B97EF91F794525A475D0C318318349BD9E31837908129A4F4F6E2DA9648868A485D910C150CE2F1E0F5623422CB6CDB466D2D4D4D14159198C85FFE4275354E27B7DECAF0E1BCF002763BB1B1F4EF1FAEA04545242571F6D9C4C7F3F7BF6334A2D5860F04BFFCE5711BEAD6B53DDA899C4F7EEF2292A13AC2EFE7DD77F9EE3BFEF8C7638BB14F9D7A6637F2536DC05F43CD5EF66E66F316B6EC6257238D9A444DBE26FF322E2BA67818C3D2483360E8D2667515910C1591CE4C325420402080C381D1884EC777DF515D4D4D0D1326909BCBDCB9545602DC7C334545BCF61A2E17160B679F4D7636E3C6A1D3111FCFC081C4C7337F7EB8571A6AD2F5D71FB7A1DE336A2E0A6D3710C9503F4F20C0BA755457337326EBD6D1D484C7D3F1573D0D2DB4D452BB9BDD5BD8F22DDF9651E6C061C1924FFE155C514CB1542115A517255B92BBB459DD41244345A4534A8652559C4EDC6E3C1ECC66CC66D6AFE7D0211A1A282CA4A080C71FA7BC1CAF975FFD8A69D3F8DFFFC5E9242181E1C3D1E9983A954B2E212E8EAC2CAC56162C4096D168C2A5F4F2CB8FDB56A4FCCE45A1ED062219EAE7713898370FAD968B2E62DE3C0C063A7B991C05A599E6831CDCC9CEEFF86E3BDB2BA974E1B2621DCAD0FFE43F0B291CC0801452423DD7405EA08F9C5015C9501149A7D30DCCCFD7C8324E274D4D381CC4C763B5B26205E5E53436326102932631772E7BF6E0F572E38D5C7A295F7C417D3DB1B1C8322613975C82AA9294446626B1B13CFB2C3A1DAD87BBE9D38FDBA421324FF9B4D3278EF53D904886FA49C120D5D548129999E15BE2E278FE791212484C3CC38D6CCB85AB9EFA72CAB7B37D0B5B4A28A9A75E45CD206310836632732423F3C84B265943FB836F7575F5CF4E86EA5D4432546F15080068343436D2D44443037171E4E5F1E187ECD9437DBDBBA04073F5D5F2DCB9ECD8815ECF5557F18B5F505A8ACD169EB56B3472E38DA82AD1D12425111DCDA38F2249C756729E3CF9B82D1A8D5DBC8B3D9028B4DD432443FD1845A1AE0E93890307983D9BC993993F3F3C6D5092183CF8CCB73048F028470F70600F7BB6B2751BDBAAA86AA1259AE8010CB8888B0A2818C2904C326388397908A288108A48BDE66D0D06090470BBD168309B292FA7A6868686F08CDC7FFE936DDB686E66D2247EF94B9E79866DDBD06AB9FC72CE3A8BC3870906A58103E59C1CC968E4B6DBD068888EC662C164E281078EDB50BB2183BED1DDEF085168BB874886FA315F7DC55D7771F3CD5C7B2DB7DE4A713167FC0B4990A01D7B35D56594ED60B81700A000001F4049444154C74E76EE656F238D12521A694318328319C3199E4B6E2AA9A7B5F6DC2926434500910CD53D5C2EDCEE70294D4EE6DB6FA9A8A0A181FEFDB9E4129E7B8E6FBFC5E3E1820BB8F966DE7C931D3B309BB9E822468D223A9A8103494E66C8104C26EEBE1B492226263C71F737BF096DC1E0F74B3A1D679FDDBD3B1A61FAC441A1A711C9506DB95C180CC746709292B8EC32C68FC76AE5CE3BCF4C1B141417AEC31C2EA77C17BBB6B3BD8CB2231C01E2881BC080CBB8AC8082B3393B838C18627E784EF8149D24192AC28864A83346555114140540A7E3C8111A1B713AB158183890952BD9B183E666F2F3B9EE3A5E78818D1BF17A993C993973D8B489DDBBB158C8C9419639F75C468F2621818C0CCC66EEBF1F202A2AFCE99A35EBB8ED9E6834C7E7F3959494F4D664A81E4C14DA6E2092A11405B71BA391850B59B488A79E62D4A8F05D830631776E4737EAC7EFC4594B6D39E5DFF3FD6E76975156438D176F0C31B9E44E61CA30860D61483FFA59B19EA92B5CDB25434530910C754A1485D0C422970B8F0749A25F3FB66F67EF5EEC76D2D2B8F042DE78838D1B696961D830E6CCE1B5D7D8B0015966E244060CA0A909AF97E464B2B3D16AB9FA6AA64F273A1AAB15A391BBEE028E0D8E8E1B77DCD64FFF7B7C2F4886EA9DFAC4B1BE07EACBC9505E2FCF3FCFE6CDFCF5AFA82A393967E0CAF20081669AABA9AEA06237BBBFE7FB0A2A6AA809108821269BECB18C1DC290210CC9263B9E78239D3241E3F0E1C38989897D6432549F4E860A051885C644A3A33972849A1A1C0E0C06468E64CD1A366EA4B1917EFD983387575FE5F3CFF1F9282CE4C107F9E61B366F3E766D685E5E7828342B0B83813BEEE0965BD0EB311AD1EBDBAF96DCEE32B9333D72DCFDC950114A14DAEED1A792A154551B0AFA0ED16AF1F9C8CE4692B8FE7A7EF5ABD33E5C0409BA7035D1B49FFD9554965052465925958D3406092691944556A8CF7A3667F7A35F12495D131CA1D3E9FAC8112A6293A102011405BD1EBB1D9B0DA71359D6C6C64A5BB7525E4E531309095C730D8B17B37225763B8306F1C4137CF4111F7F8C564B7131C38611081015C5A0419C7D363A1D575EC985176236131383D9CCADB772EBADC87278F6C19429C735A03581A53B744532549F240A6DF7E80BC9506E37B24C7DBDF1B1C78C3939FCE10FE182AAD1F0C00368B5E11F4FE5FB860F5F238DB5D4565051465929A595541EE6700B2D060C56AC79E4CD60C610860C60401659162C5174C3D982F8F8F83E3217B7972543A92A9284DF8FD3494B0B810019195455515E4E430306033367B262052B57E2749299C9EF7FCFDB6FB378311A0DC387C7FEF18FBACA4ABEFD96981892929024060D223696E868D2D3D168B8EE3AAEBA8AA8A8F080E8F4E9C75D2D9A95755C637AF0179433930C25FC8028B4DDA02F24436DD8C0238F307B36E79EAB34362AC5C55A553D76EF498A918AEAC66DC75E43CD410E56525946590515073860C71E2468C59A41460105B3983590815964A59062C1F2B367309D419595951919197D6132544F49860AAD30EAF3214958ADD4D4B0674F787EDDB9E7B269139F7E8ACD466A2A77DFCDFBEFF3F6DB280AF9F93CF104EBD6B17265782E6E304842022347865777311AB9FC72CE3F1F8B85989883070E24CF9811DB36FF6FF4E8E35636B658B058BA7EEFCFB8534A86124E9F28B4DD20F292A19C4EEAEBC9C8A0B597AED3919949BF7E6465496FBE29FFD8370A05C58BB781867AEAABA82AA7BC828A2AAA0E73B8892619D988318DB41C72CEE19C7CF2B3C90E4D0CEEA441D60E1A30604024BDAD27D129C950A17E673088D78BD389A29094445D1D9595389DA82A53A6B0650B9F7F8ECD46622277DFCDD2A5BCF30EC1205959CC9BC7FAF52C5A84C5C280014C98104EAE4F4B233B3B1CFE376408F1F1C4C4101DCD75D771EDB5E874E1532B93263169D2B1C62427931C8ED2CCC9CDED23852734C7AD8FEC6C57EA1307851E280292A18241F6EFC7E1203F9F871EE2ABAFF8BFFFE3ACB3C2F7161551588824E172B53437379BCDFD02045CB85CB8EAA83BCCE1431CAAA0E220070F70A08EBA165A149478E25349CD26FB3CCE1BC0806CB213494C26D980E1E449113DC4E1C387FB4E3254757575F6292EF91BEA77FAFD280A8989D4D6B2772F4E27C0D4A9ECDCC9F2E5E1455AEEB987CF3EE3ADB7F07A494BE3D967D9B08137DE202A8ADC5CC68E251040AFA77F7FB2B2D068983081B3CEC268C462C16CE6F2CBB9F452349A7076EED4A9C7AD35919171DC352DA77C923FA292A14E4A4C86EA24A2D0768F084886AAABE3861BB05878FB6D264E0CAF5E05A8A841822DB4344A8D4D3455C8153BB43BBC7843FDD47AEA9D3865E428A2E288CB247314A372C8C921A73FFDD348B3603161EA8D6BA1D38B22847E9ED0159FAA8A568BC7A33B7A14554555E9DF9FFA7A4A4AB0D99024CE3F9F92123EF9048783A828EEBB8FD5ABF9E73F5114AC569E7C92CD9B79FD75CC66D2D3993409BF1FBD9EB3CEA25F3FF47AC68C212B0B8B85B8386263B9E412A64D0B5F6AADD170CE399C73CEB1266565B51F01ED84330A11FEB6B6D1A702BFBA9228B4DDA3172543793C180C7CFF3DEFBECBA597525C1CBEDD6AE537F7F963923D0EA37BF855CD4738B29CEA031CD8CFFE6AAA43E77EBD787D069F21C1904E7A2AA98514F6A77F36D999645AB1269268C21449ABB4F6B26428452110C0E70BE7D6BA5C343460B3010C1CC881036CD982DD8E5ECFAC596CDDCA5B6FE1F160B5F2C0039A0D1B92172C0847513FF71CDBB6F1EAAB44459193C3C489280A0603B1B1C76A677A3A4623D1D12426327D3A175C10EE74867AA513261C6B95D94CDB8EB246D3EDB9F33D2819AA9369349AC4C4C43EF2ADA22BF59E834204E92DC950AACAEBAFF3D9673CF2846FE31ED7DF3EB149858D368E1EE0402DB535FA9A9A4B6B42C3ABCD3407081830983025919449E6600687C653F576BD5C2B17E51719319E569C616FD40DC950ADBD4C4541A7C3E3C166C3ED0E0F5B3637535A8ACF87DBCDE4C9ECDFCFA79FE272613472FDF56CDFCE3FFF89CB4572328F3DC6A64DBCF822924446068F3DC6FEFDAC5D1BFED1EB2521813163301A494CC464F28F1EBDF78E3B0617164A261331314C9DCAB9E7A2D58647E9ADD663DFC880B434D2D28E6B76AFAA5B9D9B0CD593F87CBED2D252910C75C68942DB0D2449EA51330E5AFC7EBFC6D3D4AC7EF3AF186D7A5DC2A45D4D3435D0502BD5BEE34ADE1D2BEFD62EF54C3F204DF1BC1AE77A95A01E7D1C7171C42591140A57CA20238BAC2492E2898F275E87AE7548558D55158BD213A60477810E25430583E162E9F763B78757CF4E4EC66E67EF5E9A9BD168183386234758B52A3C57E8A69BD8B78FD75EC3ED46ABE54F7FA2AC8CE79FC7E7233D9DC71F67CF1E5E7C11A3918404468FC6E7C3E140AF272E0E8D869C1C7EF52B8C466263898DE5DC73193992A828CC66A2A2484B63EA5424297C01567C7CDB251DF42653FECC99526BF73DA2CF37FEFC64A8DE46AFD70F1932A48FEC6C57EA41855609A57DF601AAAAEEDAB52B3737D7D2C99704A8A80A4A90A01BB70B9713A71BB71367030D47391AFA57BF6AF8FE572FB0DFF9942DBABAF291C7F5572C8B9E384F2FE93468CC98136E4FBA5A4E49D464A552DCCFD82F99E4249292498E263A8A2823C69F3CF1DBD4D4545B5B3B68D0A04EDDD39E400D04F6EEDE9D9E96169B9484D78BCD463088C743BF7EB4B4505585DB8DA2307224478FF2E9A7381CE874FCE2175457F3DA6BD86C984C3CF820D5D53CF34C78D6CF5FFE427535CF3D87A29091C1A041389D54561215456A2A5A6DB81C86AA634202C5C52C58804E172EAE69698C19835E8F4683564B7AFAB1AC4BC06A3D367B0D301ADB6774FDF83482969696F2F2F2A14387F685D38C15151556AB35B1535767EC19BC5EEFEEDDBB870E1DDA5B06B63A4255D52E2B3A3DA8D0BADD6EB5EDB59691CBE7F33DFFFCF3F7DC73CF8811234EF7B9418241827EFC418201027EFC3E7C366C4E9C76ECA16AEAC0D14863134DCD34DBB11FF5399D368DD354E70EFA9C6FCD706B9C31372DD669E468A2A389966CB1B16E63A1343A657052E287FB929386A548EF5AB044136DC162D15974E83AD21FDDB66DDB471F7DF4DC73CFF582AFC9C1202D2DE184F79818BC5E1A1AF07A6969E1ECB3B1DBD9B60D970B4962CA148E1EE5E38F6968C068E4A69BA8ADE585173C5BB6047273993F9F438778FA6982414C269E7B8E438778E1053C1E1213C9CEA6A989EFBFC768C46A4555B158282C44AF272585F878A2A379E4110C06F47AFAF523339337DF4492C2C53223E3B82B3813128E2DD81B121B7BDC8F9DF365AEA2A262C18205F3E7CFEFEC2F8BDD4E55D537DE7863CC98313367CEECEEB674BABABABABFFCE52FCF3FFF7C5F589A29100878BDDEAED9560F2AB48AA27476A15551DBFEBFF5C750CF2FF4A384E4C5EBC1D3EEB92DB4F8F1B77DBA074F9060BBA7845ECA852B9AE8D0DC5A3DFAD07F64642D5A33668FEAA90FD6D7A9758D34B6D0E2C50B78F1FAF1ABA84E9CA1D0061B36172E3B762F5E172E078E501175E376E0F0E1F3E069A1C5852BD40C155583C6DFA253DC86E4046DB464B6604924515E3F72F303175E787DCD25577ADF7EFFE28C1CFF9CFF77438A263634682A5D62D04FD7990CB3003A2125DEEBF53A1C8E33FCCE865E4D55916554357CDD086030E0F3D1D888CB05840717ABAA70B9080418350A9B8D2FBFA4B111BD9ECB2EC36663E1426C36743AEEBE9BBA3AE6CD0B0F343EF20875753CF30C8A82D1C833CF70F428EFBE4B304862222347E2F5D2D484D14852121A0D8989C169D33EAFACBC60E244ABD54A5C1C4F3F8DC9844E474A0AA9A9BCF20A9284C180C1404606CF3F7F6C779293C9CB3B6E07DB0D07F6BCCBC07C3E9FDD6EEF0B67A1545575381C6EB7BBBB1BD21582C1601F795BE9B33D5AC083A7810637C7FD4D4B48A1139EADB784D6130D10687D96078F842421F9F0D9B187AA1D10EAE44948327280403DF5808C1CAA856EDCA16729284739EAC7AF4113DA5C6B1B42CF059C38030442FFD7A10B6D374830748967A80D1A34A153A9A19AEDC3179A55EBC71F4554A8C166CCAA413D38F760696AA90993078F0F9F1EBD0F9F82A241E3C2A54113DA9016AD1E7D34D17AF4264C3A7466CC162CA9A486FAA3162CB1C4BA6B62BFFA387E6876F494B1C6DFDE6E969C9685AF6BB312A265641DBA923475E995D294228A52B87A11168BD1185570ECF7DBC9836B92244992A4860620FDFE70087B20103EB31A1A8674BBA9A80807B50F1C88DFCF962D381C4812E79C83CBC5CA95E1EEE635D7E072F1B7BFA1AAE8F5DC720B5E2F7FFE330E07261373E7D2DCCCE38FD3D24272320F3E88DBCDFCF9389DC4C4F0C823B8DD6CDA84AA929A8AD78B4E476A2A3939E1641F8B85DFFE16A3311CB79191C1CB2FA3D3A1D31117476E2EAFBC0220CBE18883471F6DBBA7EA5557EDF8E493D12347863B91ED8A65648D6286DED6EE6E455790FEADBB1B22F4623DA8D06AB5DA65EED55B6CB39CB1FB834763D5E6785D5A9D6CF40041823E25E8AB4E9190A2FAD57B1B2D2DF5D186AC9AE86845872E48D01F549BF7A6E0894A1D565B5B6576D49AB3873862E31442352FA0DBBBC30C140C57F6ED88755625174DF2242607B468A388D2FACC1BBF3042F6F8C9EEEA9DD69AFDA67113FCA929E10EA2D193B0E4030D70C3956CD820ED2A51AFBE543F3C334E4595905C2DFCDF1B463DFA9B6E60F56A69FB779AFFBA36363F57ABA028288D4A73F9FEA0362A109BEA52505C92CB8B5B41A90BD6BDBBF5DD89E3270E350E0DD5E938E234680C1842814751AAD9A01A4DB23E068B0E9D0E5D8B4BDEB249136FD18E1DA97FED1F52CD61E9D7BFA6356B767B2D8BFEC188998C9DC28D93301A496F13A23F68A034E8DF5DD570D64D689E6AE85C6E28451DC2F345432B4B03F1F1280AD5D50483C832E9E904025455E1F3E1F1105A88F4CB2F696941A763D2247C3E962FC7E3A1A525BCE4C8DFFF8ECB955D55951D1BAB9694F0F7BF535F4F541473E7E2F3F1C413A1C4761E7F1C9F8FA79F0EFD11F0A73F21CB7CF4116E773815CFE763DFBEF0F2D4A1A5AA0B0A888E262A8AC444341A6EBA098381E8683232C8CEE6E5979124A2A28889419278F555E0D89AB72FBC70DC9F5D68A1B1566DB381F8C14263BDE8D21DE1CCE95355B64FED6C97E959078E866579EE9A8B47DEF079D567A30F7F35E4BC3BB7E40C77A8AA2A4992DBA65BFEDC682DDAAB7F57F5E547C9DFAD4ABBF49E8AE123035A450B386D9A57E6E6495EE3ADF3AA96BD99BCFE53EBAC47EA4616FA15459124C9D9A47BFC8F4920DDFD9463D142E3A79F98CE9BEB2C2A5614459125B9F9A8B4E63E0B70F1B38E456F1AF7AC30CEFE6F575191120C066559B6D9E4DA3F45037916E7376FE96A3ED3C5F93CC9850483414992344D6AE58228800CCF9145DA2D2B74FB4DF6A47FDFEBB2CBAF3D61898E567EF7BBA8DDBBA31A1AF4E3C7BBE3E2822D2D2DAB5F583DB26EE4D0A14343E7545555F57AE58307CD3A5D203DDDBD72ADD4D8E89F36AD292EAE4651145996F7EEE5BEFBCCA346057EF73BF7C2D7B575152D43626DE9697862632545910ED4CDB948898F96D7AD4C1CD44FB51C3EBCFB753F1E8F2B3717306DDB260502AAC3D1326E1C605AB74E723854AFB7E5B2CB00D3071F48F5F56834AE6BAF05CCFFFC27CDCDE874AE5FFF1A55353FFDB4A2AA8AC5E2B9ED365555F57FFFBBE472A97EBFFF8F7F54351AF999671455556362B8F55655A391DE79079F0F8D464D4991743A75E74ED9602877B94A5DAE552525FA9414353111B399DDBB916569E2445555311838704092247EF10B0C0615A48307912466CE540159A6AA4A9224A64D93641950CBCA2449D29E7D76E8F716DCB91390351A0201B5A949F9FA6B20343D4755D5D06342078E2E18FEF7FBFD478E1CD9BA75AB2CCBC160B0B337D78D64592E2D2DADA9A9F9E28B2F7AF8256A1DA728CAFEFDFBA3A3A353525222FB6D9524E9C89123F5F5F56BD7AEB55AAD913763C6EFF7FB7CBED0FF6559AEA8A8E8B2499A52CFF96DBEFFFEFB0B16FC8F2C9B4D268FD7ABF3FBB5D1D181D6F36D8AA23A1C3A202626E076CB1E8F64B1283A5DF860AA28AAC3A105D562097ABDB2C7239BCDC1D67B5515A7530B98CD7E9F4FE3F56A4C26BF4E47EBBD2E97AEDDBD5AEDBF876FDBDC1B08C87EBF6C3004359A63F77ABD5AC06008040292DFAF697BAFA2E074EA24498D8E0EB8DD5A87438E8DF54745A9404B4B8BC160683B3FC8E793AAAAB4B1B16A4A4AC0E9D40683524C4C40965B5F4A763A355AAD6A3205037E490A04F4F8400D1A0C92AA6ADC6E59925408444549AAAA713A43EF6BC06201B40E47284536101D0D685BEF8D8901B476BB04C71E1C0A9595A4D08F3AA7539565349A4054942A491ABF1F55552549D1E924599614459565499643BFC9D609A8A1910F59962549F2F97C5EAFD764328576B6755CA4F58B73EB8F3DE74FF16773BBDD3A9DAE376556FC5CC160D0EBF51A8DC6BED001F2783C1A8DA62F4CC45514C5E3F144EADBAA284ADB4159B7DB7DCD35D7DC7EFBED5DB0E91E74745314C5EFF7B7BBB16DF35ABB26AD7F04DD726FBBDFD8A9DFEBF3A9A1301C4E545782411A1B319B319BC3AD38F986DAB6B36DB33BE913F2C30D9D702F7EA8CB3A943D415FDBD9BEB3A788B73522B43B3C6AB5DAAEB91A22927FA782200882D0ED22FF627341100441E846A2D00A8220084227128556100441103A9128B482200882D08944A115044110844E240AAD200882207422516805411004A11389422B088220089D48145A41100441E844A2D00A427B7EBFBFBEBEBEB6B6B6B6B6B6BEBEBE3519545194E6E6E6CE4B96B7D96CADA1E78AA2949797D7D6D69ED62B9C4A0B3B7B2FDA72BBDD0E87A30B3624083D9928B482D0DE962D5BAEBAEAAA1B6FBCF1E69B6F9E3D7BF66DB7DDF6DD77DF017575750F3CF040757575676CD4E7F33DFAE8A39B376F0EFDB879F3E6471F7DB4A1A1E1B45EA4B6B6F6DE7BEF3D74E850071FF3331C3870A0B4B4B4DD8DCB962DFBEB5FFF2A725E853E2EF297191184D3D5DCDCEC76BB9F7DF6D9E4E4E4A6A6A6850B17DE77DF7D6FBCF186D56ABDE69A6B121212420F53144555D55028792010D068346D23CB434B25B6AE681412080464596EBBCC91A228A1D57EB45AED15575C919B9B0BA8AABA77EFDE5B6FBD75C890216D9F1EEA869E30063DB422A4CFE72B2F2FF77ABD276943BBC784DAD0AEF16D5FF6C7F65155D56030D87ACBD2A54B2B2A2AE6CF9FDFFA5C5555478C1891939313914BC108C2A9138556104E40AFD7676565252727676565E5E4E45C73CD352B57AEBCE69A6B0E1E3C3862C4884F3FFDD4E1706CDFBEFDC89123175D7491DBED5EB76E5D6262E21D77DC919999E9F57ADF7BEFBD2FBFFC52A7D3CD9C39F3C20B2FDCB76FDFC68D1BFD7EFFFAF5EBCD66F36DB7DD969F9FFFF5D75FBFF3CE3B4D4D4D83070FBEE5965B626262AAABABD3D3D31545F9E0830F3EFFFC739D4E77E4C8912BAFBCD2E5722D5BB6CC6834AE59B3C6EFF75F77DD75938E5FA07EC3860D8B162DF2FBFD03060C081557BFDFFFCE3BEFB4B661DAB469EDCA6DC8D2A54B57AE5CE976BB070C1870CB2DB7242525B5DEB572E54AA7D3F963FB186A7C7373737272F22DB7DCA2D7EB57AF5E7DE8D0A1CF3EFBACB8B8F8934F3E916579DBB66D13274ED468345EAF77F1E2C5555555A1957AD3D3D36FB8E186AE593545107A0271EA58107E424C4CCCE0C18377EEDCD9D0D0F03FFFF33F8D8D8D1F7FFCF14B2FBD5454543460C0803973E6ECDAB5EB8A2BAED8B469D37BEFBD072C5AB4E8ADB7DEBAF0C20B870D1BF6D8638F6DDCB8F1D0A1437FFAD39F0E1C38306BD6AC868686975E7AA9A6A6E691471E494949B9EAAAAB56AF5EBD64C9124551162E5C585E5EBE62C58AF9F3E74F9A3469FCF8F1F3E7CF5FBE7CB9D3E97CEAA9A7D6AC593363C60CABD5FAD4534FB51DF82C2F2FBFEFBEFBE2E3E32FBEF8E20D1B36D4D6D6CAB2DCAE0DEBD7AF6FB7531A8DA6A4A4E4E9A79F2E2828B8FAEAAB376EDCF8F6DB6FB77DC0471F7D74C27D5CBC78B1CD669B3B776E5C5CDCB5D75EDBD4D4F4C20B2FE8F5FAB8B8B8D8D8D8E4E464BBDDFED4534F2D59B2A4B0B0F0FBEFBF5FB264892449E9E9E903060CC8C8C858B66CD977DF7D27FAB8429F227AB482F0D34C26536D6D6D68B9DFD0829D93274F9E3163C6B061C3962C59327BF6ECA14387969494343535B95CAE0F3EF8E0CA2BAF3CFFFCF30381C0CE9D3B57AC58316DDAB4F8F8F89B6EBA293D3DBDB6B676F9F2E576BBDD6EB7A7A7A78F1F3F7EE0C081068321B424752010F8F0C30F2FBFFCF29B6EBA090815F58282029D4E77DD75D78D1D3B363E3EFE9B6FBE696969B1582CA1B6AD59B3262525E5C1071F341A8D09090973E6CCB1D96C3F6C43BB4EB0A228C9C9C94F3EF9E4F0E1C33D1E4FFFFEFD1B1B1BDBEDF509F7F1E8D1A30683E1FEFBEF1F3C78B056ABDDB973E7962D5B525252860D1B1615153562C48803070EC8B27CD75D774D9C38F1C5175F04743ADD942953807FFCE31F5959597FF8C31F4ED8BD168448250AAD20FCB4FAFAFAC4C4448D46A3AA6AA8DCC6C4C400B22C1B0C06BD5E0FE8F57A49923C1E4F6363E3871F7E18EA44D6D5D5E5E4E4288A62B55AA3A3A30149921445C9CACA9A3367CEC2850BDF7CF3CDBCBCBC3BEFBC33252505F0FBFD757575175C704168BB393939AB57AFF6F97C168BA5756CB85D77F0D0A14379797946A311E8DFBFBFC56271BBDDEDDA909999F9C39D922469EDDAB5AFBDF69A2CCB656565175E7861BB7B7F6C1F2549DAB367CF1B6FBC2149D291234712131369B32EBAAAAAA1AE6DBBCD7DF2C927EFBEFBEE534F3DD5AF5FBF0EBC1582D0FB88422B0827D0B6989594946CDDBAF5B1C71E6BDB0F6B5B57DADEA8D3E9E2E3E3AFBFFEFAA953A70683C1506FCF66B3B57D982449369B2D2F2F6FE1C285D5D5D52FBDF4D2934F3EF9F2CB2F4B92A4D56A131212EAEAEA428FACA9A9898B8B3BF970667272F2860D1BFC7EBF4EA7ABAFAF77BBDD7ABDBE5D1BAC566BBB67C9B2FCDE7BEF6DD9B265DEBC79D9D9D90B162CF0783CED1E73C27DD468341B366C78FBEDB7E7CD9B575050F0D9679F2D5DBAF4C79ED8BABF5BB76E5DB060C16F7FFBDB9123479E645F0421228913388270027575752FBFFCF2FCF9F3E7CD9B77E79D778E1B376EF2E4C96DAF3D3DE1252BAAAAC6C4C44C9C38F1FDF7DFAFAAAADAB265CB9FFFFCE7E6E6665996435DE1D0632449AAABABBBF7DE7B57AE5CA9D1680C0683C9640A3D46A7D39D77DE798B172F5EB366CD175F7CB178F1E2F3CE3BCF6030B42BE76D373A71E2C4B2B2B2575F7D75F3E6CD2FBEF8625353535C5CDCA44993DAB5E187ADF5FBFDA112FEEDB7DFAE5CB9F2C891232D2D2DED76E784FB1808045455D56AB57BF6EC79FFFDF70F1D3AD4D8D828CB727373F30FCF3F03CDCDCDBFFFFDEF6559AEAFAF5FB468D1D2A54B9D4EE7C97FFF821049348F3EFA6877B741107A16BFDF6FB7DB6D36DBD1A347BD5EEF25975C72FBEDB79BCDE66030E8F1788A8B8B1545C9CDCDCDCDCD551425748BD96C76BBDD898989F9F9F943870EADA8A878EFBDF7B66FDF7EE595575E7AE9A57EBF5FABD51617176BB55A8FC763369BA74C99A2D1683EF8E083356BD6444545DD7BEFBDA9A9A9369BADA0A060FCF8F176BBFDBDF7DEFBFAEBAFA74D9B76C30D37C8B2DCBA9550912B2E2E36180CA1D6A6A4A42427277FF4D1476BD7AE1D3264C8C489138B8A8AC68C19535E5EDEB60DADDDE2D636E7E7E7EFD8B163F9F2E5B5B5B563C78E2D2D2D1D306040EB795D87C391979777C27D9C3469526D6DED92254BCACACA8A8A8AEAEAEA2C16CBE0C183BFF8E20B8D463374E850AFD7DBFA78ABD59A9797B76FDF3EB3D95C5D5D7DF0E0419BCD366AD42893C9D43DEFAE207439495C4B2E08679CA228369B4DA7D385C6654F485555A7D3E9F7FB6362624297D2B67DBAC3E108F58F4F71DE504B4B8BCFE76BFBF8536983DFEF77381C66B359AFD7DBED76A3D1181A8BFD49C160D06EB787FAE20E8743ABD51A8D46BBDDAED56A450515847644A115044110844E24C66805411004A11389422B088220089D48145A41100441E844A2D00A8220084227128556100441103A9128B482200882D08944A115044110844EF4FF016C81603DE09E73610000000049454E44AE426082>|png>|495px|324px||>
  </itemize-dot>

  <new-page*>

  <section|BIBLIOGRAFIA>

  \;

  BURDEN, R; FAIRES, J; 2010. Numerical Analysis; Cengage Learning

  \;

  MOIN, P; 2010. Fundamentals of engineering - Numerical Analysis; Cambridge

  \;

  QUARTERONI, A; SALERI, F; 2006. Calculo matematico con MATLAB y Octave;
  Springer

  \;

  FANGOHR, H; 2014. Python for computational science and engineering;
  Southampton\ 

  \;
</body>

<\initial>
  <\collection>
    <associate|info-flag|detailed>
    <associate|page-medium|paper>
    <associate|page-screen-margin|false>
    <associate|page-show-hf|true>
    <associate|page-type|a4>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|1>>
    <associate|auto-10|<tuple|2.1|12>>
    <associate|auto-11|<tuple|2.2|14>>
    <associate|auto-12|<tuple|2.3|16>>
    <associate|auto-13|<tuple|2.4|18>>
    <associate|auto-14|<tuple|2.5|21>>
    <associate|auto-15|<tuple|2.6|24>>
    <associate|auto-16|<tuple|3|30>>
    <associate|auto-17|<tuple|4|32>>
    <associate|auto-2|<tuple|1.1|3>>
    <associate|auto-3|<tuple|1.1.1|3>>
    <associate|auto-4|<tuple|1.1.2|7>>
    <associate|auto-5|<tuple|1.1.3|8>>
    <associate|auto-6|<tuple|1.2|9>>
    <associate|auto-7|<tuple|1.2.1|10>>
    <associate|auto-8|<tuple|1.2.2|10>>
    <associate|auto-9|<tuple|2|11>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Sistemas
      de ecuaciones lineales> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <with|par-left|<quote|1tab>|1.1<space|2spc>Métodos directos
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2>>

      <with|par-left|<quote|2tab>|1.1.1<space|2spc>Método de eliminación
      gaussiana <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3>>

      <with|par-left|<quote|2tab>|1.1.2<space|2spc>Método de Gauss-Jordan
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|2tab>|1.1.3<space|2spc>Sustitución progresiva
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|1.2<space|2spc>Pivoteo
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <with|par-left|<quote|2tab>|1.2.1<space|2spc>Pivoteo parcial
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7>>

      <with|par-left|<quote|2tab>|1.2.2<space|2spc>Pivoteo parcial escalado
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Factorización
      LU> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-9><vspace|0.5fn>

      <with|par-left|<quote|1tab>|2.1<space|2spc>Factorización
      <with|mode|<quote|math>|LU> en términos de operaciones elementales. Un
      primer algoritmo <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|2.2<space|2spc>Permutación
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|1tab>|2.3<space|2spc>Descomposición de Crout
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|1tab>|2.4<space|2spc>Descomposición de Doolittle
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-13>>

      <with|par-left|<quote|1tab>|2.5<space|2spc>Descomposición de Choleski
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>

      <with|par-left|<quote|1tab>|2.6<space|2spc>Matrices dispersas
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>¾Directo
      o iterado?> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-16><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>BIBLIOGRAFIA>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-17><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>