(* --- Interface --- *)
(*
================================================================================
Function Block Method : LongStash.Commit

Purpose:
    Commits the staged DWORD value and reports the bits that differ from the
    previously committed value.

Application:
    Use to obtain the change mask and advance the committed value to the current
    staged value.

Operation:
    1. Commit the low and high WordStash values.
    2. Reassemble their change masks in their original DWORD positions.

Inputs:
    None.

Outputs:
    None.

InOut:
    None.

Return Value:
    DWORD - XOR mask of the staged and previously committed values.

Assumptions:
    - The LongStash instance retains its staged and committed values between
      calls.

Limitations:
    - Calling Commit updates the committed value; a subsequent call without
      further staging changes returns DWORD#0.

Dependencies:
    - WordStash.Commit method.

Example:
    dwChanged := fbLongStash.Commit();

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    06/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD Commit : DWORD
VAR_INPUT
END_VAR

(* --- Implementation --- *)
Commit := WORD_TO_DWORD(Lo_fb.Commit()) OR SHL(WORD_TO_DWORD(Hi_fb.Commit()), 16);
