(* --- Interface --- *)
METHOD LoadExclusivelyForBank : BOOL
VAR_INPUT
	(* Bank to load exclusively. *)
	bank : LOAD_BANK;
	(* Bits to set exclusively. *)
	set_u32 : DWORD;
END_VAR
VAR
	load : LongSetReset;
END_VAR

(* --- Implementation --- *)
(* Load a bank that exclusively sets the specified bits. The set bits OR
   with the stash. The reset bits AND with the stash. This presumes that
   resets apply before sets. *)
load.Set_u32           := set_u32;
load.Reset_u32         := set_u32;
LoadExclusivelyForBank := LoadForBank(bank, load);
