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
	fbDeb : WAS; (* WAS instance for handling the debounce timing *)
END_VAR

(* --- Implementation --- *)
(* Only accept a state change after the raw input remains stable for its
   configured debounce time. *)
fbDeb(IN := IN);
IF fbDeb.ET >= SEL(IN, tPresetFall, tPresetRise) THEN
	Q := IN;
END_IF;
