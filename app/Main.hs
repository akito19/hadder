module Main where

import System.Environment
import Hadder

compensate :: Int -> Int -> Maybe Int
compensate n m
  | n < m     = Nothing
  | otherwise = Just n

stringToInt :: String -> Int
stringToInt x = read x :: Int

-- Example of calculate addition which is `5 + 6` (5 bit and 4 bit)
--  $ ./hadder add 5 5 6 4 
--
-- Example of calculate multiplication which is `10 * 6` (6 bit and 4 bit)
--  $ ./hadder mul 10 6 8 4
main :: IO ()
main = do
    args <- getArgs
    let operation = args !! 0
    let num1      = stringToInt (args !! 1)
    let bitNum1   = stringToInt (args !! 2)
    let num2      = stringToInt (args !! 3)
    let bitNum2   = stringToInt (args !! 4)
    case compensate bitNum1 bitNum2 of
      Nothing -> putStrLn "2nd argument must be bigger number then 4th.\n"
      Just b  -> hadder operation num1 num2 b
