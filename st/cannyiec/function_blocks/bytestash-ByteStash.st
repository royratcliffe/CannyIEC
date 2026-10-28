(* --- Interface --- *)
FUNCTION_BLOCK ByteStash
VAR_INPUT
	EN : BOOL;
END_VAR
VAR_OUTPUT
	ENO : BOOL;
END_VAR
VAR
	Stashed_u8   : BYTE;
	Committed_u8 : BYTE;
END_VAR

(* --- Implementation --- *)
IF EN THEN
	IF Commit() <> BYTE#0 THEN
		ENO := TRUE;
	END_IF
END_IF
