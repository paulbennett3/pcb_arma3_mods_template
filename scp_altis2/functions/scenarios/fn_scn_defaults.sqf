/* *******************************************************************
                           scn_defaults

This function sets the default scenario parameters and functions.
Call it prior to subsequent scenario files, which may alter these.

******************************************************************* */

["Scenario Defaults Running"] call pcb_fnc_debug;
scenario_object = createHashMap;
scenario_object set ["Init Order", []];

scenario_object set ["Name", "DEFAULT"];

// ------------------------------
// Set Methods (and calling order)
// ------------------------------

// *****************************
// *** convenience functions ***
// *****************************

// add a method for adding methods ...
scenario_object set ["_addmethod", {
    params ["_obj", "_name", "_func"];
    _obj set [_name, _func];
}];

// add a method for adding methods, along with their calling order (for init)  ...
scenario_object set ["_addmethod_ordered", {
    params ["_obj", "_name", "_func"];
    [_obj, _name, _func] call (_obj get "_addmethod");
    (_obj get "Init Order") pushBack _name;
}];

// For logging -- adds scenario name
scenario_object set ["_log", {
    params ["_msg"];
    [(scenario_object get "Name") + " :: " + _msg] call pcb_fnc_debug;
}];

// Runs the init functions in their specified order -- called by Mission Generator once at startup 
scenario_object set ["_init", {
    params ["_obj"];
    private _order = _obj get "Init Order";
    private _iodx = 0;
    for [{}, {_iodx < (count _order)}, {_iodx = _iodx + 1}] do { 
        private _method_name = _order select _iodx;
        private _method = _obj getOrDefault [_method_name, { 
            ["Error! method <" + _method_name + "> not found!"] call (_obj get "_log"); 
        }];

        [" running: " + _method_name] call (_obj get "_log");
        [] call _method;
    };
}];

// ************************
// *** Standard Methods ***
// ************************

// Determine where the start point is
[
    scenario_object, 
    "Start Position", 
    pcb_fnc_random_start_pos
] call (scenario_object get "_addmethod_ordered");

// Wait until the start point is established
[
    scenario_object, 
    "Start Synch", 
    { waitUntil { ! isNil "random_start_ready" }; }
] call (scenario_object get "_addmethod_ordered");


// Create the starting point (base?) + spawning point
[
    scenario_object,
    "Start Base", 
    pcb_fnc_start_base_setup2
] call (scenario_object get "_addmethod_ordered");

// manipulate the starting weather et al
[
    scenario_object,
    "Mission Environment", 
    pcb_fnc_set_mission_environment
] call (scenario_object get "_addmethod_ordered");

// Start the "director" process running
[
    scenario_object,
    "Director", 
    pcb_fnc_director
] call (scenario_object get "_addmethod_ordered");

// Start the "background" event generator running
[
    scenario_object,
    "Background", 
    pcb_fnc_background
] call (scenario_object get "_addmethod_ordered");

// ********************************
// *** Mission Helper Functions ***
//  !!! not called during init !!!
// ********************************

// For decorating mission areas 
[
    scenario_object,
    "Decorate", 
    pcb_fnc_occult_decorate
] call (scenario_object get "_addmethod");

// For generating mission encounters (ie, not background or director stuff)
[
    scenario_object,
    "Mission Encounter", 
    pcb_fnc_mission_encounter
] call (scenario_object get "_addmethod");

// For adding anomalies (or mines eventually?!?)
[
    scenario_object,
    "Add Anomalies", 
    pcb_fnc_add_anomalies
] call (scenario_object get "_addmethod");




// ------------------------------------------------------------- 
//  Set variables
// ------------------------------------------------------------- 
scenario_object set ["Mission List", []];  // will hold the list of missions to run
scenario_object set ["Mission Select", "sequential"]; // how to pick the next mission
scenario_object set ["Total Missions", 0]; // How many missions until done (with this phase of scenario)
scenario_object set ["Scenario State", 1]; // Which phase of the scenario we are in

private _sobj = scenario_object;
_sobj
