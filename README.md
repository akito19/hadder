# Hadder

Hadder is a simple adder/multiplier. It outputs calculation results as DIMACS form.

This tool calculates addition and multiplication to give 2 numbers with bits:

### Installation

Requirements:
* Stack 1.9.3+
* GHC 8.0.2+

```
$ git clone https://github.com/akito19/hadder
$ stack install hadder
```

### Behavior

```
$ hadder add 6 8 5 3
c CNF encoding of `6 + 5`
p cnf 1 9
-9 0
-8 0
-7 0
-6 0
-5 0
4 0
-3 0
2 0
1 0
```

`add 6 8 5 3` means that `6(8 bit) + 5(3 bit)`, namely, `00000110 + 101`.
Furthermore, after giving the output to SAT solver such as miniSAT, the solver calculate them.

```
$ hadder add 6 8 5 3 > try.cnf
$ minisat try.cnf output
============================[ Problem Statistics ]=============================
|                                                                             |
|  Number of variables:             9                                         |
|  Number of clauses:               0                                         |
|  Parse time:                   0.00 s                                       |
|                                                                             |
============================[ Search Statistics ]==============================
| Conflicts |          ORIGINAL         |          LEARNT          | Progress |
|           |    Vars  Clauses Literals |    Limit  Clauses Lit/Cl |          |
===============================================================================
===============================================================================
restarts              : 1
conflicts             : 0              (0 /sec)
decisions             : 1              (0.00 % random) (783 /sec)
propagations          : 9              (7048 /sec)
conflict literals     : 0              (-nan % deleted)
Memory used           : 20.00 MB
CPU time              : 0.001277 s

SATISFIABLE
$ cat output
SAT
1 2 -3 4 -5 -6 -7 -8 -9 0
```

As arranging the output from right, `1 2 -3 4 -5 -6 -7 -8 -9` is conerted to `000001011`, and it means `11` as binary number.

### Argument

The tool requires 5 arguments when running.

| # | value     | Description                                         |
| - | -----     | --------------------------------------------------- |
| 1 | add / mul | Specify operation which addition or multiplication. |
| 2 | number    | Numer to be added / multiplicand.                   |
| 3 | # of bit  | Number of bits of 2nd arg.                          |
| 4 | number    | Number to add / multiplier.                         |
| 5 | # of bit  | Number of bits of 4th arg.                          |
