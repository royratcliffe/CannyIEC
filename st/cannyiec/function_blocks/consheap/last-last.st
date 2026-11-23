(* --- Interface --- *)
METHOD last : CONS_REG
VAR_INPUT
	head : CONS_REG;
END_VAR
VAR
	tail : CONS_REG := head;
END_VAR

(* --- Implementation --- *)
last := CONS_NIL;

WHILE tail <> CONS_NIL DO
	last := tail;
	tail := cdr(tail);
END_WHILE
