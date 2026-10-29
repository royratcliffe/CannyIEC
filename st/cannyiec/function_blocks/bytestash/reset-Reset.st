(* --- Interface --- *)
(*
================================================================================
Method : Reset

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
    Given a previous stash of BYTE#16#AC, call:
        byDifference := fbByteStash.Reset(Stashing_u8 := BYTE#16#F0);

    Previous stash:     BYTE#16#AC = 2#1010_1100
    Retain mask:        BYTE#16#F0 = 2#1111_0000
    Return (XOR):       BYTE#16#5C = 2#0101_1100
    New stash (AND):    BYTE#16#A0 = 2#1010_0000

    The mask's upper four ones preserve the stash's upper four bits.
    Its lower four zeros clear the stash's lower four bits.
    The return value is calculated before the stash is updated:
        BYTE#16#AC XOR BYTE#16#F0 = BYTE#16#5C
    It includes both bits cleared from the stash (BYTE#16#0C) and mask
    bits that were already absent from the stash (BYTE#16#50).
    Thus byDifference is a difference from the mask, not a cleared-bit mask.
================================================================================
*)
METHOD Reset : BYTE
VAR_INPUT
	Stashing_u8 : BYTE;
END_VAR

(* --- Implementation --- *)
Reset      := Stashed_u8 XOR Stashing_u8;
Stashed_u8 := Stashed_u8 AND Stashing_u8;
