(* --- Interface --- *)
(* Sets the requested bits in the stash and returns the XOR of the previous
   stash value and the requested bits. *)
METHOD Set : BYTE
VAR_INPUT
	Stashing_u8 : BYTE;
END_VAR

(* --- Implementation --- *)
Set        := Stashed_u8 XOR Stashing_u8;
Stashed_u8 := Stashed_u8 OR Stashing_u8;
