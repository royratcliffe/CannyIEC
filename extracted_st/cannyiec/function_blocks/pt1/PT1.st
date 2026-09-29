(* --- Interface --- *)
FUNCTION_BLOCK PT1
VAR_INPUT
	IN: REAL;
END_VAR
VAR_OUTPUT
	Q1: REAL;
END_VAR
VAR_INPUT
	P: REAL;
END_VAR
VAR
	P1: REAL;
	Q: REAL;
END_VAR

(* --- Implementation --- *)
P1 := LIMIT(0, P, 1);
Q1 := (IN * P1) + (Q * (1 - P1));
Q := Q1;