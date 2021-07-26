/* *********************************************************
                    destroy building

For things that have "ruin" model, swap the model for the
ruined version.  To work around the issue in MP, "hide" the
"good" model on all the other clients (bug -- it shows
both the ruined and original except on the machine this is
native to ...)
********************************************************* */
params ["_building"];

_building call BIS_fnc_createRuin;
[_building, true] remoteExecCall ["hideObject",-clientOwner];
