(* --- Interface --- *)
FUNCTION IsTrivalentHolding : BOOL
VAR_INPUT
	eTrivalent : E_Trivalent;
END_VAR
VAR
END_VAR

(* --- Implementation --- *)
IsTrivalentHolding := eTrivalent = E_Trivalent.holding;
