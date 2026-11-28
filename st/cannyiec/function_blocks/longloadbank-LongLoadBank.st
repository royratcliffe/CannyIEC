(* --- Interface --- *)
(*
================================================================================
Function Block : LongLoadBank

Purpose:
    Associates bank identifiers with set/reset masks for a 32-bit load state.

Application:
    Use to stage load changes by bank, commit those changes, and find registered
    banks whose masks match a load state.

Operation:
    1. Register each bank once with LoadForBank, or use
       LoadExclusivelyForBank to set and reset the same bits.
    2. Energise applies a bank's masks to the staged value. DeEnergise applies
       their complements. Reset_u32 is a retain mask: reset is applied before
       set, so set bits take precedence when masks overlap.
    3. EN enables LongStash commit processing for the scan. ENO is TRUE when
       that commit reports one or more changed bits.
    4. Energising exposes the staged value; Energised exposes the committed
       value. BanksForLoad finds all registered banks whose set mask is present
       and whose reset mask is absent in the supplied load.
    5. EnergisingBanks and EnergisedBanks use BanksForLoad to collect matching
       bank identifiers into a caller-provided array.

Inputs:
    EN  - Enables commit processing for this scan.

Outputs:
    ENO - TRUE when commit processing reports one or more changed bits.

InOut:
    None.

Alarms/Faults:
    None. The block has no dedicated alarm, fault, or timeout output.

Assumptions:
    - Call the function block cyclically.
    - Initialise the shared LongBankLoadHeap before registering banks.
    - Call LoadForBank or LoadExclusivelyForBank once per bank registration,
      not cyclically.

Limitations:
    - Registrations use the shared fixed-capacity LongBankLoadHeap and
      LongBankLoads globals. LoadForBank returns FALSE when no heap cell is
      available.
    - Registrations are not deduplicated or removed. FindBank uses the first
      matching registration.
    - BanksForLoad writes only as many matches as fit in the supplied array,
      but returns the total number of matches.
    - Energise and DeEnergise report whether Stash returned a non-zero value;
      this is not a committed-change indication. Use ENO for that indication.

Dependencies:
    - LongStash and LongSetReset.
    - Shared LongBankLoadHeap and LongBankLoads globals.
    - ConsHeap, CONS_REG, CONS_NIL, and CONS_MAX.
    - LOAD_BANK.

Example:
    xRegistered := fbLongLoadBank.LoadForBank(
        bank := eBank,
        load := stLoad
    );
    xStashed := fbLongLoadBank.Energise(bank := eBank);
    fbLongLoadBank(EN := TRUE, ENO => xCommittedChange);
    dwPending := fbLongLoadBank.Energising;
    dwCurrent := fbLongLoadBank.Energised;

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    21/11/2026   1.0      CannyIEC         Documented existing behaviour
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
FUNCTION_BLOCK LongLoadBank
VAR_INPUT
	EN : BOOL; (* Enables commit processing for this scan. *)
END_VAR
VAR_OUTPUT
	ENO : BOOL; (* Set TRUE when a commit reports one or more changed bits. *)
END_VAR
VAR
	longStash : LongStash;
	head      : CONS_REG := CONS_NIL;
END_VAR

(* --- Implementation --- *)
longStash(EN := EN, ENO => ENO);
