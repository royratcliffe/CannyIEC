(* --- Interface --- *)
FUNCTION ring_buf_clamp
VAR_IN_OUT
	clamp_size : RING_BUF_SIZE;
END_VAR
VAR_INPUT
	limit_size : RING_BUF_SIZE;
END_VAR

(* --- Implementation --- *)
IF clamp_size > limit_size THEN
	clamp_size := limit_size;
END_IF
