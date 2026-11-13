(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.rplacd

Purpose:
    Replaces the cdr value of a cons cell.

Application:
    Call to update the next register linked from a list cell.

Operation:
    1. Looks up the cell identified by head.
    2. Writes d to the cell's cdr when the register is valid.

Inputs:
    head - Register of the cell to update.
    d - New cdr value.

Outputs:
    None.

InOut:
    None.

Return Value:
    None.

Assumptions:
    - head identifies a cell in this heap.

Limitations:
    - An invalid register is ignored without an error indication.

Dependencies:
    - ConsHeap.find.

Example:

    fbConsHeap.rplacd(head := crCell, d := crNext);

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
	head, d : CONS_REG;
END_VAR
VAR
	cell : POINTER TO ConsCell;
END_VAR

(* --- Implementation --- *)
IF find(head, cell => cell) AND cell <> 0 THEN
	cell^.cdr := d;
END_IF
