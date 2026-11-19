(* --- Interface --- *)
FUNCTION_BLOCK LongLoadBank
VAR_INPUT
	EN : BOOL; (* Enables commit processing for this scan. *)
END_VAR
VAR_OUTPUT
	ENO : BOOL; (* Set TRUE when a commit reports one or more changed bits. *)
END_VAR
VAR
	longStash : LongStash;
	loads     : ARRAY[1..CONS_MAX] OF LongSetReset;
	heap      : ConsHeap;
	head      : CONS_REG;
END_VAR

(* --- Implementation --- *)
longStash(EN := EN, ENO => ENO);
