(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
Committing := BYTE_TO_WORD(Lo_fb.Committing) OR SHL(BYTE_TO_WORD(Hi_fb.Committing), 8);
