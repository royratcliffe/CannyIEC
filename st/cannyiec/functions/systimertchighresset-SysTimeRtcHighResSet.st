(* --- Interface --- *)
FUNCTION SysTimeRtcHighResSet : BOOL
VAR_INPUT
	tNow : SYSTIME;
END_VAR

(* --- Implementation --- *)
IF tNow > SysTimeRtcHighRes THEN
	SysTimeRtcHighRes    := tNow;
	SysTimeRtcHighResSet := TRUE;
ELSE
	SysTimeRtcHighResSet := FALSE;
END_IF
