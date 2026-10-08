(* --- Interface --- *)
FUNCTION_BLOCK SymmetricDebounce
VAR_INPUT
    IN : BOOL;           (* raw input signal from a sensor or switch *)
    PT : TIME := T#50MS; (* preset time for rising and falling edge debounce *)
END_VAR
VAR_OUTPUT
    Q : BOOL; (* debounced "input" signal *)
END_VAR
VAR
    fbAsymmetricDebounce : AsymmetricDebounce;
END_VAR

(* --- Implementation --- *)
fbAsymmetricDebounce(IN := IN, tPresetRise := PT, tPresetFall := PT);
Q := fbAsymmetricDebounce.Q;
