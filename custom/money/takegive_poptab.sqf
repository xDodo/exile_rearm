/*
	Original HALV_takegive_crypto.sqf by Halv
	Copyright (C) 2015  Halvhjearne > README.md
	Edit to takegive_poptab.sqf for Exile by Dodo
*/

_player = _this select 0;
_costs = _this select 1;

_money = _player getVariable ["ExileMoney", 0];
_money = _money - _costs;
_player setVariable ["ExileMoney", _money];
format["setAccountMoney:%1:%2", _money, (getPlayerUID _player)] call ExileServer_system_database_query_fireAndForget;
[_player, "purchaseVehicleSkinResponse", [0, str _money]] call ExileServer_system_network_send_to;
