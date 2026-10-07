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
    fbDelayedRise : TON; (* timer for rising edge *)
    fbDelayedFall : TOF; (* timer for falling edge *)
END_VAR

(* --- Implementation --- *)
(* The raw input signal passes through the TON and TOF function blocks, which
implement the debounce logic. The TON block starts timing when the raw input
goes high, and the TOF block starts timing when the TON output goes low. The
system takes the debounced output signal from the TOF output. *)
(* Rising edge debounce *)
fbDelayedRise(IN := IN, PT := tPresetRise);
(* Falling edge debounce *)
fbDelayedFall(IN := fbDelayedRise.Q, PT := tPresetFall);
Q := fbDelayedFall.Q;
