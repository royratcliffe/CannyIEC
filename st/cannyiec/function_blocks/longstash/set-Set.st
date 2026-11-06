(* --- Interface --- *)
METHOD Set : DWORD
VAR_INPUT
	Stashing_u32 : DWORD;
END_VAR

(* --- Implementation --- *)
Set := WORD_TO_DWORD(Lo_fb.Set(DWORD_TO_WORD(Stashing_u32))) OR SHL(WORD_TO_DWORD(Hi_fb.Set(DWORD_TO_WORD(SHR(Stashing_u32, 16)))), 16);
