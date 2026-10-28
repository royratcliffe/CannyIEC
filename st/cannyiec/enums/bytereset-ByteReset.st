(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE ByteReset :
(
	reset0 := SHL(BYTE#1, 0),
	reset1 := SHL(BYTE#1, 1),
	reset2 := SHL(BYTE#1, 2),
	reset3 := SHL(BYTE#1, 3),
	reset4 := SHL(BYTE#1, 4),
	reset5 := SHL(BYTE#1, 5),
	reset6 := SHL(BYTE#1, 6),
	reset7 := SHL(BYTE#1, 7)
) BYTE;
END_TYPE
