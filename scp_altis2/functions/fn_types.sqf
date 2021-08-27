/* *********************************************************************
                         types


For defining types and groups thereof
********************************************************************* */

[] spawn {

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
    "sg_mini_gate_Ramp",
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
    ["Land_vn_tent_02_02", 0, 1.5],
    ["Land_vn_tent_02_01", 0, 1.5],
    ["Land_CanvasCover_02_F", 0, 1.5], 
    ["Land_IRMaskingCover_02_F", 0, 1.5], 
    ["Land_Cargo_Patrol_V4_F", 0, 4.5],
    ["CamoNet_OPFOR_F", 0, 1.5],
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
    "C_man_polo_1_F_afro", "C_man_shorts_2_F_afro", "C_Man_casual_8_F_asia", "C_man_polo_4_F_asia",
    "C_man_p_beggar_F", "C_man_1", "C_Man_casual_1_F", "C_Man_casual_2_F", "C_Man_casual_3_F",
    "C_Man_casual_4_v2_F", "C_Man_casual_5_v2_F", "C_Man_casual_6_v2_F", "C_Man_casual_7_F",
    "C_Man_casual_8_F", "C_Man_casual_9_F", "C_Man_formal_1_F", "C_Man_formal_2_F", "C_Man_formal_3_F",
    "C_Man_formal_4_F", "C_Man_smart_casual_1_F", "C_Man_smart_casual_2_F", "C_man_sport_1_F",
    "C_man_sport_2_F", "C_man_sport_3_F", "C_Man_casual_4_F", "C_Man_casual_5_F", "C_Man_casual_6_F",
    "C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F",
    "C_man_polo_6_F", "C_man_shorts_1_F", "C_man_1_2_F", "C_man_1_3_F", "C_Man_Fisherman_01_F",
    "C_man_p_fugitive_F", "C_man_p_shorts_1_F", "C_man_hunter_1_F", "C_Man_Messenger_01_F", "C_man_shorts_2_F",
    "C_man_p_beggar_F_afro", "C_Man_casual_2_F_afro", "C_Man_casual_3_F_afro", "C_Man_casual_4_v2_F_afro",
    "C_Man_casual_5_v2_F_afro", "C_Man_casual_6_v2_F_afro", "C_Man_casual_7_F_afro", "C_Man_casual_8_F_afro",
    "C_Man_casual_9_F_afro", "C_Man_smart_casual_1_F_afro", "C_Man_smart_casual_2_F_afro", "C_man_sport_1_F_afro",
    "C_man_sport_2_F_afro", "C_man_sport_3_F_afro", "C_Man_casual_4_F_afro", "C_Man_casual_5_F_afro",
    "C_Man_casual_6_F_afro", "C_man_polo_1_F_afro", "C_man_polo_2_F_afro", "C_man_polo_3_F_afro",
    "C_man_polo_4_F_afro", "C_man_polo_5_F_afro", "C_man_polo_6_F_afro", "C_man_shorts_1_F_afro",
    "C_man_p_fugitive_F_afro", "C_man_p_shorts_1_F_afro", "C_man_shorts_2_F_afro", "C_Man_1_enoch_F",
    "C_Man_2_enoch_F", "C_Man_3_enoch_F", "C_Man_4_enoch_F", "C_Man_5_enoch_F",
    "C_Man_6_enoch_F", "C_Farmer_01_enoch_F"
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
"RyanZombieSpider32", "RyanZombieCrawler1", "RyanZombieCrawler2", "RyanZombieCrawler3",
"RyanZombieCrawler4", "RyanZombieCrawler5", "RyanZombieCrawler6", "RyanZombieCrawler7",
"RyanZombieCrawler8", "RyanZombieCrawler9", "RyanZombieCrawler10", "RyanZombieCrawler11",
"RyanZombieCrawler12", "RyanZombieCrawler13", "RyanZombieCrawler14", "RyanZombieCrawler15",
"RyanZombieCrawler16", "RyanZombieCrawler17", "RyanZombieCrawler18", "RyanZombieCrawler19",
"RyanZombieCrawler20", "RyanZombieCrawler21", "RyanZombieCrawler22", "RyanZombieCrawler23",
"RyanZombieCrawler24", "RyanZombieCrawler25", "RyanZombieCrawler26", "RyanZombieCrawler27",
"RyanZombieCrawler28", "RyanZombieCrawler29", "RyanZombieCrawler30", "RyanZombieCrawler31",
"RyanZombieCrawler32"
]];


