(* --- Interface --- *)
METHOD Stash : BYTE
VAR_INPUT
	ByteSetReset_st : ByteSetReset;
END_VAR

(* --- Implementation --- *)
Stash := Set(ByteSetReset_st.Set_u8) XOR Reset(ByteSetReset_st.Reset_u8);
