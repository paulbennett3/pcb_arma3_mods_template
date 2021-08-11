/* ****************************************************************************
                         mutex

Mutex implementation based on code found on the web ...

Params:
   _action (string) : what action to take -- one of "create", "get" or "release"
   _id (string) : "unique" string to use as ID for mutex


Example use:
    // make a new mutex -- share with your friends!
    private _my_mutex = ["create", "my mutex 1"] call pcb_fnc_mutex;

    // enter a critical section -- will wait until it succeeds 
    ["get", "my mutex 1", _my_mutex] call pcb_fnc_mutex; 

    // release the mutex
    ["release", "my mutex 1", _my_mutex] call pcb_fnc_mutex; 
   
**************************************************************************** */
params ["_action", "_id", ["_mutex", [true, "empty", 0]]];

private _result = false;
switch (_action) do {
    case "create": {
       _result = [true, _id, 0];
    };

    case "get": {
        if ((_mutex select 1) != _id) then {
["Waiting on mutex"] call pcb_fnc_debug;
           waitUntil { [_mutex select 0, _mutex set [0, false]] select 0} ;
["Got mutex"] call pcb_fnc_debug;
           _mutex set [1, _id];
       }; 
       _mutex set [2,(_mutex select 2) +1];
   };

   case "release": {
       _mutex set [2,(_mutex select 2) -1];
       if ((_mutex select 2) == 0) then {
           _mutex set [1, "empty"];
           _mutex set [0, true];
       };
    };
};

_result
