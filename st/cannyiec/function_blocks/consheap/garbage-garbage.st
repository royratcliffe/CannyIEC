(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.garbage

Purpose:
    Returns a valid cell to the free list.

Application:
    Call to release a cell for future allocation. Invalid registers and
    registers already in the free list are ignored.

Operation:
    1. Searches the free list for head and returns without change if it is
       already present.
    2. Checks that head identifies a heap cell.
    3. Prepends a valid cell to the free list and clears its car.

Inputs:
    head - Register of the cell to return.

Outputs:
    None.

InOut:
    None.

Return Value:
    None.

Assumptions:
    - A valid head is no longer in use by another list.

Limitations:
    - Does not report an error when head is invalid or already free.
    - Does not check whether a valid head is still linked into another list.

Dependencies:
    - ConsHeap.consp, ConsHeap.cons, ConsHeap.cdr, and ConsHeap.rplaca.

Example:

    fbConsHeap.garbage(head := crCell);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD garbage
VAR_INPUT
	head : CONS_REG; (* Register of cons cell to be added to the free list *)
END_VAR
VAR
	tail     : CONS_REG; (* Current register being checked in the free list *)
	cell_adr : POINTER TO ConsCell;
END_VAR

(* --- Implementation --- *)
tail := free;

(* Check if the register is already in the list to avoid duplicates
   before adding it to the free list. If it is found, exit the method
   early. Do not signal an error. Double free is harmless. The method
   behaves idempotently. *)
WHILE tail <> CONS_NIL DO
	IF tail = head THEN
		RETURN;
	END_IF

	tail := cdr(tail);
END_WHILE

IF consp(head, cell_adr => cell_adr) THEN
	cons(free, head);
	rplaca(head, CONS_NIL);
END_IF
