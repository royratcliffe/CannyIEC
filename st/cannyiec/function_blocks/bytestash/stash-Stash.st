(* --- Interface --- *)
METHOD Stash : BYTE
VAR_INPUT
	Stashing_st : ByteSetReset;
END_VAR
VAR
	Reset_u8 : BYTE;
END_VAR

(* --- Implementation --- *)
(* When stashing, perform the reset operation first, then the set
   operation. In case of overlapping set and reset bits, the set takes
   precedence since it applies last. *)
Reset_u8 := Reset(Stashing_st.Reset_u8);
Stash    := Set(Stashing_st.Set_u8) XOR Reset_u8;
