(* --- Interface --- *)
METHOD append
VAR_INPUT
	head, tail : CONS_REG;
END_VAR

(* --- Implementation --- *)
rplacd(last(head), tail);
