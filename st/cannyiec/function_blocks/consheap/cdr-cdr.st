(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.cdr

Purpose:
    Reads the cdr value of a cons cell.

Application:
    Call to read the next register linked from a list cell.

Operation:
    1. Looks up the cell identified by head.
    2. Returns the cell's cdr when the register is valid.

Inputs:
    head - Register of the cell to read.

Outputs:
    None.

InOut:
    None.

Return Value:
    CONS_REG - Cell cdr value, or CONS_NIL when head has no tail.

Assumptions:
    - head identifies a cell in this heap.

Limitations:
    - An invalid register returns CONS_NIL, the same value used for an
      empty list. This is a fail-safe behaviour but may not distinguish
      between an empty list and an invalid register. In effect, every
      invalid register exists but always treated as having no tail.

Dependencies:
    - ConsHeap.find.
    - CONS_NIL.

Example:

    tail := fbConsHeap.cdr(head := tail);

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
	head : CONS_REG;
END_VAR
VAR
	cell : ConsCell;
END_VAR

(* --- Implementation --- *)
IF find(head, cell) THEN
	cdr := cell.cdr;
ELSE
	cdr := CONS_NIL;
END_IF
