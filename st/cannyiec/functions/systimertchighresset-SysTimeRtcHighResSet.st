(* --- Interface --- *)
FUNCTION SysTimeRtcHighResSet
VAR_INPUT
	tNow : SYSTIME;
END_VAR

(* --- Implementation --- *)
SysTimeRtcHighRes := tNow;
