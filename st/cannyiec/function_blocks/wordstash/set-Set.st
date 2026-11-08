(* --- Interface --- *)
METHOD Set : WORD
VAR_INPUT
	Stashing_u16 : WORD;
END_VAR

(* --- Implementation --- *)
Set := BYTE_TO_WORD(Lo_fb.Set(WORD_TO_BYTE(Stashing_u16))) OR SHL(BYTE_TO_WORD(Hi_fb.Set(WORD_TO_BYTE(SHR(Stashing_u16, 8)))), 8);
