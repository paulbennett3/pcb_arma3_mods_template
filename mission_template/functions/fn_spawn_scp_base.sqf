
sgc_briefing = "";
pos = objNull;

if (pcb_mod_name isEqualTo "scp") then {
       private _pos_dir = [] call pcb_fnc_random_stargate_position;
       pos = _pos_dir select 0;
	_item6 = createVehicle ["B_CargoNet_01_ammo_F",pos,[],0,"NONE"];
	_this = _item6;
	sgc_briefing = _this;
	_this setVehicleVarName "sgc_briefing";
        publicVariable "sgc_briefing";
	_this setVectorDirAndUp [[0,1,0],[0.00666691,0,0.999978]];
	[_this,"[[[[""arifle_MXC_F"",""arifle_MXM_F"",""arifle_MX_F"",""arifle_MX_GL_F"",""arifle_MX_SW_F"",""arifle_SDAR_F"",""hgun_P07_F"",""hgun_Pistol_heavy_01_F"",""launch_NLAW_F"",""launch_Titan_F"",""launch_Titan_short_F"",""SMG_01_F"",""srifle_EBR_F"",""srifle_LRR_camo_F"",""srifle_LRR_F"",""launch_RPG7_F"",""DSA_MachinePistol45"",""hgun_Pistol_Signal_F""],[4,2,8,4,4,2,2,2,2,2,2,2,2,2,2,2,4,4]],[[""100Rnd_65x39_caseless_mag_Tracer"",""11Rnd_45ACP_Mag"",""16Rnd_9x21_Mag"",""1Rnd_HE_Grenade_shell"",""1Rnd_SmokeBlue_Grenade_shell"",""1Rnd_SmokeGreen_Grenade_shell"",""1Rnd_SmokeOrange_Grenade_shell"",""1Rnd_SmokePurple_Grenade_shell"",""1Rnd_SmokeRed_Grenade_shell"",""1Rnd_SmokeYellow_Grenade_shell"",""1Rnd_Smoke_Grenade_shell"",""20Rnd_556x45_UW_mag"",""20Rnd_762x51_Mag"",""30Rnd_45ACP_Mag_SMG_01"",""30Rnd_556x45_Stanag_red"",""30Rnd_65x39_caseless_mag"",""3Rnd_HE_Grenade_shell"",""7Rnd_408_Mag"",""APERSBoundingMine_Range_Mag"",""APERSMine_Range_Mag"",""APERSTripMine_Wire_Mag"",""ATMine_Range_Mag"",""B_IR_Grenade"",""ClaymoreDirectionalMine_Remote_Mag"",""DemoCharge_Remote_Mag"",""HandGrenade"",""Laserbatteries"",""MiniGrenade"",""NLAW_F"",""SatchelCharge_Remote_Mag"",""SLAMDirectionalMine_Wire_Mag"",""SmokeShell"",""SmokeShellBlue"",""SmokeShellGreen"",""SmokeShellOrange"",""SmokeShellPurple"",""SmokeShellRed"",""SmokeShellYellow"",""Titan_AA"",""Titan_AP"",""Titan_AT"",""UGL_FlareGreen_F"",""UGL_FlareWhite_F"",""RPG7_F"",""DSA_25Rnd_45ACP_Mag"",""6Rnd_GreenSignal_F"",""6Rnd_RedSignal_F""],[16,14,14,15,2,2,2,2,2,2,2,6,24,14,6,52,3,12,5,5,5,5,8,5,10,24,5,24,8,5,5,2,2,2,2,2,2,2,6,6,6,2,2,20,20,5,5]],[[""Binocular"",""Laserdesignator"",""Rangefinder"",""acc_flashlight"",""acc_pointer_IR"",""FirstAidKit"",""ItemGPS"",""Medikit"",""MineDetector"",""muzzle_snds_acp"",""muzzle_snds_B"",""muzzle_snds_H"",""muzzle_snds_H_SW"",""muzzle_snds_L"",""optic_DMS"",""optic_Hamr"",""optic_Holosight"",""optic_LRPS"",""optic_MRD"",""optic_NVS"",""optic_SOS"",""optic_tws"",""optic_tws_mg"",""ToolKit"",""optic_ACO_grn"",""optic_ACO_grn_smg"",""acc_flashlight_smg_01"",""acc_flashlight_pistol"",""optic_AMS"",""bipod_01_F_blk"",""optic_Arco_blk_F"",""optic_ERCO_blk_F"",""acc_esd_01_flashlight"",""DSA_Detector"",""B_UavTerminal""],[5,1,1,5,5,10,5,3,3,5,5,5,1,5,5,2,2,2,2,2,2,2,2,1,5,5,5,5,5,5,5,5,5,1,5]],[[""B_UAV_01_backpack_F"",""B_AssaultPack_blk"",""B_HMG_01_support_F"",""B_HMG_01_weapon_F"",""B_HMG_01_A_weapon_F"",""B_GMG_01_A_weapon_F"",""B_HMG_01_high_weapon_F"",""B_Mortar_01_support_F"",""B_Mortar_01_weapon_F"",""B_Patrol_Respawn_bag_F"",""B_UAV_06_backpack_F"",""B_UAV_06_medical_backpack_F"",""B_SCBA_01_F"",""B_UGV_02_Science_backpack_F"",""B_UGV_02_Demining_backpack_F""],[2,4,1,2,2,2,2,1,1,2,2,2,5,2,2]]],false]"] call bis_fnc_initAmmoBox;;

    {
       _x setVehiclePosition [pos, [], 10, "NONE"]; 
    } forEach playableUnits;

};
