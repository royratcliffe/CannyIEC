(* --- Interface --- *)
VAR
END_VAR

(* --- Implementation --- *)
used_space := TO_UDINT(put.tail - get.head);
