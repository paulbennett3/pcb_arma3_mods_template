
// Create diary entries (shows up under "briefing" tab on map display).  
// They display in stack order (ie, first one placed is at the bottom)
// Uses "structured text", so can add images et al
{
    _x createDiaryRecord [
        "diary", [
            "Resupply", 
            "Resupply chat commands:<br /> resupply X at Y <br /> where X is ammo, medical, or support, and " +
            "Y is grid coordinates.  <br /> Example:  resupply ammo at 124125<br /> resupply there <br /> " + 
            "will cause the squad to attempt to move to the item pointed to and resupply"
        ]
    ];
} forEach playableUnits;

[] spawn {
    while { sleep 30; true } do {
        {
            if (isPlayer _x) then {
                [] remoteExec ["pcb_fnc_convenience_remote", owner _x];
            };
        } forEach playableUnits;
    };
};

