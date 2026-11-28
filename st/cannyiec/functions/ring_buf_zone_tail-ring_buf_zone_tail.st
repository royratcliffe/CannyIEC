(* --- Interface --- *)
(* Tail index of a zone. *)
FUNCTION ring_buf_zone_tail : RING_BUF_SIZE
VAR_INPUT
	zone : ring_buf_zone;
END_VAR

(* --- Implementation --- *)
ring_buf_zone_tail := TO_UDINT(zone.tail - zone.base);
