module Listas where

import Data.List

--listas por comprension
unaLista :: [Int]
unaLista = [0..10] --todos los numeros entre 0 y 10

unaListaDePares :: [Int]
unaListaDePares = [ a | a <- [0..10] , even a]

unaListaDeImpares :: [Int]
unaListaDeImpares = [ a | a <- [0..10] , odd a]

unaListaDeParesMayoresA5 :: [Int]
unaListaDeParesMayoresA5 = [ a | a <- [0..10] , even a, a > 5]

abc :: [Char] -- String y [Char] son lo mismo
abc = "abcdefghijklmnopqrstuvwxyz"

--Funciones utiles de listas
{-
elem me dice si un elemento pertenece a una lista
elem :: a -> [a] -> Bool

tambien existe notElem
-}
pertenece1 :: Bool
pertenece1 = 1 `elem` unaLista

{-
(!!) me retorna el elemento en la posicion de una lista, empezando de 0
(!!) :: [a] -> Int -> a
-}
elementoPos5 :: Char
elementoPos5 = abc !! 5

{-
(++) concatena dos listas
(++) :: [a] -> [a] -> [a]
-}
listaDesordenada = unaListaDePares ++ unaListaDeImpares

{-
sort, ordena una lista de menor a mayor
sort :: Ord a => [a] -> [a]
-}

listaOrdenada = sort listaDesordenada

{-
map, le paso una funcion y una lista, le aplica esa funcion a toda la lista
map :: (a -> b) -> [a] -> [b]
map _ [] = []
map f (x:xs) = f x : map f xs
-}
--ejemplo
unaListaDuplicada :: [Int]
unaListaDuplicada = map (2*) unaLista
--es equivalente a
otraListaDuplicada :: [Int]
otraListaDuplicada = [ 2*a | a <- unaLista]

{-
filter, le paso un predicado (a->Bool) y una lista, y se queda con los elementos que cumplen el predicado
filter :: (a -> B) -> [a] -> [a]
-}
--ejemplo
unaListaFiltradaDePares :: [Int]
unaListaFiltradaDePares = filter even unaLista
--es equivalente a unaListaDePares

{-
maximum me devuelve el elemento mas grande de una lista
maximum :: Ord a => [a] -> a

idem minimum
-}
maximoUnaLista :: Int
maximoUnaLista = maximum unaLista

minimuUnaLista :: Int
minimuUnaLista = minimum unaLista

{-
(\\) es la diferencia, elimina la primera ocurrencia de cada elemento en comun de las dos listas
(\\) :: Eq a => [a] -> [a] -> [a]
-}
diferenciaUnaListaConUnaListaDePares :: [Int]
diferenciaUnaListaConUnaListaDePares = unaLista \\ unaListaDePares -- == unaListaDeImpares

{-
intersect, opuesto a \\
-}
interseccionUnaListaConUnaListaDePares :: [Int]
interseccionUnaListaConUnaListaDePares = unaLista `intersect` unaListaDePares

{-
nub, elimina los duplicados de una lista
-}
unaListaSinDuplicados = nub (unaLista ++ unaLista ++ unaLista)

{-
zip, dadas dos listas, me retorna una lista de pares ordenados
zip :: [a] -> [b] -> [(a,b)]
existen tambien zip3, ..., zip7 analogas
-}
dosListasZippeadeas :: [(Int, Int)]
dosListasZippeadeas = zip unaLista unaListaDePares -- agarra tantos elementos como la lista mas chica

{-
unzip, dada una lista de pares ordenados, me devuelve un par ordenado de listas
unzip :: [(a,b)] -> ([a],[b])
existen tambien unzip3, ..., unzip7 analogas
-}

listasUnzippeadas :: ([Int], [Int])
listasUnzippeadas = unzip dosListasZippeadeas

{-
find, dado un predicado me devuelve (si existe) el primer elemento que lo cumple
find :: (a -> Bool) -> [a] -> Maybe a

data Maybe a = Nothing | Just a
-}

encontrarSimbolo :: Maybe Char
encontrarSimbolo = find (== '!') abc

encontrarLetra :: Maybe Char
encontrarLetra = find (== 'a') abc

{-
concat, dada una lista de listas las concatena
concat :: [[a]] -> [a]
-}

listasConcatenadas :: [Int]
listasConcatenadas = concat [unaLista, unaLista, unaLista]

{-
and, dada una lista de booleanos devuelve True si todos son True, sino False
and :: [Bool] -> Bool
or, dada una lista de booleanos devuelve False si todos son False, sino True
or :: [Bool] -> Bool
-}
{-
any :: (a -> Bool) -> [a] -> Bool, devuelve True si AL MENOS UN elemento cumple el predicado
all :: (a -> Bool) -> [a] -> Bool, devuelve True si TODOS los elementos cumplen el predicado
-}