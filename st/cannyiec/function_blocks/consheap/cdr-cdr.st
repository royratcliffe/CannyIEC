(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.cdr

Purpose:
    Reads the cdr value of a cons cell.

Application:
    Call to read the next register linked from a list cell.

Operation:
    1. Checks cr with contain.
    2. Returns the cell's cdr when cr is valid.

Inputs:
    cr - Register of the cell to read.

Outputs:
    None.

InOut:
    None.

Return Value:
    CONS_REG - Cell cdr value, or CONS_NIL when cr is invalid.

Assumptions:
    - cr identifies a cell in this heap.

Limitations:
    - An invalid register returns CONS_NIL, the same value used for an empty
      list.

Dependencies:
    - ConsHeap.contain.
    - CONS_NIL.

Example:

    crNext := fbConsHeap.cdr(cr := crCell);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD cdr : CONS_REG
VAR_INPUT
	cr : CONS_REG;
END_VAR
VAR
	cell : ConsCell;
END_VAR

(* --- Implementation --- *)
IF contain(cr, content => cell) THEN
	cdr := cell.cdr;
ELSE
	cdr := CONS_NIL;
END_IF
