(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
Committed := WORD_TO_DWORD(Lo_fb.Committed) OR SHL(WORD_TO_DWORD(Hi_fb.Committed), 16);
