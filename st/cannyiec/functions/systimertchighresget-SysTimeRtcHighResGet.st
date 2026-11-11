(* --- Interface --- *)
FUNCTION SysTimeRtcHighResGet : ERROR
VAR_IN_OUT
	tNow : SYSTIME;
END_VAR

(* --- Implementation --- *)
tNow := SysTimeRtcHighRes;
SysTimeRtcHighResGet := ERROR.NO_ERROR;
