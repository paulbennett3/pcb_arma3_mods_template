params ["_target", "_packed_unpacked_rot", "_act"];

// add an action to our new object to pack/unpack
private _cmd = {
    params ["_target", "_caller", "_actionId", "_arguments"];
    private _packed_unpacked_rot = _arguments select 0;
    private _act = _arguments select 1;

    private _msg = ["pck", _target, _packed_unpacked_rot, _act];
    [_msg] call pcb_fnc_send_mail;
};


[
    _target,
    [
        _act,
        _cmd,
        [_packed_unpacked_rot, _act], 1.5, true, true, "", "true", 5 
    ]
] remoteExec ["addAction", 0, true];
