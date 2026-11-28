(* --- Interface --- *)
METHOD EnergisingBanks : DINT
VAR_IN_OUT
	banks : ARRAY[*] OF LOAD_BANK;
END_VAR

(* --- Implementation --- *)
EnergisingBanks := BanksForLoad(load := Energising, banks);
