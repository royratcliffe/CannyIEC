(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.contain

Purpose:
    Checks whether a register identifies a cell in the heap.

Application:
    Use to validate a register before reading or writing a heap cell.

Operation:
    1. Checks whether cr is between 1 and CONS_HEAP_SIZE inclusive.
    2. Copies the cell to content when the register is valid.

Inputs:
    cr - Register to check.

Outputs:
    content - Cell value; valid only when contain returns TRUE.

InOut:
    None.

Return Value:
    BOOL - TRUE when cr is a valid heap register; otherwise FALSE.

Assumptions:
    - CONS_HEAP_SIZE matches the upper bound of heap.

Limitations:
    - content is not assigned when cr is invalid.

Dependencies:
    - heap.
    - CONS_HEAP_SIZE.

Example:

    xValid := fbConsHeap.contain(cr := crCell, content => stCell);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD contain : BOOL
VAR_INPUT
	cr : CONS_REG;
END_VAR
VAR_OUTPUT
	content : Cell;
END_VAR

(* --- Implementation --- *)
IF 1 <= cr AND cr <= CONS_HEAP_SIZE THEN
	content := heap[cr];
	contain := TRUE;
ELSE
	contain := FALSE;
END_IF
