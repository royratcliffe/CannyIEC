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
    - CONS_NIL and an invalid register both return CONS_NIL, so this method
      cannot distinguish them.

Dependencies:
    - ConsHeap.consp.
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
	cell_adr : POINTER TO ConsCell;
END_VAR

(* --- Implementation --- *)
IF consp(head, cell_adr => cell_adr) AND cell_adr <> 0 THEN
	cdr := cell_adr^.cdr;
ELSE
	cdr := CONS_NIL;
END_IF
