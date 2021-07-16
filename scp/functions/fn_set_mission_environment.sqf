/* ---------------------------------------------------------
                   set mission environment

Set random time and weather conditions at mission start
--------------------------------------------------------- */
// dawn ~ 4am, dark ~8pm
setDate [2021, 7, 10, 4, 0]; // 4 am
skipTime (random 16);

// its always overcast in Altis
0 setOvercast (random 1);

private _rnd = random 1;

// chance of a clear-ish day
//if (_rnd > .2) then {
if (false) then {
    0 setFog [random 1, 0, 500];
    0 setRain (random 1);
};
