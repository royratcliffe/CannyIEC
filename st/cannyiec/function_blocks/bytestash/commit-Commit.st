(* --- Interface --- *)
METHOD Commit : BYTE
VAR_INPUT
END_VAR

(* --- Implementation --- *)
Commit       := Stashed_u8 XOR Committed_u8;
Committed_u8 := Stashed_u8;
