module Solucion where
-- 1.1
data E = X Var | App E E | L Var E | RApp | RL Var
type Var = String

count :: E -> Int
count (X _) = 0
count (App e1 e2) = count e1 + count e2
count (L _ e) = 1+count e


-- 1.2 en haskell para despues pasarlo a chi
countTL :: E -> Int
countTL e = countTL' [e] []

countTL' :: [E] -> [Int] -> Int
countTL' [] [r] = r
countTL' (X v:es) rs = countTL' es (0:rs)
countTL' (App e1 e2:es) rs = countTL' (e1:e2:RApp: es) rs
countTL' (RApp:es) (e2:e1:rs) = countTL' es (e1 + e2:rs)
countTL' (L v e : es) rs = countTL' (e: LR v : es) rs
countTL' (RL v : es) (e:rs) = countTL' es (1+e : rs)


-- en chi, usamos fix en vez de rec (pero funcionan exactamente igual)
fix f = let x = f x in x

data N = O | S N

data List a = Nil | Const a (List a)

countX = \e -> countX' (Const e Nil) Nil

countX' = fix (\c-> \es rs-> case es of{
    Nil -> case rs of {Const r _ -> r};
    Const e es' -> case e of{
        X v -> c es' (Const O rs);
        App e1 e2 ->c (Const e1 (Const e2 (Const RApp es')) rs;
        RApp -> case rs of {Const e2 (Const e1 rs') -> c es' (Const (sum e1 e2) rs')};
        L v e->c (Const e (Const (RL v) es')) rs;
        RL v -> case rs of {Const e rs' -> c es' (Const (S e) rs')} ;
    }
})

sum = fix (\s -> \n m -> case n of {
    O -> m;
    S y -> s y (S m)
})

-- 1.3
{- recibimos la expresion en e y devolvemos en ret
es, rs := Const e Nil, Nil

while es of {
    Const e es' -> case e of{
         X v -> es, rs := es', Const O rs |
        App e1 e2 -> es := Const e1 (Const e2 (Const RApp es')) |
        RApp -> case rs of{
            Const e2 (Const e1 (Const rs')) -> SUM ; es, rs := es', Const sum rs'
        } |
        L v e-> es := Const e (Const (RL v) es')|
        RL v -> case rs of {
            Const e rs' -> es, rs:= es', Const (S e) rs'
        }|
    }
}

-}

{- macro SUM recibe numeros en e1 y e2, devuelve en sum
cont, sum := e1, e2
while cont of{
    S x -> cont, sum := x, S sum 
}

-}


-- 2
{-
D: Lista de items numerados, que contienen peso y valor
Q: Existe una manera de almacenar items de un valor de al menos B con una capacidad de hasta C?
Ɛ: lista ordenada con los indices de los items que pertenecen a la mochila

Dada un problema y una evidencia, podemos verificar la evidencia en tiempo polinomial?
Recorremos la lista de indices y vamos a la lista de items buscando ese indice
Vamos guardando la suma de los valores y pesos totales
Cuando terminamos de recorrer la lista de indices nos fijamos si
    1) La suma de los valores totales es mayor o igual a B
    2) La suma de los pesos totales es menor o igual a C

Esto es de O(n), entonces demostramos que este problema es NP
-}

-- 3.1
{-
Queremos demostrar, dado un P decidible, demostrar que not P tambien lo es

Como sabemos que P es decidible, entonces existe un programa m que decide el problema
Si tomamos el resultado de este programa y lo negamos entonces nos da not P
Este programa lo podemos escribir
\[p] case m p of{True -> False; False -> True}
Entonces not P es decidible
-}

-- 3.2
-- Demostracion por reduccion del halting problem

-- 3.3
-- Demostracion por reduccion o usando Rice
