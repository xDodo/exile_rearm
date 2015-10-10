// Vehicle Service Point (Repair) by Axe Cop
//reworked for a3 epoch by Halv
//reworked for a3 exile by Dodo
 
private ["_vehicle","_args","_servicePoint","_costs","_repairTime","_type","_name","_hitpoints","_allRepaired"];
 
_vehicle = _this select 0;
 
if (!local _vehicle) exitWith { diag_log format["Error: called service_point_repair.sqf with non-local vehicle: %1", _vehicle] };
 
_args = _this select 3;
_servicePoint = _args select 0;
_costs = _args select 1;
_repairTime = _args select 2;
_type = typeOf _vehicle;
_name = getText(configFile >> "cfgVehicles" >> _type >> "displayName");
_wallet = ExileClientPlayerMoney;
_veh = vehicle player; 
 
if (_wallet < _costs) exitWith {cutText [format["You need %1 Pop tab to Repair %2", _costs,_name], "PLAIN DOWN"];};
 
if(_costs > 0 && isTradeEnabled)then{
        takegive_poptab = [player,_costs,true];
        publicVariableServer "takegive_poptab";
};

 
_fnc_vehicle_getHitpoints = {
        private ["_cfgHitPoints", "_hps", "_funcGetHitPoints"];
        _cfgHitPoints = configFile >> "CfgVehicles" >> (typeOf _this) >> "HitPoints";
        _hps = [];
 
        _funcGetHitPoints =
        {
                for "_i" from 0 to ((count _this) - 1) do
                {
                        private ["_hp"];
                        _hp = configName (_this select _i);
                       
                        if (!(_hp in _hps)) then
                        {
                                _hps set [count _hps, _hp];
                        };
                };
        };
 
        while {(configName _cfgHitPoints) != ""} do
        {
                _cfgHitPoints call _funcGetHitPoints;
                _cfgHitPoints = inheritsFrom _cfgHitPoints;
        };
 
        _hps
};
 
_vehicle engineOn false;
 
_hitpoints = _vehicle call _fnc_vehicle_getHitpoints;
_allRepaired = true;
{
        private "_damage";
        if ((vehicle player != _vehicle) || (!local _vehicle) || ([0,0,0] distance (velocity _vehicle) > 1)) exitWith {
                _allRepaired = false;
                titleText [format["Repairing of %1 stopped", _name], "PLAIN DOWN"];
        };
        _damage = _vehicle getHitPointDamage _x;
        if (_damage > 0) then {
                if (_repairTime > 0) then {
                        private "_partName";
                        //change "HitPart" to " - Part" rather than complicated string replace
                        _partName = toArray _x;
                        _partName set [0,20];
                        _partName set [1,45];
                        _partName set [2,20];
                        _partName = toString _partName;
                        titleText [format["Repairing%1 ...", _partName], "PLAIN DOWN", _repairTime];
                        sleep _repairTime;
                };
                _vehicle setHitPointDamage [_x, 0];
        };
} forEach _hitpoints;
 
if (_allRepaired) then {
        _vehicle setDamage 0;
        _vehicle setVelocity [0,0,1];
        titleText [format["%1 Repaired", _name], "PLAIN DOWN"];
};
