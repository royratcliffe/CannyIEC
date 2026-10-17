(* --- Interface --- *)
FUNCTION ISIGNBIT : BOOL
VAR_INPUT
	iValue : INT;
END_VAR

(* --- Implementation --- *)
ISIGNBIT := iValue < INT#0;
