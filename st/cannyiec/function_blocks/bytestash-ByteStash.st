(* --- Interface --- *)
(*
================================================================================
Function Block : ByteStash

Purpose:
    Maintains a byte-sized stash and reports when its committed value changes.

Application:
    Use to stage byte updates through the Stash, Set, and Reset
    methods, then detect committed changes by enabling the function block.

Operation:
    1. Method calls update the internal stashed byte.
    2. When EN is TRUE, Commit compares the stashed byte with the previously
       committed byte and stores the new committed value.
    3. ENO is set TRUE when Commit reports a non-zero XOR difference.

Inputs:
    EN  - Enables commit processing for this scan.

Outputs:
    ENO - Set TRUE when a commit reports a changed byte.

Assumptions:
    - Stash operations are made through the function block's methods.
    - The function block instance retains its state between calls.

Limitations:
    - ENO is not cleared when EN is FALSE or when a later commit reports no
      change; it remains TRUE once set.
    - ENO indicates whether the byte changed, not which individual bits changed.

Dependencies:
    - ByteSetReset structure for the Stash method input.

Example:
    fbByteStash(EN := xEnable);
    xChanged := fbByteStash.ENO;
================================================================================
*)
FUNCTION_BLOCK ByteStash
VAR_INPUT
	EN : BOOL;
END_VAR
VAR_OUTPUT
	ENO : BOOL;
END_VAR
VAR
	Stashed_u8   : BYTE;
	Committed_u8 : BYTE;
END_VAR

(* --- Implementation --- *)
IF EN THEN
	IF Commit() <> BYTE#0 THEN
		ENO := TRUE;
	END_IF
END_IF
