(* --- Interface --- *)
(*
================================================================================
Function Block Method : LongStash.Stash

Purpose:
    Applies set and retain masks to the staged DWORD value.

Application:
    Use to update selected bits in one call through the LongSetReset structure.

Operation:
    1. Set the bits selected by Set_u32.
    2. Apply Reset_u32 as a retain mask: one bits retain stash bits and zero
       bits clear them.
    3. XOR the Set and Reset return masks, then reassemble the low and high
       word results in their original DWORD positions.

Inputs:
    Stashing_st - LongSetReset containing the Set_u32 and Reset_u32 masks.

Outputs:
    None.

InOut:
    None.

Return Value:
    DWORD - XOR-combined return masks from the Set and Reset operations. This
            is not guaranteed to equal the bits actually changed.

Assumptions:
    - The LongStash instance retains its staged value between calls.

Limitations:
    - The return value is the XOR of the underlying method results, not a
      guaranteed mask of bits changed by the complete operation.
    - Reset_u32 is a retain mask; bits set to one are retained.

Dependencies:
    - LongSetReset structure.
    - WordStash.Set and WordStash.Reset methods.

Example:
    dwResult := fbLongStash.Stash(
        Stashing_st := stMasks
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
METHOD Stash : DWORD
VAR_INPUT
	Stashing_st : LongSetReset;
END_VAR
VAR
	StashingLo_st : WordSetReset;
	StashingHi_st : WordSetReset;
END_VAR

(* --- Implementation --- *)
(* Split each double-word mask into its low and high word. *)
StashingLo_st.Set_u16   := DWORD_TO_WORD(Stashing_st.Set_u32);
StashingLo_st.Reset_u16 := DWORD_TO_WORD(Stashing_st.Reset_u32);
StashingHi_st.Set_u16   := DWORD_TO_WORD(SHR(Stashing_st.Set_u32, 16));
StashingHi_st.Reset_u16 := DWORD_TO_WORD(SHR(Stashing_st.Reset_u32, 16));
(* Apply the masks to each word stash, then reassemble the changed-bit masks. *)
Stash := WORD_TO_DWORD(Lo_fb.Stash(StashingLo_st)) OR SHL(WORD_TO_DWORD(Hi_fb.Stash(StashingHi_st)), 16);
