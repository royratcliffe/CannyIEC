(* --- Interface --- *)
METHOD Commit : DWORD
VAR_INPUT
END_VAR

(* --- Implementation --- *)
Commit := WORD_TO_DWORD(Lo_fb.Commit()) OR SHL(WORD_TO_DWORD(Hi_fb.Commit()), 16);
