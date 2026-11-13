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
    1. Iterates over registers 1 through CONS_HEAP_SIZE.
    2. Calls put for each register.

Inputs:
    bInitRetains - CODESYS retained-data initialisation flag.
    bInCopyCode - CODESYS copy-code flag.

Outputs:
    None.

InOut:
    None.

Return Value:
    BOOL - CODESYS FB_Init result; this implementation does not explicitly
    assign a value.

Assumptions:
    - The heap bounds correspond to 1..CONS_HEAP_SIZE.

Limitations:
    - The input flags are not used by this implementation.

Dependencies:
    - ConsHeap.put.
    - CONS_HEAP_SIZE.

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
FOR tail := 1 TO CONS_HEAP_SIZE DO
	put(tail);
END_FOR

FB_Init := TRUE;
