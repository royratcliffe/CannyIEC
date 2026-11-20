(* --- Interface --- *)
METHOD Commit : BYTE
VAR_INPUT
END_VAR

(* --- Implementation --- *)
Commit       := Committing;
Committed_u8 := Stashed_u8;
