/* *********************************************************************
                         types


For defining types and groups thereof
********************************************************************* */

types_hash = createHashMap;

// --------------------------------
// Occult Large Items - outdoors only!
//   for use with investigate, spawn,
//   destroy ...
// best place in forest or on hilltop
// --------------------------------
types_hash set ["occult large items", [
    "Land_Grave_obelisk_F",
    "Land_Grave_forest_F",
    "Land_Grave_dirt_F",
    "Land_Grave_rocks_F",
    "Land_Castle_01_tower_F",
    "Land_AncientPillar_damaged_F",
    "Land_AncientPillar_fallen_F",
    "Land_Water_source_F",
    "Land_TreeBin_F",
    "Land_WoodenBox_F",
    "Land_Calvary_01_V1_F",
    "Land_Maroula_F",
    "Land_AncientHead_01_F",
    "Land_AncientStatue_01_F",
    "Land_AncientStatue_02_F",
    "Land_StoneTanoa_01_F",
    "Land_RaiStone_01_F"
]];


// --------------------------------
// Tech Large Items - outdoors only!
//   for use with investigate, spawn,
//   destroy ...
// best place in forest or on hilltop
//   or near "research" lab ...
// --------------------------------
types_hash set ["tech large items", [
    "Land_PowerGenerator_F",
    "Land_Device_assembled_F",
    "Land_Device_disassembled_F"
]];


// --------------------------------
//    tech small items -- ok for inside
// --------------------------------
types_hash set ["small items", [
    "Land_DataTerminal_01_F",
    "Land_FMradio_F",
    "Land_HandyCam_F",
    "Land_Laptop_F",
    "Land_MobilePhone_smart_F",
    "Land_MobilePhone_old_F",
    "Land_PortableLongRangeRadio_F",
    "Land_Tablet_02_F",
    "Land_SurvivalRadio_F",
    "Land_Suitcase_F"
]];

// --------------------------------
// Civilians
// --------------------------------
types_hash set ["civilians", [
    "Max_Tak_woman1", "Max_Tak_woman2", "Max_Tak_woman3", "Max_Tak_woman4",
    "Max_Tak_woman5", "Max_Tak_woman6", "Max_Taky_woman1", "Max_Taky_woman2",
    "Max_Taky_woman3", "Max_Taky_woman4", "Max_Taky_woman5", "Max_Tak2_woman1",
    "Max_Tak2_woman2", "Max_Tak2_woman3", "Max_Tak2_woman4", "Max_Tak2_woman5",
    "Max_woman4", "Max_woman5", "Max_woman2", "Max_woman3", "Max_woman1",
    "vn_c_men_01", "vn_c_men_02", "vn_c_men_05", "vn_c_men_06",
    "vn_c_men_09", "vn_c_men_10", "vn_c_men_13", "vn_c_men_14",
    "vn_c_men_17", "vn_c_men_18", "vn_c_men_21", "vn_c_men_22",
    "vn_c_men_25", "vn_c_men_26", "vn_c_men_29", "vn_c_men_30",
    "vn_c_men_24", "vn_c_men_03", "vn_c_men_04", "C_IDAP_Man_AidWorker_01_F",
    "C_IDAP_Man_AidWorker_08_F", "C_IDAP_Man_AidWorker_05_F", "C_IDAP_Man_AidWorker_04_F",
    "C_IDAP_Man_AidWorker_03_F", "C_man_p_beggar_F_afro", "C_Man_casual_2_F_afro",
    "C_man_polo_1_F_afro", "C_man_shorts_2_F_afro", "C_Man_casual_8_F_asia", "C_man_polo_4_F_asia"
]];

types_hash set ["civ infected", [
    "C_Man_casual_1_F_afro_sick",
    "C_Man_casual_3_F_afro_sick",
    "C_man_sport_2_F_afro_sick",
    "C_Man_casual_4_F_afro_sick",
    "C_Man_casual_5_F_afro_sick",
    "C_Man_casual_6_F_afro_sick",
    "C_man_polo_1_F_afro_sick",
    "C_man_polo_2_F_afro_sick",
    "C_man_polo_3_F_afro_sick",
    "C_man_polo_6_F_afro_sick"
]];

// --------------------------------
// Zombies
// --------------------------------
types_hash set ["zombies", [
    "RyanZombieC_man_1", "RyanZombieC_man_hunter_1_F", "RyanZombie19", "RyanZombie23",
    "RyanZombie29", "RyanZombieC_man_polo_4_F", "RyanZombieC_scientist_F", "RyanZombieB_Soldier_lite_F",
    "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_02_fmediumOpfor", "RyanZombieB_Soldier_02_f_1mediumOpfor",
    "RyanZombieB_Soldier_02_f_1_1mediumOpfor", "RyanZombieB_Soldier_03_fmediumOpfor",
    "RyanZombieB_Soldier_03_f_1mediumOpfor", "RyanZombieB_Soldier_03_f_1_1mediumOpfor",
    "RyanZombieB_Soldier_04_fmediumOpfor", "RyanZombieB_Soldier_04_f_1mediumOpfor",
    "RyanZombieB_Soldier_04_f_1_1mediumOpfor", "RyanZombieB_Soldier_lite_FmediumOpfor",
    "RyanZombieB_Soldier_lite_F_1mediumOpfor", "RyanZombieB_Soldier_02_fmediumOpfor",
    "RyanZombieB_Soldier_02_f_1mediumOpfor", "RyanZombieB_Soldier_02_f_1_1mediumOpfor"
]];


// --------------------------------
// Demons
// --------------------------------
types_hash set ["demons", [
    "RyanZombieboss1", "RyanZombieboss10", "RyanZombieboss11", "RyanZombieboss12",
    "RyanZombieboss13", "RyanZombieboss15", "RyanZombieboss30", "RyanZombieboss16",
    "RyanZombieboss28"
]];

