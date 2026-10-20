(* --- Interface --- *)
FUNCTION U16_TO_AU8 : BOOL
VAR_INPUT
	(* Where to put the low and high bytes in the array *)
	i32Lo, i32Hi : DINT;
	(* The 16-bit value to split into low and high bytes *)
	u16 : UINT;
END_VAR
VAR_IN_OUT
	(* The mutable array of 8-bit values to write into *)
	au8 : ARRAY[*] OF USINT;
END_VAR
VAR
	i32LowerBound : DINT := LOWER_BOUND(au8, 1);
	i32UpperBound : DINT := UPPER_BOUND(au8, 1);
END_VAR

(* --- Implementation --- *)
U16_TO_AU8 := FALSE;

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

au8[i32Lo] := UINT_TO_USINT(u16);
au8[i32Hi] := UINT_TO_USINT(SHR(u16, 8));
U16_TO_AU8 := TRUE;
