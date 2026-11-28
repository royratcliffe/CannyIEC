(* --- Interface --- *)
FUNCTION IsTrivalentHolding : BOOL
VAR_INPUT
	eTrivalent : Trivalent;
END_VAR
VAR
END_VAR

(* --- Implementation --- *)
IsTrivalentHolding := eTrivalent = Trivalent.holding;
