/* *********************************************************************
                         types


For defining types and groups thereof
********************************************************************* */

types_hash = createHashMap;

// --------------------------------
// Large Items - outdoors only!
// --------------------------------
private _large_items = [
    "Land_Grave_obelisk_F",
    "Land_Grave_forest_F",
    "Land_Grave_dirt_F",
    "Land_AncientPillar_damaged_F",
    "Land_Maroula_F",
    "Land_Cages_F",
    "Land_Sacks_heap_F",
    "Land_PaperBox_closed_F",
    "Land_PaperBox_open_full_F",
    "Land_DataTerminal_01_F",
    "Land_CargoBox_V1_F",
    "Land_WaterBarrel_F",
    "Land_WaterTank_F",
    "Land_Cargo20_EMP_F",
    "Land_Device_assembled_F",
    "Land_Device_disassembled_F",
    "Catacomb_Stone_casket",
    "vn_dragon_01",
    "vn_dragon_02",
    "Land_vn_shrine_01",
    "Land_vn_vase_loam_3_ep1",
    "sga_skull_post"
];
types_hash set ["large items", _large_items];

// --------------------------------
//     small items -- ok for inside
// --------------------------------
private _small_items = [
    "Land_FirePlace_F",
    "Land_Campfire_F",
    "Land_Sleeping_bag_folded_F",
    "Land_CarBattery_02_F",
    "Land_CarBattery_01_F",
    "Land_FMradio_F",
    "Land_HandyCam_F",
    "Land_Laptop_F",
    "Land_MobilePhone_smart_F",
    "Land_MobilePhone_old_F",
    "Land_PortableLongRangeRadio_F",
    "Land_Tablet_02_F",
    "Land_SurvivalRadio_F",
    "Land_Sack_F",
    "Land_Ammobox_rounds_F",
    "Land_MetalBarrel_F",
    "Land_BarrelSand_F",
    "Land_BarrelTrash_grey_F",
    "Land_Suitcase_F",
    "Land_CanisterPlastic_F",
    "Land_GasCanister_F"
];
types_hash set ["small items", _small_items];

// --------------------------------
// Civilians
// --------------------------------
private _civ_list = [
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
];
types_hash set ["civilians", _civ_list];

// --------------------------------
// Zombies
// --------------------------------
private _zombies = [
    "RyanZombieC_man_1", "RyanZombieC_man_hunter_1_F", "RyanZombie19", "RyanZombie23",
    "RyanZombie29", "RyanZombieC_man_polo_4_F", "RyanZombieC_scientist_F", "RyanZombieB_Soldier_lite_F",
    "RyanZombieB_Soldier_02_f_1_1", "RyanZombieB_Soldier_02_fmediumOpfor", "RyanZombieB_Soldier_02_f_1mediumOpfor",
    "RyanZombieB_Soldier_02_f_1_1mediumOpfor", "RyanZombieB_Soldier_03_fmediumOpfor",
    "RyanZombieB_Soldier_03_f_1mediumOpfor", "RyanZombieB_Soldier_03_f_1_1mediumOpfor",
    "RyanZombieB_Soldier_04_fmediumOpfor", "RyanZombieB_Soldier_04_f_1mediumOpfor",
    "RyanZombieB_Soldier_04_f_1_1mediumOpfor", "RyanZombieB_Soldier_lite_FmediumOpfor",
    "RyanZombieB_Soldier_lite_F_1mediumOpfor", "RyanZombieB_Soldier_02_fmediumOpfor",
    "RyanZombieB_Soldier_02_f_1mediumOpfor", "RyanZombieB_Soldier_02_f_1_1mediumOpfor"
];
types_hash set ["zombies", _zombies];


// --------------------------------
// Demons
// --------------------------------
private _demons = [
    "RyanZombieboss1", "RyanZombieboss10", "RyanZombieboss11", "RyanZombieboss12",
    "RyanZombieboss13", "RyanZombieboss15", "RyanZombieboss30", "RyanZombieboss16",
    "RyanZombieboss28"
];
types_hash set ["demons", _demons];

// --------------------------------
// Spooks
// --------------------------------
private _spooks = [
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
];
types_hash set ["spooks", _spooks];

