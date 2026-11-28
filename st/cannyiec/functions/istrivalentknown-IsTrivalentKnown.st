(* --- Interface --- *)
(* Known check for trivalent values (i.e., not holding_unknown). Known
   means known to be either holding or not holding, but not unknown. *)
FUNCTION IsTrivalentKnown : BOOL
VAR_INPUT
	eTrivalent : Trivalent;
END_VAR
VAR
END_VAR

(* --- Implementation --- *)
IsTrivalentKnown := eTrivalent <> Trivalent.unknown;
