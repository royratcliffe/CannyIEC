(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
Committed := BYTE_TO_WORD(Lo_fb.Committed) OR SHL(BYTE_TO_WORD(Hi_fb.Committed), 8);
