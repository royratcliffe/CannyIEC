(* --- Interface --- *)
FUNCTION IsTrivalentKnown : BOOL
VAR_INPUT
	eTrivalent : E_Trivalent;
END_VAR
VAR
END_VAR

(* --- Implementation --- *)
IsTrivalentKnown := eTrivalent <> E_Trivalent.holding_unknown;
