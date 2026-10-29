(* --- Interface --- *)
(*
Function : AU8_TO_U16

Purpose:
    Combines two USINT values from an array into a UINT, with the byte at
    i32Lo as the low byte and the byte at i32Hi as the high byte.

Application:
    Decode a 16-bit little-endian value stored in two bytes of a USINT
    array. This function is not little- or big-endian oriented: the low
    byte is supplied at i32Lo and the high byte at i32Hi, regardless of
    their array index order.

Inputs:
    i32Lo  - Array index of the low byte.
    i32Hi  - Array index of the high byte.
    u16XX  - UINT fallback returned when either index is outside the array.
    au8    - Source array of USINT values.

Return Value:
    UINT   - The combined 16-bit value, or u16XX if either index is outside
             the array bounds.

Assumptions:
    - The array contains the bytes to decode at the specified indices.
    - The byte at i32Lo is the least significant byte; the byte at i32Hi is
      the most significant byte.
    - For example, bytes 16#34 at i32Lo and 16#12 at i32Hi produce 16#1234.

Limitations:
    - Invalid indices are indicated only by returning u16XX; there is no
      separate error status, so this value may be indistinguishable from a
      valid result.
    - The function does not require the indices to be adjacent or ordered.
    - Big-endian data must be mapped so i32Hi selects the high byte and
      i32Lo selects the low byte. Typically, big-endian data is stored
      with the high byte first in the array. Hence, for big-endian data,
      i32Hi should be the index of the first byte and i32Lo should be
      the index of the second byte.

Example:

    uiValue := AU8_TO_U16(
        i32Lo := 0,
        i32Hi := 1,
        u16XX := UINT#0,
        au8 := au8Data
    );

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    15/10/2026   1.0      CannyIEC         Documented existing behavior
    ----------------------------------------------------------------------------
*)
FUNCTION AU8_TO_U16 : UINT
VAR_INPUT
	(* Array index of the low byte *)
	i32Lo : DINT;
	(* Array index of the high byte *)
	i32Hi : DINT;
	(* 16-bit fallback returned when either index is outside the array *)
	u16XX : UINT;
END_VAR
VAR_IN_OUT CONSTANT
	(* Source array of 8-bit values *)
	au8 : ARRAY[*] OF USINT;
END_VAR
VAR
	i32LowerBound : DINT := LOWER_BOUND(au8, 1);
	i32UpperBound : DINT := UPPER_BOUND(au8, 1);
END_VAR

(* --- Implementation --- *)
AU8_TO_U16 := u16XX;

(* Check if the low byte index is within bounds. Do this in an early
   exit manner: return immediately if the index is out of bounds. *)
IF i32LowerBound > i32Lo THEN
	RETURN;
END_IF

IF i32Lo > i32UpperBound THEN
	RETURN;
END_IF

(* Same for the high byte index. *)
IF i32LowerBound > i32Hi THEN
	RETURN;
END_IF

IF i32Hi > i32UpperBound THEN
	RETURN;
END_IF

AU8_TO_U16 := SHL(USINT_TO_UINT(au8[i32Hi]), 8) OR USINT_TO_UINT(au8[i32Lo]);
