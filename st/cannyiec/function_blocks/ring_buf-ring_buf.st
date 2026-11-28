(* --- Interface --- *)
(* Ring buffer instance.
   Represents a ring buffer with its associated size and zones for putting and
   getting elements. *)
FUNCTION_BLOCK ring_buf
VAR
	(* Total size of the ring buffer in elements. *)
	capacity : RING_BUF_SIZE;
	(* Zone for putting elements into the ring buffer. *)
	put : ring_buf_zone;
	(* Zone for getting elements from the ring buffer. *)
	get : ring_buf_zone;
END_VAR
