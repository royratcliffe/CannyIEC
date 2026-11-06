(* --- Interface --- *)
METHOD Reset : DWORD
VAR_INPUT
	Stashing_u32 : DWORD;
END_VAR

(* --- Implementation --- *)
Reset := WORD_TO_DWORD(Lo_fb.Reset(DWORD_TO_WORD(Stashing_u32))) OR SHL(WORD_TO_DWORD(Hi_fb.Reset(DWORD_TO_WORD(SHR(Stashing_u32, 16)))), 16);
