local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('checkgroup')
AddEventHandler('checkgroup', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter         
	if Character.group == "admin" then
		TriggerClientEvent("openmenu",_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Devi essere un Admin', 4000)
	end
end)

RegisterServerEvent('checkgroup2')
AddEventHandler('checkgroup2', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter

	if User.getGroup == "admin" then
		TriggerClientEvent("tuzia",_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Devi essere un Admin', 4000)
	end
end)