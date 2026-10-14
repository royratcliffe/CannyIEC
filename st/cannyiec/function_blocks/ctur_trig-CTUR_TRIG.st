(* --- Interface --- *)
FUNCTION_BLOCK CTUR_TRIG
VAR_INPUT
	CU    : BOOL; (* Count Up *)
	RESET : BOOL; (* Reset the up-counter *)
	PV    : WORD; (* Preset Value *)
END_VAR
VAR_OUTPUT
	Q  : BOOL; (* Single-cycle trigger pulse *)
	CV : WORD; (* Current Value of the up-counter *)
END_VAR
VAR
	fbCTU    : CTU;    (* Up-counter function block *)
	fbR_TRIG : R_TRIG; (* Rising edge trigger function block *)
END_VAR

(* --- Implementation --- *)
fbCTU(CU := CU, RESET := RESET, PV := PV, CV => CV);
(* Feed the output of the up-counter to the rising edge trigger. When
   the up-counter reaches its preset value, the rising edge trigger will
   generate a single-cycle pulse. *)
fbR_TRIG(CLK := fbCTU.Q, Q => Q);
