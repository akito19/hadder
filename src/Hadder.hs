module Hadder (hadder) where

import System.Environment
import Data.List
import Hadder.Util
import Hadder.Adder
import Hadder.Multiplier

-- Convert to binary.
-- e.g. `dec2Bin 6 5` is evaluated as ["0", "0", "1", "1", "0"]
dec2bin :: Int -> Int -> [String]
dec2bin n 0 = []
dec2bin 0 bitNum = dec2bin 0 (bitNum - 1) ++ ["0"]
dec2bin n bitNum
  | n `mod` 2 == 0 = dec2bin (n `div` 2) (bitNum - 1) ++ ["0"]
  | n `mod` 2 == 1 = dec2bin (n `div` 2) (bitNum - 1) ++ ["1"]

outputDIMACS :: String -> Int -> Int -> [[Int]] -> String
outputDIMACS ops x y list = comment ++ cnfHeader ++ cnfContent
    where
        comment    = "c CNF encoding of `" ++ show x ++ " " ++ ops ++ " " ++ show y ++ "`\n"
        numVar     = show $ last $ nub $ map abs $ concat list
        numClauses = show $ length list
        cnfHeader  = "p cnf " ++ numVar ++ " " ++ numClauses ++ "\n"
        cnfContent = concat [ intercalate " " (map show n) ++ " 0\n" | n <- list ]

hadder :: String -> Int -> Int -> Int -> IO ()
hadder operation num1 num2 alignNum = do
    let x = dec2bin num1 alignNum
    let y = dec2bin num2 alignNum
    let c = tail $ carryBit ["0"] (reverse x) (reverse y)
    case operation of
      "add" -> putStrLn $ outputDIMACS "+" num1 num2 (add [] x y c)
      -- Reverse y to use multiplier from y_0.
      "mul" -> putStrLn $ outputDIMACS "*" num1 num2 (mult [] x (reverse y))
