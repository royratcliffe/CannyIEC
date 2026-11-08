(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE WordReset : (
		resetAll  := WORD#16#0000,
		reset0    := NOT WORD#16#0001, (* SHL(WORD#16#0001, 0) *)
		reset1    := NOT SHL(WORD#16#0001, 1),
		reset2    := NOT SHL(WORD#16#0001, 2),
		reset3    := NOT SHL(WORD#16#0001, 3),
		reset4    := NOT SHL(WORD#16#0001, 4),
		reset5    := NOT SHL(WORD#16#0001, 5),
		reset6    := NOT SHL(WORD#16#0001, 6),
		reset7    := NOT SHL(WORD#16#0001, 7),
		reset8    := NOT SHL(WORD#16#0001, 8),
		reset9    := NOT SHL(WORD#16#0001, 9),
		reset10   := NOT SHL(WORD#16#0001, 10),
		reset11   := NOT SHL(WORD#16#0001, 11),
		reset12   := NOT SHL(WORD#16#0001, 12),
		reset13   := NOT SHL(WORD#16#0001, 13),
		reset14   := NOT SHL(WORD#16#0001, 14),
		reset15   := NOT SHL(WORD#16#0001, 15),
		resetNone := WORD#16#FFFF
	) WORD;
END_TYPE
