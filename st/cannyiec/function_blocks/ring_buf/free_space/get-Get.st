(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
free_space := size - TO_UDINT(put.head - get.tail);
