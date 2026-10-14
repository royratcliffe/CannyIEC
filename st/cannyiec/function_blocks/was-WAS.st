(* --- Interface --- *)
FUNCTION_BLOCK WAS
VAR_INPUT
	IN : BOOL; (* input signal *)
END_VAR
VAR_OUTPUT
	Q  : BOOL; (* "quittierung" for change detection flag *)
	ET : TIME; (* elapsed time since the last change *)
END_VAR
VAR
	xWas : BOOL;               (* previous input value *)
	tWas : SysTimeRtc.SYSTIME; (* previous timestamp *)
END_VAR
VAR_TEMP
	xDif : BOOL;               (* difference between the current and previous input value *)
	tNow : SysTimeRtc.SYSTIME; (* current timestamp *)
END_VAR

(* --- Implementation --- *)
(* Capture the current high-resolution RTC time and determine if the
   input has changed. *)
IF SysTimeRtcHighResGet(tNow) <> CmpErrors.Errors.ERR_OK THEN
	RETURN;
END_IF

xDif := xWas <> IN;

(* Update the previous input and timestamp if a change is detected. *)
IF xDif THEN
	xWas := IN;
	tWas := tNow;
END_IF

(* Update output variables. The change detection flag (Q) and the
   elapsed time since the last change (ET). *)
Q  := xDif;
ET := ULINT_TO_TIME(tNow - tWas);
