/* Prevents this running for a joining player */
//if (isNull (_this select 1)) exitWith {};
/* Private variables */
//private["_NameSpaceDef"];
/* Defines namespace */
//_NameSpaceDef = name (_this select 1);
/* Loads the players equipment if exists */
//loadout = [player, [missionNamespace, "_NameSpaceDef"]] call BIS_fnc_loadInventory;
/* Deletes the players old body */
//deleteVehicle (_this select 1);
/* Calls define group script */
//[[[],"scripts\Markers\DefineGroups.sqf"],"BIS_fnc_execVM"] call BIS_fnc_MP;
/* Resets the players RV setting */
//(_this select 0) setvariable ["BEARB_RVPlacement", 0];



_preAssignedRole = player setVariable ["PO3_VAR_roleAttribute",nil];
	if(isNil "_preAssignedRole") then {
		switch (true) do {
			case ( getText(configFile >> "CfgWeapons" >> primaryWeapon(player) >> "UIPicture" ) == "\a3\weapons_f\data\ui\icon_mg_ca.paa") : { player setVariable ["PO3_VAR_roleAttribute","MachineGunner",true] };
			case ( getText(configFile >> "CfgWeapons" >> secondaryWeapon(player) >> "UIPicture" ) == "\a3\weapons_f\data\ui\icon_at_ca.paa") : { player setVariable ["PO3_VAR_roleAttribute","MissileSpecialist",true] };
			
							
			
			/* Set Pilots */
			case ( (typeOf player) IN ["UK3CB_BAF_HeliPilot_RAF"] ) : {
				player setVariable ["PO3_VAR_roleAttribute","Support",true];
				//[player] call PO3_fnc_setAsCrewman; // Automatically Assign Drivers License
				[player] call PO3_fnc_setAsPilot; // Automatically Assign Pilots License
			};
			
			
			/* Set Crew */
			case ( (typeOf player) IN ["UK3CB_BAF_Crewman_MTP"] ) : {
				player setVariable ["PO3_VAR_roleAttribute","Support",true];
				[player] call PO3_fnc_setAsCrewman; // Automatically Assign Drivers License
				//[player] call PO3_fnc_setAsPilot; // Automatically Assign Pilots License
			};
			
			
			default { player setVariable ["PO3_VAR_roleAttribute","Rifleman",true] };
		};
	};
	[player] spawn PO3_fnc_vehicleRestrict;