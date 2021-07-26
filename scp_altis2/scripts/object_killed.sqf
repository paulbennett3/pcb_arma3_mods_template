/* --------------------------------------------------------
                 object_killed

This script is used to "kill" an object (ie, crate, statue, ...)
Need to install MP event handler like:
    _obj addMPEventHandler["mpkilled",{_this execVM "scripts\object_killed.sqf"}]; 

  this addMPEventHandler ["mpkilled", { deleteVehicle (_this select 0); };

Stolen from Drongo's Spooks and Anomalies "Idol" code
-------------------------------------------------------- */

private["_obj","_pos","_ps"];

_obj =_this select 0;
deleteVehicle _obj;
