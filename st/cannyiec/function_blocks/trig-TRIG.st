(* --- Interface --- *)
FUNCTION_BLOCK TRIG
VAR_INPUT
    CLK : BOOL; (* signal to monitor *)
END_VAR
VAR_OUTPUT
    Q : BOOL; (* one-cycle pulse when CLK changes *)
END_VAR
VAR
    fbRise : R_TRIG; (* rising edge trigger *)
    fbFall : F_TRIG; (* falling edge trigger *)
END_VAR

(* --- Implementation --- *)
fbRise(CLK := CLK);
fbFall(CLK := CLK);
Q := fbRise.Q OR fbFall.Q;
