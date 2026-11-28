(* --- Interface --- *)
(* Claims contiguous elements for putting and advances the put head.
   The claim cannot span the end of the buffer and is limited by the
   available free space. Returns the number of elements claimed and the
   zero-based offset of the claimed space. *)
METHOD put_claim : RING_BUF_SIZE
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
base := put.base;
head := ring_buf_zone_head(zone := put);

IF head >= claim_size THEN
	base := base + TO_DINT(claim_size);
	head := head - claim_size;
END_IF

ring_buf_clamp(clamp_size := claim_size, limit_size := claim_size - head);
ring_buf_clamp(clamp_size := claim_size, limit_size := free_space);
offset   := put.head - base;
put.head := put.head + TO_DINT(claim_size);
