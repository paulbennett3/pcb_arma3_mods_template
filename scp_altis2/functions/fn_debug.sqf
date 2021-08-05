/* *************************************************************
                     debug

For handling debug messages.
************************************************************* */
params ["_message"];

private _msg = "PCB :: " + _message;
diag_log _msg;
if (pcb_DEBUG) then {
    [_msg] remoteExec ["systemChat", 0, true];
    [_msg] remoteExec ["hint", 0, true];
};
