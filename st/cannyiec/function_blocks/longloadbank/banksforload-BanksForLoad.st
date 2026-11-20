(* --- Interface --- *)
METHOD BanksForLoad : DINT
VAR_INPUT
	load : DWORD;
END_VAR
VAR_IN_OUT
	banks : ARRAY[*] OF LOAD_BANK;
END_VAR
VAR
	tail : CONS_REG := head;
	setReset : LongSetReset;
	bankIndex : DINT := LOWER_BOUND(banks, 1);
	bankCount : DINT := 0;
END_VAR

(* --- Implementation --- *)
(* It does not make sense to ask for "a" bank, since there may be
   multiple banks that satisfy the load condition. Instead, this method
   collates all banks that satisfy the load condition, into the provided
   array, and returns the count of such banks. *)
WHILE tail <> CONS_NIL DO
	setReset := LongBankLoads[tail AND CONS_MAX];

	IF (load AND setReset.Set_u32) = setReset.Set_u32 AND (load AND NOT setReset.Reset_u32) = 0 THEN
		IF bankIndex <= UPPER_BOUND(banks, 1) THEN
			banks[bankIndex] := TO_SINT(LongBankLoadHeap.car(tail));
			bankIndex        := bankIndex + 1;
		END_IF

		bankCount := bankCount + 1;
	END_IF

	tail := LongBankLoadHeap.cdr(tail);
END_WHILE

BanksForLoad := bankCount;
