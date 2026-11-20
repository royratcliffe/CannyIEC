(* --- Interface --- *)
(*
================================================================================
Function Block : ConsHeap

Purpose:
    Manages a fixed-size heap of cons cells and a free list of available
    cells.

Application:
    Use to build and manipulate lists whose cells are addressed by CONS_REG
    values.

Operation:
    1. FB_Init adds every heap register to the free list.
    2. get and collect remove a cell from the free list, clear it, and return
       its register; they return CONS_NIL when the heap is exhausted.
    3. cons links a cell at the head of a list. car, cdr, rplaca, and rplacd
       read or update cell contents. find and consp return a pointer to a
       register's cell when it is valid.
    4. put and garbage return a cell to the free list, clear its car value,
       and ignore registers already on the free list.

Inputs:
    None.

Outputs:
    None.

InOut:
    None.

Alarms/Faults:
    None. There is no dedicated alarm or fault output.

Assumptions:
    - Allow FB_Init to run before using the heap methods.
    - Pass valid heap registers to methods that allocate or modify cells.
    - Treat CONS_NIL as the empty-list and no-cell value.

Limitations:
    - Capacity is fixed by CONS_MAX; get and collect return CONS_NIL when no cells
      are available.
    - The function block does not track cell ownership.

Dependencies:
    - ConsCell.
    - CONS_REG, CONS_NIL, and CONS_MAX.

Example:

    crCell := fbConsHeap.get();
    IF crCell <> CONS_NIL THEN
        fbConsHeap.rplaca(head := crCell, a := crValue);
        fbConsHeap.cons(tail := crList, head := crCell);
    END_IF

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    13/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
FUNCTION_BLOCK ConsHeap
VAR
	free : CONS_REG := CONS_NIL;
	heap : ARRAY[1..CONS_MAX] OF ConsCell;
END_VAR
