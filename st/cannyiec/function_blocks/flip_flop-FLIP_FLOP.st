(* --- Interface --- *)
FUNCTION_BLOCK FLIP_FLOP
VAR_INPUT
	IN : BOOL; (* Input signal *)
END_VAR
VAR_OUTPUT
	Q : BOOL; (* Output signal *)
END_VAR
VAR
	fbTrig : R_TRIG; (* Rising edge trigger function block *)
	xFlip  : BOOL;   (* Internal flip-flop state *)
END_VAR
VAR_TEMP
	xFlop : BOOL; (* Temporary variable for edge detection *)
END_VAR

(* --- Implementation --- *)
fbTrig(CLK := IN, Q => xFlop);

(* Temporarily disable SA0062 warning. The static analyser incorrectly
   flags the R_TRIG function block output as always FALSE. It does not
   have access to the actual run-time behaviour. *)
{analysis -62}
IF xFlop {analysis +62} THEN
	xFlip := NOT xFlip;
END_IF

(* Use a temporary variable for edge detection in order to avoid reading
   the previous state from the output. *)
Q := xFlip;
