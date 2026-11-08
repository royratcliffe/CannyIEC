(* --- Interface --- *)
(*
================================================================================
Function Block Method : LongStash.Reset

Purpose:
    Clears selected bits from the staged DWORD value.

Application:
    Use to retain selected staged bits and clear the rest.

Operation:
    1. Split Stashing_u32 into its low and high words.
    2. AND each word stash with its mask; one bits retain stash bits and zero
       bits clear them.
    3. Reassemble the masks of cleared bits in their original DWORD positions.

Inputs:
    Stashing_u32 - Retain mask; one bits retain staged bits and zero bits clear
                   staged bits.

Outputs:
    None.

InOut:
    None.

Return Value:
    DWORD - Mask of bits that were set before the call and cleared by it.

Assumptions:
    - The LongStash instance retains its staged value between calls.

Limitations:
    - Bits already clear are not included in the return value.
    - Input bits set to one retain bits; they do not set absent bits.

Dependencies:
    - WordStash.Reset method.

Example:
    dwCleared := fbLongStash.Reset(
        Stashing_u32 := dwRetainMask
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
METHOD Reset : DWORD
VAR_INPUT
	Stashing_u32 : DWORD;
END_VAR

(* --- Implementation --- *)
Reset := WORD_TO_DWORD(Lo_fb.Reset(DWORD_TO_WORD(Stashing_u32))) OR SHL(WORD_TO_DWORD(Hi_fb.Reset(DWORD_TO_WORD(SHR(Stashing_u32, 16)))), 16);
