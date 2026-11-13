(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.car

Purpose:
    Reads the car value of a cons cell.

Application:
    Like Lisp's car, reads the first (head) value from a cons cell.
    Note, the value can be anything that fits in a CONS_REG.
    It will be a parent node reference when used in a tree construct.

Operation:
    1. Looks up the cell identified by head.
    2. Returns the cell's car when the register is valid.

Inputs:
    head - Register of the cell to read.

Outputs:
    None.

InOut:
    None.

Return Value:
    CONS_REG - Cell car value, or CONS_NIL when head is invalid.

Assumptions:
    - head identifies a cell in this heap.

Limitations:
    - An invalid register returns CONS_NIL, the same value used for an empty
      list.

Dependencies:
    - ConsHeap.find.
    - CONS_NIL.

Example:

    someValue := fbConsHeap.car(head := head);

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
	head : CONS_REG;
END_VAR
VAR
	cell : ConsCell;
END_VAR

(* --- Implementation --- *)
IF find(head, cell) THEN
	car := cell.car;
ELSE
	car := CONS_NIL;
END_IF
