(* --- Interface --- *)
METHOD StashSet : BYTE
VAR_INPUT
	Stashing_u8: BYTE;
END_VAR

(* --- Implementation --- *)
StashSet := Stashed_u8 XOR Stashing_u8;

Stashed_u8 := Stashed_u8 OR Stashing_u8;