// --------------------------------
// Demons
// --------------------------------
types_hash set ["demons", [
    "RyanZombieboss1", "RyanZombieboss2", "RyanZombieboss3", "RyanZombieboss4",
    "RyanZombieboss5", "RyanZombieboss6", "RyanZombieboss7", "RyanZombieboss8",
    "RyanZombieboss9", "RyanZombieboss10", "RyanZombieboss11", "RyanZombieboss12",
    "RyanZombieboss13", "RyanZombieboss14", "RyanZombieboss15", "RyanZombieboss16",
    "RyanZombieboss17", "RyanZombieboss18", "RyanZombieboss19", "RyanZombieboss20",
    "RyanZombieboss21", "RyanZombieboss22", "RyanZombieboss23", "RyanZombieboss24",
    "RyanZombieboss25", "RyanZombieboss26", "RyanZombieboss27", "RyanZombieboss28",
    "RyanZombieboss29", "RyanZombieboss30", "RyanZombieboss31", "RyanZombieboss32"
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

types_hash set ["all spooks", [
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
types_hash set ["spooks", types_hash get ["weaker spooks"]]; 

// --------------------------------
// Looters
// --------------------------------
types_hash set ["looters", [
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", 
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", 
    "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F", "I_L_Looter_SMG_F",
    "I_L_Criminal_SG_F", "I_L_Criminal_SMG_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F",
    "vn_o_men_vc_local_02", "vn_o_men_vc_local_20", "vn_o_men_vc_local_06",
    "vn_o_men_vc_local_04", "vn_o_men_vc_local_18", "vn_o_men_vc_local_03",
    "vn_o_men_vc_local_17", "vn_o_men_vc_local_05", "vn_o_men_vc_local_19",
    "vn_o_men_vc_local_09", "vn_o_men_vc_local_23", "vn_o_men_vc_local_30",
    "vn_o_men_vc_local_07", "vn_o_men_vc_local_08", "vn_o_men_vc_local_22",
    "vn_o_men_vc_local_29", "vn_o_men_vc_local_01", "vn_o_men_vc_local_15"
]];

types_hash set ["insurgents", [
    "I_C_Soldier_Bandit_4_F", "I_C_Soldier_Bandit_3_F", "I_C_Soldier_Bandit_7_F",
    "I_C_Soldier_Bandit_5_F", "I_C_Soldier_Bandit_6_F", "I_C_Soldier_Bandit_2_F", "I_C_Soldier_Bandit_8_F",
    "I_C_Soldier_Bandit_1_F", "I_L_Looter_Pistol_F", "I_L_Looter_SG_F", "I_L_Looter_Rifle_F",
    "I_E_Soldier_TL_F", "I_E_Soldier_AR_F", "I_E_Soldier_GL_F", "_E_RadioOperator_F",
    "vn_o_men_vc_local_02", "vn_o_men_vc_local_20", "vn_o_men_vc_local_06",
    "vn_o_men_vc_local_04", "vn_o_men_vc_local_18", "vn_o_men_vc_local_03",
    "vn_o_men_vc_local_17", "vn_o_men_vc_local_05", "vn_o_men_vc_local_19",
    "vn_o_men_vc_local_09", "vn_o_men_vc_local_23", "vn_o_men_vc_local_30",
    "vn_o_men_vc_local_07", "vn_o_men_vc_local_08", "vn_o_men_vc_local_22",
    "vn_o_men_vc_local_29", "vn_o_men_vc_local_01", "vn_o_men_vc_local_15"
]];

// --------------------------------
// Civilian Vehicles
// --------------------------------
types_hash set ["civ vehicles", [
    "C_Hatchback_01_F", "C_Offroad_02_unarmed_F", "C_Offroad_01_F", "C_Offroad_01_comms_F",
    "C_Offroad_01_covered_F", "C_Offroad_01_repair_F", "C_Quadbike_01_F", "C_SUV_01_F",
    "C_Tractor_01_F", "C_Van_01_transport_F", "C_Van_01_box_F", "C_Van_02_vehicle_F",
    "C_Van_02_service_F", "C_Van_02_transport_F", "C_Truck_02_fuel_F", "C_Truck_02_box_F",
    "C_Truck_02_transport_F", "C_Truck_02_covered_F", "C_Van_02_medevac_F", "vn_c_bicycle_01",
    "vn_b_wheeled_m151_02", "vn_o_wheeled_z157_02_nva65", "vn_o_wheeled_z157_01_nva65",
    "vn_c_wheeled_m151_02", "vn_c_wheeled_m151_01", "C_Van_01_fuel_F", "C_Offroad_01_F"
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
    "B_Heli_Light_01_F",
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

// Planes 
types_hash set ["plane civ", [
    "C_Plane_Civil_01_F",
    "C_Plane_Civil_01_racing_F"
]];

types_hash set ["plane mil", [
    "vn_b_air_f4b_navy_at", "vn_b_air_f4c_hcas", "vn_b_air_f4b_navy_bmb",
    "vn_b_air_f4b_navy_mbmb", "vn_b_air_f4b_usmc_cas", "vn_b_air_f4b_usmc_ehcas",
    "vn_b_air_f4b_usmc_hcas", "vn_b_air_f4b_usmc_lrbmb", "vn_b_air_f4b_navy_cap",
    "vn_b_air_f4b_navy_cbu", "vn_b_air_f4b_navy_lbmb", "vn_b_air_f4c_mbmb",
    "vn_b_air_f4b_usmc_bmb", "vn_b_air_f4b_usmc_cap", "vn_b_air_f4b_usmc_cbu",
    "vn_b_air_f4b_usmc_mbmb", "vn_b_air_f4b_navy_cas", "vn_b_air_f4c_lrbmb",
    "vn_b_air_f4c_mr", "vn_b_air_f4b_usmc_mr", "vn_b_air_f4b_usmc_ucas",
    "vn_b_air_f4b_navy_ehcas", "vn_b_air_f4b_navy_gbu", "vn_b_air_f4c_sead",
    "vn_b_air_f4b_navy_hbmb", "vn_b_air_f4b_navy_hcas", "vn_b_air_f4b_navy_lrbmb",
    "vn_b_air_f4b_usmc_hbmb", "vn_b_air_f4b_usmc_lbmb", "vn_b_air_f4b_navy_mr",
    "vn_b_air_f4b_navy_sead", "vn_b_air_f4b_navy_ucas", "vn_b_air_f4c_at",
    "vn_b_air_f4c_bmb", "vn_b_air_f4c_cap", "vn_b_air_f4c_hbmb", "vn_b_air_f4c_cas",
    "vn_b_air_f4c_cbu", "vn_b_air_f4c_chico", "vn_b_air_f4c_ehcas", "vn_b_air_f4c_gbu",
    "vn_b_air_f4c_lbmb", "vn_b_air_f4b_usmc_sead", "vn_b_air_f4c_ucas",
    "vn_b_air_f4b_usmc_at", "vn_b_air_f4b_usmc_gbu", "B_Plane_CAS_01_dynamicLoadout_F",
    "B_Plane_Fighter_01_F", "B_Plane_Fighter_01_Stealth_F", "B_T_VTOL_01_armed_F",
    "B_T_VTOL_01_infantry_F", "B_T_VTOL_01_vehicle_F", "O_Plane_CAS_02_dynamicLoadout_F",
    "O_Plane_Fighter_02_F", "O_Plane_Fighter_02_Stealth_F", "O_T_VTOL_02_infantry_dynamicLoadout_F",
    "O_T_VTOL_02_vehicle_dynamicLoadout_F", "I_Plane_Fighter_03_dynamicLoadout_F", "I_Plane_Fighter_04_F"
]];

types_hash set ["hangars", [
    "Land_Airport_01_hangar_F",
    "Land_Hangar_F",
    "Land_TentHangar_V1_F",
    "Land_vn_airport_02_hangar_left_f",
    "Land_vn_airport_02_hangar_right_f",
    "Land_vn_airport_01_hangar_f",
    "Land_Ss_hangard",
    "Land_Ss_hangar",
    "Land_Mil_hangar_EP1",
    "WarfareBAirport"
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


types_hash set ["boat civ", [
    "B_G_Boat_Transport_01_F",
    "B_Lifeboat",
    "vn_o_boat_01_03",
    "vn_o_boat_01_04",
    "vn_o_boat_02_03",
    "vn_o_boat_01_00",
    "vn_o_boat_01_mg_03",
    "vn_o_boat_01_mg_01",
    "vn_o_boat_01_02",
    "vn_o_boat_02_mg_04",
    "vn_o_boat_02_mg_02",
    "vn_o_boat_02_mg_03",
    "vn_o_boat_02_mg_00",
    "vn_o_boat_02_00",
    "vn_o_boat_08_02",
    "vn_o_boat_08_01",
    "vn_o_boat_07_02",
    "vn_o_boat_07_01",
    "C_Boat_Civil_01_F",
    "C_Boat_Civil_01_police_F",
    "C_Boat_Civil_01_rescue_F",
    "C_Rubberboat",
    "C_Boat_Transport_02_F",
    "C_Scooter_Transport_01_F"    
]];

types_hash set ["boat mil", [
    "vn_b_boat_06_02",
    "vn_b_boat_06_01",
    "vn_b_boat_05_02",
    "vn_b_boat_05_01",
    "B_Boat_Armed_01_minigun_F",
    "vn_o_boat_03_02",
    "vn_o_boat_03_01",
    "vn_o_boat_04_02",
    "vn_o_boat_04_01",
    "B_Boat_Transport_01_F"
]];

// -----------------------------------------------------
// "background" encounters
types_hash set ["background_options_with_weights", [
    ["animal_follower", 1],
    ["police_foot", 1],
    ["police_vehicle", 1],
    ["bandit_foot", 1],
    ["bandit_car", 2],
    ["goblins", 1],
    ["cultists", 1],
    ["spooks", 2],
    ["civ_air", 1],
    ["civ_vehicle", 10],
    ["civ_foot", 10]
]];

types_hash set ["zombies_options_with_weights", [
    ["police_foot", 1],
    ["police_vehicle", 1],
    ["bandit_foot", 2],
    ["bandit_car", 2],
    ["zombies", 3],
    ["civ_air", 1],
    ["civ_vehicle", 10],
    ["civ_foot", 10]
]];


types_hash set ["aliens_options_with_weights", [
    ["drone", 1],
    ["vehicle", 1],
    ["police_foot", 1],
    ["police_vehicle", 1],
    ["bandit_foot", 1],
    ["bandit_car", 2],
    ["spooks", 2],
    ["civ_air", 1],
    ["civ_vehicle", 10],
    ["civ_foot", 10]
]];


// -----------------------------------------------------------------------------
// For loadouts and types for SCP Operators (base loadout) and support specialists
// -----------------------------------------------------------------------------
scp_specialists = createHashMap;

// --- SCP Base Loadout ---
scp_specialists set ["base loadout", { 
    params ["_this", ["_uniform", "U_B_CTRG_Soldier_Arid_F"], ["_vest", "V_PlateCarrier2_rgr_noflag_F"]];

    _this setVariable ["role", "base"];

    removeAllWeapons _this;
    removeAllItems _this;
    removeAllAssignedItems _this;
    removeUniform _this;
    removeVest _this;
    removeBackpack _this;
    removeHeadgear _this;
    removeGoggles _this;

    _this forceAddUniform _uniform;

    _this addWeapon "arifle_MXC_F";
    _this addPrimaryWeaponItem "acc_pointer_IR";
    _this addPrimaryWeaponItem "optic_Hamr";
    _this addPrimaryWeaponItem "100Rnd_65x39_caseless_mag";
    _this addWeapon "hgun_Rook40_F";
    _this addHandgunItem "30Rnd_9x21_Green_Mag";


    _this addVest _vest;
    _this addBackpack "B_Kitbag_rgr";
    _this addItemToUniform "FirstAidKit";
    _this addItemToUniform "B_UavTerminal";
    for "_i" from 1 to 2 do {_this addItemToVest "DemoCharge_Remote_Mag";};
    _this addItemToVest "30Rnd_9x21_Green_Mag";
    _this addItemToVest "30Rnd_9x21_Green_Mag";
    _this addItemToVest "SmokeShellGreen";
    _this addItemToVest "SmokeShellRed";
    _this addItemToVest "Chemlight_red";
    _this addItemToVest "acc_flashlight";
    for "_i" from 1 to 3 do {_this addItemToVest "100Rnd_65x39_caseless_mag_Tracer";};

    _this addHeadgear "H_HelmetB_TI_arid_F";
    _this addGoggles "G_Balaclava_TI_G_blk_F";

    _this linkItem "ItemMap";
    _this linkItem "ItemCompass";
    _this linkItem "ChemicalDetector_01_watch_F";
    _this linkItem "ItemRadio";
    _this linkItem "NVGogglesB_blk_F";
    _this linkItem "DSA_Detector";
}];

scp_specialists set ["Engineer", [
    "B_engineer_F", {
    params ["_this"];
    _this setVariable ["role", "Engineer"];
    _this addItemToBackpack "ToolKit";
    _this addItemToBackpack "MineDetector";
    _this addItemToBackpack "SatchelCharge_Remote_Mag";
    for "_i" from 1 to 2 do {_this addItemToBackpack "DemoCharge_Remote_Mag";};
    _this setUnitTrait ["engineer", true];
    _this setUnitTrait ["explosiveSpecialist", true];
}]];

scp_specialists set ["UAV", [
    "B_soldier_UAV_F", {
    params ["_this"];
    _this setVariable ["role", "UAV"];
    removeBackpack _this;
    _this addBackpack "B_UAV_01_backpack_F";
}]];


scp_specialists set ["UGV", [
    "B_soldier_UGV_02_Demining_F", {
    params ["_this"];
    _this setVariable ["role", "UGV"];
    removeBackpack _this;
    _this addBackpack "B_UGV_02_Demining_backpack_F";
}]];

scp_specialists set ["Medic", [
    "B_medic_F", {
    params ["_this"];
    _this setVariable ["role", "Medic"];
    _this addItemToBackpack "Medikit";
    for "_i" from 1 to 10 do {_this addItemToBackpack "FirstAidKit";};
    _this setUnitTrait ["medic", true];
}]];

scp_specialists set ["AT", [
    "B_soldier_AT_F", {
    params ["_this"];
    _this setVariable ["role", "AT"];
    _this addWeapon "launch_B_Titan_short_F";
    _this addSecondaryWeaponItem "Titan_AT";
    for "_i" from 1 to 2 do {_this addItemToBackpack "Titan_AT";};
}]];

//-------------------
scp_specialists set ["AA", [
    "B_soldier_AA_F", {
    params ["_this"];
    //_this addWeapon "launch_B_Titan_F";
    //_this addSecondaryWeaponItem "Titan_AA";
    //for "_i" from 1 to 2 do {_this addItemToBackpack "Titan_AA";};

    _this addWeapon "launch_MRAWS_sand_rail_F";
    _this addSecondaryWeaponItem "MRAWS_HEAT_F";
    _this addItemToBackpack "MRAWS_HE_F";
    _this addItemToBackpack "MRAWS_HE_F";
}]];

scp_specialists set ["LAT", [
    "B_soldier_LAT2_F", {
    params ["_this"];
    _this setVariable ["role", "LAT"];
    _this addWeapon "launch_MRAWS_sand_F";
    _this addSecondaryWeaponItem "MRAWS_HEAT_F";

    for "_i" from 1 to 2 do {_this addItemToBackpack "MRAWS_HEAT_F";};
    _this addItemToBackpack "MRAWS_HE_F";
}]];

scp_specialists set ["HMG", [
    "B_Patrol_HeavyGunner_F", {
    params ["_this"];
    _this setVariable ["role", "HMG"];
    removeAllWeapons _this;
    _this addWeapon "LMG_Zafir_F";
    _this addPrimaryWeaponItem "acc_pointer_IR";
    _this addPrimaryWeaponItem "optic_Holosight";
    _this addPrimaryWeaponItem "150Rnd_762x54_Box";
    _this addWeapon "hgun_Rook40_F";
    _this addHandgunItem "30Rnd_9x21_Green_Mag";
    _this addItemToUniform "FirstAidKit";

    for "_i" from 1 to 2 do {_this addItemToVest "150Rnd_762x54_Box";};
}]];

scp_specialists set ["Marksman", [
    "B_Patrol_Soldier_M_F", {
    params ["_this"];
    _this setVariable ["role", "Marksman"];
    removeAllWeapons _this;
    _this addWeapon "srifle_EBR_F";
    _this addPrimaryWeaponItem "muzzle_snds_B";
    _this addPrimaryWeaponItem "acc_pointer_IR";
    _this addPrimaryWeaponItem "optic_DMS";
    _this addPrimaryWeaponItem "20Rnd_762x51_Mag";
    _this addPrimaryWeaponItem "bipod_01_F_snd";
    _this addWeapon "Rangefinder";

    _this addWeapon "hgun_Rook40_F";
    _this addHandgunItem "30Rnd_9x21_Green_Mag";
    _this addItemToUniform "FirstAidKit";

    _this addItemToUniform "20Rnd_762x51_Mag";
    for "_i" from 1 to 6 do {_this addItemToVest "20Rnd_762x51_Mag";};
}]];

publicVariable "scp_specialists";

scp_support_units = [
    "Engineer",
    "UAV", 
    "Marksman", 
    "Medic", 
    "AT",
    "AA"
];
publicVariable "scp_support_units";

types_hash_loaded = true;
publicVariable "types_hash_loaded";

};


