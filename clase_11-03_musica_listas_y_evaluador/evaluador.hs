module Evaluador where
--La letra esta en el teams Guia_Evaluador_+-

data Exp = Lit Int -- literal, un numero
  | (:+) Exp Exp -- la suma de dos expresiones
  | (:-) Exp Exp -- la resta de dos expresiones
  deriving Show

a :: Exp
a = Lit 1
b :: Exp
b = Lit 1 :+ Lit 2
c :: Exp
c = (Lit 1 :- Lit 2) :- Lit 3
d :: Exp
d = Lit 1 :- (Lit 2 :- Lit 3)

eval :: Exp -> Int
eval (Lit n) = n
eval (e1 :+ e2) = eval e1 + eval e2
eval (e1 :- e2) = eval e2 - eval e2