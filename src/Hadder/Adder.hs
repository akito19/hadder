module Hadder.Adder (add) where

import Data.List
import Hadder.Util

add :: [[[String]]] -> [String] -> [String] -> [String] -> [[Int]]
add cnf []         []         _        = add' [] (zip [1..] cnf)
add cnf p@(x : xs) q@(y : ys) r@(c : cs)
  | null cnf  = add ([["nop", "nop", atLeastTwo x y c]] : cnf) p q r
  | otherwise = add (elm x y c : cnf) xs ys cs

add' :: [[Int]] -> [(Int, [[String]])] -> [[Int]]
add' cnf@(c : cs) [] = cnf
add' cnf (z : zs) = add' (toCNF z : cnf) zs

-- Create CNF as `X xor Y xor C`
elm :: String -> String -> String -> [[String]]
elm x y c = [[x, not' y, not' c], [not' x, y, not' c], [not' x, not' y, c], [x, y, c]]

-- Conversion to CNF
-- x + y = z
-- c is carry number
-- If it has non used elements, it returns 0, then the 0 is filtered at
-- `add'` fuction.
toCNF :: (Int, [[String]]) -> [Int]
toCNF (i, es) = filter (/= 0) [z]
    where
        e = toCNF' es
        z = if e == "1" then i else -i 

toCNF' :: [[String]] -> String
toCNF' ([x, y, c] : []) = disjunct (disjunct x y) c
toCNF' ([x, y, c] : es) = z
    where
        z = conjunct (disjunct (disjunct x y) c) (toCNF' es)
