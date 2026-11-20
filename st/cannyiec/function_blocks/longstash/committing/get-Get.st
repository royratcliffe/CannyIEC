(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
Committing := WORD_TO_DWORD(Lo_fb.Committing) OR SHL(WORD_TO_DWORD(Hi_fb.Committing), 16);
