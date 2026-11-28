(* --- Interface --- *)
(* Acknowledges elements claimed for putting.
   Advances the put zone when the acknowledged amount does not exceed the
   outstanding claim. Returns TRUE on success and FALSE otherwise. *)
METHOD put_ack : BOOL
VAR_INPUT
	ack_size : RING_BUF_SIZE;
END_VAR
VAR
	claim_size : RING_BUF_SIZE;
END_VAR

(* --- Implementation --- *)
claim_size := ring_buf_zone_claim(zone := put);

IF ack_size > claim_size THEN
	put_ack := FALSE;
ELSE
	put.tail := put.tail + TO_DINT(ack_size);
	put.head := put.tail;

	IF ring_buf_zone_tail(zone := put) >= capacity THEN
		put.base := put.base + TO_DINT(capacity);
	END_IF

	put_ack := TRUE;
END_IF
