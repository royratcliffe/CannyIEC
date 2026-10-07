(* --- Interface --- *)
FUNCTION_BLOCK FirstCycle
VAR_OUTPUT
    Q : BOOL; (* TRUE during the first cycle of the program run *)
END_VAR
VAR
    X : BOOL := FALSE; (* Has executed at least once during the program run *)
END_VAR

(* --- Implementation --- *)
(* Track the first cycle of the program run. Q will be TRUE only during
   the first cycle, and X will be set to TRUE afterwards. *)
Q := NOT X;
X := TRUE;
