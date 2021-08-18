// used for sending "mail" to the server

params ["_mail"];

private _my_mutex_id = "server_mail" + (str serverTime) + (str (random 1000));
if (isNil "server_mail_mutex") then {
    server_mail_mutex = ["create", _my_mutex_id] call pcb_fnc_mutex;
    publicVariable "server_mail_mutex";
};
waitUntil { ! isNil "server_mail_mutex"; };
["get", _my_mutex_id, server_mail_mutex] call pcb_fnc_mutex;

message_box pushBackUnique _mail;
publicVariable "message_box";

["release", _my_mutex_id, server_mail_mutex] call pcb_fnc_mutex;
