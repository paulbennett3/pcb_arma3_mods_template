/* ******************************************************************
                         spawn cultists

Parameters:
    _group (group object) : the group of objects to "convert" to cultists
    _uniform (list of strings) : the "uniforms" to force on the cultists

Returns:
   Nothing
****************************************************************** */
params ["_group"];

private _units = units _group;
["Converting units to cultists: " + (str _units)] call pcb_fnc_debug;
private _cdx = 0;
for [{_cdx = 0}, {_cdx < (count _units)}, {_cdx = _cdx + 1}] do {
    private _unit = _units select _cdx;

    removeAllWeapons _unit;
    removeAllItems _unit;
    removeAllAssignedItems _unit;
    removeUniform _unit;
    removeVest _unit;
    removeBackpack _unit;
    removeHeadgear _unit;
    removeGoggles _unit;

    _unit addWeapon "hgun_Pistol_heavy_02_F";
    _unit addHandgunItem "6Rnd_45ACP_Cylinder";

    _unit forceAddUniform "U_B_FullGhillie_sard";

    _unit addItemToUniform "FirstAidKit";
    for "_i" from 1 to 10 do {_unit addItemToUniform "6Rnd_45ACP_Cylinder";};

    // set the textures to black
    private _texture = "#(rgb,8,8,3)color(0,0,0,1)"; // black texture
    private _tdx = 0;
    for [{_tdx = 0}, {_tdx < 15}, {_tdx = _tdx + 1}] do {
        _unit setObjectTextureGlobal [_tdx, _texture]; // set it on player
    };
    uniformContainer _unit setVariable ["texture", _texture, true]; // store it on uniform    
};

