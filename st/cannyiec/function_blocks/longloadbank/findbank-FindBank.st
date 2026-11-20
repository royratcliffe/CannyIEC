(* --- Interface --- *)
METHOD PROTECTED FindBank : CONS_REG
VAR_INPUT
	bank : LOAD_BANK;
END_VAR
VAR
	tail : CONS_REG := head;
END_VAR

(* --- Implementation --- *)
WHILE tail <> CONS_NIL DO
	IF TO_SINT(heap.car(tail)) = bank THEN
		EXIT;
	END_IF

	tail := heap.cdr(tail);
END_WHILE

FindBank := tail;
