(* --- Interface --- *)
FUNCTION ISIGNBIT : BIT
VAR_INPUT
    iValue : INT;
END_VAR

(* --- Implementation --- *)
ISIGNBIT := iValue < INT#0;