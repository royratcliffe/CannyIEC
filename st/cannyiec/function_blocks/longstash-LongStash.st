(* --- Interface --- *)
FUNCTION_BLOCK LongStash
VAR_INPUT
	EN : BOOL;
END_VAR
VAR_OUTPUT
	ENO : BOOL;
END_VAR
VAR
	Lo_fb, Hi_fb : WordStash;
END_VAR

(* --- Implementation --- *)
IF EN THEN
	IF Commit() <> DWORD#0 THEN
		ENO := TRUE;
	END_IF;
END_IF;
