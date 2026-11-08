(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE ByteSet : (
		setNone := BYTE#16#00,
		set0    := BYTE#01, (* SHL(BYTE#01, 0) *)
		set1    := SHL(BYTE#01, 1),
		set2    := SHL(BYTE#01, 2),
		set3    := SHL(BYTE#01, 3),
		set4    := SHL(BYTE#01, 4),
		set5    := SHL(BYTE#01, 5),
		set6    := SHL(BYTE#01, 6),
		set7    := SHL(BYTE#01, 7),
		setAll  := BYTE#16#FF
	) BYTE;
END_TYPE
