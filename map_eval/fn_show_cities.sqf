/* ********************************************************
                   show cities
******************************************************** */
private _militaryIndustrial = createHashMapFromArray [ 
    ["CivilDefense", 1], ["CulturalProperty", 1],
    ["NameLocal", 1], ["SafetyZone", 1]
];
private _city = createHashMapFromArray [
    ["CityCenter", 1],
    ["NameCityCapital", 1],
    ["NameVillage", 1],
    ["NameCity", 1],
    ["FlatAreaCity", 1],
    ["FlatAreaCitySmall", 1]
];
private _other = createHashMapFromArray [
    ["DangerousForces", 1],
    ["HistoricalSite", 1],
    ["n_installation", 1],
    ["Name", 1],
    ["u_installation", 1],
    ["Strategic", 1],
    ["StrongpointArea", 1],
    ["FlatArea", 1],
    ["Area", 1],
    ["BorderCrossing", 1],
    ["Flag", 1],
    ["Hill", 1],
    ["Mount", 1],
    ["NameMarine", 1],
    ["RockArea", 1],
    ["VegetationBroadleaf", 1],
    ["VegetationFir", 1],
    ["VegetationPalm", 1],
    ["VegetationVineyard", 1],
    ["ViewPoint", 1],
    ["fakeTown", 1],
    ["respawn_air", 1],
    ["respawn_armor", 1],
    ["respawn_inf", 1],
    ["respawn_motor", 1],
    ["respawn_naval", 1],
    ["respawn_para", 1],
    ["respawn_plane", 1],
    ["respawn_unknown", 1]
];


 private _allLocationTypes = [];
"_allLocationTypes pushBack configName _x" configClasses (configFile >> "CfgLocationTypes");
{
    private _pos = locationPosition _x;
    private _size = size _x;
    private _importance = importance _x;
    private _type = type _x;
    private _rect = rectangular _x;

    if (_type in _militaryIndustrial) then {
        private _marker = createMarker [(str _x), _pos];
        if (_rect) then {
            _marker setMarkerShapeLocal "RECTANGLE";
        } else {
            _marker setMarkerShapeLocal "ELLIPSE";
        };
        _marker setMarkerSizeLocal _size;
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorORANGE";
    };

    if (_type in _city) then {
        private _marker = createMarker [(str _x), _pos];
        if (_rect) then {
            _marker setMarkerShapeLocal "RECTANGLE";
        } else {
            _marker setMarkerShapeLocal "ELLIPSE";
        };
        _marker setMarkerSizeLocal _size;
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorBLUE";
    };


} forEach nearestLocations [(playableUnits select 0), _allLocationTypes, worldSize];





// https://community.bistudio.com/wiki/Arma_3:_CfgPatches_CfgVehicles#A3_Structures_F_Mil_Cargo
private _mil_building_types = [
    "Land_Cargo_House_V1_F",
    "Land_Cargo_House_V2_F",
    "Land_Cargo_House_V3_F",
    "Land_Cargo_HQ_V1_F",
    "Land_Cargo_HQ_V2_F",
    "Land_Cargo_HQ_V3_F",
    "Land_Cargo_Patrol_V1_F",
    "Land_Cargo_Patrol_V2_F",
    "Land_Cargo_Patrol_V3_F",
    "Land_Cargo_Tower_V1_F",
    "Land_Cargo_Tower_V1_No1_F",
    "Land_Cargo_Tower_V1_No2_F",
    "Land_Cargo_Tower_V1_No3_F",
    "Land_Cargo_Tower_V1_No4_F",
    "Land_Cargo_Tower_V1_No5_F",
    "Land_Cargo_Tower_V1_No6_F",
    "Land_Cargo_Tower_V1_No7_F",
    "Land_Cargo_Tower_V2_F",
    "Land_Cargo_Tower_V3_F",
    "Land_Medevac_house_V1_F",
    "Land_Medevac_HQ_V1_F",
    "Land_i_Barracks_V1_F",
    "Land_i_Barracks_V2_F",
    "Land_u_Barracks_V2_F",
    "Land_Radar_F",
    "Land_Radar_Small_F",
    "Land_Dome_Big_F",
    "Land_Dome_Small_F",
    "Land_Research_house_V1_F",
    "Land_Research_HQ_F"
];


[_mil_building_types] spawn {
    params ["_types"];

    [
        _types, 
        getPosATL (playableUnits select 0), 
        worldSize, 
        200, 
        3
    ] call compile preprocessFileLineNumbers "fn_find_object_clusters.sqf";
    sleep 5;
    waitUntil { sleep 1; not (isNil "cluster_search_done") };
    waitUntil { sleep 1; cluster_search_done };

    {
        private _cluster = cluster_search_results get _x;
        private _center = _cluster get "center";
        private _marker = createMarker ["MILCLUST" + (str _x), _center];
        _marker setMarkerType "KIA";
    } forEach (keys cluster_search_results);
 };


