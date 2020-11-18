--[[#######################################]]--
-- Made by Dangy x Saint Denis Life Italia ]]--
--[[#######################################]]--


local show = false

RegisterNetEvent("menu:id:start")
AddEventHandler("menu:id:start", function()
	show = not show
	if show then
       TriggerServerEvent("document:getInfo")
       Wait(250)
    else
      TriggerEvent("document:hideInfo")
	  Wait(250)
    end
end)


RegisterNetEvent("menu:id:get")
AddEventHandler("menu:id:get", function()
	show = not show
	if show then
		local closestPlayer, closestDistance = GetClosestPlayer()
		if (closestPlayer ~= nil and closestPlayer ~= -1) and (closestDistance < 10) then
			local destSource = GetPlayerServerId(closestPlayer)
			TriggerServerEvent("document:getInfoAnother", destSource)
		end
	else
		TriggerEvent("document:hideInfo")
		Wait(250)
	end
end)

RegisterNetEvent("document:showInfo")
AddEventHandler("document:showInfo", function(name, surname, address)
	
	local gender 
	if IsPedMale(PlayerPedId()) then 
		gender = "Maschio" 
	else 
		gender = "Femmina" 
	end
	
	SendNUIMessage(
		{
			type = "ui",
			display = true,
			name = name,
			surname = surname,
			address = address,
			gender1 = gender
		}
	)
end)

RegisterNetEvent("document:hideInfo")
AddEventHandler("document:hideInfo", function()
    SendNUIMessage({
        type = "ui",
        display = false
    })
end)

function GetClosestPlayer()

	local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
	local playerPed, playerId = PlayerPedId(), PlayerId()
	local coords, usePlayerPed = coords, false
    
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		usePlayerPed = true
		coords = GetEntityCoords(playerPed)
	end
    
	for i=1, #players, 1 do

		local tgt = GetPlayerPed(players[i])

		if IsPlayerTargettingEntity(PlayerId(), tgt, false) then
			local targetCoords = GetEntityCoords(tgt)
			local distance = #(coords - targetCoords)
			return players[i], distance
		end

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

			local targetCoords = GetEntityCoords(tgt)
			local distance = #(coords - targetCoords)

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer = players[i]
				closestDistance = distance
			end

		end

	end
	return closestPlayer, closestDistance
	--return PlayerId(), 0.0
end