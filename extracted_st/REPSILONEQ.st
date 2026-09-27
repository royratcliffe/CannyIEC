(* --- Interface --- *)
FUNCTION REPSILONEQ : BOOL
VAR_INPUT
    rLHS     : REAL; (* nominal left-hand side *)
    rRHS     : REAL; (* nominal right-hand side *)
    rEpsilon : REAL := REAL#1e-6; (* allowable difference *)
END_VAR

(* --- Implementation --- *)
(* Error band is inclusive of the epsilon value.
Less than or equal to is close enough, rather than strict equality. *)
REPSILONEQ := ABS(rLHS - rRHS) <= rEpsilon;
