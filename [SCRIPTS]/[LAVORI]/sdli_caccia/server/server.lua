VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("hunting:add")
AddEventHandler("hunting:add", function(item)

	local _source = source
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter

	local _item = item
	local randomitem =  math.random(1,3)
	
	if _item ~= nil then
		VorpInv.addItem(_source, _item, randomitem)
	end
end)

RegisterServerEvent("hunting:money")
AddEventHandler("hunting:money", function(item)
	TriggerEvent("vorp:addMoney", source, 0, tonumber(item))
end)


