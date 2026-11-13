(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.rplacd

Purpose:
    Replaces the cdr value of a cons cell.

Application:
    Call to update the next register linked from a list cell.

Operation:
    1. Checks cr with contain.
    2. Writes d to the cell's cdr when cr is valid.

Inputs:
    cr - Register of the cell to update.
    d - New cdr value.

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

    fbConsHeap.rplacd(cr := crCell, d := crNext);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD rplacd
VAR_INPUT
	cr, d : CONS_REG;
END_VAR
VAR
	cell : ConsCell;
END_VAR

(* --- Implementation --- *)
IF contain(cr, content => cell) THEN
	cell.cdr := d;
END_IF
