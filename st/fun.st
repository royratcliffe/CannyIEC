(*
================================================================================
Function : FUN_<NAME>

Purpose:
    <Brief description of what the function calculates or returns.>

Application:
    <Typical use case.>

Inputs:
    <InputName>  - <Description>

Return Value:
    <Type>       - <Description of returned value>

Assumptions:
    - <Assumption 1>
    - <Assumption 2>

Limitations:
    - <Limitation 1>
    - <Limitation 2>

Example:

    rFlowRate := FUN_CalculateFlow(
        rVolume := 100.0,
        tTime := T#10s
    );

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    DD/MM/YYYY   1.0      <Author>         Initial Release
    DD/MM/YYYY   1.1      <Author>         <Change Description>
    ----------------------------------------------------------------------------
================================================================================
*)
FUNCTION FUN_<NAME> : <RETURN_TYPE>

VAR_INPUT
    /// Description of input parameter
    <Input1> : <TYPE>;

    /// Description of input parameter
    <Input2> : <TYPE>;
END_VAR
