# pcb_arma3_mods_template
Basic scripts and utilities

# Notes and Snippets
### Stuff that hasn't found a home yet

[Keybindings -- infantry, vehicle, helicopter, group / team commands](http://cdn.akamai.steamstatic.com/steam/apps/107410/manuals/Arma_3_keylayout_ENG.pdf?t=1478619759)

## Mods
[ACE3](https://steamcommunity.com/sharedfiles/filedetails/?id=815366548)
[ACE3 Wiki](https://ace3mod.com/wiki/)
[tutorial and cheat sheet](https://steamcommunity.com/sharedfiles/filedetails/?id=930706887)
[???](https://steamcommunity.com/workshop/filedetails/?id=463939057)
[CBA](https://cbateam.github.io/CBA_A3/docs/files/overview-txt.html)

[Drongos Spooks and Anomalies](https://steamcommunity.com/workshop/filedetails/?id=2262255106)

[Stargate ARMA](https://steamcommunity.com/sharedfiles/filedetails/?id=815366548&searchtext=stargate)
[Stargate Mod](http://www.stargatearma.com/wiki/)
[Stargate Mod -- Steam Workshop](https://steamcommunity.com/app/107410/workshop/)

[Equipment Reference - tags](https://community.bistudio.com/wiki/Arma_3:_CfgWeapons_Equipment)

## DLC (like the Vietname 'S.O.G Prairie Fire')
On pc: 

in launcher, go to "DLC", enable!

On server:

\# You have to enter the following in to steamCMD:

    app_update 233780 -beta creatordlc " validate +quit

And launch with the Arma startup parameter -mod=vn;  

---
# Dedicated Server Stuff

## Uploading Mods to Server

On pc

    # zip up the mod
    cd /mnt/d/SteamLibrary/steamapps/common/'Arma 3'/'!Workshop'/'@Stargate Arma'

    # have to cd *into* the @directory, since it is a symbolic link ...
    # tar up the contents (make a new name with no spaces, upper case, ...)
    tar czf @stargate_arma.tgz addons/ keys/ logo_small.paa ...   
    # not sure if .* will recursively add tgz file ... so list content explicitly.
        but we want everything in the directory
    # send it to the server
    scp @stargate_arma.tgz LOGIN@IPADDR:@stargate_arma.tgz   # root file!
    # this will take awhile -- ~200KB/s, for 2G - 3+ hours?!?

On server:

    # as root!
    chown Arma3server @stargate_arma.tgz
    cp ~/@stargate_arma.tgz /home/Arma3server/mods_zips/   # make this dir first!
    su - Arma3server
  
    # make mods directory in ~/serverfiles   (if you haven't already done this)
    cp ~/mods_zips/@stargate_arma.tgz ~/serverfiles/mods/
    cd ~/serverfiles/mods
    tar xzf @stargate_arma.tgz

    # unzip our modfile (in mods_zips where we copied it -- or wherever we put it with scp ...)
    # copy contents to serverfiles/mods/@mymodname
    #   so now the first level subdirectories of @mymodname will be like "addons", "keys", ...
    cp serverfiles/mods/@mymodname/keys/* serverfiles/keys/ 
 
    # Edit the config file to load the mod (name must be in all lower case!!!!)
    vi ~/lgsm/config-lgsm/arma3server/arma3server.cfg
      # edit line
             servermods=""
        Example:   
            servermods="mods/@drongossa\;mods/@drongosmap\;mods/@zombiesanddemons\;mods/@notwhattheyseem"

## Missions (local machine)
- Documents > Arma 3 > Missions
- Documents > Arma 3 > compositions

- Location of "@mods" (local machine)
- SDD2 (D:) > SteamLibrary > steamapps > common > Arma 3 > !Workshop

---
## Basic Editor / Scripting
[???](https://steamcommunity.com/sharedfiles/filedetails/?id=132000887)

## Equipment discussion
[???](https://steamcommunity.com/sharedfiles/filedetails/?id=1488677422)
[ultimate - guns](https://steamcommunity.com/sharedfiles/filedetails/?id=1131138131)
[sights / optics!](https://steamcommunity.com/sharedfiles/filedetails/?id=416741360) 

## Virtual Private Server
[how to host](https://www.bestarmahosting.com/guides/how-to-host-an-arma-3-dedicated-server/)
[server options](https://www.bestarmahosting.com/guides/how-to-configure-your-arma-3-server-all-options-explained/)
[Turnkey Internet](https://www.turnkeyinternet.net/cloud-hosted-virtual-servers-vps/)

## IPTABLES
[IP Tables for Beginners](https://www.howtogeek.com/177621/the-beginners-guide-to-iptables-the-linux-firewall/)

---
## Handy commands reference
[SQF Syntax](https://community.bistudio.com/wiki/SQF_Syntax)
[Control Structures](https://community.bistudio.com/wiki/Control_Structures)

[Code Optimization](https://community.bistudio.com/wiki/Code_Optimisation)
[Scripting Commands Index](https://community.bistudio.com/wiki/Category:Arma_3:_Scripting_Commands)
[Functions Index](https://community.bistudio.com/wiki/Category:Arma_3:_Functions)
[Event Scripts](https://community.bistudio.com/wiki/Event_Scripts)
[Event Handlers](https://community.bistudio.com/wiki/Arma_3:_Event_Handlers)
[Multiplayer Scripting](https://community.bistudio.com/wiki/Multiplayer_Scripting)
[Remote Execution](https://community.bistudio.com/wiki/Arma_3:_Remote_Execution)
[Task Framework](https://community.bistudio.com/wiki/Arma_3:_Task_Framework)
[Task Framework Tutorial](https://community.bistudio.com/wiki/Arma_3:_Task_Framework_Tutorial)
[Equipment Reference](https://community.bistudio.com/wiki/Arma_3:_CfgVehicles_Equipment)

### Specific commands / scripts
[BIS_fnc_taskPatrol - assign random patrol to group](https://community.bistudio.com/wiki/BIS_fnc_taskPatrol)
[Unit Loadout Array](https://community.bistudio.com/wiki/Unit_Loadout_Array)


---
### Change Loadout via Code
    removeallweapons this;
    removeGoggles this;
    removeHeadgear this;
    removeVest this;
    removeUniform this;
    removeAllAssignedItems this;

    this addgoggles "G_Shades_Black";
    this addheadgear "H_Cap_brn_SERO";
    this adduniform "U_B_CombatUniform_mcam";
    this addvest "V_TacVest_khk";
    this addbackpack "B_AssaultPack_blk"

### Strip all players in trigger area
    # from trigger - all players in trigger down to skivvies ...
    {removeallweapons _x; } forEach thisList; 
    {removeGoggles _x;} forEach thisList;
    {removeHeadgear _x} forEach thisList;
    {removeVest _x;} forEach thisList;
    {removeUniform _x;} forEach thisList;
    {removeBackpack _x;} forEach thisList;
    {removeAllAssignedItems _x;} forEach thisList;

### Equip based on Trigger Area
    {_x addgoggles "G_Shades_Black";} forEach thisList;
    {_x addHeadgear "H_Cap_blu";} forEach thisList;
    {_x addvest "V_TacVest_khk";} forEach thisList;
    {_x addMagazine "30Rnd_65x39_caseless_mag";} forEach thisList;
    {_x addWeapon "arifle_MX_GL_Black_F";} forEach thisList;
    {_x addWeaponItem ["arifle_MX_GL_Black_F", "1Rnd_HE_Grenade_shell"];} forEach thisList;
    {_x linkItem "ItemMap";} forEach thisList;
    {_x linkItem "ItemWatch";} forEach thisList;
    {_x linkItem "ItemCompass";} forEach thisList;
    {_x linkItem "ItemRadio";} forEach thisList;
    {_x linkItem "NVGoggles_OPFOR";} forEach thisList;
    {_x addItemToUniform "FirstAidKit";} forEach thisList;
    {_x addItemToUniform "30Rnd_65x39_caseless_mag";} forEach thisList;
    {_x addItemToUniform "30Rnd_65x39_caseless_mag";} forEach thisList;
    {_x addItemToVest "30Rnd_65x39_caseless_mag";} forEach thisList;
    {_x addItemToVest "30Rnd_65x39_caseless_mag";} forEach thisList;
    {_x addItemToVest "30Rnd_65x39_caseless_mag";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addItemToVest "1Rnd_HE_Grenade_shell";} forEach thisList;
    {_x addPrimaryWeaponItem "acc_flashlight";} forEach thisList;
    {_x addPrimaryWeaponItem "optic_Aco";} forEach thisList;
    {_x addMagazine "HandGrenade";} forEach thisList;
    {_x addMagazine "HandGrenade";} forEach thisList;
    {_x addWeapon "Binocular";} forEach thisList;
    {_x adduniform "U_B_CombatUniform_mcam";} forEach thisList;

[Scope Reference](https://steamcommunity.com/sharedfiles/filedetails/?id=416741360) 
- Assault Rifle - MX  -- Mk17 holosight, TWS?
- Grenade Launcher - MX-GL  -- Mk17 holosight, TWS?
- Marksman rifle -- MXM style can share ammo with MX -- DMS scope, TWS or TWS-MG
- Machine gun - MX-SW can use same ammo as MX & MXM   -- TWS-MG scope
- RPG-7 (unguided -- lightest!)
- Type 115 - underslung .50 for short range big hits

### Backpack loadouts
    # Medic
    {removeBackpack _x;} forEach thisList;
    {_x addbackpack "B_AssaultPack_blk";} forEach thisList;
    {_x addItemToBackpack "Medikit";} forEach thisList;
    {_x setUnitTrait ["engineer", false];} forEach thisList;
    {_x setUnitTrait ["explosiveSpecialist", false];} forEach thisList;
    {_x setUnitTrait ["medic", true];} forEach thisList;
    {_x setUnitTrait ["mage", false, true];} forEach thisList;

    # Sapper
    {removeBackpack _x;} forEach thisList;
    {_x addbackpack "B_AssaultPack_blk";} forEach thisList;
    {_x addItemToBackpack "MineDetector";} forEach thisList;
    {_x addItemToBackpack "ToolKit";} forEach thisList;
    {(unitBackpack _x) addmagazineCargo ["DemoCharge_Remote_Mag", 2]} forEach thisList;
    {(unitBackpack _x) addmagazineCargo ["ATMine_Range_Mag", 1]} forEach thisList;
    {_x setUnitTrait ["engineer", true];} forEach thisList;
    {_x setUnitTrait ["explosiveSpecialist", true];} forEach thisList;
    {_x setUnitTrait ["medic", false];} forEach thisList;
    {_x setUnitTrait ["mage", false, true];} forEach thisList;



    # Misc
    {removeBackpack _x;} forEach thisList;
    {_x addbackpack "B_AssaultPack_blk";} forEach thisList;
    {_x addItemToBackpack "ToolKit";} forEach thisList;
    {(unitBackpack _x) addmagazineCargo ["DemoCharge_Remote_Mag", 1]} forEach thisList;
    {_x setUnitTrait ["engineer", false];} forEach thisList;
    {_x setUnitTrait ["explosiveSpecialist", false];} forEach thisList;
    {_x setUnitTrait ["medic", false];} forEach thisList;
    {_x setUnitTrait ["mage", true, true];} forEach thisList;


### add stuff to pool of weapons and magazines that may be chosen for the mission
    addWeaponPool ["name", amount];
    addMagazinePool ["name", amount];


### Select a random element from a list
    _randomElement = selectRandom [1,2,3,4,5];

### Set trigger to add driver of vehicle to player
    [<name1>, <name2>] join (group players);

### "condition" for a Trigger (any player, present) -- "must have mage trait"
    if ((thisList findIf  { _x getUnitTrait "mage";}) >= 0) then { true; } else { false; }

### "condition" for a Trigger (any player, present) -- "must have MineDetector"
    "ItemGPS" in (items player + assignedItems player)
    if ((thisList findIf {"MineDetector" in (items _x + assignedItems _x)}) >= 0) then { true; } else { false; }

### create object on the server and add action to the object on every client
    if (isServer) then
    {
        private _object = "some_obj_class" createVehicle [1234, 1234, 0];
        [_object, ["Greetings!", { hint "Hello!"; }]] remoteExec ["addAction"]; // Note: does not return action id
    };

### find all map markers (can filter!)
[allMapMarkers](https://community.bistudio.com/wiki/allMapMarkers)
[getMarkerPos](https://community.bistudio.com/wiki/getMarkerPos)

### find all "entities" (objects?)
[entities](https://community.bistudio.com/wiki/entities)

### set a vehicle position -- use to "teleport" players

[setVehiclePosition](https://community.bistudio.com/wiki/setVehiclePosition)

    player setVehiclePosition [[1000,2000], ["Pos1","Pos2","Pos3"], 0, "CAN_COLLIDE"];
    # Will place the player at either [1000,2000], or one of the three markers positions.

### marker (type "empty") with variable name MPOS1 placed on map
    player setVehiclePosition [(getMarkerPos "MPOS1"),[],0,"NONE"];

### same but for trigger activation
    {_x setVehiclePosition [(getMarkerPos "MPOS1";),[],0,"NONE"];} forEach thisList;

### command animations (open/close doors, etc)
[animateSource](https://community.bistudio.com/wiki/animateSource)

### Finite State Machines
[FSM](https://community.bistudio.com/wiki/FSM)
[execFSM](https://community.bistudio.com/wiki/execFSM)


### Run script
[execVM](https://community.bistudio.com/wiki/execVM)
[Functions Library](https://community.bistudio.com/wiki/Arma_3:_Functions_Library)


### Locking All Doors
actually it is possible now in arma 3. this is what i found out looking through the configs.
you can lock a house's door using the following method.
all you need is to setvariable the house like this:

    house1 setVariable ['bis_disabled_Door_1',1,true]

the red highlighted 1 is the value that locks the door. 0 will open it again. infact i think everything that is not 1 will work.
to test it simply put a gamelogic right on or near the house and put this in its init line:

    ((nearestobjects [this, ["house_f"], 5]) select 0) setVariable ['bis_disabled_Door_1',1,true]

to access different doors you need to use different numbers at the end of the variable name marked again red here:

    bis_disabled_Door_1 

### SG Unit Init
    this addvest "V_TacVest_blk";
    this addgoggles "G_Shades_Black";
    this removeItem "ItemMap";
    this linkItem "ItemWatch";
    this linkItem "ItemCompass";
    this linkItem "ItemRadio";
    this addItemToVest "FirstAidKit";
    this addPrimaryWeaponItem "acc_flashlight";
    this addPrimaryWeaponItem "optic_Aco";
    this addMagazine "HandGrenade";
    this addMagazine "HandGrenade";
    this addbackpack "B_AssaultPack_blk";
    this addmagazineCargo ["DemoCharge_Remote_Mag", 1];
    (unitBackpack this) addmagazineCargo ["DemoCharge_Remote_Mag", 2]; 
    this addItemTobackpack "Medikit";
    this addItemToVest "50Rnd_570x28_SMG_03";
    this addItemToVest "50Rnd_570x28_SMG_03";
    this addItemTobackpack "50Rnd_570x28_SMG_03";
    this addItemTobackpack "50Rnd_570x28_SMG_03";
    this setUnitTrait ["medic", true]; 
    this setUnitTrait ["engineer", false];
    this setUnitTrait ["explosiveSpecialist", false];
    this setvariable["sga_skills",["Engineer"],true];

### trigger - anybody, present -- on activation, teleport non players somewhere else
    { 
     if (not (isPlayer _x)) then {_x setVehiclePosition [ (getMarkerPos "MGateroom1"),[],0,"NONE"]; }  
    } forEach thisList; 

### dump out the loadout on attached unit (place in init?)
    hint str getUnitLoadout this;

### put in trigger "on activated" to cause fade out, then fade in after a few seconds
    0 = thisList spawn 
    {          
       [0,"BLACK",1,1] call BIS_fnc_fadeEffect;  
       sleep 1;  
       {_x setVehiclePosition [ (getMarkerPos "MFarGate1"),["MFarGate1"],0,"NONE"]; }  forEach _this;
       [1,"BLACK",1,1] call BIS_fnc_fadeEffect;  
    };

### only teleport non-players that are playable (MP AI) -- note that AI will just get right back in ...
    {
        if (not (isPlayer _x)) then {
            doGetOut _x;
            _x setVehiclePosition [(getPos vorash_dhd),[], 0, "NONE"];
        };
    } forEach units group player;

### put in init -- use to dump out all attached variables
    hint str allVariables this;

### Loadout script with parameter(s) -- target, Role
    [this, "Medic"] call compile preprocessFile "scripts\pcb_loadout.sqf";
    [this, "Team Leader"] call compile preprocessFile "scripts\pcb_loadout.sqf";
    [this, "Team Member"] call compile preprocessFile "scripts\pcb_loadout.sqf";

### Add respawn event handler to call loadout
    # should use role description from corpse(?) vice hardcoding "Team Member"
    this addEventHandler ["Respawn", {
	params ["_unit", "_corpse"];
        [this, "Team Member"] call pcb_loadout;
    }];

### Task Snippets
    [true, "T001", ["Go to dialing computer", "Go to the stargate dialing computer in the control room", "Computer"],
                       [sgc_computer, true], "ASSIGNED"] call BIS_fnc_taskCreate;

### trigger at SGC computer
    if (pcb_mission_state == 1) then {
        ["T001", "SUCCEEDED"] call BIS_fnc_taskSetState; 
        [true, "T002", ["Gate to Vorash", 
                                    "Open the stargate iris, dial Vorash, and enter the stargate", 
                                    "Computer"], [sgc_computer, true], "ASSIGNED"] call BIS_fnc_taskCreate;
    };

### trigger at SGC stargate (return)
    if (pcb_mission_state == 2) then {
        ["T001", "SUCCEEDED"] call BIS_fnc_taskSetState; 
    };

### trigger at vorash gate
    if (pcb_mission_state == 1) then {
        ["T002", "SUCCEEDED"] call BIS_fnc_taskSetState; 
        [true, "T003", ["Find SG-7", "Locate and assist SG-7", "Computer"], 
            [teltak, true], "ASSIGNED"] call BIS_fnc_taskCreate; 
    
        units group player orderGetIn false;
    
        { 
            if (not (isPlayer _x)) then { 
                _x setVehiclePosition [(getPos vorash_dhd),[], 0, "NONE"]; 
            }; 
        } forEach units group player; 
        pcb_mission_state = 2;
    };

### Do something after server starts
    [] spawn {
        sleep 5;
        hint "after (at least) 5 seconds...";
    };

### force all playable units (including players!) to get out of vehicles
    #  note that "doGetOut" will work, but the AI just gets back in ...
    playableUnits orderGetIn false;

# SGC Coords
    X     14349.22
    Y     15898.788
    Z              0.262
    Rot X      0
    Rot Y      0
    Rot Z   131.355
