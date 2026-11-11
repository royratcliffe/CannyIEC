(* --- Interface --- *)
FUNCTION_BLOCK Button
VAR_INPUT
	IN : BOOL;
END_VAR
VAR_OUTPUT
	Q        : BOOL;
	xPress   : BOOL;
	xRelease : BOOL;
END_VAR
VAR
	asymDeb : AsymmetricDebounce;
	x       : BOOL;
	rTrig   : R_TRIG;
	fTrig   : F_TRIG;
END_VAR

(* --- Implementation --- *)
asymDeb(IN := IN, Q => x);
rTrig(CLK := x, Q => xPress);
fTrig(CLK := x, Q => xRelease);
Q := x;
