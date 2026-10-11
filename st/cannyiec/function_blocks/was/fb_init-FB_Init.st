(* --- Interface --- *)
//FB_Init is always available implicitly and it is used primarily for initialization.
//The return value is not evaluated. For a specific influence, you can also declare the
//methods explicitly and provide additional code there with the standard initialization
//code. You can evaluate the return value.
METHOD FB_Init : BOOL
VAR_INPUT
	(* Indicates whether to initialise retained variables. *)
	bInitRetains : BOOL;
	(* Indicates whether the function block is being initialised as part
	   of a copy-code operation. *)
	bInCopyCode  : BOOL;
END_VAR

(* --- Implementation --- *)
(* Get the current high-resolution RTC time. Throw away the real-time
   system's internal error code. The function block initialiser sets up
   a meaningful initial timestamp for the elapsed time calculation. *)
FB_Init := SysTimeRtcHighResGet(tWas) = CmpErrors.Errors.ERR_OK;
