/* ******************************************************************
                  spawn spare helicopters

Put helicopters on all the helipads on the map
****************************************************************** */
// only let this run once!!!!
if (! isNil "spare_heli_spawner") exitWith {};
spare_heli_spawner = true; 
publicVariable "spare_heli_spawner";

// List of types allowed to be spawned in
//  Feel free to remove items from this list (just make sure
//    to add commas after lines, except for the very last one).
//  The easy way to get model strings is to place a model in the
//   editor, then right-click it and select "Log" -> "Log Classes to Clipboard", then
//   paste that in, adding quotes and commas as appropriate.  Note that you
//   can do multiple models at once this way -- just select 'em all ...
//   The airports or the plains of Almyra are great for this, just sayin'.
//
//  Also, if you want a particular heli to have a higher than strictly uniform chance,
//   just add multiple duplicate lines of it.  I'll leave it to you to figure
//   out the exact probabilities if you are so inclined, I'm on "vacation".
private _types = [
    "vn_b_air_uh1d_01_04",
    "vn_b_air_uh1d_01_06",
    "vn_b_air_uh1d_01_07",
    "vn_o_air_mi2_01_01",
    "vn_o_air_mi2_01_02",
    "vn_i_air_ch34_02_02",
    "B_Heli_Transport_03_unarmed_F",
    "O_Heli_Transport_04_covered_F",
    "O_Heli_Light_02_unarmed_F",
    "I_Heli_light_03_unarmed_F",
    "B_Heli_Light_01_F",
    "C_Heli_Light_01_civil_F"  // NOTE no comma on last element in list !!!!
]; 

// get a list of all the helipads
// we use the first playableUnit (probably the player, as it is the leader) as
//  a central point to search from
private _helipads = (playableUnits select 0) nearObjects ["Helipad_Base_F", worldSize];

// For each helipad in the world, spawn a heli
{
    private _pos = getPosATL _x;
    private _type = selectRandom _types;
    private _veh = createVehicle [_type, _pos, [], 0, "NONE"];
    _veh setVariable ["BIS_enableRandomization", false];
    _veh setDir (random 360);
    sleep .1;
} forEach _helipads;
