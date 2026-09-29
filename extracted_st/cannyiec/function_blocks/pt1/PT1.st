(* --- Interface --- *)
FUNCTION_BLOCK PT1
VAR_INPUT
    IN : REAL; (* Input signal *)
END_VAR
VAR_OUTPUT
    Q1 : REAL; (* Output signal *)
END_VAR
VAR_INPUT
    P : REAL; (* Proportional factor *)
END_VAR
VAR
    P1 : REAL; (* Limited proportional factor *)
    Q  : REAL; (* Previous output signal, used for feedback *)
END_VAR
(* --- Implementation --- *)
(* First, limit the proportional factor to the range [0, 1] because
values outside this range could lead to instability or unexpected
behaviour. Next, calculate the output signal using the limited
proportional factor and the internal state, i.e. the previous output
signal. The current cycle's output becomes the next cycle's feedback.

Avoid SA0038: read access to output variable within the same cycle. IEC
61131-3 standard recommends avoiding read access to output variables
within the same cycle. It is considered a bad practice and can lead to
unpredictable behavior in the control logic. *)
P1 := LIMIT(0, P, 1);
Q  := (IN * P1) + (Q * (1 - P1));
Q1 := Q;