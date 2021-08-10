/* ********************************************************************
                        plot clusters and create triggers

Parameters:
   _map (hashmap) : cluster hashmap to plot
   _class (string) : type of map it is ("MIL", "CIV", "IND", "UNK")
   _buffer (number) : (optional) "buffer zone" in meters to extend borders by

Returns:
    _trigger_list (array of triggers) : triggers for each cluster 
******************************************************************** */
params ["_map", "_class", ["_buffer", 500]];

private _trigger_list = [];

{
    private _cluster = _map get _x;
    private _center = _cluster get "center";
    private _a = (_cluster get "a") + _buffer;
    private _b = (_cluster get "b") + _buffer;
    private _trg = createTrigger ["EmptyDetector", _center, false];
    _trg setVariable ["cid", [_cluster get "label", _x]];
    _trg setTriggerArea [_a, _b, 0, false, -1];
    private _area = [_center] + (triggerArea _trg);

    if (true) then {
        _trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
        _trg setTriggerStatements [
            "this",
            "bck_trg_fired pushBackUnique (thisTrigger getVariable 'cid'); publicVariable 'bck_trg_fired';",
            ""
        ];
        _trg setTriggerInterval 2;
        _trigger_list pushBack _trg;
    } else {
        deleteVehicle _trg;
    };

    if (pcb_DEBUG) then {
        _marker = createMarker [_x, _center];
        _marker setMarkerShapeLocal "ELLIPSE";
        _marker setMarkerSizeLocal [_a, _b];
        _marker setMarkerBrushLocal "BORDER";
        _marker setMarkerAlphaLocal 0.9;
        _marker setMarkerColor "ColorBLACK";
    };
} forEach (keys _map);

_trigger_list