// --------------------------------
// Looters
// --------------------------------
private _looters = [
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F",
    "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F",
    "I_L_Looter_Rifle_F", "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_7_F",
    "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F",
    "I_C_Soldier_Bandit_1_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F"
];
types_hash set ["looters", _looters];

// --------------------------------
// Civilian Vehicles
// --------------------------------
private _civ_vehicles = [
    "C_Hatchback_01_F", "C_Offroad_02_unarmed_F", "C_Offroad_01_F", "C_Offroad_01_comms_F",
    "C_Offroad_01_covered_F", "C_Offroad_01_repair_F", "C_Quadbike_01_F", "C_SUV_01_F",
    "C_Tractor_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Van_02_vehicle_F",
    "C_Van_02_service_F", "C_Van_02_transport_F", "C_Truck_02_fuel_F", "C_Truck_02_box_F",
    "C_Truck_02_transport_F", "C_Truck_02_covered_F"
];
types_hash set ["civ vehicles", _civ_vehicles];


// --------------------------------
//   Police Foot
// --------------------------------
private _police = [
    "B_GEN_Commander_F",
    "B_GEN_Soldier_F"
];
types_hash set ["police", _police];

// --------------------------------
//   Police Vehicles
// --------------------------------
private _police_vehicles = [
    "B_GEN_Offroad_01_gen_F",
    "B_GEN_Van_02_vehicle_F",
    "B_GEN_Van_02_transport_F",
    "B_GEN_Offroad_01_comms_F"
];
types_hash set ["police vehicles", _police_vehicles];

// --------------------------------
//  Civilian Air
// --------------------------------
private _civ_air = [
    "C_Plane_Civil_01_F",
    "C_Heli_Light_01_civil_F"
];
types_hash set ["civ air", _civ_air];

// --------------------------------
//   Ambulance
// --------------------------------
private _ambulance = [
    "C_Van_02_medevac_F"
];
types_hash set ["ambulance", _ambulance];

// --------------------------------
// Military Base Buildings
// --------------------------------
private _mil_buildings = [
    "Cargo_Tower_base_F", "Land_i_Barracks_V1_F",
    "Land_i_Barracks_V2_F", "Land_u_Barracks_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F",
    "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F",
    "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F",
    "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F",
    "Land_Dome_Big_F", "Land_Dome_Small_F", "Land_Research_HQ_F"
];
types_hash set ["military buildings", _mil_buildings];

// --------------------------------
// Cool Buildings (overlaps with Military buildings)
// --------------------------------
private _cool_buildings = [
    "Cargo_Tower_base_F", "Land_Offices_01_V1_F", "Land_Hospital_Main_F",
    "Land_LightHouse_F", "Land_Castle_01_tower_F", "Land_d_Windmill01_F", "Land_i_Barracks_V1_F",
    "Land_i_Barracks_V2_F", "Land_u_Barracks_V2_F", "Land_Cargo_Tower_V1_F", "Land_Cargo_Tower_V1_No1_F",
    "Land_Cargo_Tower_V1_No2_F", "Land_Cargo_Tower_V1_No3_F", "Land_Cargo_Tower_V1_No4_F",
    "Land_Cargo_Tower_V1_No5_F", "Land_Cargo_Tower_V1_No6_F", "Land_Cargo_Tower_V1_No7_F",
    "Land_Cargo_Tower_V2_F", "Land_Cargo_Tower_V3_F", "Land_Medevac_house_V1_F", "Land_Medevac_HQ_V1_F",
    "Land_Dome_Big_F", "Land_Dome_Small_F", "Land_Research_HQ_F"
];
types_hash set ["cool buildings", _cool_buildings];


// --------------------------------
//  Resupply crates (already loaded)
// --------------------------------
private _crates = [
    "O_CargoNet_01_ammo_F",
    "C_IDAP_CargoNet_01_supplies_F",
    "I_E_CargoNet_01_ammo_F",
    "B_CargoNet_01_ammo_F"
];
types_hash set ["resupply crates", _crates];


// Helicopters


// Trucks 


publicVariable "types_hash";
