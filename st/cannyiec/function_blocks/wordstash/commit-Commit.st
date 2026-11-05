(* --- Interface --- *)
METHOD Commit : WORD
VAR_INPUT
END_VAR

(* --- Implementation --- *)
Commit := BYTE_TO_WORD(Lo_fb.Commit()) OR SHL(BYTE_TO_WORD(Hi_fb.Commit()), 8);
