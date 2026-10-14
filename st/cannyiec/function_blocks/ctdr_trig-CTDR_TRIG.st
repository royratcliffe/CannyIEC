(* --- Interface --- *)
FUNCTION_BLOCK CTDR_TRIG
VAR_INPUT
	CD   : BOOL; (* Count Down *)
	LOAD : BOOL; (* Load the preset value into the down-counter *)
	PV   : WORD; (* Preset Value *)
END_VAR
VAR_OUTPUT
	Q  : BOOL; (* Single-cycle trigger pulse *)
	CV : WORD; (* Current Value of the down-counter *)
END_VAR
VAR
	fbCTD    : CTD;    (* Down-counter function block *)
	fbR_TRIG : R_TRIG; (* Rising edge trigger function block *)
END_VAR

(* --- Implementation --- *)
(* Note that the down-counter's Q goes high when the counter reaches
   zero. The rising edge trigger will generate a single-cycle pulse at
   that moment. *)
fbCTD(CD := CD, LOAD := LOAD, PV := PV, CV => CV);
fbR_TRIG(CLK := fbCTD.Q, Q => Q);
