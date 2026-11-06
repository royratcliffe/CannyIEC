(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE ByteReset : (
		reset0 := NOT BYTE#1, (* SHL(BYTE#1, 0) *)
		reset1 := NOT ROL(BYTE#1, 1),
		reset2 := NOT SHL(BYTE#1, 2),
		reset3 := NOT SHL(BYTE#1, 3),
		reset4 := NOT SHL(BYTE#1, 4),
		reset5 := NOT SHL(BYTE#1, 5),
		reset6 := NOT SHL(BYTE#1, 6),
		reset7 := NOT SHL(BYTE#1, 7)
	) BYTE;
END_TYPE
