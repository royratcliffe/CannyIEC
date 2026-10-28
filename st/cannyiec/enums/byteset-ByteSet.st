(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE ByteSet : (
		set0 := SHL(BYTE#1, 0),
		set1 := SHL(BYTE#1, 1),
		set2 := SHL(BYTE#1, 2),
		set3 := SHL(BYTE#1, 3),
		set4 := SHL(BYTE#1, 4),
		set5 := SHL(BYTE#1, 5),
		set6 := SHL(BYTE#1, 6),
		set7 := SHL(BYTE#1, 7)
	) BYTE;
END_TYPE
