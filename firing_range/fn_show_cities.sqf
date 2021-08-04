/* ********************************************************
                   show cities
******************************************************** */
private _allLocationTypes = [];
"_allLocationTypes pushBack configName _x" configClasses (configFile >> "CfgLocationTypes");
{
    private _pos = locationPosition _x;
    private _size = size _x;
    private _importance = importance _x;
    private _type = type _x;
    private _rect = rectangular _x;

    switch (_type) do {
        case "CivilDefense";
        case "CulturalProperty";
        case "NameLocal";
        case "SafetyZone":
            {
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
        case "CityCenter";
        case "NameCityCapital";
        case "NameVillage";
        case "NameCity";
        case "FlatAreaCity";
        case "FlatAreaCitySmall":
            {
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
        case "DangerousForces";
        case "HistoricalSite";
        case "n_installation";
        case "Name";
        case "u_installation";
        case "Strategic";
        case "StrongpointArea";
        case "FlatArea";
        case "Area";
        case "BorderCrossing";
        case "Flag";
        case "Hill";
        case "Mount";
        case "NameMarine";
        case "RockArea";
        case "VegetationBroadleaf";
        case "VegetationFir";
        case "VegetationPalm";
        case "VegetationVineyard";
        case "ViewPoint";
        case "fakeTown";
        case "respawn_air";
        case "respawn_armor";
        case "respawn_inf";
        case "respawn_motor";
        case "respawn_naval";
        case "respawn_para";
        case "respawn_plane";
        case "respawn_unknown":
            {
            };
    };

} forEach nearestLocations [(playableUnits select 0), _allLocationTypes, worldSize];

/*
"_allLocationTypes pushBackUnique configName _x" configClasses (configFile >> "CfgLocationTypes");
systemChat (str _allLocationTypes);
*/

/*
{
    private _pos = locationPosition _x;
    private _size = size _x;
    private _importance = importance _x;
    private _type = type _x;
    private _rect = rectangular _x;

    private _marker = createMarker [(str _x), _pos];
    if (_rect) then {
        _marker setMarkerShapeLocal "RECTANGLE";
    } else {
        _marker setMarkerShapeLocal "ELLIPSE";
    };
    _marker setMarkerSizeLocal _size;
    _marker setMarkerColorLocal "ColorRED";
    _marker setMarkerBrushLocal "BORDER";
    _marker setMarkerAlpha 0.9;

//    systemChat ((str _x) + " " + (str _pos) + " " + (str _size) + " " + (str _importance) + " " + (str _type));
} forEach nearestLocations [(playableUnits select 0), ["NameCity", "NameCityCapital", "NameVillage"], worldSize];
*/
