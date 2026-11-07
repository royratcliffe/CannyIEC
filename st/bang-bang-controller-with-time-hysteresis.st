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
    - Hysteresis durations are supplied in microseconds.
    - IEC TON resolution is milliseconds; durations are rounded up to the
      next millisecond so a configured minimum is not shortened.
    - The first transition after enabling is subject to the same minimum time.

Example:
    fbController(
        xEnable := TRUE,
        lrInputValue := lrTemperature,
        lrSeparationValue := 20.0,
        udiHysteresisTimeToOn := 5000000,
        udiHysteresisTimeToOff := 3000000
    );

================================================================================
*)
FUNCTION_BLOCK BangBangControllerWithTimeHysteresis
VAR_INPUT
    /// Activates operation; FALSE aborts and resets the controller.
    xEnable : BOOL;

    /// Value to classify using the separation value.
    lrInputValue : LREAL;

    /// Value separating the TRUE and FALSE input regions.
    lrSeparationValue : LREAL;

    /// Minimum time in microseconds before switching from FALSE to TRUE.
    udiHysteresisTimeToOn : UDINT;

    /// Minimum time in microseconds before switching from TRUE to FALSE.
    udiHysteresisTimeToOff : UDINT;
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
    tonTimeToOn : TON;
    tonTimeToOff : TON;
    udiTimeToOnMilliseconds : UDINT;
    udiTimeToOffMilliseconds : UDINT;
END_VAR

udiTimeToOnMilliseconds := udiHysteresisTimeToOn / UDINT#1000;
IF (udiHysteresisTimeToOn MOD UDINT#1000) <> UDINT#0 THEN
    udiTimeToOnMilliseconds := udiTimeToOnMilliseconds + UDINT#1;
END_IF;

udiTimeToOffMilliseconds := udiHysteresisTimeToOff / UDINT#1000;
IF (udiHysteresisTimeToOff MOD UDINT#1000) <> UDINT#0 THEN
    udiTimeToOffMilliseconds := udiTimeToOffMilliseconds + UDINT#1;
END_IF;

IF xEnable THEN
    xBusy := TRUE;
    xError := FALSE;
    eErrorID := 0;

    tonTimeToOn(
        IN := NOT xOutput,
        PT := UDINT_TO_TIME(udiTimeToOnMilliseconds)
    );
    tonTimeToOff(
        IN := xOutput,
        PT := UDINT_TO_TIME(udiTimeToOffMilliseconds)
    );

    IF NOT xOutput THEN
        IF tonTimeToOn.Q AND (lrInputValue < lrSeparationValue) THEN
            xOutput := TRUE;
        END_IF;
    ELSIF tonTimeToOff.Q AND (lrInputValue >= lrSeparationValue) THEN
        xOutput := FALSE;
    END_IF;
ELSE
    xBusy := FALSE;
    xError := FALSE;
    eErrorID := 0;
    xOutput := FALSE;
    tonTimeToOn(IN := FALSE, PT := T#0ms);
    tonTimeToOff(IN := FALSE, PT := T#0ms);
END_IF;
END_FUNCTION_BLOCK
