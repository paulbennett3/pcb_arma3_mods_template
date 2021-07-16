/* ***********************************************************************
                      Spawn a support unit (High Command)

Args:
    _types_lists [array] -- arrays of unit types and names 
    
Example:
   [
        ["Unit1", ["type1", "type2", ...  ]],
        ["Unit2", ["type1", "type2", ...]],
   ]
    unit
*********************************************************************** */

params ["_types_lists"];

support_units = _types_lists;
publicVariable "support_units";

{
    private _leader = leader group (playableUnits select 0);
    private _gpos = getPosATL _leader;

    // create the top level commander module
    private _group_logic = createGroup sideLogic;
    "HighCommand" createUnit [
        _gpos,
        _group_logic,
        "this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; HC = this;"
    ];

    if (! isNil "HC") then {
        _leader synchronizeObjectsAdd [HC];
    };

    // create the groups
    {
        private _group_name = _x select 0;
        private _group_types = _x select 1;

        private _group = createGroup side _leader;
        {
            private _obj = _group createUnit [_x, _gpos, [], 1, "NONE"];
        } forEach _group_types;

        _group setCombatMode "RED";
        _group setBehaviour "SAFE";
        _group setFormation "LINE";

        "HighCommandSubordinate" createUnit [
            _gpos,
            _group_logic,
            "this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; HCSub = this;"
        ];

        if (! isNil "HCSub") then {
            HCSub synchronizeObjectsAdd (units _group);
        };
        if (! isNil "HC") then {
            HC synchronizeObjectsAdd [HCSub];
        };
    } forEach support_units;

} remoteExec ["call", leader group (playableUnits select 0), true];


