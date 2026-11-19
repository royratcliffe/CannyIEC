(* --- Interface --- *)
METHOD DeEnergise : BOOL
VAR_INPUT
	bank : LOAD_BANK;
END_VAR
VAR
	tail : CONS_REG;
	load : LongSetReset;
END_VAR

(* --- Implementation --- *)
DeEnergise := FALSE;
tail       := FindBank(bank);

IF tail = CONS_NIL THEN
	RETURN;
END_IF

load           := loads[tail AND CONS_MAX];
load.Set_u32   := NOT load.Set_u32;
load.Reset_u32 := NOT load.Reset_u32;
DeEnergise     := longStash.Stash(load) <> 0;
