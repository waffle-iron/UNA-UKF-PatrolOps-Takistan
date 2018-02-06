/* Private variables */
private["_NameSpaceDef"];
/* Defines namespace */
_NameSpaceDef = name (_this select 1);
/* Saves the players equipment */
//[player, [missionNamespace, "_NameSpaceDef"]] call BIS_fnc_saveInventory;
/* Provides a hint on who killed player */
//hintSilent format ['Killed by %1', name (_this select 1)];
/* Gets the players custom radio setting */
//((_this select 1) getVariable "BEARB_RADIO_CHANNEL") radioChannelRemove [(_this select 1)];
