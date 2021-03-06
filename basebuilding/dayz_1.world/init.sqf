// This is an example init.sqf for DayZ, try and match the best with your world build

startLoadingScreen ["","DayZ_loadingScreen"];
enableSaving [false, false];
dayZ_instance = 1;	//The instance
hiveInUse	=	true;
initialized = false;
dayz_previousID = 0;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\variables.sqf"; //Initilize the Variables (IMPORTANT: Must happen very early)
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\publicEH.sqf";	//Initilize the publicVariable event handlers
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf"; //Functions used by CLIENT for medical
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\compiles.sqf"; //Compile regular functions

//  Add this in for Base Building 1.2 Make sure it is last to be added before progressLoadingScreen 1.0 and after the last "call compile preprocessFileLineNumbers"
call compile preprocessFileLineNumbers "dayz_code\init\variables.sqf"; //Initializes custom variables
call compile preprocessFileLineNumbers "dayz_code\init\compiles.sqf"; //Compile custom compiles
call compile preprocessFileLineNumbers "dayz_code\init\settings.sqf"; //Initialize custom clientside settings

progressLoadingScreen 1.0;
player setVariable ["BIS_noCoreConversations", true];
enableRadio false;

"filmic" setToneMappingParams [0.153, 0.357, 0.231, 0.1573, 0.011, 3.750, 6, 4]; setToneMapping "Filmic";
if (isServer) then {
	hiveInUse = true;
	_serverMonitor = [] execVM "\z\addons\dayz_server\system\server_monitor.sqf";
};

if (!isDedicated) then {
	0 fadeSound 0;
	0 cutText [(localize "STR_AUTHENTICATING"), "BLACK FADED",60];
	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = 	[] execVM "\z\addons\dayz_code\system\player_monitor.sqf";
	
};
