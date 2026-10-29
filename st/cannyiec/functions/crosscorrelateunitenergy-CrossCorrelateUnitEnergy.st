(* --- Interface --- *)
FUNCTION CrossCorrelateUnitEnergy : BOOL
VAR_IN_OUT CONSTANT
	alrX, alrY : ARRAY[*] OF LREAL;
END_VAR
VAR_IN_OUT
	alrSum : ARRAY[*] OF LREAL;
END_VAR
VAR
	energy_x, energy_y : ARRAY[0..0] OF LREAL;
	scale_x, scale_y   : LREAL;
	not_a_num          : LREAL;
	has_scale          : BOOL;
	lag                : DINT;
END_VAR

(* --- Implementation --- *)
CrossCorrelateUnitEnergy := FALSE;

IF NOT CrossCorrelate(alrX := alrX, alrY := alrY, alrSum := alrSum) THEN
	RETURN;
END_IF

(* Compute the energy of alrX. Cross-correlate alrX with itself.
   The zero-lag value of this cross-correlation gives the energy.
   Energy measurement is done without mean subtraction. *)
IF NOT CrossCorrelate(alrX := alrX, alrY := alrX, alrSum := energy_x) THEN
	RETURN;
END_IF

IF NOT CrossCorrelate(alrX := alrY, alrY := alrY, alrSum := energy_y) THEN
	RETURN;
END_IF

not_a_num := FPU.GetLRealSpecialVal(FPU.ESpecial_FP_Value.NaN);
has_scale := FALSE;

(* Determine if both energies are valid and non-zero, indicating that scaling is possible. *)
IF NOT FPU.IsLRealNaN(energy_x[0]) AND NOT FPU.IsLRealNaN(energy_y[0]) THEN
	has_scale := (energy_x[0] > LREAL#0.0) AND (energy_y[0] > LREAL#0.0);
END_IF

(* Compute the scaling factors for normalisation if both energies are valid and non-zero. *)
IF has_scale THEN
	scale_x := SQRT(energy_x[0]);
	scale_y := SQRT(energy_y[0]);
END_IF

(* Normalise the cross-correlation results by the computed scaling factors. *)
FOR lag := LOWER_BOUND(alrSum, 1) TO UPPER_BOUND(alrSum, 1) DO
	IF has_scale AND scale_x > 0 AND scale_y > 0 THEN
		IF NOT FPU.IsLRealNaN(alrSum[lag]) THEN
			alrSum[lag] := (alrSum[lag] / scale_x) / scale_y;
		END_IF
	ELSE
		alrSum[lag] := not_a_num;
	END_IF
END_FOR

CrossCorrelateUnitEnergy := TRUE;
