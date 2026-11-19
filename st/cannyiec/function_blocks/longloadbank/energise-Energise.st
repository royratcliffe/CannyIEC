(* --- Interface --- *)
METHOD Energise : BOOL
VAR_INPUT
	bank : LOAD_BANK;
END_VAR
VAR
	tail : CONS_REG;
END_VAR

(* --- Implementation --- *)
Energise := FALSE;
tail     := FindBank(bank);

IF tail = CONS_NIL THEN
	RETURN;
END_IF

Energise := longStash.Stash(loads[tail AND CONS_MAX]) <> 0;
