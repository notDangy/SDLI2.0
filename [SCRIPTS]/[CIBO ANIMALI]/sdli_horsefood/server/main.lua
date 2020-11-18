Inventory = exports.vorp_inventory:vorp_inventoryApi()


Citizen.CreateThread(function()
	Citizen.Wait(2000)
	Inventory.RegisterUsableItem("galletta", function(data)
		Inventory.subItem(data.source, "galletta", 1)
        TriggerClientEvent("dar:galletta", data.source) 
	end)

	Inventory.RegisterUsableItem("mela", function(data)
		Inventory.subItem(data.source, "mela", 1)
        TriggerClientEvent("dar:mela", data.source) 
	end)
	Inventory.RegisterUsableItem("carote", function(data)
		Inventory.subItem(data.source, "carote", 1)
        TriggerClientEvent("dar:carote", data.source) 
	end)
	Inventory.RegisterUsableItem("sugar", function(data)
		Inventory.subItem(data.source, "sugar", 1)
        TriggerClientEvent("dar:sugar", data.source) 
	end)
	
end)


RegisterNetEvent("devolver:galletta")
AddEventHandler("devolver:galletta", function()
	local _source = source
	Inventory.addItem(_source, "galletta", 1)

end)

RegisterNetEvent("devolver:mela")
AddEventHandler("devolver:mela", function()
	local _source = source
	Inventory.addItem(_source, "mela", 1)

end)

RegisterNetEvent("devolver:carote")
AddEventHandler("devolver:carote", function()
	local _source = source
	Inventory.addItem(_source, "carote", 1)

end)

RegisterNetEvent("devolver:sugar")
AddEventHandler("devolver:sugar", function()
	local _source = source
	Inventory.addItem(_source, "sugar", 1)

end)
