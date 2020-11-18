canHeal = false


local blips = {
    { name = 'Clinica', sprite = -1739686743, x=1369.4, y=-1310.3, z=77.9 },
    { name = 'Clinica', sprite = -1739686743, x=-289.5, y=807.9, z=119.6 },
    { name = 'Clinica', sprite = -1739686743, x=-790.7, y=-1304.7, z=43.6 },
    { name = 'Clinica', sprite = -1739686743, x=2721.3, y=-1231.8, z=50.4 },
    { name = 'Tenda della Vita', sprite = 1109348405, x=441.8, y=2221.3, z=247.6 },
}

function DrawTxt(str, x, y, w, h, col1, col2, col3, a, center)
	local str = CreateVarString(10, "LITERAL_STRING", str)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(center)
	SetTextDropshadow(1, 0, 0, 0, 255)
	Citizen.InvokeNative(0xADA9255D, 1)
	DisplayText(str, x, y)
end

Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(500)
        for _, info in pairs(blips) do 
            local playerPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
            local dist = GetDistanceBetweenCoords(playerPos, info.x, info.y, info.z, true)
            while dist < 1 do
                Citizen.Wait(0)
                local health = GetEntityHealth(PlayerPedId())
                playerPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
                dist = GetDistanceBetweenCoords(playerPos, info.x, info.y, info.z, true)
                DrawTxt("Premi E per curarti oppure premi G rianimare il tuo compagno.", 0.5, 0.9, 0.5, 0.5, 255, 255, 255, 255, true)

                if IsControlJustReleased(0, 0xCEFD9220) then
                    if health >= -1 then
                        TriggerServerEvent("clinics:pay")
                    else
                        --notify
                        TriggerEvent("redemrp_notification:start", "Non puoi curarti ora!", 3, "error")
                    end
                elseif IsControlJustReleased(0, 0x760A9C6F) then
                    if not IsPedDeadOrDying(PlayerPedId()) then
                        local closestPlayer, closestDistance = GetClosestPlayer()
                        if closestPlayer ~= -1 and closestDistance < 3 and IsPedDeadOrDying(GetPlayerPed(closestPlayer), true) then
                            TriggerServerEvent("clinics:pay:revive", GetPlayerServerId(closestPlayer))
                        else
                            TriggerEvent("redemrp_notification:start", "Nessun compagno da rianimare!", 3, "error")
                        end
                    else
                        TriggerEvent("redemrp_notification:start", "Non puoi rianimare!", 3, "error")
                    end
                end
            end
        end
    end
end)



RegisterNetEvent("clinics:heal")
AddEventHandler("clinics:heal", function()
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 60)
    TriggerEvent("redemrp_notification:start", "Il medico ti ha curato!", 3, "success")
    canHeal = false
    TriggerEvent("clinics:wait")
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
end


