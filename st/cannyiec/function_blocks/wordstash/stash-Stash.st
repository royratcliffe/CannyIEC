(* --- Interface --- *)
METHOD Stash : WORD
VAR_INPUT
	Stashing_st : WordSetReset;
END_VAR
VAR
	StashingLo_st : ByteSetReset;
	StashingHi_st : ByteSetReset;
END_VAR

(* --- Implementation --- *)
StashingLo_st.Set_u8   := WORD_TO_BYTE(Stashing_st.Set_u16);
StashingLo_st.Reset_u8 := WORD_TO_BYTE(Stashing_st.Reset_u16);
StashingHi_st.Set_u8   := WORD_TO_BYTE(SHR(Stashing_st.Set_u16, 8));
StashingHi_st.Reset_u8 := WORD_TO_BYTE(SHR(Stashing_st.Reset_u16, 8));
Stash                  := BYTE_TO_WORD(Lo_fb.Stash(StashingLo_st)) OR SHL(BYTE_TO_WORD(Hi_fb.Stash(StashingHi_st)), 8);
