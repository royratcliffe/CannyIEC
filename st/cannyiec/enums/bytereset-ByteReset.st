(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE ByteReset : (
		resetAll  := BYTE#16#00,
		reset0    := NOT BYTE#01, (* SHL(BYTE#01, 0) *)
		reset1    := NOT SHL(BYTE#01, 1),
		reset2    := NOT SHL(BYTE#01, 2),
		reset3    := NOT SHL(BYTE#01, 3),
		reset4    := NOT SHL(BYTE#01, 4),
		reset5    := NOT SHL(BYTE#01, 5),
		reset6    := NOT SHL(BYTE#01, 6),
		reset7    := NOT SHL(BYTE#01, 7),
		resetNone := BYTE#16#FF
	) BYTE;
END_TYPE
