(* --- Interface --- *)
FUNCTION_BLOCK AutoStarter
VAR_INPUT
	tEngaging : TIME := T#3S;
	tStarting : TIME := T#3S;
	xRunning  : BOOL;
END_VAR
VAR
	xEngage : BOOL;
	xStart  : BOOL;
END_VAR
