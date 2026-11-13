(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.cons

Purpose:
    Prepends an existing cons cell to a list.

Application:
    Call to add an allocated cell to the head of a list.

Operation:
    1. Sets the cell's cdr to the current list head.
    2. Updates the list head to the cell register.

Inputs:
    cell - Register of the cell to prepend.

Outputs:
    None.

InOut:
    list - List head; updated to the new head.

Return Value:
    None.

Assumptions:
    - cell is a valid heap register.

Limitations:
    - Does not check whether cell is already linked into another list.

Dependencies:
    - ConsHeap.rplacd.

Example:

    fbConsHeap.cons(list := crList, cell := crCell);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD cons
VAR_IN_OUT
	list : CONS_REG;
END_VAR
VAR_INPUT
	head : CONS_REG;
END_VAR

(* --- Implementation --- *)
rplacd(head, list);
list := head;
