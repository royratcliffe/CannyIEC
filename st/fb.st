(*
================================================================================
Function Block : FB_<NAME>

Purpose:
    <Brief description of what the function block does.>

Application:
    <Where this FB is intended to be used.>

Operation:
    1. <Step 1>
    2. <Step 2>
    3. <Step 3>

Inputs:
    <InputName>  - <Description>

Outputs:
    <OutputName> - <Description>

InOut:
    <VarName>    - <Description>

Alarms/Faults:
    <FaultName>  - <Description>

Assumptions:
    - <Assumption 1>
    - <Assumption 2>

Limitations:
    - <Limitation 1>
    - <Limitation 2>

Dependencies:
    - <Other FBs, libraries, hardware requirements>

Example:

    fbExample(
        xEnable := TRUE,
        rSetpoint := 50.0
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
FUNCTION_BLOCK FB_<NAME>

VAR_INPUT
    /// Enables FB execution
    xEnable : BOOL;

    /// Process setpoint
    rSetpoint : REAL;
END_VAR

VAR_OUTPUT
    /// Indicates FB operating correctly
    xHealthy : BOOL;

    /// Fault condition active
    xFault : BOOL;

    /// Process output value
    rOutput : REAL;
END_VAR

VAR_IN_OUT
    /// Shared process data
    stData : ST_ProcessData;
END_VAR

VAR
    // Internal timer used for delay functions
    tonDelay : TON;

    // Internal state machine
    iState : INT;
END_VAR
