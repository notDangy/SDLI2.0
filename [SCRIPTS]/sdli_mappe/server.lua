local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


--AddEventHandler("redemrp:playerLoaded", function(source, user)
    --initArticles()
--end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map1", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map1.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map2", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map2.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map3", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map3.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map4", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map4.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map5", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map5.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map6", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map6.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map7", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map7.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("map8", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "map8.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("indovinello", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "LetteraIndovinello.png")
	end)
	
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("mappa", function(data) 
		local _source = data.source
		TriggerClientEvent('map:toggle', _source, "mappa.png")
	end)
	
	
end)