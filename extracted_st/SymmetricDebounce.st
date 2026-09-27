(* --- Interface --- *)

FUNCTION_BLOCK SymmetricDebounce
VAR
    xDirty           : BOOL;           (* raw input signal from a sensor or switch *)
    xClean           : BOOL;           (* debounced "input" signal *)
    tPreset          : TIME := T#50MS; (* preset time for debounce; default to a 20 Hertz debounce rate *)
    fbDelayedRising  : TON;            (* timer for rising edge *)
    fbDelayedFalling : TOF;            (* timer for falling edge *)
END_VAR

(* --- Implementation --- *)

(* The raw input signal passes through the TON and TOF function blocks, which
implement the debounce logic. The TON block starts timing when the raw input
goes high, and the TOF block starts timing when the TON output goes low. The
system takes the debounced output signal from the TOF output. *)
(* Rising edge debounce *)
fbDelayedRising(IN := xDirty, PT := tPreset);
(* Falling edge debounce *)
fbDelayedFalling(IN := fbDelayedRising.Q, PT := tPreset);
xClean := fbDelayedFalling.Q;
