(* --- Interface --- *)
FUNCTION REPSILONEQ : BOOL
VAR_INPUT
    rLHS     : REAL; (* nominal left-hand side *)
    rRHS     : REAL; (* nominal right-hand side *)
    rEpsilon : REAL; (* allowable difference *)
END_VAR

(* --- Implementation --- *)
(* Should real-epsilon comparison use "less than, or "less than or equal
to"? What should happen on the epsilon boundary? At its extreme, epsilon
is the smallest possible difference representable in the system.

In addition, what happens if rEpsilon is zero, or even negative? *)
REPSILONEQ := ABS(rLHS - rRHS) < rEpsilon;
