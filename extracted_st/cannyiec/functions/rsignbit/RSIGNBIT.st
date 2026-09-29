(* --- Interface --- *)
FUNCTION RSIGNBIT : BIT
VAR_INPUT
    rValue : REAL;
END_VAR

(* --- Implementation --- *)
RSIGNBIT := rValue < REAL#0;
