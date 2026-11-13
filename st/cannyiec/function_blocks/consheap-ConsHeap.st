(* --- Interface --- *)
(*
================================================================================
Function Block : ConsHeap

Purpose:
    Manages a fixed-size heap of cons cells and a free list of available cells.

Application:
    Use to build and manipulate lists whose cells are addressed by CONS_REG
    values.

Operation:
    1. FB_Init adds every heap register to the free list.
    2. get removes a cell from the free list, clears it, and returns its
       register; it returns CONS_NIL when the heap is exhausted.
    3. cons links a cell at the head of a list. car, cdr, rplaca, and rplacd
       read or update cell contents, while contain checks a register.
    4. put returns a cell to the free list, clears its car value, and ignores
       registers already on the free list.

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
    - Capacity is fixed by CONS_HEAP_SIZE; get returns CONS_NIL when no cells
      are available.
    - The function block does not track cell ownership.

Dependencies:
    - Cell.
    - CONS_REG, CONS_NIL, and CONS_HEAP_SIZE.

Example:

    crCell := fbConsHeap.get();
    IF crCell <> CONS_NIL THEN
        fbConsHeap.rplaca(crCell, crValue);
        fbConsHeap.cons(list := crList, cell := crCell);
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
	heap : ARRAY[1..CONS_HEAP_SIZE] OF ConsCell;
END_VAR