// --------------------------------
// Spooks
// --------------------------------
types_hash set ["spooks", [
    "DSA_411",
    "DSA_Abomination",
    "DSA_Crazy",
    "DSA_Hatman",
    "DSA_Mindflayer",
    "DSA_Rake",
    "DSA_Shadowman",
    "DSA_Snatcher",
    "DSA_Vampire",
    "DSA_Wendigo"
]];

// --------------------------------
// Looters
// --------------------------------
types_hash set ["looters", [
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F",
    "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F",
    "I_L_Looter_Rifle_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_7_F",
    "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F",
    "I_C_Soldier_Bandit_1_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F"
]];

// --------------------------------
// Civilian Vehicles
// --------------------------------
types_hash set ["civ vehicles", [
    "C_Hatchback_01_F", "C_Offroad_02_unarmed_F", "C_Offroad_01_F", "C_Offroad_01_comms_F",
    "C_Offroad_01_covered_F", "C_Offroad_01_repair_F", "C_Quadbike_01_F", "C_SUV_01_F",
    "C_Tractor_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Van_02_vehicle_F",
    "C_Van_02_service_F", "C_Van_02_transport_F", "C_Truck_02_fuel_F", "C_Truck_02_box_F",
    "C_Truck_02_transport_F", "C_Truck_02_covered_F"
]];


// --------------------------------
//   Police Foot
// --------------------------------
types_hash set ["police", [
    "B_GEN_Commander_F",
    "B_GEN_Soldier_F"
]];

// --------------------------------
//   Police Vehicles
// --------------------------------
types_hash set ["police vehicles", [
    "B_GEN_Offroad_01_gen_F",
    "B_GEN_Van_02_vehicle_F",
    "B_GEN_Van_02_transport_F",
    "B_GEN_Offroad_01_comms_F"
]];

// --------------------------------
//  Civilian Air
// --------------------------------
types_hash set ["civ air", [
    "C_Plane_Civil_01_F",
    "C_Heli_Light_01_civil_F"
]];

// --------------------------------
//   Ambulance
// --------------------------------
types_hash set ["ambulance", [
    "C_Van_02_medevac_F"
]];

// --------------------------------
// Military Base Buildings
// --------------------------------
types_hash set ["military buildings", [
    "Cargo_Tower_base_F", "Land_i_Barracks_V1_F",
    "Land_i_Barracks_V2_F", "Land_u_Barracks_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F",
    "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F",
    "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F",
    "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F",
    "Land_Dome_Big_F", "Land_Dome_Small_F", "Land_Research_HQ_F"
]];

// --------------------------------
// Cool Buildings (overlaps with Military buildings)
// --------------------------------
types_hash set ["cool buildings", [
    "Cargo_Tower_base_F", "Land_Offices_01_V1_F", "Land_Hospital_Main_F",
    "Land_LightHouse_F", "Land_Castle_01_tower_F", "Land_d_Windmill01_F", "Land_i_Barracks_V1_F",
    "Land_i_Barracks_V2_F", "Land_u_Barracks_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F",
    "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F",
    "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F",
    "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F",
    "Land_Dome_Big_F", "Land_Dome_Small_F", "Land_Research_HQ_F"
]];


// --------------------------------
//  Resupply crates (already loaded)
// --------------------------------
types_hash set ["resupply crates", [
    "O_CargoNet_01_ammo_F",
    "C_IDAP_CargoNet_01_supplies_F",
    "I_E_CargoNet_01_ammo_F",
    "B_CargoNet_01_ammo_F"
]];

// --------------------------------
// SVBuildings (from CfgVehicles!) 
//  "spare vehicle buildings" -- ie, the
//   buildings to spawn spare cars near
// --------------------------------
types_hash set ["svbuildings", [
    "House", "Fuelstation", "Lighthouse", "Church", "Hospital", "Transmitter"
]];


// --------------------------------
// Blood splatters
// --------------------------------
types_hash set ["blood", [
    "BloodPool_01_Large_New_F",
    "BloodPool_01_Large_Old_F",
    "BloodPool_01_Medium_New_F",
    "BloodPool_01_Medium_Old_F",
    "BloodSplatter_01_Large_New_F",
    "BloodSplatter_01_Large_Old_F",
    "BloodSplatter_01_Medium_New_F",
    "BloodSplatter_01_Medium_Old_F",
    "BloodSplatter_01_Small_New_F",
    "BloodSplatter_01_Small_Old_F",
    "BloodSpray_01_New_F",
    "BloodSpray_01_Old_F",
    "BloodTrail_01_New_F",
    "BloodTrail_01_Old_F"
]];

types_hash set ["bones", [
    "Land_HumanSkeleton_F",
    "Land_HumanSkull_F"
]];

types_hash set ["detritus", [
    "Land_Pumpkin_01_F",
    "Campfire_burning_F",
    "Land_FirePlace_F",
    "Land_WoodenLog_F",
    "Land_WoodPile_F",
    "Leaflet_05_F",
    "Leaflet_05_Old_F",
    "Land_Garbage_square3_F",
    "Land_Garbage_square5_F",
    "Land_Garbage_line_F",
    "Oil_Spill_F",
    "Land_Cages_F",
    "Land_Axe_F",
    "Land_Bucket_F",
    "Land_File_F",
    "Land_MetalWire_F",
    "Land_Rope_01_F",
    "Land_Shovel_F",
    "Land_vn_garbage_square3_f",
    "vn_b_item_trapkit_gh"
]];



// Helicopters


// Trucks 


publicVariable "types_hash";
