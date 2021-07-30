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

_cmd = "DSA_DetectableSpooks = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_DetectableSpooks setVariable ['DSA_Wendigo', 'FALSE', true]; DSA_DetectableSpooks setVariable ['DSA_Vampire', 'FALSE', true]; DSA_DetectableSpooks setVariable ['DSA_411', 'TRUE', true]; DSA_DetectableSpooks setVariable ['DSA_Shadowman', 'TRUE', true]; DSA_DetectableSpooks setVariable ['DSA_Hatman', 'TRUE', true]; DSA_DetectableSpooks setVariable ['DSA_Rake', 'FALSE' , true]; DSA_DetectableSpooks setVariable ['DSA_Mindflayer', 'TRUE', true]; DSA_DetectableSpooks setVariable ['DSA_Abomination', 'TRUE', true]; DSA_DetectableSpooks setVariable ['DSA_Snatcher', 'TRUE' , true]; DSA_DetectableSpooks setVariable ['DSA_Crazy', 'FALSE' , true];";

"DSA_DetectableSpooks" createUnit [
	epicenter,
	_moduleGroup,
	_cmd
];


/* ----------------------------------------------------------------
                 Configure and Place Anomalies 

Do multiple!
---------------------------------------------------------------- */
/*
diag_log "finding selection of good places ...";
private _filter = "3*forest + 2*trees + meadow + 3*houses - 5*sea - 5*waterDepth";  
private _nplaces = 20;
private _places = selectBestPlaces [epicenter, mission_radius, _filter, 50, _nplaces];
diag_log " ... done finding!";

diag_log "Placing DSA Anomalies ...";

_cmd = "DSA_SpawnerAnomaly = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_SpawnerAnomaly setVariable ['DSA_Type', '''Launchpad'',''Leech'',''Trapdoor'',''Zapper''', true]; DSA_SpawnerAnomaly setVariable ['DSA_RandomTypes', '''Launchpad'',''Leech'',''Trapdoor'',''Zapper''', true]; DSA_SpawnerAnomaly setVariable ['DSA_Radius',500, true]; DSA_SpawnerAnomaly setVariable ['DSA_CountCluster','1,3', true]; DSA_SpawnerAnomaly setVariable ['DSA_Count','1,3', true]; DSA_SpawnerAnomaly setVariable ['DSA_RadiusCluster', 30, true]; ";

private _nanomalies = ceil (_nplaces * (random 1)); 
private _placed = 0;
private _rpos = objNull;
while {_placed < _nanomalies} do {
    
    diag_log ("    " + (str _placed));
    _rpos = (_places select _placed) select 0;
 
    "DSA_SpawnerAnomaly" createUnit [ _rpos, _moduleGroup, _cmd];
    _placed = _placed + 1;
};
*/
