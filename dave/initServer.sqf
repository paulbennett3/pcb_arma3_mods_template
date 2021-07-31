/* -----------------------------------------------------------
                   initServer

This script runs when the "server" (local or dedicated) 
is initializing.
----------------------------------------------------------- */

// ----------------------------
// Make some spare helicopters
//    We spawn this since there 
//   are some embedded "sleep"
//   commands
// ----------------------------
[] spawn {
    // this doesn't need to be compiled, but it is good practice 
    [] call compile preprocessFileLineNumbers "spare_helis.sqf";
};

diag_log "initServer done and ready to kill Wendigos!";
