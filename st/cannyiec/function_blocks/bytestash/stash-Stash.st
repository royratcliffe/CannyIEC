(* --- Interface --- *)
METHOD Stash : BYTE
VAR_INPUT
	Stashing_st : ByteSetReset;
END_VAR

(* --- Implementation --- *)
Stash := Set(Stashing_st.Set_u8) XOR Reset(Stashing_st.Reset_u8);
