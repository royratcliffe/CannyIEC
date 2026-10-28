(* --- Interface --- *)
METHOD StashReset : BYTE
VAR_INPUT
	Stashing_u8: BYTE;
END_VAR
VAR
	Resetting_u8: BYTE;
END_VAR

(* --- Implementation --- *)
Resetting_u8 := NOT Stashing_u8;

StashReset := Stashed_u8 XOR Resetting_u8;

Stashed_u8 := Stashed_u8 AND Resetting_u8;
