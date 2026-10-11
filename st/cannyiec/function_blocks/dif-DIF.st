(* --- Interface --- *)
FUNCTION_BLOCK DIF
VAR_INPUT
	IN: BOOL;
END_VAR
VAR_OUTPUT
	Q: BOOL;
END_VAR
VAR
	xWas: BOOL;
END_VAR

(* --- Implementation --- *)
Q := IN <> xWas;
xWas := IN;
