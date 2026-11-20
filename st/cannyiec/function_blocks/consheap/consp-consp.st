(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.consp

Purpose:
    Finds a cell in the heap by register.

Application:
    Use to retrieve a cell and validate its register before reading or writing.

Operation:
    1. Checks whether head is non-zero.
    2. Returns a pointer to heap[head] when head is non-zero.

Inputs:
    head - Register to check.

Outputs:
    cell_adr - Pointer to heap[head]; valid only when consp returns TRUE.

InOut:
    None.

Return Value:
    BOOL - TRUE when head is a valid heap register; otherwise FALSE.

Assumptions:
    - CONS_MAX covers the full non-zero range of CONS_REG.

Limitations:
    - cell_adr is left unchanged when head is invalid.

Dependencies:
    - heap.
    - CONS_MAX and CONS_REG.

Example:

    xValid := fbConsHeap.consp(head := registerOfCell, cell_adr => pCell);

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
	consp    := TRUE;
ELSE
	consp := FALSE;
END_IF
