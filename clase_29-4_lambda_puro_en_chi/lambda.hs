module Lambda where

import Tarea1

-- type Var = String
-- type Id = String
-- type B = (Id, ([Var], E))

-- data E = X Var | C Id | L [Var] E | E :- [E] | Case E [B] | Rec E
--     deriving(Show)

c_0::E
c_0 = L["f"] (L["x"] (X "x"))

c_1::E
c_1 = L["f"] (L["x"] (X "f" :- [X "x"]))

c_2::E
c_2 = L["f"] (L["x"] (X "f" :- [X "f" :- [X "x"]]))

c_3::E
c_3 = L["f"] (L["x"] (X "f" :- [X "f" :- [X"f" :- [X "x"]]]))

c_4::E
c_4 = L["f"] (L["x"] (X "f" :- [X "f" :- [X"f" :- [X"f" :- [X "x"]]]]))

c_plus :: E
c_plus = L["m"] (L["n"] (L["f"] (L["x"] ((X "m" :- [X "f"]):- [(X "n" :- [X "f"]):-[X "x"]]))))

c_1_plus_2 :: E
c_1_plus_2 = eval ((c_plus :- [c_1]):-[c_2])

c_1_plus_2_S_O :: E
c_1_plus_2_S_O = eval ((((c_plus :- [c_1]):-[c_2]):- [C"S"]):-[C"O"])

--t = \x.(\y. x)
t :: E
t = L ["x"] (L ["y"] (X "x"))

--f = \x.(\y. y)
f :: E
f = L ["x"] (L ["y"] (X "y"))

--not = \b.(\x.\y.(b [y])[x])
nnot :: E
nnot = L["b"] (L["x"] (L["y"] ((X "b" :- [X"y"]) :- [X"x"])))

nnot_t :: E
nnot_t = eval (nnot :- [t])
nnot_f :: E
nnot_f = eval (nnot :- [f])

nnot_t_T_F :: E
nnot_t_T_F = eval (((nnot :- [t]) :- [C "True"]):-[C"False"])

nnot_f_T_F :: E
nnot_f_T_F = eval (((nnot :- [f]) :- [C "True"]):-[C"False"])

c_mul :: E
c_mul = L["m"] (L["n"]  (L["f"] (X"m":-[X"n":-[X"f"]])))

pair :: E
pair = L["x"] (L["y"] (L["f"] ((X "f" :- [X"x"]):- [X"y"])))

first :: E
first = L["p"] (X"p" :- [t])

second :: E
second = L["p"] (X"p" :- [f])

s::E
s = L["n"] (L["f"] (L["x"] (X "f" :- [(X "n" :- [X"f"]):- [X "x"]])))

s' :: E
s' = L ["p"] ((pair :- [second :- [X"p"]]):- [s :- [second :- [X"p"]]])

p :: E
p = L["n"] (first :- [(X "n" :- [s']):-[(pair :- [c_0]):-[c_0]]])

c_ :: E
c_ = L["m"] (L["n"] ((X"n" :- [p]):- [X"m"]))

p_4_minus_1 = eval ((((c_:-[c_4]):- [c_1]):-[C"S"]):-[C"O"])

y :: E
y= L["f"](L["x"] (X "x" :- [(X"f" :- [X"f"]) :- [X "x"]])) :- [L["f"](L["x"] (X "x" :- [(X"f" :- [X"f"]) :- [X "x"]]))]

if_0 :: E
if_0 = L["n"] ((X"n" :- [L["x"] (f)]):-[t])

sum_upto :: E
sum_upto = (y:-[L["r"] (L["n"] (((if_0 :-[X"n"]):-[c_0]):-[(c_plus:-[X"n"]):-[X"r" :- [p :- [X"n"]]]]))])

expo :: E
expo = (y:-[L["r"] (L["n"] (((if_0 :-[X"n"]):-[c_1]):-[(c_mul:-[X"n"]):-[X"r" :- [p :- [X"n"]]]]))])