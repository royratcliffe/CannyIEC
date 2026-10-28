(* --- Interface --- *)
(* Retains stash bits set in Stashing_u8 and clears the others. Returns the
   XOR of the previous stash value and Stashing_u8. *)
METHOD StashReset : BYTE
VAR_INPUT
	Stashing_u8: BYTE;
END_VAR

(* --- Implementation --- *)
StashReset := Stashed_u8 XOR Stashing_u8;
Stashed_u8 := Stashed_u8 AND Stashing_u8;
