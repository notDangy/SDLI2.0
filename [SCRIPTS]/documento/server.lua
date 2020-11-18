--[[#######################################]]--
-- Made by Dangy x Saint Denis Life Italia ]]--
--[[#######################################]]--

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("document:getInfo")
AddEventHandler("document:getInfo", function()
    local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter

	local identifier = Character.identifier
	local firstname = Character.firstname
	local lastname = Character.lastname

		
	TriggerClientEvent("document:showInfo", _source, firstname, lastname)
	
end)


RegisterServerEvent("document:getInfoAnother")
AddEventHandler("document:getInfoAnother", function(player)

	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter

	
	local firstname = Character.firstname
	local lastname = Character.lastname

	TriggerClientEvent("document:showInfo", player, firstname, lastname)
	
end)