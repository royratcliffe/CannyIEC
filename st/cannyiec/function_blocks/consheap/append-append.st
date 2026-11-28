(* --- Interface --- *)
METHOD append
VAR_IN_OUT
	head : CONS_REG;
END_VAR
VAR_INPUT
	tail : CONS_REG;
END_VAR

(* --- Implementation --- *)
IF head = CONS_NIL THEN
	head := tail;
ELSE
	rplacd(last(head), tail);
END_IF
