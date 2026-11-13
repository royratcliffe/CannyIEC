(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.rplaca

Purpose:
    Replaces the car value of a cons cell.

Application:
    Call to update the first value stored in a list cell.

Operation:
    1. Checks cr with contain.
    2. Writes a to the cell's car when cr is valid.

Inputs:
    cr - Register of the cell to update.
    a - New car value.

Outputs:
    None.

InOut:
    None.

Return Value:
    None.

Assumptions:
    - cr identifies a cell in this heap.

Limitations:
    - An invalid register is ignored without an error indication.

Dependencies:
    - ConsHeap.contain.

Example:

    fbConsHeap.rplaca(cr := crCell, a := crValue);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD rplaca
VAR_INPUT
	head, a : CONS_REG;
END_VAR
VAR
	cell : ConsCell;
END_VAR

(* --- Implementation --- *)
IF find(head, cell => cell) THEN
	cell.car := a;
END_IF
