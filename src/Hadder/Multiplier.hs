module Hadder.Multiplier (mult) where

import Data.List
import Hadder.Util
import Hadder.Adder

shiftBit :: [String] -> [String]
shiftBit x = tail x ++ ["0"]

trueY :: [String] -> String -> [String]
trueY x y
  | y == "1" = x
  | y == "0" = take (length x) $ repeat "0"

-- Each [[Int]] have just 1 element, so compere 0 with first element of the list.
convertTruthValue :: [String] -> [[Int]] -> [String]
convertTruthValue val []         = val
convertTruthValue val (x : xs)
  | head x > 0 = convertTruthValue (val ++ ["1"]) xs
  | head x < 0 = convertTruthValue (val ++ ["0"]) xs

fitBitNum :: [String] -> [String] -> ([String], [String])
fitBitNum n@(x : _) m@(y : _)
  | length n < length m = fitBitNum (["0"] ++ n) m
  | length n > length m = fitBitNum n (["0"] ++ m)
  | otherwise           = (n, m)

-- mult [] ["0", "0", "0", "1", "1"] ["1", "1", "0", "0", "0"]
mult ::  [[String]] -> [String] -> [String] -> [[Int]]
mult cnf x []       = addForMult [] cnf
mult cnf x (y : ys) = mult (trueY x y : cnf) (shiftBit x) ys

addForMult :: [String] -> [[String]] -> [[Int]]
addForMult result         []   = addForMult' [] (zip [1..] $ map (\x -> [x]) (reverse result))
addForMult []     (x : y : zs) = addForMult (convertTruthValue [] $ add [] x' y c) zs
    where
        x' = fst $ fitBitNum x y
        c  = tail $ carryBit ["0"] (reverse x') (reverse y)
addForMult result (x : xs) = addForMult (convertTruthValue [] $ add [] x' result c) xs
    where
        x' = snd $ fitBitNum result x
        c  = tail $ carryBit ["0"] (reverse x') (reverse result)

addForMult' :: [[Int]] -> [(Int, [String])] -> [[Int]]
addForMult' cnf []            = cnf
addForMult' cnf ((i, e) : xs) = addForMult' ([x] : cnf) xs
    where
        e' = concat e
        x  = if e' == "1" then i else -i
