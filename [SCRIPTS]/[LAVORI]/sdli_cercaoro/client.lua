local Config = {}
local panninglocations = Config.PanningLocations

local active = false
local ShopPrompt
local hasAlreadyEnteredMarker, lastZone
local currentZone = nil

--REQUEST CONFIG--
-- Allora, ti diverti a cercare le coordinate che sono state messe lato server? Genio :)
Citizen.CreateThread(function() 
	Wait(2000)
	TriggerServerEvent("cercaoro:requestconfig")
end)

RegisterNetEvent("cercaoro:saveconfig")
AddEventHandler("cercaoro:saveconfig", function(svConfig)
	Config = svConfig
end)

local setacciando = false
function playSuccessAnim()
	if not setacciando then
		Citizen.CreateThread(function()
			setacciando = true
			math.randomseed(GetGameTimer())
			x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
			RequestAnimDict(Config.AnimDict)
			while not HasAnimDictLoaded(Config.AnimDict) do
				RequestAnimDict(Config.AnimDict)
				Citizen.Wait(1)
			end
			RequestModel(Config.PanObject)
			while not HasModelLoaded(Config.PanObject) do
			RequestModel(Config.PanObject)
			Citizen.Wait(1)
			end
			exports['progressBars']:startUI(10000, "Setacciando...")
			local object = CreateObject(Config.PanObject, x, y, z, true, true, true)
			AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), Config.Bone), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 1, 0, 0, 1)
			TaskPlayAnim(PlayerPedId(), Config.AnimDict, "search0"..tostring(math.random(1,4)), 1.0, 8.0, -1, 1, 0, false, false, false)
			--Citizen.Wait(4500)
			Wait(10000)
			DeleteObject(object)
			ClearPedTasks(PlayerPedId())
			TriggerEvent("checkgold", false)
			giveGold()
			setacciando = false
		end)
	end
end

function giveGold()
	TriggerServerEvent('vorp_goldpanning:successGiveGold', lastZone)
end

RegisterNetEvent('vorp_goldpanning:panPresent')
AddEventHandler('vorp_goldpanning:panPresent', function(test)
	
	TriggerEvent("checkgold", true)
	Wait(500)
	playSuccessAnim()
	
end)

function isPlayingAnimFishing(player) 
	local animations = {"search01","search02",}
end

AddEventHandler('vorp_goldpanning:hasEnteredMarker', function(zone)
	currentZone = zone
end)

AddEventHandler('vorp_goldpanning:hasExitedMarker', function(zone)
    
	currentZone = nil
end)

Citizen.CreateThread(function()
	Wait(5000)
    while true do
        Citizen.Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZone = false
		local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)

		for k,v in pairs(Config.PanningLocations) do
			if not IsPlayerDead(PlayerId()) then
				local distance = GetDistanceBetweenCoords(v["x"],v["y"],v["z"],coords.x,coords.y,coords.z, true)
				if Water == Config.PanningLocations[k]["waterhash"] and IsEntityInWater(player) and IsPedOnFoot(player) and distance < v["radius"] then
					--TriggerEvent("redemrp_notification:start", "prova!", 1, "error")
					TriggerEvent("vorp:TipBottom", "~o~Vedi qualcosa brillare nell'acqua!", 3000)
					isInMarker  = true
					currentZone = k
					lastZone    = k
					break            
				end
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			TriggerEvent('vorp_goldpanning:hasEnteredMarker', currentZone)
		end
		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('vorp_goldpanning:hasExitedMarker', lastZone)
		end
    end
end)

RegisterNetEvent('sdli_cercaoro:checkZone')
AddEventHandler('sdli_cercaoro:checkZone', function()
    if currentZone then
        if active == false then
            active = true
        end
		TriggerServerEvent('vorp_goldpanning:checkPan')
		Citizen.Wait(5000)
	else
		Citizen.Wait(500)
	end

end)
