/*
	Original HALV_takegive_crypto_init.sqf by Halv
	Copyright (C) 2015  Halvhjearne > README.md
	Edit to takegive_poptab.sqf for Exile by Dodo
*/

if(isServer)then{
	takegive_poptab = compileFinal preprocessFileLineNumbers "custom\money\takegive_poptab.sqf";
	"takegive_poptab" addPublicVariableEventHandler {(_this select 1) call takegive_poptab};
};

if(hasInterface)then{
	isTradeEnabled = true;
};
