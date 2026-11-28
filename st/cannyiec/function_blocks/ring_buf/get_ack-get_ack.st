(* --- Interface --- *)
(* Acknowledges elements claimed for getting.
   Advances the get zone when the acknowledged amount does not exceed the
   outstanding claim. Returns TRUE on success and FALSE otherwise. *)
METHOD get_ack : BOOL
VAR_INPUT
	ack_size : RING_BUF_SIZE;
END_VAR
VAR
	claim_size : RING_BUF_SIZE;
END_VAR

(* --- Implementation --- *)
claim_size := ring_buf_zone_claim(zone := get);

IF ack_size > claim_size THEN
	get_ack := FALSE;
ELSE
	get.tail := get.tail + TO_DINT(ack_size);
	get.head := get.tail;

	IF ring_buf_zone_tail(zone := get) >= capacity THEN
		get.base := get.base + TO_DINT(capacity);
	END_IF

	get_ack := TRUE;
END_IF
