local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

-------------------------
----- SEZIONE ADMIN -----
-------------------------

RegisterServerEvent('admincheck1')
AddEventHandler('admincheck1', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter         
	if Character.group == "admin" or Character.group == "helper" then
		TriggerClientEvent("pedmenu",_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Devi essere un Admin', 4000)
	end
end)

RegisterServerEvent('admincheck2')
AddEventHandler('admincheck2', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter

	if User.getGroup == "admin" then
		TriggerClientEvent("cambioped",_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Devi essere un Admin', 4000)
	end
end)

--------------------------
----- SEZIONE PLAYER -----
--------------------------

-- PED1
RegisterServerEvent('ped1check')
AddEventHandler('ped1check', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter

	if User.getGroup == "ped1" then
		TriggerClientEvent("cambiopedped1",_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Non hai il gruppo ped1', 4000)
	end
end)

-- PED2
RegisterServerEvent('ped2check')
AddEventHandler('ped2check', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter

	if User.getGroup == "ped2" then
		TriggerClientEvent("cambiopedped2",_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Non hai il gruppo ped2', 4000)
	end
end)

-- PED3
RegisterServerEvent('ped3check')
AddEventHandler('ped3check', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter

	if User.getGroup == "ped3" then
		TriggerClientEvent("cambiopedped3",_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Non hai il gruppo ped3', 4000)
	end
end)