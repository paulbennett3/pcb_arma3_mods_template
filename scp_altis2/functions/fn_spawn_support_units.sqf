/* ***********************************************************************
                      Spawn a support unit (High Command)

Args:
    _types_lists [array] -- arrays of [unit type, [type string 1, type string 1, ...]] 
    
Example:
   [
        ["Infantry", ["type1", "type2", ...  ]],
        ["Vehicle", ["type1", "type2", ...]],
   ]
    unit
*********************************************************************** */

params ["_types_lists"];

support_units = _types_lists;
publicVariable "support_units";

{
    private _leader = leader group (playableUnits select 0);
    private _gpos = _leader getRelPos [20 + (random 30), random 360];

    HC = objNull;
    _group_logic = objNull;
    private _hc_synced = false;
 
    // is there already a high command module assigned to this unit?
    {
        if (typeOf _x == "HighCommand") then {
            HC = _x;
            _group_logic = group _x;
            _hc_synced = true;
        } 
    } forEach (synchronizedObjects _leader);
     
    if (isNull HC) then { 
        // create the top level commander module
        _group_logic = createGroup sideLogic;
        "HighCommand" createUnit [
            _gpos,
            _group_logic,
            "this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; HC = this;"
        ];
    };

    if ((! isNull HC) and (! _hc_synced)) then {
        _leader synchronizeObjectsAdd [HC];
    };

    // create the groups
    {
         _gpos = _leader getRelPos [20 + (random 30), random 360];
        private _group_type = _x select 0;
        private _group_types = _x select 1;
        private _group_support = _x select 0;

        private _obj_list = [];
        private _group = createGroup side _leader;
        {
            if (_group_type isEqualTo "Infantry") then {
                private _obj = _group createUnit [_x, _gpos, [], 1, "NONE"];
                _obj_list pushBack _obj;
            } else {
                private _res = [
                    _leader getRelPos [50, random 360],
                    0,
                    _x,
                    _group
                ] call BIS_fnc_spawnVehicle;
                _obj_list pushBack (_res select 0);
                {
                    _obj_list pushBack _x;
                } forEach (_res select 1);
            };
        } forEach _group_types;
        
        _obj_list joinSilent _group;
        _group deleteGroupWhenEmpty true;

        // allow the group to use any spare vehicle on the map
        if (_group_type isEqualTo "Infantry") then {
            {
                _group addVehicle _x;
            } forEach spare_vehicle_list;
        };
       

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
        } else {
            hint "ERROR! HCSub nil!";
        };
        if (! isNil "HC") then {
            HC synchronizeObjectsAdd [HCSub];
        };
    } forEach support_units;

} remoteExec ["call", leader group (playableUnits select 0), true];


