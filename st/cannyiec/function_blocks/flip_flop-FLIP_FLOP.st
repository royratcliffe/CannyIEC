(* --- Interface --- *)
FUNCTION_BLOCK FLIP_FLOP
VAR_INPUT
	IN : BOOL;
END_VAR
VAR_OUTPUT
	Q : BOOL;
END_VAR
VAR
	fbTrig : R_TRIG;
	xFlip  : BOOL;
END_VAR
VAR_TEMP
	xFlop : BOOL;
END_VAR

(* --- Implementation --- *)
fbTrig(CLK := IN, Q => xFlop);

{analysis -62}
IF xFlop THEN
	{analysis +62}
	xFlip := NOT xFlip;
END_IF

Q := xFlip;
