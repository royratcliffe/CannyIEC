(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
Stashed := BYTE_TO_WORD(Lo_fb.Stashed) OR SHL(BYTE_TO_WORD(Hi_fb.Stashed), 8);
