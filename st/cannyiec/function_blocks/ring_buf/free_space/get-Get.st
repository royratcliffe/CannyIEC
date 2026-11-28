(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
free_space := capacity - TO_UDINT(put.head - get.tail);
