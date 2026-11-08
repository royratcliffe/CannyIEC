(* --- Interface --- *)
(*
================================================================================
Function Block Method : LongStash.Set

Purpose:
    Sets the bits selected by a DWORD mask in the staged value.

Application:
    Use to set selected bits without changing other staged bits.

Operation:
    1. Split Stashing_u32 into its low and high words.
    2. OR each word mask into the corresponding WordStash.
    3. Reassemble the two return values in their original DWORD positions.

Inputs:
    Stashing_u32 - Mask of bits to set in the staged value.

Outputs:
    None.

InOut:
    None.

Return Value:
    DWORD - XOR of the staged value before the call and Stashing_u32.

Assumptions:
    - The LongStash instance retains its staged value between calls.

Limitations:
    - The return value is not a mask of bits actually set. It can include
      previously set bits where Stashing_u32 contains zeroes.

Dependencies:
    - WordStash.Set method.

Example:
    dwDifference := fbLongStash.Set(
        Stashing_u32 := dwSetMask
    );

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    06/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD Set : DWORD
VAR_INPUT
	Stashing_u32 : DWORD;
END_VAR

(* --- Implementation --- *)
Set := WORD_TO_DWORD(Lo_fb.Set(DWORD_TO_WORD(Stashing_u32))) OR SHL(WORD_TO_DWORD(Hi_fb.Set(DWORD_TO_WORD(SHR(Stashing_u32, 16)))), 16);
