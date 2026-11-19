(* --- Interface --- *)
METHOD LoadForBank : BOOL
VAR_INPUT
	bank : LOAD_BANK;
	load : LongSetReset;
END_VAR
VAR
	tail : CONS_REG;
END_VAR

(* --- Implementation --- *)
LoadForBank := FALSE;
tail        := heap.collect();

IF tail = CONS_NIL THEN
	RETURN;
END_IF

heap.cons(head, tail);
heap.rplaca(head, TO_USINT(bank));
loads[head AND CONS_MAX] := load;
LoadForBank              := TRUE;
