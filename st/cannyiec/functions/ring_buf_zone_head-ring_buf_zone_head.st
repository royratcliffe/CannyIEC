(* --- Interface --- *)
(* Head index of a zone.
   Used as the wrap size when claiming. The wrap size equals the head relative
   to the base. *)
FUNCTION ring_buf_zone_head : RING_BUF_SIZE
VAR_INPUT
	zone : ring_buf_zone;
END_VAR

(* --- Implementation --- *)
ring_buf_zone_head := TO_UDINT(zone.head - zone.base);
