(* --- Interface --- *)
(*
================================================================================
Function Block : BangBangControllerWithValueHysteresis

Purpose:
    Maps a real-valued input to a boolean output using separate on and off
    thresholds to provide value hysteresis.

Operation:
    While enabled, the output turns on when the input is below the on
    threshold and turns off when the input exceeds the off threshold. Between
    the thresholds, the output retains its previous value. Disabling the
    function block resets the output and aborts operation.

Assumptions:
    - The application configures the thresholds so that the on threshold is
      lower than the off threshold.
    - No threshold validation is performed.

Example:
    fbController(
        xEnable := TRUE,
        lrInputValue := lrTemperature,
        lrHysteresisValueToOn := 18.0,
        lrHysteresisValueToOff := 22.0
    );

================================================================================
*)
FUNCTION_BLOCK BangBangControllerWithValueHysteresis
VAR_INPUT
	/// Activates operation; FALSE aborts and resets the controller.
	xEnable : BOOL;
	/// Value to classify using the hysteresis thresholds.
	lrInputValue : LREAL;
	/// Input values below this threshold turn the output on.
	lrHysteresisValueToOn : LREAL;
	/// Input values above this threshold turn the output off.
	lrHysteresisValueToOff : LREAL;
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
END_VAR

(* --- Implementation --- *)
IF xEnable THEN
	xBusy    := TRUE;
	xError   := FALSE;
	eErrorID := 0;
	IF lrInputValue < lrHysteresisValueToOn THEN
		xOutput := TRUE;
	ELSIF lrInputValue > lrHysteresisValueToOff THEN
		xOutput := FALSE;
	END_IF;
ELSE
	xBusy    := FALSE;
	xError   := FALSE;
	eErrorID := 0;
	xOutput  := FALSE;
END_IF;
