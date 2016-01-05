/*
	Original HALV_takegive_crypto.sqf by Halv
	Copyright (C) 2015  Halvhjearne > README.md
	Edit to takegive_poptab.sqf for Exile by Dodo
*/

_player = _this select 0;
_costs = _this select 1;

_exile = _player getVariable ["ExileMoney", 0];
_exile = _exile - _costs;
_player setVariable ["ExileMoney", _exile];
format["setAccountMoney:%1:%2", _exile, (getPlayerUID _player)] call ExileServer_system_database_query_fireAndForget;
[_player, "purchaseVehicleSkinResponse", [0, str _exile]] call ExileServer_system_network_send_to;
