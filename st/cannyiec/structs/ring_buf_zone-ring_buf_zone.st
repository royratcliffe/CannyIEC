(* --- Interface --- *)
(* Ring buffer zone.
   A ring buffer contains two zones: one for putting data and one for getting
   data. Each zone has a base, head, and tail pointer. Pointer here refers to a
   signed zero-based index relative to the buffer's start. The base pointer
   marks the beginning of the zone, while the head pointer marks the end of the
   zone. The tail pointer tracks the position of the oldest data in the zone. *)
TYPE
    ring_buf_zone : STRUCT
        (* Base index of the zone. Marks the starting point of the zone within the ring buffer. *)
        base : RING_BUF_BASE;

        (* Head index of the zone. Marks the end point of the zone within the ring buffer. *)
        head : RING_BUF_BASE;

        (* Tail index of the zone. Marks the position of the oldest data in the zone. *)
        tail : RING_BUF_BASE;
    END_STRUCT
END_TYPE
