(* --- Interface --- *)
{attribute 'conditionalshow'}
{attribute 'conditionalshow' := 'DevMode'}
{attribute 'hide'}
{attribute 'analysis' := '-43'}
VAR_GLOBAL
	SysTimeRtcHighRes : SYSTIME;
	LongBankLoads     : ARRAY[1..CONS_MAX] OF LongSetReset;
	LongBankLoadHeap  : ConsHeap;
END_VAR
