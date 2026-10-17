(* --- Interface --- *)
{attribute 'qualified_only'}
{attribute 'strict'}
(* A proposition's known state. Unknown is distinct from known false. *)
TYPE E_Trivalent : (
		holding_unknown := 0,
		holding,
		not_holding
	);
END_TYPE
