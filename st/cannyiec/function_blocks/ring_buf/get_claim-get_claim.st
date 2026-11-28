(* --- Interface --- *)
(* Claims contiguous elements for getting and advances the get head.
   The claim cannot span the end of the buffer and is limited by the
   number of used elements. Returns the number of elements claimed and the
   zero-based offset of the claimed space. *)
METHOD get_claim
VAR_IN_OUT
	claim_size : RING_BUF_SIZE;
END_VAR
VAR_OUTPUT
	offset : RING_BUF_BASE;
END_VAR
VAR
	base : RING_BUF_BASE;
	head : RING_BUF_SIZE;
END_VAR

(* --- Implementation --- *)
base := get.base;
head := ring_buf_zone_head(zone := get);

IF head >= claim_size THEN
	base := base + TO_DINT(claim_size);
	head := head - claim_size;
END_IF

ring_buf_clamp(clamp_size := claim_size, limit_size := claim_size - head);
ring_buf_clamp(clamp_size := claim_size, limit_size := used_space);
offset   := get.head - base;
get.head := get.head + TO_DINT(claim_size);
