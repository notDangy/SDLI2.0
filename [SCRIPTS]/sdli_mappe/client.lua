mapEnabled = false --paperEnabled


function ToggleMap(png) --ToggleNewspaper
	mapEnabled = not mapEnabled --paperEnabled

	if mapEnabled then --paperEnabled
		TriggerEvent("vorp_inventory:CloseInv") -- Per evitare il bug del NUI Focus, da lasciare solo se il giornale viene aperto mediante l'item
		SetNuiFocus( true, true )
		SendNUIMessage({
			action = "toggle",
			showmap = true,
			image = png
		})
    else
		SetNuiFocus( false )
		SendNUIMessage({
			action = "toggle",
			showmap = false
		})
	end
end

RegisterNUICallback('escape', function(data, cb)
	ToggleMap() --ToggleNewspaper
    TriggerEvent('inventory:mapanim', "close") --inventory:newspaperanim
end)

RegisterNetEvent('map:toggle') --newspaper:toggle
AddEventHandler('map:toggle', function(image) --newspaper:toggle
    ToggleMap(image) --ToggleNewspaper
end)

Citizen.CreateThread(function() 
	Wait(10000)
	SendNUIMessage({
		action = "init",
		resourceName = GetCurrentResourceName()
	})
end)