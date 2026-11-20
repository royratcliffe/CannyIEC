(* --- Interface --- *)
METHOD PrependSet : BOOL
VAR_INPUT
	bank : LOAD_BANK;
	set_u32 : DWORD;
END_VAR
VAR
	load : LongSetReset;
END_VAR

(* --- Implementation --- *)
load.Set_u32 := set_u32;
load.Reset_u32 := NOT set_u32;
PrependSet := Prepend(bank, load);
