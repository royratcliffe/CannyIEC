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
tail        := LongBankLoadHeap.collect();

IF tail = CONS_NIL THEN
	RETURN;
END_IF

LongBankLoadHeap.cons(head, tail);
LongBankLoadHeap.rplaca(head, TO_USINT(bank));
LongBankLoads[head AND CONS_MAX] := load;
LoadForBank              := TRUE;
