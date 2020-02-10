module Hadder.Util where

import Data.List

not' :: String -> String
not' x
  | x == "0"  = "1"
  | x == "1"  = "0"
  | otherwise = "nop"

conjunct :: String -> String -> String
conjunct x y
  | x == "1"   && y == "1"   = "1"
  | x == "1"   && y == "nop" = "1"
  | x == "nop" && y == "1"   = "1"
  | x == "nop" && y == "nop" = "nop"
  | otherwise                = "0"

disjunct :: String -> String -> String
disjunct x y
  | x == "0"   && y == "0"   = "0"
  | x == "0"   && y == "nop" = "0"
  | x == "nop" && y == "0"   = "0"
  | x == "nop" && y == "nop" = "nop"
  | otherwise                = "1"

carryBit :: [String] -> [String] -> [String] -> [String]
carryBit result         []       []       = result
carryBit result@(c : _) (x : xs) (y : ys)
  | length result == 1 = carryBit (conjunct   x y   : result) xs ys
  | otherwise          = carryBit (atLeastTwo x y c : result) xs ys

atLeastTwo :: String -> String -> String -> String
atLeastTwo x y c = conjunct (conjunct (disjunct x y) (disjunct x c)) (disjunct y c)
