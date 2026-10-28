(* --- Interface --- *)
METHOD Stash : BYTE
VAR_INPUT
	ByteSetReset_st: ByteSetReset;
END_VAR

(* --- Implementation --- *)
Stash := StashSet(ByteSetReset_st.Set_u8) XOR StashReset(ByteSetReset_st.Reset_u8);
