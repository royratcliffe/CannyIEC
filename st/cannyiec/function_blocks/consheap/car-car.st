(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.car

Purpose:
    Reads the car value of a cons cell.

Application:
    Call to read the first value stored in a list cell.

Operation:
    1. Checks cr with contain.
    2. Returns the cell's car when cr is valid.

Inputs:
    cr - Register of the cell to read.

Outputs:
    None.

InOut:
    None.

Return Value:
    CONS_REG - Cell car value, or CONS_NIL when cr is invalid.

Assumptions:
    - cr identifies a cell in this heap.

Limitations:
    - An invalid register returns CONS_NIL, the same value used for an empty
      list.

Dependencies:
    - ConsHeap.contain.
    - CONS_NIL.

Example:

    crValue := fbConsHeap.car(cr := crCell);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD car : CONS_REG
VAR_INPUT
	cr : CONS_REG;
END_VAR
VAR
	cell : Cell;
END_VAR

(* --- Implementation --- *)
IF contain(cr, content => cell) THEN
	car := cell.car;
ELSE
	car := CONS_NIL;
END_IF
