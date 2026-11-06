(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
TYPE WordSet : (
		setNone := WORD#16#0000,
		set0    := WORD#16#0001, (* SHL(BYTE#16#0001, 0) *)
		set1    := SHL(WORD#16#0001, 1),
		set2    := SHL(WORD#16#0001, 2),
		set3    := SHL(WORD#16#0001, 3),
		set4    := SHL(WORD#16#0001, 4),
		set5    := SHL(WORD#16#0001, 5),
		set6    := SHL(WORD#16#0001, 6),
		set7    := SHL(WORD#16#0001, 7),
		set8    := SHL(WORD#16#0001, 8),
		set9    := SHL(WORD#16#0001, 9),
		set10   := SHL(WORD#16#0001, 10),
		set11   := SHL(WORD#16#0001, 11),
		set12   := SHL(WORD#16#0001, 12),
		set13   := SHL(WORD#16#0001, 13),
		set14   := SHL(WORD#16#0001, 14),
		set15   := SHL(WORD#16#0001, 15),
		setAll  := WORD#16#FFFF
	) WORD;
END_TYPE
