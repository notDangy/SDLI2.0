local jailLocs = {
	
	["valentine1"] = {x=-272.3, y=807.6, z=119.4, x1=-276.3, y1=800.6, z1=119.4},
	["valentine2"] = {x=-273.1, y=812.0, z=119.4, x1=-276.3, y1=800.6, z1=119.4},
	

	["rhodes1"] = {x=1355.6, y=-1302.3, z=77.8, x1=1358.2, y1=-1308.3, z1=77.7},

	["saintdenis1"] = {x=2502.0, y=-1306.4, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},
	["saintdenis2"] = {x=2503.8, y=-1311.0, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},
	["saintdenis3"] = {x=2499.8, y=-1310.9, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},
	["saintdenis4"] = {x=2498.2, y=-1306.6, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},

	["strawberry1"] = {x=-1812.8, y=-355.2, z=161.4, x1=-1805.3, y1=-351.3, z1=161.4},
	["strawberry2"] = {x=-1811.7, y=-350.4, z=161.5, x1=-1805.3, y1=-351.3, z1=161.4},

	["tumbelweed1"] = {x=-5531.4, y=-2920.4, z=-1.4, x1=-5526.7, y1=-2934.0, z1=199.3},
	["tumbleweed2"] = {x=-5528.4, y=-2926.0, z=-1.4, x1=-5526.7, y1=-2934.0, z1=199.3},
	["tumbleweed3"] = {x=-5529.8, y=-2923.1, z=-1.4, x1=-5526.7, y1=-2934.0, z1=199.3},
	
	["blackwater1"] = {x=-762.7, y=-1263.4, z=44.0, x1=-754.8, y1=-1269.1, z1=44.0},
	["blackwater2"] = {x=-766.7, y=-1264.0, z=44.0, x1=-754.8, y1=-1269.1, z1=44.0},

	["annesburg1"] = {x=2901.5, y=1310.9, z=44.9, x1=-754.8, y1=-1269.1, z1=44.0},
	["annesburg2"] = {x=2902.9, y=1314.7, z=44.9, x1=-754.8, y1=-1269.1, z1=44.0},
}

local offices = {
    ["blackwater"] = {x = -764.84, y = -1271.85, z = 44.04},
    ["valentine"] = {x = -278.36, y = 805.37, z = 119.38},
    ["strawberry"] = {x = -1811.91, y = -353.65, z = 164.65},
    ["rhodes"] =  {x = 1359.61, y = -1303.27, z = 77.77},
    ["tumbleweed"] = {x = -5530.48, y = -2928.49, z = -1.36},
    ["saintdenis"] = {x = 2496.79, y = -1302.06, z = 48.95},
}

function isPedNearOffice(pedCoords, offices) 
    for k,v in pairs(offices) do 
        local distance = GetDistanceBetweenCoords(pedCoords.x,pedCoords.y,pedCoords.z,v.x,v.y,v.z,true)
        if distance < 2.0 then 
            return true 
        end
    end
    return false
end

Citizen.CreateThread(function()
	for _, info in pairs(offices) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, 778811758, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Forze dell'ordine")
    end  
end)

