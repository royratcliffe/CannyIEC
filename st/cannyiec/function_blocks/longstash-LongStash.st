(* --- Interface --- *)
(*
Function Block : LongStash

Purpose:
    Maintains a 32-bit stash and reports when its committed value changes.

Application:
    Use to stage DWORD updates through the Stash, Set, and Reset methods,
    then detect committed changes by enabling the function block.

Operation:
    1. Stash, Set, and Reset update the stashed DWORD; their return values have
       method-specific meanings.
    2. When EN is TRUE, Commit compares the stashed DWORD with the previously
       committed DWORD and stores the new committed value.
    3. ENO is set TRUE when Commit reports a non-zero changed-bit mask.

Inputs:
    EN  - Enables commit processing for this scan.

Outputs:
    ENO - Set TRUE when a commit reports one or more changed bits.

Assumptions:
    - Stash operations are made through the Stash, Set, and Reset methods.
    - The function block instance retains its state between calls.

Limitations:
    - ENO is not cleared when EN is FALSE or when a later commit reports no
      changes; it remains TRUE once set.
    - ENO reports whether any bit changed, not which bits changed. Call Commit
      directly instead of relying on the EN-gated commit when the DWORD mask
      is required.

Dependencies:
    - LongSetReset structure for the Stash method input.

Example:
    fbLongStash(EN := xEnable);
    xChanged := fbLongStash.ENO;

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    06/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------
*)
FUNCTION_BLOCK LongStash
VAR_INPUT
	EN : BOOL; (* Enables commit processing for this scan. *)
END_VAR
VAR_OUTPUT
	ENO : BOOL; (* Set TRUE when a commit reports one or more changed bits. *)
END_VAR
VAR
	Lo_fb, Hi_fb : WordStash; (* Low and high word stashes for the 32-bit value. *)
END_VAR

(* --- Implementation --- *)
IF EN THEN
	IF Commit() <> DWORD#0 THEN
		ENO := TRUE;
	END_IF;
END_IF;
