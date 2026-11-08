(*
================================================================================
Function Block Method : <FB_NAME>.<METHOD_NAME>

Purpose:
    <Brief description of what the method does.>

Application:
    <When or why this method is called.>

Operation:
    1. <Step 1>
    2. <Step 2>

Inputs:
    <InputName>  - <Description>

Outputs:
    <OutputName> - <Description>

InOut:
    <VarName>    - <Description>

Return Value:
    <Type>       - <Description of the returned value>

Assumptions:
    - <Assumption 1>
    - <Assumption 2>

Limitations:
    - <Limitation 1>
    - <Limitation 2>

Dependencies:
    - <Other FBs, methods, libraries, or hardware requirements>

Example:

    <ReturnValue> := fbExample.<MethodName>(
        <Input1> := <Value>
    );

Revision History:
    ----------------------------------------------------------------------------
    Date         Version  Author           Description
    ----------------------------------------------------------------------------
    DD/MM/YYYY   1.0      <Author>         Initial Release
    DD/MM/YYYY   1.1      <Author>         <Change Description>
    ----------------------------------------------------------------------------

SPDX-License-Identifier: MIT
================================================================================
*)
METHOD <METHOD_NAME> : <RETURN_TYPE>

VAR_INPUT
    (* Description of input parameter *)
    <Input1> : <TYPE>;
END_VAR

VAR_OUTPUT
    (* Description of output parameter *)
    <Output1> : <TYPE>;
END_VAR

VAR_IN_OUT
    (* Description of input/output parameter *)
    <InOut1> : <TYPE>;
END_VAR

VAR
    (* Description of local variable *)
    <Local1> : <TYPE>;
END_VAR
