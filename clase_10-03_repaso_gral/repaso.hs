module Repaso where

data N = O | S N
    deriving (Show, Eq)

-- para declarar que N cumple con ord
instance Ord N where
    O <= _ = True
    _ <= O = False
    S x <= S y = x <= y

cero :: N
cero = O
uno :: N
uno = S cero
dos :: N
dos = S uno
tres :: N
tres = S dos
cuatro :: N
cuatro = S tres

iToN :: Int -> N
iToN 0 = O
iToN n
    | n < 0 = error "tiene que ser mayor o igual a 0"
    | otherwise = S (iToN (n -1))

suma :: N -> N -> N
suma = \a b -> case a of
    O -> b
    S x -> S (suma x b)

suma' :: N -> N -> N
suma' O b = b
suma' (S x) b = S (suma' x b)

sumaSi :: (N -> Bool) -> N -> N -> N
sumaSi = \p a b -> case p a of {
    True -> suma a b;
    False -> a;
}

sumaSi' :: (N -> Bool) -> N -> N -> N
sumaSi' p a b
    | p a       = suma' a b
    | otherwise = a

resta :: N -> N -> N
resta O _ = O
resta x O = x
resta (S x) (S y) = resta x y

multiplicacion :: N -> N -> N
multiplicacion O _ = O
multiplicacion _ O = O
multiplicacion (S x) b = suma b (multiplicacion x b)
-- a > 0
-- b cualquiera
-- b + b + b ... a veces

division :: N -> N -> N
division _ O = error "division por cero"
division O _ = O
division a b = S (division aMenosB b)
    where
        aMenosB = resta a b
-- voy contando cuantas veces puedo restarle 'b' a 'a'
--10 / 2
-- 8
-- 6
-- 4
-- 2
-- 0


division' :: N -> N -> N
division' _ O = error "division por cero"
division' O _ = O
division' a b = let 
    aMenosB = resta a b 
    in S (division aMenosB b)

{-
    la diferencia entre el let y el where, es que en caso de tener guardas
        where es accesible desde todas
        let es accesible solo desde la guarda que lo define
-}


modulo :: N -> N -> N
modulo a b
    | a >= b = let aMenosB = resta a b in modulo aMenosB b
    | otherwise = a

esPar :: N -> Bool
esPar a = O == modulo a dos

--curryficacion
sumaSiPar = sumaSi esPar
-- no necesito ponerle tipo, haskell puede darse cuenta solo
-- esta bueno ponerle para poder leerlo yo, pero a haskell no le molesta si no esta
-- para ver el tipo en ghci ponemos `:t sumaSiPar`

todosLosMenores :: N -> [N]
todosLosMenores O = []
todosLosMenores (S x) = S x : todosLosMenores x

-- si usan la extension "haskell" de vscode, aca ya les dice que pueden usar map (esta definido mas abajo en aplicar)
-- tambien les dice el hint de aplicar una reduccion "Eta", lo cual es lo que llamamos curryficar
-- de todas maneras, no apliquen los hints por que si, dejenlo con lo que les quede mas claro
doblarValores :: [N] -> [N]
doblarValores [] = []
doblarValores (x : xs) = multiplicacion x dos : doblarValores xs

triplicarValores :: [N] -> [N]
triplicarValores [] = []
triplicarValores (x : xs) = multiplicacion x tres : triplicarValores xs

multiplicarPorN :: N -> [N] -> [N]
multiplicarPorN _ [] = []
multiplicarPorN n (x : xs) = multiplicacion x n : multiplicarPorN n xs

aplicar :: (a -> b) -> [a] -> [b] -- en haskell ya esta, se llama map
aplicar _ [] = []
aplicar f (x :xs) = f x : aplicar f xs

multN :: N -> [N] -> [N]
multN n = map (multiplicacion n)