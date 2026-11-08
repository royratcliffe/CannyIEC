(* --- Interface --- *)
FUNCTION_BLOCK BangBangControllerWithTimeHysteresis
VAR_INPUT
	/// Activates operation; FALSE aborts and resets the controller.
	xEnable : BOOL;
	/// Value to classify using the separation value.
	lrInputValue : LREAL;
	/// Value separating the TRUE and FALSE input regions.
	lrSeparationValue : LREAL;
	// Minimum time before switching from FALSE to TRUE.
	tHysteresisTimeToOn : TIME;
	// Minimum time before switching from TRUE to FALSE.
	tHysteresisTimeToOff : TIME;
END_VAR
VAR_OUTPUT
	/// TRUE while the enabled controller is operating.
	xBusy : BOOL;
	/// Error status; this implementation has no runtime error conditions.
	xError : BOOL;
	/// Hysteresis controller result.
	xOutput : BOOL;
	/// Error code; zero means no error.
	eErrorID : INT;
END_VAR
VAR
	xHysteresis  : BOOL;
	tonTimeToOn  : TON;
	tonTimeToOff : TON;
END_VAR

(* --- Implementation --- *)
IF xEnable THEN
	xBusy    := TRUE;
	xError   := FALSE;
	eErrorID := 0;
	tonTimeToOn(IN := NOT xHysteresis, PT := tHysteresisTimeToOn);
	tonTimeToOff(IN := xHysteresis, PT := tHysteresisTimeToOff);
	{analysis -62}
	IF NOT xHysteresis THEN
		IF tonTimeToOn.Q AND (lrInputValue < lrSeparationValue) THEN
			xHysteresis := TRUE;
		END_IF;
	ELSIF tonTimeToOff.Q AND (lrInputValue >= lrSeparationValue) THEN
		xHysteresis := FALSE;
	END_IF;
	{analysis +62}
ELSE
	xBusy       := FALSE;
	xError      := FALSE;
	eErrorID    := 0;
	xHysteresis := FALSE;
	tonTimeToOn(IN := FALSE, PT := T#0MS);
	tonTimeToOff(IN := FALSE, PT := T#0MS);
END_IF;

xOutput := xHysteresis;
