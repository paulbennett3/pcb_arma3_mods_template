/* ---------------------------------------------------------
                   set mission environment

Set random time and weather conditions at mission start
--------------------------------------------------------- */

if (! isServer) exitWith {};

// dawn ~ 4am, dark ~8pm
setDate [2021, 7, 10, 4, 0]; // 4 am
skipTime (random 16);

private _rnd = random 1;

// chance of a clear-ish day
if (_rnd > .3) then {
    0 setFog [random 1, 0.05, 0];
    private _rain = random 1;

    // if it is really rainy, it should be really overcast ...
    if (_rain > 0.5) then {
        0 setOvercast 1;
    } else {
        0 setOvercast (random 1);
    };
    0 setRain _rain;
    0 setGusts (random 1);
};
