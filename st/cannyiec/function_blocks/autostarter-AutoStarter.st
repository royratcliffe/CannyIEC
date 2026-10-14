(* --- Interface --- *)
FUNCTION_BLOCK AutoStarter
VAR_INPUT
	tEngaging: TIME := T#3s;
	tStarting: TIME := T#3s;
	xRunning: BOOL;
END_VAR
VAR
	xEngage: BOOL;
	xStart: BOOL;
END_VAR
