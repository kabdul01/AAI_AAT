include "globals.mzn"; 

int: n = 5;
array[1..n, 1..n] of int: matrix = 
   array2d(1..n, 1..n,
    [
    20, 14, 119, 100, 29,
   15,  1,  9,  7, 10,
   14, 12, 21, 24,  8,
    3, 25, 22, 18,  4,
   20, 19,  6,  5, 17,
   ]);        


% decision values
array[1..n, 1..n] of var 0..1: x;
array[1..n] of var 1..25: y;


solve :: int_search([x[i,j] | i,j in 1..n], input_order, indomain_min, complete) minimize max(y);

constraint

   forall(i in 1..n) (
      sum([x[i,j] | j in 1..n]) = 1 /\
      sum([x[j,i] | j in 1..n]) = 1
   )
   /\
   forall(j in 1..n) (
      exists(i in 1..n) (
        x[i,j] = 1 /\ 
        y[j] = matrix[i,j]
      )
   )
;


output 
[ "y: " ++ show(y) ++ " max y:" ++ show(max(y)) ++ "\n" ] 
++
[
  if j = 1 then "\n" else " " endif ++
    if fix(x[i,j]) = 1 then 
       show_int(2, matrix[i,j])
    else 
       "__"
    endif
  | i,j in 1..n
]
++ ["\n"] ++ 
[
  if j = 1 then "\n" else " " endif ++
    show_int(2, matrix[i,j])
  | i,j in 1..n
]
;
