(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.find

Purpose:
    Finds a cell in the heap by register.

Application:
    Use to retrieve a cell and validate its register before reading or writing.

Operation:
    1. Checks whether head is between 1 and CONS_HEAP_SIZE inclusive.
    2. Returns a pointer to the matching heap cell when the register is valid.

Inputs:
    head - Register to check.

Outputs:
    cell - Pointer to the matching heap cell; valid only when find returns TRUE.

InOut:
    None.

Return Value:
    BOOL - TRUE when head is a valid heap register; otherwise FALSE.

Assumptions:
    - CONS_HEAP_SIZE matches the upper bound of heap.

Limitations:
    - cell is left unchanged when head is invalid.

Dependencies:
    - heap.
    - CONS_HEAP_SIZE.

Example:

    xValid := fbConsHeap.find(head := registerOfCell, cell => pCell);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD consp : BOOL
VAR_INPUT
	head : CONS_REG;
END_VAR
VAR_OUTPUT
	cell_adr : POINTER TO ConsCell;
END_VAR

(* --- Implementation --- *)
IF 1 <= head THEN
	cell_adr := ADR(heap[head]);
	consp := TRUE;
ELSE
	consp := FALSE;
END_IF
