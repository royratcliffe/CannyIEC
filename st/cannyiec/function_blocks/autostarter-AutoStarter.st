(* --- Interface --- *)
(*
Function Block : AutoStarter

Purpose:
    Automatically cycles a start command until the equipment reports that it
    is running or the engagement request is removed.

Application:
    Use to control equipment that requires an engagement delay followed by
    repeated timed start attempts.

Operation:
    1. When xEngage is TRUE, wait for tEngaging.
    2. Assert xStart for tStarting, then wait for tEngaging before the next
       start attempt.
    3. Stop the cycle when xRunning is TRUE or xEngage is FALSE.

Inputs:
    tEngaging - Delay between start attempts (default T#3S).
    tStarting - Duration of each start command (default T#3S).
    xRunning  - Running feedback; ends the start cycle when TRUE.
    xEngage   - Start-cycle request; the cycle ends when FALSE.

Outputs:
    xStart - Timed start command, asserted during each start attempt.

InOut:
    None.

Alarms/Faults:
    None. There is no dedicated fault or timeout output.

Assumptions:
    - Call the function block cyclically.
    - xRunning is driven by valid equipment running feedback.
    - Keep xEngage TRUE while start attempts are required.

Limitations:
    - The block does not detect or report a failed start; it continues cycling
      until running feedback is received or xEngage is removed.
    - Timing resolution depends on the PLC task cycle.

Dependencies:
    - None.

Example:

    fbAutoStarter(
        tEngaging := T#3S,
        tStarting := T#3S,
        xRunning := xMotorRunning,
        xEngage := xAutoStart
    );
    xMotorStart := fbAutoStarter.xStart;

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    15/10/2026   1.0      CannyIEC         Documented existing behavior
    ----------------------------------------------------------------------------
*)
FUNCTION_BLOCK AutoStarter
VAR_INPUT
	tEngaging : TIME := T#3S;
	tStarting : TIME := T#3S;
	xRunning  : BOOL;
	xEngage   : BOOL;
END_VAR
VAR_OUTPUT
	xStart : BOOL;
END_VAR
