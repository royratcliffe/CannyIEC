(* --- Interface --- *)
FUNCTION SysTimeRtcHighResGet : ERROR
VAR_IN_OUT
	tNow : SYSTIME;
END_VAR

(* --- Implementation --- *)
tNow := SysTimeRtcHighRes;
(* Answer based on whether the high-resolution RTC time is zero. If
   non-zero, return NO_ERROR; otherwise when zero, return TIME_OUT. *)
SysTimeRtcHighResGet := SEL(tNow <> 0, ERROR.NO_ERROR, ERROR.TIME_OUT);
