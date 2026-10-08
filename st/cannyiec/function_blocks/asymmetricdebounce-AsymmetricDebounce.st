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
    fbDebounce : TON; (* TON instance for handling the debounce timing *)
    xWasIN     : BOOL; (* private debounced state *)
END_VAR

(* --- Implementation --- *)
(* Only accept a state change after the raw input remains stable for its
   configured debounce time. The TON runs only while the raw input differs
   from the private debounced state. *)
fbDebounce(IN := IN <> xWasIN, PT := SEL(IN, tPresetFall, tPresetRise));
IF fbDebounce.Q THEN
    xWasIN := IN;
END_IF;
Q := xWasIN;
