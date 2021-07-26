/* ********************************************************
                       monitor ratings

Used to monitor player "ratings" so it can be announced
when they change -- for learning purposes ...
******************************************************** */

[] spawn {
    private _DELAY = 5; // amount of time between checks
    sleep _DELAY;
    private _pu_ratings = createHashMap;

    // get initial ratings (*should* be 0 ?1?)
    { _pu_ratings set [str _x, rating _x]; } forEach playableUnits;

    while { sleep _DELAY; true } do {
        { 
            private _rating = rating _x; 
            if (_rating != (_pu_ratings get (str _x))) then {
                 if (_rating < -2000) then {
                     [(str _x) + " is now an ENEMY! Rating: " + (str _rating)] remoteExec ["hint", 0, true]; 
                 } else {
                     [(str _x) + " has changed their rating to " + (str _rating)] remoteExec ["hint", 0, true]; 
                 };
                 _pu_ratings set [str _x, rating _x];
            };
        } forEach playableUnits;
    };
};

