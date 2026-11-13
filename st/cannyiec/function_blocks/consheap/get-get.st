(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.get

Purpose:
    Removes and returns the first available cell from the free list.

Application:
    Call to allocate an available cell before populating it.

Operation:
    1. Reads the free-list head.
    2. Advances the free-list head to the selected cell's cdr.
    3. Clears the selected cell's car and cdr.

Inputs:
    None.

Outputs:
    None.

InOut:
    None.

Return Value:
    CONS_REG - Allocated cell register, or CONS_NIL when the free list is
    empty.

Assumptions:
    - FB_Init has populated the free list.

Limitations:
    - Returns CONS_NIL without an error indication when no cells are
      available.

Dependencies:
    - ConsHeap.cdr, ConsHeap.rplaca, and ConsHeap.rplacd.
    - CONS_NIL.

Example:

    crCell := fbConsHeap.get();

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD get : CONS_REG
VAR
	cell : CONS_REG;
END_VAR

(* --- Implementation --- *)
cell := free;

IF free <> CONS_NIL THEN
	free := cdr(cell);
	rplaca(cell, CONS_NIL);
	rplacd(cell, CONS_NIL);
END_IF

get := cell;
