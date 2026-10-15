(* --- Interface --- *)
(*
================================================================================
Function : AU8_TO_LE16

Purpose:
    Combines two USINT values from an array into a UINT, with the byte at
    i32Lo as the low byte and the byte at i32Hi as the high byte.

Application:
    Decode a 16-bit little-endian value stored in two bytes of a USINT array.

Inputs:
    i32Lo  - Array index of the low byte.
    i32Hi  - Array index of the high byte.
    u8XX   - USINT fallback returned when either index is outside the array.
    au8    - Source array of USINT values.

Return Value:
    UINT   - The combined 16-bit value, or u8XX converted to UINT if either
             index is outside the array bounds.

Assumptions:
    - The array contains the bytes to decode at the specified indices.
    - The byte at i32Lo is the least significant byte; the byte at i32Hi is
      the most significant byte.

Limitations:
    - Invalid indices are indicated only by returning u8XX; there is no
      separate error status, so this value may be indistinguishable from a
      valid result.
    - The function does not require the indices to be adjacent or ordered.

Example:

    uiValue := AU8_TO_LE16(
        i32Lo := 0,
        i32Hi := 1,
        u8XX := USINT#0,
        au8 := au8Data
    );

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    15/10/2026   1.0      CannyIEC         Documented existing behavior
    ----------------------------------------------------------------------------
================================================================================
*)
FUNCTION AU8_TO_LE16 : UINT
VAR_INPUT
	i32Lo : DINT;
	i32Hi : DINT;
	u8XX : USINT;
END_VAR
VAR_IN_OUT CONSTANT
	au8 : ARRAY[*] OF USINT;
END_VAR
VAR
	i32LowerBound : DINT := LOWER_BOUND(au8, 1);
	i32UpperBound : DINT := UPPER_BOUND(au8, 1);
END_VAR
(* --- Implementation --- *)
AU8_TO_LE16 := u8XX;
IF i32LowerBound > i32Lo THEN
	RETURN;
END_IF
IF i32Lo > i32UpperBound THEN
	RETURN;
END_IF
IF i32LowerBound > i32Hi THEN
	RETURN;
END_IF
IF i32Hi > i32UpperBound THEN
	RETURN;
END_IF
AU8_TO_LE16 := SHL(USINT_TO_UINT(au8[i32Hi]), 8) OR USINT_TO_UINT(au8[i32Lo]);
