(* --- Interface --- *)
{attribute 'analysis' := '-62'}
FUNCTION_BLOCK BINGED
VAR_INPUT
	bIng     : BYTE;
	tLatency : TIME := T#3S;
END_VAR
VAR_OUTPUT
	bEd : BYTE;
	ENO : BOOL;
END_VAR
VAR
	bIngEd : BYTE;
	fbTON  : TON;
END_VAR
