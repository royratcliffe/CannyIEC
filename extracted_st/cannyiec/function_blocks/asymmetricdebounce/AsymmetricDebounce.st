(* --- Interface --- *)
FUNCTION_BLOCK AsymmetricDebounce
VAR_INPUT
    IN          : BOOL;           (* raw input signal from a sensor or switch *)
    tPresetRise : TIME := T#50MS; (* preset time for rising edge debounce *)
    tPresetFall : TIME := T#50MS; (* preset time for falling edge debounce *)
END_VAR
VAR_OUTPUT
    Q : BOOL; (* debounced "input" signal *)
END_VAR
VAR
    fbDebounce : TON;
END_VAR

(* --- Implementation --- *)
(* Only accept a state change after the raw input remains stable for its
   configured debounce time. The TON's input receives the XOR of the raw
   input and the current output, ensuring that the timer only runs when
   there is a state change. *)
fbDebounce(IN := IN <> Q, PT := SEL(IN, tPresetFall, tPresetRise));
IF fbDebounce.Q THEN
    Q := IN;
END_IF;
