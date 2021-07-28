/* *******************************************************************
                      add_anomalies 

Generates one of Drongo's Anomaly Spawners at the given position

Parameters:
   _pos (position) : where to put it
   _min_n (number) : minimum number of anomalies
   _max_n (number) : maximum number of anomalies

******************************************************************* */
params ["_pos", ["_min_n", 1], ["_max_n", 3]];

/* ----------------------------------------------------------------
                 Configure and Place Anomalies 
---------------------------------------------------------------- */
if (true) then {
    diag_log "Placing DSA Anomalies ...";

    private _count = (str _min_n) + "," + (str _max_n);
    private _moduleGroup = createGroup sideLogic;
    _cmd = "DSA_SpawnerAnomaly = this; this setVariable ['BIS_fnc_initModules_disableAutoActivation', false, true]; DSA_SpawnerAnomaly setVariable ['DSA_Type', '''Launchpad'',''Leech'',''Trapdoor'',''Zapper''', true]; DSA_SpawnerAnomaly setVariable ['DSA_RandomTypes', '''Launchpad'',''Leech'',''Trapdoor'',''Zapper''', true]; DSA_SpawnerAnomaly setVariable ['DSA_Radius',500, true]; DSA_SpawnerAnomaly setVariable ['DSA_CountCluster','1,3', true]; DSA_SpawnerAnomaly setVariable ['DSA_Count','" + _count + "', true]; DSA_SpawnerAnomaly setVariable ['DSA_RadiusCluster', 30, true]; ";

    "DSA_SpawnerAnomaly" createUnit [ _pos, _moduleGroup, _cmd];
};
