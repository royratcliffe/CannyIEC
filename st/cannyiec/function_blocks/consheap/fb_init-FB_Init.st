(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.FB_Init

Purpose:
    Adds every heap register to the free list during function block
    initialisation.

Application:
    Called automatically by CODESYS when the function block instance is
    initialised.

Operation:
    1. Iterates over registers CONS_MAX down to 1.
    2. Calls garbage for each register to add it to the free list.

Inputs:
    bInitRetains - CODESYS retained-data initialisation flag.
    bInCopyCode - CODESYS copy-code flag.

Outputs:
    None.

InOut:
    None.

Return Value:
    BOOL - TRUE, indicating successful initialisation.

Assumptions:
    - The heap bounds correspond to 1..CONS_MAX.

Limitations:
    - The input flags are not used by this implementation.

Dependencies:
    - ConsHeap.garbage.
    - CONS_MAX.

Example:

    Called by the CODESYS runtime; do not normally call it directly.

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD FB_Init : BOOL
VAR_INPUT
	bInitRetains : BOOL;
	bInCopyCode  : BOOL;
END_VAR
VAR
	tail : CONS_REG;
END_VAR

(* --- Implementation --- *)
FOR tail := CONS_MAX TO 1 BY -1 DO
	garbage(tail);
END_FOR

FB_Init := TRUE;
