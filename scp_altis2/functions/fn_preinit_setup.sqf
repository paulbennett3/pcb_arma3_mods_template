/* ---------------------------------------------------------------------------
                         setup

This script is run as preInit, so be careful what you do here!
This is done to script Drongo's fantastic mods at random locations.
--------------------------------------------------------------------------- */

if (! isServer) exitWith {};
mission_radius = 5000;
publicVariable "mission_radius";

// Pick a random location (not in the water) to place the "epicenter"
// center, minDist, maxDist, objDist, waterMode, maxGrad, shoreMode, blacklistPos, defaultPos
epicenter = [[], 0, -1, 0, 0, 0.1, 0, [], []] call BIS_fnc_findSafePos;
publicVariable "epicenter";

// Put a marker on the epicenter -- see, I'm not entirely evil ...
private _marker = createMarker ["mmission_center", epicenter];
//_marker setMarkerType "mil_unknown";
_marker setMarkerType "mil_warning";
_marker setMarkerText "Aprox. Epicenter";
_marker setMarkerColor "ColorRed";


/* ##################################################################
       Create Drongo's Spooks and Anomalies stuff
################################################################## */
private _moduleGroup = createGroup sideLogic;



/* ----------------------------------------------------------------
                    Configure and Place Core
---------------------------------------------------------------- */
diag_log "Placing DSA Core";
private _cmd = "
    DSA_Core = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_Core setVariable ['DSA_Debug', 'FALSE', true]; DSA_Core setVariable ['DSA_DetailedDebug', 'FALSE', true]; DSA_Core setVariable ['DSA_RandomDelay', 1, true]; DSA_Core setVariable ['DSA_ArmourProtection', 100, true]; DSA_Core setVariable ['DSA_AttackDowned', 'TRUE', true]; DSA_Core setVariable ['DSA_ACEdamage', 'FALSE', true]; DSA_Core setVariable ['DSA_AnomalySleep', 5, true]; DSA_Core setVariable ['DSA_AnomalyRange', 7, true]; DSA_Core setVariable ['DSA_AddRating', 'FALSE', true]; DSA_Core setVariable ['DSA_DeathFX', 'TRUE', true]; DSA_Core setVariable ['DSA_ActiveIdolChance', 25, true]; DSA_Core setVariable ['DSA_AllowWater', 'FALSE', true]; DSA_Core setVariable ['DSA_Side', 'EAST', true]; DSA_Core setVariable ['DSA_DMPAO', 'TRUE', true]; ";

"DSA_Core" createUnit [
	epicenter,
	_moduleGroup,
        _cmd	
];


/* ----------------------------------------------------------------
                    Configure and Place MissionGenerator
---------------------------------------------------------------- */
private _use_drongo_missions = false;

if (_use_drongo_missions) then {
    diag_log "Placing DSA MissionGenerator";

    _cmd = "DSA_MissionGenerator = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_MissionGenerator setVariable ['DSA_RadiusAO'," + (str mission_radius) + ", true]; DSA_MissionGenerator setVariable ['DSA_RadiusMission', " + (str mission_radius) + ", true]; DSA_MissionGenerator setVariable ['DSA_MissionTypes', '''Kill'',''Purge'',''Destroy'',''Recover'',''Investigate'',''InvestigateBuilding'',''Rescue''', true]; DSA_MissionGenerator setVariable ['DSA_MissionCount', '3,7' , true]; DSA_MissionGenerator setVariable ['DSA_ChainMissions', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_RequireExfil', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_KillAllSpooks', 'FALSE', true]; DSA_MissionGenerator setVariable ['DSA_MissionScatter', 20, true]; DSA_MissionGenerator setVariable ['DSA_TaskNotification', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_UseMarkers', 'FALSE', true]; DSA_MissionGenerator setVariable ['DSA_EndAllDown', 'FALSE', true]; DSA_MissionGenerator setVariable ['DSA_EndOnComplete', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_MissionSpookTypes', '''Wendigo'',''Vampire'',''411'',''Shadowman'',''Hatman'',''Rake'',''Mindflayer'',''Abomination'',''Snatcher''', true]; DSA_MissionGenerator setVariable ['DSA_UseDMP', 'TRUE', true]; DSA_MissionGenerator setVariable ['DSA_SoundWin', '', true]; DSA_MissionGenerator setVariable ['DSA_SoundLose', '', true];";

    "DSA_MissionGenerator" createUnit [
   	    epicenter,
    	    _moduleGroup,
  	    _cmd
    ];
};

