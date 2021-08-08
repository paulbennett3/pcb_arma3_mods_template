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
    "Land_RaiStone_01_F",
    "Land_Statue_03_F",
    "Land_Monument_02_F",
    "Land_OldSculpture_01_F",
    "Land_Cross_01_small_F",
    "Land_Grave_11_F",
    "Land_Tombstone_04_F",
    "Land_Tombstone_07_F",
    "Land_Tombstone_08_F",
    "Land_Tombstone_08_damaged_F",
    "Land_Tombstone_08_damaged_F",
    "Land_Tombstone_10_F",
    "Land_Tombstone_11_damaged_F",
    "Land_Tombstone_15_F",
    "Land_Tombstone_16_F",
    "Land_Tombstone_05_F",
    "Land_Tombstone_14_F",
    "Land_Caravan_01_green_F",
    "Land_Calvary_03_F",
    "Land_Chapel_02_white_damaged_F",
    "Land_Substation_01_F",
    "Land_Statue_01_F",
    "Land_Monument_01_F"
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
//    bases
//   tents etc for start base
//    [ type string, rotation, offset in z]  
//     note that rotation and offset are as
//     compared to our starting
//     "canvas cover, small"
// --------------------------------
types_hash set ["bases", [
    ["Land_CanvasCover_02_F", 0, 1.5], 
    ["CamoNet_OPFOR_F", 0, 1.5],
    ["Land_BagBunker_Tower_F", 90, 1.3],
    ["Land_MedicalTent_01_NATO_generic_outer_F", 90, 1.3],
    ["Land_MedicalTent_01_NATO_generic_open_F", 90, 1.3],
    ["Land_MedicalTent_01_CSAT_brownhex_generic_open_F", 90, 1.3],
    ["Land_MedicalTent_01_aaf_generic_open_F", 90, 1.3],
    ["Land_MedicalTent_01_white_generic_outer_F", 90, 1.3]
]];

// --------------------------------
//    Boxes - ok for inside
// --------------------------------
types_hash set ["boxes", [
    "Land_PlasticCase_01_large_F",
    "Land_PlasticCase_01_large_black_F",
    "Land_PlasticCase_01_large_CBRN_F",
    "Land_PlasticCase_01_large_gray_F",
    "Land_PlasticCase_01_large_olive_F",
    "Land_PlasticCase_01_large_olive_CBRN_F",
    "Land_vn_plasticcase_01_large_idap_f",
    "Land_PlasticCase_01_medium_F",
    "Land_PlasticCase_01_medium_black_F",
    "Land_PlasticCase_01_medium_CBRN_F",
    "Land_vn_plasticcase_01_medium_gray_f",
    "Land_PlasticCase_01_medium_olive_F",
    "Land_PlasticCase_01_medium_olive_CBRN_F",
    "Land_PlasticCase_01_medium_idap_F",
    "Land_PlasticCase_01_small_F",
    "Land_PlasticCase_01_small_black_F",
    "Land_PlasticCase_01_small_black_CBRN_F",
    "Land_PlasticCase_01_small_CBRN_F",
    "Land_PlasticCase_01_small_gray_F",
    "Land_PlasticCase_01_small_olive_F",
    "Land_PlasticCase_01_small_olive_CBRN_F",
    "Land_PlasticCase_01_small_idap_F",
    "Land_vn_plasticcase_01_small_idap_f",
    "Land_PortableCabinet_01_closed_black_F",
    "Land_PortableCabinet_01_closed_olive_F",
    "Land_PortableCabinet_01_closed_sand_F"
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
    "Max_woman4", "Max_woman5", "Max_woman2", "Max_woman3", "Max_woman1",
    "Max_woman4", "Max_woman5", "Max_woman2", "Max_woman3", "Max_woman1",
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
    "DSA_Crazy"
]];

