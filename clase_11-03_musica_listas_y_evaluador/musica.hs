module Musica where

-- usamos la palabra data para definir un tipo inductivo. Un tipo inductivo esta formado por constantes y funciones
-- aca cada uno de los constructores/primitivas son constantes, ya que no esperan ningun parametro
data Nota = Do | DoS | Re | ReS | Mi | Fa | FaS | Sol | SolS | La | LaS | Si
  deriving (Show)

--Las notas intermedias, como DoS (Do sostenido), en realidad dependiendo el contexto podria llamarse re bemol
reB :: Nota --declaracion
reB = DoS --ecuacion definicional (cuando hablamos de lo que esta a la derecha del = le llamamos definicion)
miB :: Nota
miB = ReS
solB :: Nota
solB = FaS
laB :: Nota
laB = SolS
siB :: Nota
siB = LaS
{-
En haskell los nombres de los valores y tipos van con mayuscula y las funciones (incluyendo los valores no primitivos, eg reB) en miniscula
En el curso vamos a mantener la misma notacion, para que quede claro y consistente
-}


--indefinido es una expresion no reducible, queda en loop. Pero es valida en el lenguaje
indefinido :: Nota
indefinido = indefinido
-- por que aceptamos cosas que quedan en loop en nuestro lenguaje? porque no conocemos ninguna condicion necesaria y suficiente
-- para poder reutilizar el nombre a la derecha (llamada recursiva) sin que quede en loop. O sea, no tenemos idea como verificar si va a quedar en loop.
-- Pero en realidad son necesarias para programar las recursiones (vamos a ver en el curso como podes programar TODO en base a recursiones)

{-
FUNCIONES

foo :: a -> b
significa que foo es una funcion que recibe un a y retorna un b

bar :: a -> b -> c
significa que bar es una funcion que recibe un a y un b, y retorna un c

foobar :: a -> (b -> c)
significa que foobar es una funcion que recibe un a, y retorna una funcion la cual recibe un b y retorna un c

barfoo :: (a -> b) -> c
significa que la funcion barfoo recibe una funcion que recibe un a y retorna un b, y retorna un c
-}

ord :: Nota -> Int
ord Do = 0
ord DoS = 1
ord Re = 2
ord ReS = 3
ord Mi = 4
ord Fa = 5
ord FaS = 6
ord Sol = 7
ord SolS = 8
ord La = 9
ord LaS = 10
ord Si = 11

-- funcion opuesta a ord
intANota :: Int -> Nota
intANota 0 = Do
intANota 1 = DoS
intANota 2 = Re
intANota 3 = ReS
intANota 4 = Mi
intANota 5 = Fa
intANota 6 = FaS
intANota 7 = Sol
intANota 8 = SolS
intANota 9 = La
intANota 10 = LaS
intANota 11 = Si
intANota _ = error "el valor debe estar entre 0 y 11"

-- Las notas no determinan un sonido en particular, dado que la misma nota puede ser mas grave o mas aguda
-- Los sonidos estan formados por notas y octavas (la octava determina que tan grave o aguda es la nota)
-- Nos vamos a definir el type Octava. Un type es un alias a un tipo de datos ya existente

type Octava = Int
-- Lo hacemos porque le damos intencion al codigo, y nos va a facilitar el entendimiento a la hora de programar y leer
-- Recuerden, el codigo es para nosotros, no para la computadora
-- Una ventaja adicional es que si luego quisieramos definir un data Octava, el cambio es mas facil,
--    ya que no hay que cambiar todas las declaraciones de las funciones

-- Como dijimos, el sonido esta dado por por una nota y una octava, por lo que queremos tener un tipo de dato que contenga a ambos
type Sonido = (Nota, Octava)

-- La musica es la combinacion de sonidos en secuencia (melodia) y en paralelo (armonio), y cada sonido va a tener una duracion

data Duracion = Redonda | Blanca | Negra | Corchea | Semicorchea | Fusa | Semifusa -- cada una dura la mitad que la anterior
  deriving (Show)

data Musica = Silencio Duracion | Son Sonido Duracion | Secuencia Musica Musica | Paralelo Musica Musica
  deriving (Show)

acordeSol :: Musica
acordeSol = Paralelo (Son (Sol, 1) Redonda) (Paralelo (Son (Si, 1) Redonda) (Son (Re, 1) Redonda))

melodia :: Musica
melodia = Secuencia (Son (Sol, 2) Blanca) (Secuencia (Son (Re, 2) Negra) (Secuencia (Silencio Negra) (Son (Si, 2) Redonda)))

-- Por que no usamos lista en secuencia y paralelo?
-- Porque si queremos hacerlo ams largo, simplemente hacemos Secuencia m1 (Secuencia m2 (Secuencia m3 (...))) asi del largo que querramos

-- Obs: Como Secuencia y Paralelo podemos hacerlos de cualquier largo, esto nos posibilita tener una cantidad infinita de Musica's


-- usando la funcion transportar :: Int -> Sonido -> Sonido, transportar x son => transporta el sonido x semitonos hacia arriba o abajo segun el signo de x
-- transpieza transporta una pieza (musica) entera
transpieza :: Int -> Musica -> Musica
transpieza _ (Silencio d) = Silencio d -- trasladar un sonido no lo modifica
transpieza n (Son s d) = Son (transportar n s) d -- aca debemos trasladar el sonido, manteniendo laa duracion
transpieza n (Secuencia m1 m2) = Secuencia (transpieza n m1) (transpieza n m2)
transpieza n (Paralelo m1 m2) = Paralelo (transpieza n m1) (transpieza n m2)

-- transportar mueve un sonido una cantidad de semitonos hacia arriba
-- si una nota "da la vuelta" hacia arriba sube una octava, analogo hacia abajo
transportar :: Int -> Sonido -> Sonido
transportar x (n, o) = (notaNueva, octNueva)
  where
    ordNuevo = x + ord n -- puede ser que sea negativo, positivo o arriba de 12
    octNueva = ordNuevo `div` 12 + o -- div es la division de enteros
    notaNueva = let aux = ordNuevo `mod` 12 in if aux >= 0 then intANota aux else intANota (aux + 12)
