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
    BYTE       - Mask of bits cleared from the previous stash.

Assumptions:
    - Stashed_u8 is the current state held by the enclosing function block.

Limitations:
    - Input bits set to "one" retain stash bits; they do not set absent bits.
    - Bits already clear in the stash are not included in the return value.

Example:
    Given a previous stash of BYTE#16#AC, call:
        Cleared_u8 := fbByteStash.Reset(Stashing_u8 := BYTE#16#F0);

    Previous stash:     BYTE#16#AC = 2#1010_1100
    Retain mask:        BYTE#16#F0 = 2#1111_0000
    Return (cleared):   BYTE#16#0C = 2#0000_1100
    New stash (AND):    BYTE#16#A0 = 2#1010_0000

    The mask's upper four ones preserve the stash's upper four bits.
    Its lower four zeros clear the stash's lower four bits.
    The return value is calculated before the stash is updated:
        (BYTE#16#AC XOR BYTE#16#F0) AND NOT BYTE#16#F0 = BYTE#16#0C
    "AND NOT" removes differences at retained bit positions, leaving only
    bits that were set in the stash and are cleared by this call.
    Thus Cleared_u8 is BYTE#16#0C; repeating the call returns BYTE#0.
================================================================================
*)
METHOD Reset : BYTE
VAR_INPUT
	Stashing_u8 : BYTE;
END_VAR

(* --- Implementation --- *)
Reset      := (Stashed_u8 XOR Stashing_u8) AND NOT Stashing_u8;
Stashed_u8 := Stashed_u8 AND Stashing_u8;
