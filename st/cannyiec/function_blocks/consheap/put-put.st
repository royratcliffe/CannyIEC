(* --- Interface --- *)
(*
================================================================================
Function Block Method : ConsHeap.put

Purpose:
    Returns a cell to the free list.

Application:
    Call to release a cell for future allocation.

Operation:
    1. Searches the free list for reg.
    2. Returns without change if reg is already free.
    3. Otherwise prepends reg to the free list and clears its car.

Inputs:
    reg - Register of the cell to return.

Outputs:
    None.

InOut:
    None.

Return Value:
    None.

Assumptions:
    - reg is a valid heap register.

Limitations:
    - Does not report an error when reg is invalid or already free.

Dependencies:
    - ConsHeap.cons, ConsHeap.cdr, and ConsHeap.rplaca.
    - CONS_NIL.

Example:

    fbConsHeap.put(reg := crCell);

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD put
VAR_INPUT
	head : CONS_REG; (* Register of cons cell to be added to the free list *)
END_VAR
VAR
	tail : CONS_REG; (* Current register being checked in the free list *)
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

cons(free, head);
rplaca(head, CONS_NIL);
