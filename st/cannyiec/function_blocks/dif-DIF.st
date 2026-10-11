(* --- Interface --- *)
FUNCTION_BLOCK DIF
VAR_INPUT
	IN : BOOL;
END_VAR
VAR_OUTPUT
	Q : BOOL;
	x : BOOL;
	t : TIME;
END_VAR
VAR
	xWas : BOOL;
	tWas : SysTimeRtc.SYSTIME;
END_VAR
VAR_TEMP
	tNow    : SysTimeRtc.SYSTIME;
	xDif    : BOOL;
	rts_iec : SysTimeRtc.RTS_IEC_RESULT;
END_VAR

(* --- Implementation --- *)
rts_iec := SysTimeRtcHighResGet(tNow);
xDif    := xWas <> IN;

IF xDif THEN
	xWas := IN;
	tWas := tNow;
END_IF

Q := xWas;
x := xDif;
t := ULINT_TO_TIME(tNow - tWas);
