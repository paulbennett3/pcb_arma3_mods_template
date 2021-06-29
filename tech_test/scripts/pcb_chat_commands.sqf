// Handlers for some special debug / convenience commands
addMissionEventHandler ["HandleChatMessage", {
    params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage",
            "_sentanceType", "_chatMessageType"];
    // is it a player message?
    if ((parseNumber _strID) > 1) then {
        switch (_text) do {
            case "leader": {
                // let player grab all playable units and become the leader
                playableUnits join _person;
                [group _person, _person] remoteExec ["selectLeader", groupOwner group  _person];
                _text = _name + " has been assigned as Leader";
                _text;
                };
            case "taxi": {
                _text = ("Roger call for taxi " + _name) + ", we are on the way";
                private _taxiname = "B_Heli_Light_01_F";
                private _heli = createVehicle [_taxiname, position _person, [], 2000, "FLY"];
                private _grp = createVehicleCrew _heli;
                _grp addVehicle _heli;
                [_heli, _grp] join _person;
                [_grp, position _person, _heli] spawn BIS_fnc_wpLand; // create a "land" waypoint
                _text;
                };
            case "loadout medic": {
                _text = "Switching loadout to Medic for " + _name;
                [_person, "Medic"] call compile preprocessFile "scripts\pcb_loadout.sqf";
                _text;
                };   
            case "loadout leader": {
                _text = "Switching loadout to Medic for " + _name;
                [_person, "Leader"] call compile preprocessFile "scripts\pcb_loadout.sqf";
                _text;
                };   
            case "loadout engineer": {
                _text = "Switching loadout to Medic for " + _name;
                [_person, "Engineer"] call compile preprocessFile "scripts\pcb_loadout.sqf";
                _text;
                };   
            case "loadout heavy": {
                _text = "Switching loadout to Heavy for " + _name;
                [_person, "Heavy"] call compile preprocessFile "scripts\pcb_loadout.sqf";
                _text;
                };   
        };
    };
}];
