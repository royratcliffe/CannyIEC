(* --- Interface --- *)
(*
================================================================================
Function Block : Button

Purpose:
    Debounces a button input and provides its current state and press/release
    edge pulses.

Application:
    Use for momentary button or switch inputs that require debouncing.

Operation:
    1. Debounce IN using the default 50 ms rising and falling delays.
    2. Set Q to the debounced input state.
    3. Pulse xPress or xRelease for one PLC cycle when the debounced state
       changes to pressed or released, respectively.

Inputs:
    IN - Raw button input; TRUE represents pressed.

Outputs:
    Q        - Debounced button state.
    xPress   - One-cycle pulse on a debounced rising edge.
    xRelease - One-cycle pulse on a debounced falling edge.

InOut:
    None.

Alarms/Faults:
    None. There is no dedicated alarm or fault output.

Assumptions:
    - Call the function block cyclically.
    - IN is TRUE while the button is pressed.

Limitations:
    - The debounce delays are fixed at the AsymmetricDebounce defaults and
      cannot be configured through this function block.
    - Edge outputs are one-cycle pulses and are not latched.

Dependencies:
    - AsymmetricDebounce.
    - Standard R_TRIG and F_TRIG function blocks.

Example:

    fbButton(IN := xButton);
    xButtonPressed := fbButton.xPress;
    xButtonReleased := fbButton.xRelease;

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    11/11/2026   1.0      CannyIEC         Documented existing behavior
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
FUNCTION_BLOCK Button
VAR_INPUT
	IN : BOOL;
END_VAR
VAR_OUTPUT
	Q        : BOOL;
	xPress   : BOOL;
	xRelease : BOOL;
END_VAR
VAR
	asymDeb : AsymmetricDebounce;
	x       : BOOL;
	rTrig   : R_TRIG;
	fTrig   : F_TRIG;
END_VAR

(* --- Implementation --- *)
asymDeb(IN := IN, Q => x);
rTrig(CLK := x, Q => xPress);
fTrig(CLK := x, Q => xRelease);
Q := x;
