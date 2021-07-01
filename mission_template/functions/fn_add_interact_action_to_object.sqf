// Given an object, add an interaction command (addAction)
// Parameters:
//   _object  is the object to attach the action to
params ["_object", "_action", "_done_code", "_duration"];

private _icon = "";
private _trait = "";
switch (_action) do {
    case "repair": { 
            _icon = "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa";
            _trait = "engineer";
        };
    case "translate": {
            _icon = "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa";
            _trait = "scholar";
        };
    case "research": {
            _icon = "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa";
            _trait = "engineer";
        };
    case "study": {
            _icon = "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa";
            _trait = "scholar";
        };
    case "unpack": {
            _icon = "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa";
        };
    case "treat": {
            _icon = "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa" ;
            _trait = "medic";
        };
    case "bind": {
            _icon = "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa";
            _trait = "scholar";
        };
};

private _start_cond = "(_this distance _target < 3)";
private _cont_cond = "_caller distance _target < 3";

if (_trait != "") then {
    _start_cond = "(" + _start_cond + ' && (_this getUnitTrait "' + _trait + '"))';
    _cont_cond = "(" + _cont_cond + ' && (_caller getUnitTrait "' + _trait + '"))';
};

[
    _object,
    _action,
    _icon,
    _icon,
    _start_cond,
    _cont_cond,
    {},
    {},
    _done_code,
    {},
    [],
    _duration,
    0,
    true,
    false
] remoteExec ["BIS_fnc_holdActionAdd", 0, _object];


// Object the action is attached to
// Title of the action
// Idle icon shown on screen
// Progress icon shown on screen
// Condition for the action to be shown
// Condition for the action to progress
// Code executed when action starts
// Code executed on every progress tick
// Code executed on completion
// Code executed on interrupted
// Arguments passed to the scripts as _this select 3
// Action duration [s]
// Priority
// Remove on completion
// Show in unconscious state


// repair        (wrench and circle)   "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\repair_ca.paa"
// map           (map)        "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\map_ca.paa"
// unloaddevice (download)  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unloaddevice_ca.paa"
// unbind        (chain) "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_unbind_ca.paa" 
// destroy       (explosion)  "\a3\ui_f_oldman\data\IGUI\Cfg\holdactions\destroy_ca.paa"
// search        (magnifying glass)  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa"
// revive        (asterisk)  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_revive_ca.paa"
// reviveMedic  (sinus rythm) "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa" 
// forceRespawn (skull) "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_forceRespawn_ca.paa"
// talk (speech bubble)   "\a3\missions_f_oldman\data\img\holdactions\holdAction_talk_ca.paa"
// follow_start  (two people)   "\a3\missions_f_oldman\data\img\holdactions\holdAction_follow_start_ca.paa" 
// exit (door)     "\a3\Missions_F_Orange\Data\Img\Showcase_LawsOfWar\action_exit_CA.paa"
// box (box)    "\a3\missions_f_oldman\data\img\holdactions\holdAction_box_ca.paa"
