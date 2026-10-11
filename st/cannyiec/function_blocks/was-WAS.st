(* --- Interface --- *)
FUNCTION_BLOCK WAS
VAR_INPUT
	IN : BOOL;
END_VAR
VAR_OUTPUT
	Q : BOOL; (* "quittierung" for change detection flag *)
	ET : TIME; (* elapsed time since the last change *)
END_VAR
VAR
	xWas : BOOL;
	tWas : SysTimeRtc.SYSTIME;
END_VAR
VAR_TEMP
	xDif    : BOOL;
	tNow    : SysTimeRtc.SYSTIME;
	rts_iec : SysTimeRtc.RTS_IEC_RESULT;
END_VAR

(* --- Implementation --- *)
(* Capture the current high-resolution RTC time and determine if the
   input has changed. Ignore the result of the RTC time capture. *)
xDif    := xWas <> IN;
rts_iec := SysTimeRtcHighResGet(tNow);

(* Update the previous input and timestamp if a change is detected. *)
IF xDif THEN
	xWas := IN;
	tWas := tNow;
END_IF

(* Update output variables. The change detection flag (Q) and the
   elapsed time since the last change (ET). *)
Q := xDif;
ET := ULINT_TO_TIME(tNow - tWas);
