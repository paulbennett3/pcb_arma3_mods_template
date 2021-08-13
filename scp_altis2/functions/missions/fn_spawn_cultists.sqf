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

    _unit forceAddUniform "U_B_FullGhillie_sard";

    // set the textures to black
    private _texture = "#(rgb,8,8,3)color(0,0,0,1)"; 
    private _tdx = 0;
    for [{_tdx = 0}, {_tdx < 15}, {_tdx = _tdx + 1}] do {
        _unit setObjectTextureGlobal [_tdx, _texture]; // set it on player
    };
    uniformContainer _unit setVariable ["texture", _texture, true]; // store it on uniform    
    _unit setUnitPos "MIDDLE";
    _unit playMoveNow"AmovPercMstpSnonWnonDnon_AmovPknlMstpSnonWnonDnon";
    _unit addGoggles "NWTS_goggle_deer";

    if ((random 100) < 75) then {
        _unit addWeapon "SGA_bow_entspannt";
        _unit addPrimaryWeaponItem "sga_bow_mag";
        for "_i" from 1 to 10 do {_unit addItemToUniform "sga_bow_mag";};
    } else {
        if ((random 100) < 50) then {
            _unit addWeapon "vn_izh54_p";
            _unit addHandgunItem "vn_izh54_so_mag";

            for "_i" from 1 to 5 do {_unit addItemToUniform "vn_izh54_so_mag";};
            for "_i" from 1 to 5 do {_unit addItemToUniform "vn_izh54_mag";};
        } else {
            _unit addWeapon "hgun_Pistol_heavy_02_F";
            _unit addHandgunItem "6Rnd_45ACP_Cylinder";
            for "_i" from 1 to 10 do {_unit addItemToUniform "6Rnd_45ACP_Cylinder";};
        };
    };
};

