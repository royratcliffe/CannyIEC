(* --- Interface --- *)
(* Known check for trivalent values (i.e., not holding_unknown). Known
   means known to be either holding or not holding, but not unknown. *)
FUNCTION IsTrivalentKnown : BOOL
VAR_INPUT
	eTrivalent : E_Trivalent;
END_VAR
VAR
END_VAR

(* --- Implementation --- *)
IsTrivalentKnown := eTrivalent <> E_Trivalent.holding_unknown;
