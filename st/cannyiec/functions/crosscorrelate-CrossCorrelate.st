(* --- Interface --- *)
FUNCTION CrossCorrelate : BOOL
VAR_IN_OUT CONSTANT
	alrX, alrY : ARRAY[*] OF LREAL;
END_VAR
VAR_IN_OUT
	alrSum : ARRAY[*] OF LREAL;
END_VAR
VAR
	n, m, lag : DINT;
	sum       : LREAL;
	not_a_num : LREAL;
	has_sum   : BOOL;
END_VAR

(* --- Implementation --- *)
CrossCorrelate := FALSE;
not_a_num      := FPU.GetLRealSpecialVal(FPU.ESpecial_FP_Value.NaN);

FOR lag := LOWER_BOUND(alrSum, 1) TO UPPER_BOUND(alrSum, 1) DO
	sum     := LREAL#0.0;
	has_sum := FALSE;

	FOR m := LOWER_BOUND(alrY, 1) TO UPPER_BOUND(alrY, 1) DO
		n := m + lag;

		(* Check if the index n (for X) is within the bounds of alrX
		   before accessing it. This prevents out-of-bounds array access
		   errors. It does *not* prevent static analysis warnings about
		   potential out-of-bounds access. Temporarily suppress static
		   analysis warnings. *)
		{analysis -62}
		IF LOWER_BOUND(alrX, 1) <= n AND n <= UPPER_BOUND(alrX, 1) THEN
			IF NOT FPU.IsLRealNaN(alrX[n]) AND NOT FPU.IsLRealNaN(alrY[m]) THEN
				sum     := sum + alrX[n] * alrY[m];
				has_sum := TRUE;
			END_IF
		END_IF
		{analysis +62}
	END_FOR

	alrSum[lag] := SEL(has_sum, not_a_num, sum);
END_FOR

CrossCorrelate := TRUE;
