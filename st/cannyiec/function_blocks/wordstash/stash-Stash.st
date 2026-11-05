(* --- Interface --- *)
(* Applies the set and reset masks to both byte stashes and returns the
   combined mask of changed bits in their original word positions. *)
METHOD Stash : WORD
VAR_INPUT
	Stashing_st : WordSetReset;
END_VAR
VAR
	StashingLo_st : ByteSetReset;
	StashingHi_st : ByteSetReset;
END_VAR

(* --- Implementation --- *)
(* Split each word mask into its low and high byte. *)
StashingLo_st.Set_u8   := WORD_TO_BYTE(Stashing_st.Set_u16);
StashingLo_st.Reset_u8 := WORD_TO_BYTE(Stashing_st.Reset_u16);
StashingHi_st.Set_u8   := WORD_TO_BYTE(SHR(Stashing_st.Set_u16, 8));
StashingHi_st.Reset_u8 := WORD_TO_BYTE(SHR(Stashing_st.Reset_u16, 8));
(* Apply the masks to each byte stash, then reassemble the changed-bit masks. *)
Stash := BYTE_TO_WORD(Lo_fb.Stash(StashingLo_st)) OR SHL(BYTE_TO_WORD(Hi_fb.Stash(StashingHi_st)), 8);
