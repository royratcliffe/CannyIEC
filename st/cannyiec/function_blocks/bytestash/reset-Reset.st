(* --- Interface --- *)
(*
================================================================================
Method : StashReset

Purpose:
    Clears stash bits that are not set in the input mask.

Application:
    Use to reset selected bits in the ByteStash state while retaining bits
    enabled by the input mask.

Inputs:
    Stashing_u8 - Bit mask specifying which stash bits to retain.

Return Value:
    BYTE       - Bitwise XOR of the previous stash value and Stashing_u8.

Assumptions:
    - Stashed_u8 is the current state held by the enclosing function block.

Limitations:
    - The return value is the XOR with the input mask; it is not necessarily
      the set of bits cleared from the stash. The return value
      represents the bits that differ between the previous stash and the
      input mask. For zeroing out specific bits, the caller must
      interpret the XOR result accordingly.

Example:
    Previous Stashed_u8: BYTE#16#AC
    Stashing_u8:         BYTE#16#F0
    StashReset:          BYTE#16#5C
    New Stashed_u8:      BYTE#16#A0
================================================================================
*)
METHOD Reset : BYTE
VAR_INPUT
	Stashing_u8: BYTE;
END_VAR

(* --- Implementation --- *)
Reset := Stashed_u8 XOR Stashing_u8;
Stashed_u8 := Stashed_u8 AND Stashing_u8;
