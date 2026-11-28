(* --- Interface --- *)
METHOD LoadForBank : BOOL
VAR_INPUT
	(* Bank to associate with the load. *)
	bank : LOAD_BANK;
	(* Set and reset bit masks for the bank. *)
	load : LongSetReset;
END_VAR
VAR
	tail : CONS_REG;
END_VAR

(* --- Implementation --- *)
(* Add the bank and load to the free heap when a cell is available.
   Return TRUE only when the load was added. *)
LoadForBank := FALSE;
tail        := LongBankLoadHeap.collect();

IF tail = CONS_NIL THEN
	RETURN;
END_IF

LongBankLoadHeap.cons(head, tail);
LongBankLoadHeap.rplaca(head, TO_USINT(bank));
LongBankLoads[head AND CONS_MAX] := load;
LoadForBank                      := TRUE;