types_hash set ["zombies_ryan", [
"RyanZombieCrawler1", "RyanZombieCrawler2", "RyanZombieCrawler3",
"RyanZombieCrawler4", "RyanZombieCrawler5", "RyanZombieCrawler6",
"RyanZombieCrawler7", "RyanZombieCrawler8", "RyanZombieCrawler9",
"RyanZombieCrawler10", "RyanZombieCrawler11", "RyanZombieCrawler12",
"RyanZombieCrawler13", "RyanZombieCrawler14", "RyanZombieCrawler15",
"RyanZombieCrawler16", "RyanZombieCrawler17", "RyanZombieCrawler18",
"RyanZombieCrawler19", "RyanZombieCrawler20", "RyanZombieCrawler21",
"RyanZombieCrawler22", "RyanZombieCrawler23", "RyanZombieCrawler24",
"RyanZombieCrawler25", "RyanZombieCrawler26", "RyanZombieCrawler27",
"RyanZombieCrawler28", "RyanZombieCrawler29", "RyanZombieCrawler30",
"RyanZombieCrawler31", "RyanZombieCrawler32", "RyanZombieC_man_1",
"RyanZombieC_man_polo_1_F", "RyanZombieC_man_polo_2_F", "RyanZombieC_man_polo_4_F",
"RyanZombieC_man_polo_5_F", "RyanZombieC_man_polo_6_F", "RyanZombieC_man_p_fugitive_F",
"RyanZombieC_man_w_worker_F", "RyanZombieC_scientist_F", "RyanZombieC_man_hunter_1_F",
"RyanZombieC_man_pilot_F", "RyanZombieC_journalist_F", "RyanZombieC_Orestes",
"RyanZombieC_Nikos", "RyanZombie15", "RyanZombie16",
"RyanZombie17", "RyanZombie18", "RyanZombie19",
"RyanZombie20", "RyanZombie21", "RyanZombie22",
"RyanZombie23", "RyanZombie24", "RyanZombie25",
"RyanZombie26", "RyanZombie27", "RyanZombie28",
"RyanZombie29", "RyanZombie30", "RyanZombie31",
"RyanZombie32", "RyanZombieC_man_1medium", "RyanZombieC_man_polo_1_Fmedium",
"RyanZombieC_man_polo_2_Fmedium", "RyanZombieC_man_polo_4_Fmedium",
"RyanZombieC_man_polo_5_Fmedium", "RyanZombieC_man_polo_6_Fmedium",
"RyanZombieC_man_p_fugitive_Fmedium", "RyanZombieC_man_w_worker_Fmedium",
"RyanZombieC_scientist_Fmedium", "RyanZombieC_man_hunter_1_Fmedium",
"RyanZombieC_man_pilot_Fmedium", "RyanZombieC_journalist_Fmedium",
"RyanZombieC_Orestesmedium", "RyanZombieC_Nikosmedium",
"RyanZombie15medium", "RyanZombie16medium", "RyanZombie17medium",
"RyanZombie18medium", "RyanZombie19medium", "RyanZombie20medium",
"RyanZombie21medium", "RyanZombie22medium", "RyanZombie23medium",
"RyanZombie24medium", "RyanZombie25medium", "RyanZombie26medium",
"RyanZombie27medium", "RyanZombie28medium", "RyanZombie29medium",
"RyanZombie30medium", "RyanZombie31medium", "RyanZombie32medium",
"RyanZombieC_man_1slow", "RyanZombieC_man_polo_1_Fslow", "RyanZombieC_man_polo_2_Fslow",
"RyanZombieC_man_polo_4_Fslow", "RyanZombieC_man_polo_5_Fslow", "RyanZombieC_man_polo_6_Fslow",
"RyanZombieC_man_p_fugitive_Fslow", "RyanZombieC_man_w_worker_Fslow", "RyanZombieC_scientist_Fslow",
"RyanZombieC_man_hunter_1_Fslow", "RyanZombieC_man_pilot_Fslow", "RyanZombieC_journalist_Fslow",
"RyanZombieC_Orestesslow", "RyanZombieC_Nikosslow", "RyanZombie15slow", "RyanZombie16slow",
"RyanZombie17slow", "RyanZombie18slow", "RyanZombie19slow", "RyanZombie20slow",
"RyanZombie21slow", "RyanZombie22slow", "RyanZombie23slow", "RyanZombie24slow",
"RyanZombie25slow", "RyanZombie26slow", "RyanZombie27slow", "RyanZombie28slow",
"RyanZombie29slow", "RyanZombie30slow", "RyanZombie31slow", "RyanZombie32slow",
"RyanZombieC_man_1walker", "RyanZombieC_man_polo_1_Fwalker", "RyanZombieC_man_polo_2_Fwalker",
"RyanZombieC_man_polo_4_Fwalker", "RyanZombieC_man_polo_5_Fwalker", "RyanZombieC_man_polo_6_Fwalker",
"RyanZombieC_man_p_fugitive_Fwalker", "RyanZombieC_man_w_worker_Fwalker", "RyanZombieC_scientist_Fwalker",
"RyanZombieC_man_hunter_1_Fwalker", "RyanZombieC_man_pilot_Fwalker", "RyanZombieC_journalist_Fwalker",
"RyanZombieC_Oresteswalker", "RyanZombieC_Nikoswalker", "RyanZombie15walker",
"RyanZombie16walker", "RyanZombie17walker", "RyanZombie18walker", "RyanZombie19walker",
"RyanZombie20walker", "RyanZombie21walker", "RyanZombie22walker", "RyanZombie23walker",
"RyanZombie24walker", "RyanZombie25walker", "RyanZombie26walker", "RyanZombie27walker",
"RyanZombie28walker", "RyanZombie29walker", "RyanZombie30walker", "RyanZombie31walker",
"RyanZombie32walker", "RyanZombieSpider1", "RyanZombieSpider2", "RyanZombieSpider3",
"RyanZombieSpider4", "RyanZombieSpider5", "RyanZombieSpider6", "RyanZombieSpider7",
"RyanZombieSpider8", "RyanZombieSpider9", "RyanZombieSpider10", "RyanZombieSpider11",
"RyanZombieSpider12", "RyanZombieSpider13", "RyanZombieSpider14", "RyanZombieSpider15",
"RyanZombieSpider16", "RyanZombieSpider17", "RyanZombieSpider18", "RyanZombieSpider19",
"RyanZombieSpider20", "RyanZombieSpider21", "RyanZombieSpider22", "RyanZombieSpider23",
"RyanZombieSpider24", "RyanZombieSpider25", "RyanZombieSpider26", "RyanZombieSpider27",
"RyanZombieSpider28", "RyanZombieSpider29", "RyanZombieSpider30", "RyanZombieSpider31",
"RyanZombieSpider32"
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
types_hash set ["weaker spooks", [
    "DSA_ActiveIdol",
    "DSA_ActiveIdol2",
    "DSA_Crazy",
    "DSA_Crazy",
    "DSA_Hatman",
    "DSA_Rake",
    "DSA_Shadowman",
    "DSA_Snatcher",
    "DSA_Wendigo",
    "DSA_Wendigo",
    "DSA_Wendigo",
    "DSA_Wendigo"
]];
types_hash set ["stronger spooks", [
    "DSA_Abomination",
    "DSA_411",
    "DSA_Mindflayer",
    "DSA_Vampire"
]];

types_hash set ["spooks", [
    "DSA_ActiveIdols",
    "DSA_Crazy",
    "DSA_Hatman",
    "DSA_Rake",
    "DSA_Shadowman",
    "DSA_Snatcher",
    "DSA_Wendigo",
    "DSA_Abomination",
    "DSA_411",
    "DSA_Mindflayer",
    "DSA_Vampire"
]];

// --------------------------------
// Looters
// --------------------------------
types_hash set ["looters", [
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", 
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", 
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F",
    "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F"
]];

types_hash set ["insurgents", [
    "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_7_F",
    "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F",
    "I_C_Soldier_Bandit_1_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F",
    "I_E_Soldier_TL_F", "I_E_Soldier_AR_F", "I_E_Soldier_GL_F", "_E_RadioOperator_F"
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
// City Buildings
// --------------------------------
types_hash set ["city buildings", [
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
]];

// --------------------------------
// Military Base Buildings
// --------------------------------
types_hash set ["military buildings", [
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
//            city types
//
// Location name types used with
// nearestLocations to find "cities"
//   along with size and importance
// --------------------------------
types_hash set ["city types", [
    //"NameLocal",
    //"NameMarine",
    "NameCity",
    "NameCityCapital",
    "NameVillage"    
]];

// --------------------------------
//  Resupply crates (already loaded)
// --------------------------------
types_hash set ["resupply crates", [
    "vn_o_ammobox_full_06",
    "vn_b_ammobox_sog",
    "vn_o_ammobox_full_07",
    "O_CargoNet_01_ammo_F",
    "C_IDAP_CargoNet_01_supplies_F",
    "I_E_CargoNet_01_ammo_F",
    "B_CargoNet_01_ammo_F",
    "B_CargoNet_01_ammo_F",
    "B_CargoNet_01_ammo_F",
    "Box_IND_Ammo_F",
    "Box_T_East_Ammo_F",
    "Box_East_Ammo_F",
    "Box_EAF_Ammo_F",
    "Box_NATO_Ammo_F",
    "Box_NATO_Ammo_F",
    "Box_NATO_Ammo_F",
    "Box_Syndicate_Ammo_F",
    "Box_IND_Wps_F",
    "Box_T_East_Wps_F",
    "Box_East_Wps_F",
    "Box_EAF_Wps_F",
    "Box_T_NATO_Wps_F",
    "Box_T_NATO_Wps_F",
    "Box_T_NATO_Wps_F",
    "Box_T_NATO_Wps_F",
    "Box_NATO_Wps_F",
    "Box_NATO_Wps_F",
    "Box_NATO_Wps_F",
    "Box_NATO_Wps_F",
    "Box_Syndicate_Wps_F",
    "I_supplyCrate_F",
    "O_supplyCrate_F",
    "C_T_supplyCrate_F",
    "IG_supplyCrate_F",
    "Box_GEN_Equip_F",
    "C_IDAP_supplyCrate_F",
    "I_EAF_supplyCrate_F",
    "B_supplyCrate_F"
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
    "Land_HumanSkull_F",
    "Land_DeerSkeleton_full_01_F",
    "Land_DeerSkeleton_damaged_01_F",
    "Land_DeerSkeleton_pile_01_F",
    "Land_DeerSkeleton_skull_01_F"
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

// Cargo and repair units for funsies
types_hash set ["static repair civ", [
    "Land_RepairDepot_01_civ_F"
]];

types_hash set ["static cargo civ", [
    "B_Slingload_01_Fuel_F"
]];


types_hash set ["static repair mil", [
    "Land_Pod_Heli_Transport_04_repair_F",
    "Land_RepairDepot_01_tan_F",
    "Land_RepairDepot_01_green_F",
    "B_Slingload_01_Repair_F"
]];

types_hash set ["static cargo mil", [
    "B_Slingload_01_Medevac_F",
    "B_Slingload_01_Fuel_F",
    "B_Slingload_01_Cargo_F",
    "B_Slingload_01_Ammo_F",
    "Land_Pod_Heli_Transport_04_ammo_F",
    "Land_Pod_Heli_Transport_04_box_F"
]];

// Helicopters
types_hash set ["heli civ", [
    "B_Heli_Light_dynamicLoadout_01_F",
    "C_Heli_Light_01_civil_F",
    "C_Heli_Light_01_civil_F",
    "C_IDAP_Heli_Transport_02_F"
]];

types_hash set ["heli mil", [
    "vn_i_air_ch34_02_02",
    "vn_i_air_uh1c_07_01",
    "vn_i_air_uh1d_01_01",
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
    "O_T_VTOL_02_infantry_dynamicLoadout_F",
    "O_T_VTOL_02_vehicle_dynamicLoadout_F"
]];



// Trucks 

types_hash set ["car large civ", [
    "C_Van_02_medevac_F",
    "C_Van_02_transport_F",
    "C_Truck_02_fuel_F",
    "C_Truck_02_box_F",
    "C_Truck_02_transport_F",
    "C_Truck_02_covered_F",
    "I_G_Offroad_01_repair_F",
    "I_G_Van_02_vehicle_F",
    "vn_b_wheeled_m151_02",
    "vn_o_wheeled_z157_02_nva65",
    "vn_o_wheeled_z157_01_nva65",
    "vn_c_wheeled_m151_02",
    "vn_c_wheeled_m151_01"
]];

types_hash set ["car large mil", [
    "vn_b_wheeled_m54_01",
    "vn_b_wheeled_m54_02",
    "vn_b_wheeled_m54_01_airport",
    "B_Truck_01_transport_F",
    "B_Truck_01_covered_F",
    "O_Truck_03_transport_F",
    "O_Truck_03_transport_F",
    "I_Truck_02_box_F",
    "vn_i_wheeled_m54_repair",
    "vn_i_wheeled_m54_repair",
    "O_Truck_03_repair_F",
    "O_Truck_03_medical_F",
    "B_Truck_01_flatbed_F",
    "B_Truck_01_flatbed_F",
    "B_Truck_01_flatbed_F",
    "B_Truck_01_medical_F",
    "B_Truck_01_Repair_F",
    "B_Truck_01_Repair_F",
    "O_Truck_03_ammo_F",
    "O_Truck_03_fuel_F",
    "B_MBT_01_cannon_F",
    "B_MBT_01_TUSK_F",
    "O_MBT_04_command_F",
    "O_MBT_04_cannon_F",
    "O_MBT_04_command_F",
    "I_MBT_03_cannon_F",
    "I_LT_01_cannon_F",
    "O_Truck_03_covered_F"
]];
types_hash set ["car medium civ", [
    "C_Van_01_fuel_F",
    "C_Offroad_01_F",
    "C_Offroad_01_comms_F",
    "C_Offroad_01_covered_F",
    "C_Offroad_01_repair_F",
    "C_Van_01_box_F",
    "C_Tractor_01_F",
    "C_Van_01_transport_F"
]];

types_hash set ["car medium mil", [
    "B_MRAP_01_F",
    "B_MRAP_01_gmg_F",
    "B_MRAP_01_hmg_F",
    "O_MRAP_02_F",
    "O_MRAP_02_gmg_F",
    "O_MRAP_02_hmg_F",
    "I_MRAP_03_F",
    "I_MRAP_03_gmg_F",
    "I_MRAP_03_hmg_F"
]];

types_hash set ["car small civ", [
    "vn_c_bicycle_01",
    "C_Hatchback_01_F",
    "C_Hatchback_01_sport_F",
    "C_Offroad_02_unarmed_F",
    "C_Quadbike_01_F"
]];

types_hash set ["car small mil", [
    "vn_c_bicycle_01",
    "vn_b_wheeled_m151_mg_04",
    "vn_b_wheeled_m151_mg_04_mp",
    "vn_b_wheeled_m151_mg_02",
    "vn_b_wheeled_m151_mg_02_mp",
    "vn_b_wheeled_m151_mg_03",
    "vn_b_wheeled_m151_01",
    "B_CTRG_LSV_01_light_F",
    "B_LSV_01_AT_F",
    "B_LSV_01_armed_F",
    "B_LSV_01_unarmed_F",
    "B_Quadbike_01_F",
    "O_LSV_02_AT_F",
    "O_LSV_02_unarmed_F",
    "O_Quadbike_01_F",
    "vn_o_wheeled_btr40_mg_02_nva65",
    "vn_o_wheeled_btr40_mg_01_nva65",
    "vn_o_wheeled_btr40_mg_03_nva65",
    "vn_o_wheeled_btr40_02_nva65",
    "vn_o_wheeled_btr40_01_nva65"
]];




// -----------------------------------------------------

//publicVariable "types_hash";
