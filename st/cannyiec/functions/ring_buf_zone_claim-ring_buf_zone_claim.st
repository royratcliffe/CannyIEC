(* --- Interface --- *)
(* Claim size of a zone.
   The claim size is the difference between head and tail. *)
FUNCTION ring_buf_zone_claim : RING_BUF_SIZE
VAR_INPUT
	zone : ring_buf_zone;
END_VAR

(* --- Implementation --- *)
ring_buf_zone_claim := TO_UDINT(zone.head - zone.tail);
