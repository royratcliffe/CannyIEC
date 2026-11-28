(* --- Interface --- *)
METHOD reset
VAR_INPUT
	base : RING_BUF_BASE := 0;
END_VAR

(* --- Implementation --- *)
ring_buf_zone_reset(put, base);
ring_buf_zone_reset(get, base);
