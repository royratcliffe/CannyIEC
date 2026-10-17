(* --- Interface --- *)
FUNCTION RSIGNBIT : BOOL
VAR_INPUT
	rValue : REAL;
END_VAR

(* --- Implementation --- *)
RSIGNBIT := rValue < REAL#0;
