(* --- Interface --- *)

FUNCTION_BLOCK SymmetricDebounce
VAR_INPUT
    xDirty : BOOL; (* raw input signal from a sensor or switch *)
END_VAR
VAR_OUTPUT
    xClean : BOOL; (* debounced "input" signal *)
END_VAR
VAR
    tPresetRising    : TIME;           (* preset time for rising edge debounce *)
    tPresetFalling   : TIME;           (* preset time for falling edge debounce *)
    tPreset          : TIME := T#50MS; (* symmetric preset time used if specific rising/falling presets are not set; default to 50 milliseconds *)
    fbDelayedRising  : TON;            (* timer for rising edge *)
    fbDelayedFalling : TOF;            (* timer for falling edge *)
END_VAR


(* --- Implementation --- *)

(* The raw input signal passes through the TON and TOF function blocks, which
implement the debounce logic. The TON block starts timing when the raw input
goes high, and the TOF block starts timing when the TON output goes low. The
system takes the debounced output signal from the TOF output. *)
(* Rising edge debounce *)
fbDelayedRising(IN := xDirty, PT := SEL(tPresetRising <> T#0S, tPresetRising, tPreset));
(* Falling edge debounce *)
fbDelayedFalling(IN := fbDelayedRising.Q, PT := SEL(tPresetFalling <> T#0S, tPresetFalling, tPreset));
xClean := fbDelayedFalling.Q;

