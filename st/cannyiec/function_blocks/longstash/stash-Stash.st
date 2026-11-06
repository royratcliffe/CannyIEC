(* --- Interface --- *)
(* Applies the set and reset masks to both word stashes and returns the
   combined mask of changed bits in their original double-word positions. *)
METHOD Stash : DWORD
VAR_INPUT
	Stashing_st : LongSetReset;
END_VAR
VAR
	StashingLo_st : WordSetReset;
	StashingHi_st : WordSetReset;
END_VAR

(* --- Implementation --- *)
(* Split each double-word mask into its low and high word. *)
StashingLo_st.Set_u16   := DWORD_TO_WORD(Stashing_st.Set_u32);
StashingLo_st.Reset_u16 := DWORD_TO_WORD(Stashing_st.Reset_u32);
StashingHi_st.Set_u16   := DWORD_TO_WORD(SHR(Stashing_st.Set_u32, 16));
StashingHi_st.Reset_u16 := DWORD_TO_WORD(SHR(Stashing_st.Reset_u32, 16));
(* Apply the masks to each word stash, then reassemble the changed-bit masks. *)
Stash := WORD_TO_DWORD(Lo_fb.Stash(StashingLo_st)) OR SHL(WORD_TO_DWORD(Hi_fb.Stash(StashingHi_st)), 16);