local firsttime = true
Citizen.CreateThread(function()
    local checkbox2 = false
    WarMenu.CreateMenu('perso', _U('titulo'))
    WarMenu.SetSubTitle('perso', _U('subtitulo'))
    WarMenu.CreateSubMenu('inv', 'perso', _U('sub_menu_1'))
    WarMenu.CreateSubMenu('inv1', 'perso', _U('sub_menu_2'))
    WarMenu.SetMenuY('perso',0.2)

    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('perso') then

            
            if WarMenu.Button(_U('placa')) then

                
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(),  0x1FC12C9C, true, true, true)
                
					
			elseif WarMenu.Button(_U('esposar')) then 
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                
                    TriggerServerEvent("vorp_ml_policejob:cuffplayer", GetPlayerServerId(closestPlayer))                    
                   
                end
            elseif WarMenu.Button(_U('meter')) then 
                local closestPlayer, closestDistance = GetClosestPlayer()
                    if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    
                        TriggerServerEvent("vorp_ml_policejob:metervehiculo", GetPlayerServerId(closestPlayer))                    

                       
                end
            elseif WarMenu.Button(_U('desesposar')) then
            local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent("vorp_ml_policejob:uncuffplayer", GetPlayerServerId(closestPlayer))
                    
                end
            
            elseif WarMenu.Button("Manda in cella") and firsttime then
                local closestPlayer, closestDistance = GetClosestPlayer()
                local playerCoords = GetEntityCoords(PlayerPedId(), true,true)

                if closestPlayer ~= -1 and closestDistance <= 3.0 then

                    local closestJail = {}
                    local closestJailName = ""
                    local closestJailDistance = -1 

                    for k,v in pairs(jailLocs) do
                        local distance = GetDistanceBetweenCoords(v.x,v.y,v.z,playerCoords.x,playerCoords.y,playerCoords.z,true) 
                        if closestJailDistance == -1 or closestJailDistance > distance then 
                            closestJail = v
                            closestJailDistance = distance
                            closestJailName = k
                        end 
                    end
                    
                    if closestDistance <= 2 and closestJailDistance <= 10 and firsttime then
                        TriggerEvent("jail:getMinutesInput",GetPlayerServerId(closestPlayer), closestJailName, {x=closestJail.x,y=closestJail.y,z=closestJail.z}, {x1=closestJail.x1,y1=closestJail.y1,z1=closestJail.z1})
                        WarMenu.CloseMenu()
                        firsttime = false
                    end
                end
		    end
            
            WarMenu.Display()
        elseif whenKeyJustPressed(keys["DEL"]) then
           TriggerServerEvent("vorp_ml_policejob:checkjob")
        end
		
        Citizen.Wait(0)
    end
end)

RegisterNetEvent("jail:getMinutesInput")
AddEventHandler("jail:getMinutesInput", function(closestPlayer, jailName, jailCoords, relLoc)
    local _closestPlayer = closestPlayer
    local _jailName = jailName
    local _jailCoords = jailCoords
    local _relLoc = relLoc
    local minutes = 0
    TriggerEvent("vorpinputs:getInput", "Manda in cella", "Scrivi i minuti", function(cb)
        minutes = cb
        if tonumber(minutes) ~= nil and tonumber(minutes) <= 30 then
            TriggerServerEvent("jail:SetJail", _closestPlayer, _jailName, tonumber(minutes)*60, _jailCoords, _relLoc)
            firsttime = true
        end
    end)
end)

-- pd station
Citizen.CreateThread(function()
    local checkbox2 = false
    WarMenu.CreateMenu('perso2', _U('titulo'))
    WarMenu.SetSubTitle('perso2', _U('subtitulo'))
    WarMenu.CreateSubMenu('inv3', 'perso2', _U('sub_menu_5'))
    WarMenu.CreateSubMenu('inv4', 'perso2', _U('sub_menu_6'))
	--WarMenu.CreateSubMenu('TP', 'perso2', _U('sub_menu_7'))

    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('perso2') then

            

            if WarMenu.MenuButton(_U('sub_menu_3'), 'inv3') then
            end

            if WarMenu.MenuButton(_U('sub_menu_6'), 'inv4') then
            end

            
            

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('inv3') then


			if WarMenu.Button(_U('poner_skin')) then
				TriggerServerEvent("vanelicenze:documento")       	
			 
			elseif WarMenu.Button(_U('poner_skin2')) then
				TriggerServerEvent("vanelicenze:cacciatoreditaglie")
			 
			elseif WarMenu.Button(_U('poner_skin3')) then
				TriggerServerEvent("vanelicenze:cacciatore")
			end
      
				
            WarMenu.Display()

        elseif isPedNearOffice(coords, offices) then --blackw

            TriggerEvent("enter:pd")
            if whenKeyJustPressed(keys["G"]) then
                TriggerServerEvent("vorp_ml_policejob:checkjob2")
            end

        end
     
        Citizen.Wait(0)
    end
end)


-- function seteazaModel(name)
	-- local model = GetHashKey(name)
	-- local player = PlayerId()
	
	-- if not IsModelValid(model) then return end
	-- PerformRequest(model)
	
	-- if HasModelLoaded(model) then
		-- -- SetPlayerModel(player, model, false)
		-- Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		-- Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		-- SetModelAsNoLongerNeeded(model)
	-- end
-- end

