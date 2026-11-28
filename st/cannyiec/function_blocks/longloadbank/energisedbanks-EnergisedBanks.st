(* --- Interface --- *)
METHOD EnergisedBanks : DINT
VAR_IN_OUT
	banks : ARRAY[*] OF LOAD_BANK;
END_VAR

(* --- Implementation --- *)
EnergisedBanks := BanksForLoad(load := Energised, banks);
