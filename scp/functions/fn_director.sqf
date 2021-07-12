/* --------------------------------------------------------------------
                            Director

Monitors the scenario and updates as needed
-------------------------------------------------------------------- */

if (! isServer) exitWith {};

_marker = createMarker ["mEPI", epicenter];
"mEPI" setMarkerSize [5000, 5000];

if (pcb_DEBUG) then {
    "mEPI" setMarkerShapeLocal "ELLIPSE";
    "mEPI" setMarkerColorLocal "ColorRED";
    "mEPI" setMarkerBrushLocal "BORDER";
    "mEPI" setMarkerAlpha 0.9;
};

[] spawn {
    private _count = 0;

    while {true} do {
        sleep 10;
        _count + _count + 1;
        if (pcb_DEBUG) then {
            hint ("Director " + (str _count));
        };
    };
};

