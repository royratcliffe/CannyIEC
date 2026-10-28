(* --- Interface --- *)
METHOD StashReset : BYTE
VAR_INPUT
	Stashing_u8: BYTE;
END_VAR

(* --- Implementation --- *)
StashReset := Stashed_u8 XOR Stashing_u8;
Stashed_u8 := Stashed_u8 AND Stashing_u8;