/* ----------------------------------------------------------------
              Configure and Place Detectable Spooks
---------------------------------------------------------------- */
diag_log "Placing DSA Detectable Spooks";


_cmd = "DSA_EnableDetectors = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_EnableDetectors setVariable ['DSA_DetectorRange', 50, true]; DSA_EnableDetectors setVariable ['DSA_DetectorMode', 'BOTH', true]; DSA_EnableDetectors setVariable ['DSA_Wendigo','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Vampire','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_411','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Shadowman','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Hatman','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Rake','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Mindflayer','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Abomination','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Snatcher','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Crazy','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_ActiveIdol','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Trapdoor','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Leech','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Launchpad','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Zapper','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Idol','TRUE', true]; DSA_EnableDetectors setVariable ['DSA_Idol2','TRUE', true];";
	
"DSA_EnableDetectors" createUnit [
	epicenter,
	_moduleGroup,
	_cmd
];

/* ----------------------------------------------------------------
              Configure and Place Active Idol module
---------------------------------------------------------------- */
diag_log "Placing DSA ActiveIdols";

_cmd = "DSA_ActiveIdols = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_ActiveIdols setVariable ['DSA_Visibility', 2, true]; DSA_ActiveIdols setVariable ['DSA_Audibility', 0.1, true]; DSA_ActiveIdols setVariable ['DSA_DelayIdle', 5, true]; DSA_ActiveIdols setVariable ['DSA_DelayHunt', 2, true]; DSA_ActiveIdols setVariable ['DSA_LurkChance', 0, true]; DSA_ActiveIdols setVariable ['DSA_LurkDuration', '300,900', true]; DSA_ActiveIdols setVariable ['DSA_IdleSoundChance', 5, true]; DSA_ActiveIdols setVariable ['DSA_HuntSoundChance', 50, true]; DSA_ActiveIdols setVariable ['DSA_AttackSoundChance', 90, true]; DSA_ActiveIdols setVariable ['DSA_AnimSpeed', 1.3, true]; DSA_ActiveIdols setVariable ['DSA_SaveChance', 50, true]; DSA_ActiveIdols setVariable ['DSA_DamageModifier', 100, true]; DSA_ActiveIdols setVariable ['DSA_AttackRange', 7, true]; DSA_ActiveIdols setVariable ['DSA_Damage', '30,100', true]; DSA_ActiveIdols setVariable ['DSA_AttackEffects', '''STUN'',''KO'',''THROW''', true]; DSA_ActiveIdols setVariable ['DSA_DamageVehicle', '30,70', true]; DSA_ActiveIdols setVariable ['DSA_ArmourThreshold', 1000, true]; DSA_ActiveIdols setVariable ['DSA_SpookKillers', '''DSA_B_12Gauge_slug'',''DSA_B_12Gauge_HEAP''', true]; DSA_ActiveIdols setVariable ['DSA_DetectionRange', 2000, true]; DSA_ActiveIdols setVariable ['DSA_ScentRange', 3, true]; DSA_ActiveIdols setVariable ['DSA_PatrolRange', 200, true]; DSA_ActiveIdols setVariable ['DSA_FleeChance', 20, true]; DSA_ActiveIdols setVariable ['DSA_FleeThreshold', 10, true];";
	
"DSA_ActiveIdols" createUnit [
	epicenter,
	_moduleGroup,
	_cmd
];



