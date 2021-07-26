/* ------------------------------------------------------------------
                            Mission: nop ("no op" -- blank mission)


------------------------------------------------------------------ */

params ["_state"];
diag_log "Running empty mission";
hint "Empty mission -- never ends!";

_ok = true;
private _result = [_ok, _state];
_result
