(* --- Interface --- *)
(* Resets a ring buffer zone.
   Sets the base, head, and tail of the zone to the specified base index. *)
FUNCTION ring_buf_zone_reset
VAR_IN_OUT
	zone : ring_buf_zone;
END_VAR
VAR_INPUT
	base : RING_BUF_BASE;
END_VAR

(* --- Implementation --- *)
zone.base := base;
zone.head := base;
zone.tail := base;
