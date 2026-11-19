(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
Stashed := WORD_TO_DWORD(Lo_fb.Stashed) OR SHL(WORD_TO_DWORD(Hi_fb.Stashed), 16);
