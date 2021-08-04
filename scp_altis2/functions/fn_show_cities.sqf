/* ********************************************************
                   show cities
******************************************************** */


[] spawn {
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
        "Land_Research_HQ_F",
        "Land_MilOffices_V1_F"
    ];
    private _types = _mil_building_types;


    [
        _types, 
        world_center, 
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
        _marker setMarkerType "b_motor_inf";
        _marker = createMarker ["MILCLUSTB" + (str _x), _center];
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerSizeLocal [_cluster get "a", _cluster get "b"];
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorRED";
    } forEach (keys cluster_search_results);

private _civ_building_types = [
    "Land_Offices_01_V1_F",
    "Land_Church_01_V1_F",
    "Land_Hospital_main_F",
    "Land_Hospital_side1_F",
    "Land_Hospital_side2_F",
    "Land_WIP_F",
    "Land_d_House_Big_01_V1_F",
    "Land_i_House_Big_01_V1_F",
    "Land_i_House_Big_01_V2_F",
    "Land_i_House_Big_01_V3_F",
    "Land_u_House_Big_01_V1_F",
    "Land_d_House_Big_02_V1_F",
    "Land_i_House_Big_02_V1_F",
    "Land_i_House_Big_02_V2_F",
    "Land_i_House_Big_02_V3_F",
    "Land_u_House_Big_02_V1_F",
    "Land_d_Shop_01_V1_F",
    "Land_i_Shop_01_V1_F",
    "Land_i_Shop_01_V2_F",
    "Land_i_Shop_01_V3_F",
    "Land_u_Shop_01_V1_F",
    "Land_d_Shop_02_V1_F",
    "Land_i_Shop_02_V1_F",
    "Land_i_Shop_02_V2_F",
    "Land_i_Shop_02_V3_F",
    "Land_u_Shop_02_V1_F",
    "Land_d_House_Small_01_V1_F",
    "Land_i_House_Small_01_V1_F",
    "Land_i_House_Small_01_V2_F",
    "Land_i_House_Small_01_V3_F",
    "Land_u_House_Small_01_V1_F",
    "Land_d_House_Small_02_V1_F",
    "Land_i_House_Small_02_V1_F",
    "Land_i_House_Small_02_V2_F",
    "Land_i_House_Small_02_V3_F",
    "Land_u_House_Small_02_V1_F",
    "Land_i_House_Small_03_V1_F",
    "Land_d_Stone_HouseBig_V1_F",
    "Land_i_Stone_HouseBig_V1_F",
    "Land_i_Stone_HouseBig_V2_F",
    "Land_i_Stone_HouseBig_V3_F",
    "Land_d_Stone_Shed_V1_F",
    "Land_i_Stone_Shed_V1_F",
    "Land_i_Stone_Shed_V2_F",
    "Land_i_Stone_Shed_V3_F",
    "Land_d_Stone_HouseSmall_V1_F",
    "Land_i_Stone_HouseSmall_V1_F",
    "Land_i_Stone_HouseSmall_V2_F",
    "Land_i_Stone_HouseSmall_V3_F",
    "Land_Unfinished_Building_01_F",
    "Land_Unfinished_Building_02_F",
    "Land_CarService_F"
];


    _types = _civ_building_types;

    [
        _types, 
        world_center, 
        worldSize, 
        200, 
        12 
    ] call compile preprocessFileLineNumbers "fn_find_object_clusters.sqf";
    sleep 5;
    waitUntil { sleep 1; not (isNil "cluster_search_done") };
    waitUntil { sleep 1; cluster_search_done };

    {
        private _cluster = cluster_search_results get _x;
        private _center = _cluster get "center";
        private _marker = createMarker ["CIVCLUST" + (str _x), _center];
        _marker setMarkerType "hd_end";
        _marker = createMarker ["CIVCLUSTB" + (str _x), _center];
        _marker setMarkerShapeLocal "RECTANGLE";
        _marker setMarkerSizeLocal [_cluster get "a", _cluster get "b"];
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorBLUE";
    } forEach (keys cluster_search_results);


    systemChat "DONE!";
    hint "DONE!";

 };


