module Rec where

rec :: (t -> t) -> t
rec f = f (rec f)
--para probar programar con rec

data N = O | S N
    deriving Show
suma = rec (\sum-> \m n-> case m of {
    O -> n;
    S x -> S (sum x n)
})

resta = rec (\r-> \m n-> case m of{
    O -> O;
    S x -> case n of {
        O -> m;
        S y -> r x y
    }
})

mult = rec (\mul -> \m n -> case m of{
    O -> O;
    S x -> suma n (mul x n)
})