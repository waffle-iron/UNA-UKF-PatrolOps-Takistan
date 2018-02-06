/* Creates an entry in the server and client RPT file with the mission name in place of the %1.
Makes it easier to debug when you know what mission created the error. */
diag_log text "";
diag_log text format["|=============================   %1   =============================|", missionName];
diag_log text "";
/* Makes Params easier to call by Shuko */
for [{_i = 0},{_i < count(paramsArray)},{_i = _i + 1}] do
{
	call compile format ["PARAMS_%1 = %2",(configName ((missionConfigFile >> "Params") select _i)),(paramsArray select _i)];
};


/* Prevents team switching */
enableTeamswitch false;
/* Stops radio chat from AI */
0 fadeRadio 0;

//Execute starting scripts and functions
execVM "R3F_LOG\init.sqf";


_tf = execVM "scripts\TOUR_Functions\TOUR_Functions.sqf"; 
waitUntil {scriptDone _tf};

/* Commented out to try executing elsewhere to ensure 100% working */
//_ar = execVM "scripts\virtualArsenal\NATO.sqf";
//waitUntil {scriptDone _ar};

/* Initiates the TOUR Radio channels	*/
_fr = [TOUR_CORE,true] execVM "scripts\TOUR_FieldRadio\TOUR_FieldRadio.sqf";
waitUntil { scriptDone _fr };


#include "scripts\functions.sqf";

//Assign custom insertion vehicles to Logistics
call compile preprocessFile "scripts\staticData.sqf";



[] execVM "scripts\fn_advancedSlingLoadingInit.sqf";

/* Initialises the weather options */
[] execVM "scripts\Weather\Initial.sqf";
/* Initialises the time multiplier options */
[] execVM "scripts\Time\Multiplier.sqf";





[[player],"TOUR_fnc_startingMove",true] call BIS_fnc_MP;
[[player],"TOUR_fnc_VAR",true] call BIS_fnc_MP;
[[player],"TOUR_fnc_VAR2",true] call BIS_fnc_MP;
[[player],"TOUR_fnc_VAR3",true] call BIS_fnc_MP;

["INIT",format["Executing %1 init.sqf",missionName],true] call PO3_fnc_log;

[] execVM "Patrol_Ops_3.sqf";

if(!isDedicated) then {
	Receiving_finish = false;
	onPreloadFinished { Receiving_finish = true; onPreloadFinished {}; };
	WaitUntil{ !(isNull player) && !isNil "PO3_core_init" && Receiving_finish };
}else{
	WaitUntil{!isNil "PO3_core_init"};
};

if(!isDedicated && !PO3_debug) then {
	
	/* Executes radio channels */
	//[] execVM "scripts\RadioChannels\Add.sqf";
	
	

	
//	playMusic "LeadTrack01a_F";
//	0 fadeMusic 1;
//	[5,""] spawn PO3_fnc_camera_fadein;
//	if!(PO3_debug) then { [270,900,150] call PO3_fnc_introsequence };
//	[] spawn { sleep 20; 8 fadeMusic 0; };
	

	
	/* Really Great Script to lower everyone's weapon on mission start!*/	
	[[player],"TOUR_fnc_startingMove",true] call BIS_fnc_MP;
	[[player],"TOUR_fnc_VAR",true] call BIS_fnc_MP;
	[[player],"TOUR_fnc_VAR2",true] call BIS_fnc_MP;
	[[player],"TOUR_fnc_VAR3",true] call BIS_fnc_MP;

	

	
	
	
//External Injury system (Future Mod Support)
//	TCB_AIS_PATH = "scripts\ais_injury\";
//	{[_x] call compile preprocessFile (TCB_AIS_PATH+"init_ais.sqf")} forEach (if (isMultiplayer) then {playableUnits} else {switchableUnits});		// execute for every playable unit


//External Logistics (Future Mod Support)
	[] execVM "scripts\IgiLoad\IgiLoadInit.sqf";
};

["PO3_taskmaster"] call PO3_fnc_runTaskSequence;

[] call PO3_fnc_outrosequence;
