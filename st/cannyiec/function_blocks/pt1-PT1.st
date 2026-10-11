(* --- Interface --- *)
FUNCTION_BLOCK PT1
VAR_INPUT
	IN : REAL;        (* Input signal *)
	P  : REAL := 0.2; (* Proportional factor *)
END_VAR
VAR_OUTPUT
	Q : REAL; (* Output signal *)
END_VAR
VAR
	Q1 : REAL; (* Previous output signal, used for feedback *)
END_VAR
VAR_TEMP
	P1 : REAL; (* Limited proportional factor *)
END_VAR

(* --- Implementation --- *)
(* First, limit the proportional factor to the range [0, 1] because
values outside this range could lead to instability or unexpected
behaviour. Next, calculate the output signal using the limited
proportional factor and the internal state, i.e. the previous output
signal. The current cycle's output becomes the next cycle's feedback. *)
P1 := LIMIT(0, P, 1);
Q1 := (IN * P1) + (Q1 * (1 - P1));
Q  := Q1;
