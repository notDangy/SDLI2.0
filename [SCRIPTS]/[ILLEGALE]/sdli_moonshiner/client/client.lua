local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }
local still = 0
local openMenu = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))		
        --print(x,y,z)
        for k,v in pairs(Config.Locations) do
            --print(v.x,v.y,v.z)
            --print(tostring(GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,true)))
            if GetDistanceBetweenCoords(x,y,z,v.x,v.y,v.z,false) < 2.0 then
                DrawText3D(v.x, v.y, v.z + 1, "Premi G per preparare moonshine")
                if IsControlJustReleased(0, 0x760A9C6F) then -- g
                    TriggerEvent("ranch:moonshinecl")
                end
            end
        end
	end
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('still', "Distillatore")

    while true do
        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('still') then
			openMenu = true
			local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
			
            if WarMenu.Button('Prepara moonshine original') then
				TriggerServerEvent("ranch:moonshineoriginal")
                WarMenu.CloseMenu()
            elseif WarMenu.Button('Prepara moonshine "RED"') then
                TriggerServerEvent("ranch:moonshinered")
            elseif WarMenu.Button('Prepara moonshine "BLUEFLAME"') then
                TriggerServerEvent("ranch:moonshineblue")
            end
            WarMenu.Display()
            

        elseif openMenu then
            
			ClearPedTasksImmediately(PlayerPedId())
            openMenu = false
            
        end
        Citizen.Wait(0)
    end
end)

AddEventHandler('ranch:moonshinecl', function()
	Citizen.Wait(0)
	ClearPedTasksImmediately(PlayerPedId())
	WarMenu.OpenMenu('still')
	TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
end)

--[[function delDistillatore()
	if still ~= 0 then
		SetEntityAsMissionEntity(still)
		Citizen.Wait(50)
		DeleteObject(still)
		ClearPedTasksImmediately(PlayerPedId())
		TriggerServerEvent("moonshiner:delmoonshineSrv")
		still = 0
	end
end]]--

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

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

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

RegisterNetEvent('shiner:moonshine')
AddEventHandler('shiner:moonshine', function(type)
    local playerPed = PlayerPedId()
    
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    

    exports['progressBars']:startUI(30000, "Cucinando moonshine...")
    Wait(30000)

    if type == "original" then
        TriggerServerEvent('ranch:givemoonshineoriginal')
    elseif type == "red" then
        TriggerServerEvent('ranch:givemoonshinered')
    elseif type == "blueflame" then
        TriggerServerEvent('ranch:givemoonshineblue')
    end 


end)

--[[RegisterNetEvent('vane:setmoonshine')
AddEventHandler('vane:setmoonshine', function()
	if still ~= 0 then
        SetEntityAsMissionEntity(still)
        DeleteObject(still)
        still = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando distillatore...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_still04x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    still = prop
end)]]--