-- function PerformRequest(hash)
    -- RequestModel(hash, 0) -- RequestModel
    -- local times = 1
    -- while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do -- HasModelLoaded
        -- Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel
        -- times = times + 1
        -- Citizen.Wait(0)
        -- if times >= 100 then break end
    -- end
-- end


RegisterNetEvent('enter:pd')
  AddEventHandler('enter:pd', function()
    SetTextScale(0.5, 0.5)
    --SetTextFontForCurrentCommand(1)
    local msg = _U('abrir_menu2')
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)
  
  RegisterNetEvent('vorp_ml_policejob:open2')
AddEventHandler('vorp_ml_policejob:open2', function(cb)
	WarMenu.OpenMenu('perso2')
end)

RegisterNetEvent('vorp_ml_policejob:open')
AddEventHandler('vorp_ml_policejob:open', function(cb)
	WarMenu.OpenMenu('perso')
end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

--Police Horse

local recentlySpawned = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if recentlySpawned > 0 then
            recentlySpawned = recentlySpawned - 1
        end
    end
end)

function SpawnHorse()
    local localPed = PlayerPedId()
    local randomHorseModel = math.random(1, #Config.Horses)
    local model = GetHashKey(Config.Horses[randomHorseModel])

    RequestModel(model, true)

    while not HasModelLoaded(model) do
        Citizen.Wait(100)
    end
    
    local forward = Citizen.InvokeNative(0x2412D9C05BB09B97, localPed)
    local pos = GetEntityCoords(localPed)
    local myHorse = Citizen.InvokeNative(0xAF35D0D2583051B0, model, pos.x, pos.y - 30, pos.z - 0.5, 180.0, true, true, true, true)
    TaskGoToEntity( myHorse, localPed, -1, 7.2, 2.0, 0, 0 )
	Citizen.InvokeNative(0x283978A15512B2FE, myHorse, true)
    SetPedAsGroupMember(myHorse, 0) --Citizen.InvokeNative(0x9F3480FE65DB31B5, myHorse, 0)
	SetModelAsNoLongerNeeded(model) -- Citizen.InvokeNative(0x4AD96EF928BD4F9A, model)
	Citizen.InvokeNative(0xD3A7B003ED343FD9, myHorse, 0x1EE21489, true, true, true)
    Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, myHorse)
end

--Police cuff


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


 RegisterNetEvent('vorp_ml_policejob:cuff')
AddEventHandler('vorp_ml_policejob:cuff', function()
		local playerPed = PlayerPedId()
        SetEnableHandcuffs(playerPed, true)
		    
   
end)

--IsPedCuffed(playerPed, true)

 RegisterNetEvent('vorp_ml_policejob:uncuff')
AddEventHandler('vorp_ml_policejob:uncuff', function()
    local playerPed = PlayerPedId()
    UncuffPed(playerPed)
	
    
end)

RegisterNetEvent('vorp_ml_policejob:hogtie')
AddEventHandler('vorp_ml_policejob:hogtie', function()
	isLasso = not isLasso
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if isLasso then
            TaskKnockedOutAndHogtied(playerPed, false, false)
			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)
        elseif not isLasso then
            ClearPedTasksImmediately(playerPed, true, false)
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			DisplayRadar(true)
		end
	end)
end)

RegisterNetEvent('vorp_ml_policejob:meter')
AddEventHandler('vorp_ml_policejob:meter', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetVehicleCoords(coords)

    local seats = 1 
    while seats <= 6 do
        if Citizen.InvokeNative(0xE052C1B1CAA4ECE4, vehicle, seats) then
            -- print('Vehiclue seat')
            Citizen.InvokeNative(0xF75B0D629E1C063D, ped, vehicle, seats)
            break
        end
            if seats == 7 then
                -- print('ESTO ESTA LLENO MUCHACHO')
                break
            end
        
        seats = seats + 1
    end
end)

RegisterNetEvent('vorp_ml_policejob:sacar')
AddEventHandler('vorp_ml_policejob:sacar', function()
    local playerPed = PlayerPedId()
    local vehicle = GetVehicleCoords(coords)
    local inVehicle = GetVehiclePedIsIn(playerPed, false)
    local flag = 16
    TaskLeaveVehicle(playerPed, vehicle, flag)
end)