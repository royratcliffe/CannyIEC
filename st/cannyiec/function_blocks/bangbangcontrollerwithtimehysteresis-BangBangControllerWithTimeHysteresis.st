(* --- Interface --- *)
(*
================================================================================
Function Block : BangBangControllerWithTimeHysteresis

Purpose:
    Maps a real-valued input to a boolean output using a separation value and
    minimum times between output transitions.

Operation:
    While enabled, an input below the separation value requests TRUE and an
    input at or above it requests FALSE. A requested transition occurs only
    after the output has remained in its current state for the configured
    minimum time. Disabling the function block aborts operation and resets the
    output.

Assumptions:
    - Hysteresis durations are supplied as TIME values.
    - IEC TON resolution is milliseconds.
    - The first transition after enabling is subject to the same minimum time.

Example:
    fbController(
        xEnable := TRUE,
        lrInputValue := lrTemperature,
        lrSeparationValue := 20.0,
        tHysteresisTimeToOn := T#5S,
        tHysteresisTimeToOff := T#3S
    );

================================================================================
*)
FUNCTION_BLOCK BangBangControllerWithTimeHysteresis
VAR_INPUT
	/// Activates operation; FALSE aborts and resets the controller.
	xEnable : BOOL;
	/// Value to classify using the separation value.
	rInputValue : REAL;
	/// Value separating the TRUE and FALSE input regions.
	rSeparationValue : REAL;
	/// Minimum time before switching from FALSE to TRUE.
	tHysteresisTimeToOn : TIME;
	/// Minimum time before switching from TRUE to FALSE.
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
		IF tonTimeToOn.Q AND (rInputValue < rSeparationValue) THEN
			xHysteresis := TRUE;
		END_IF;
	ELSIF tonTimeToOff.Q AND (rInputValue >= rSeparationValue) THEN
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
