(* --- Interface --- *)
(* Claims contiguous elements for getting and advances the get head.
   The claim cannot span the end of the buffer and is limited by the
   number of used elements. Returns the number of elements claimed and the
   zero-based offset of the claimed space. *)
METHOD get_claim : RING_BUF_SIZE;
VAR_INPUT
	claim_size : RING_BUF_SIZE;
END_VAR
VAR_OUTPUT
	offset : RING_BUF_BASE;
END_VAR
VAR
	base : RING_BUF_BASE;
	head : RING_BUF_SIZE;
	size : RING_BUF_SIZE := claim_size;
END_VAR

(* --- Implementation --- *)
base := get.base;
head := ring_buf_zone_head(zone := get);

IF head >= capacity THEN
	base := base + TO_DINT(capacity);
	head := head - capacity;
END_IF

ring_buf_clamp(clamp_size := size, limit_size := capacity - head);
ring_buf_clamp(clamp_size := size, limit_size := used_space);
offset    := get.head - base;
get.head  := get.head + TO_DINT(size);
get_claim := size;
