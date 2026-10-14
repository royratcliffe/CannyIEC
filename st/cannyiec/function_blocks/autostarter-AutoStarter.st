(* --- Interface --- *)
FUNCTION_BLOCK AutoStarter
VAR_INPUT
	tEngaging : TIME := T#3S;
	tStarting : TIME := T#3S;
	xRunning  : BOOL;
	xEngage   : BOOL;
END_VAR
VAR_OUTPUT
	xStart : BOOL;
END_VAR
