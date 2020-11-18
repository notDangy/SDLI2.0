local user_group = ""
local user_job = ""


--PAYCHECK--

Citizen.CreateThread(function() 
    while true do 
        Wait(900000)
        TriggerServerEvent('sdli_core:payCheck')
    end
end)

--END PAYCHECK--


Citizen.CreateThread(function() 
    while true do
        Wait(0)
        DisableControlAction(0, 0x6E9734E8) -- Arrenditi con il lasso
        DisableControlAction(0, 0x1F6D95E5) -- F4 SELECT ITEM WEEL
    end
end)

Citizen.CreateThread(function() 
        
    Wait(30000)
    TriggerServerEvent('sdli_core:updateCounter')
    
end)

Citizen.CreateThread(function() 

    while true do 
        Wait(0)
        if IsControlJustReleased(0, 0x4CC0E2FE) then --0x4CC0E2FE [B], 0xD8F73058 U
            TriggerServerEvent("sdlicore:checkGroupMenu")
            Wait(100)
            WarMenu.OpenMenu('sdlicore_menu')

        end
    end

end)

AddEventHandler("vorp:PlayerForceRespawn", function()
    TriggerServerEvent("vorp:wipePlayer")
end)

RegisterNetEvent("vorpinventory:inspectHorseClient")
AddEventHandler("vorpinventory:inspectHorseClient", function(name, inv)
    
    local _name = name
    local _inv = inv
    WarMenu.CreateMenu(_name, name)
    WarMenu.SetMenuX(_name, 0.7) -- [0.0..1.0] top left corner
    WarMenu.SetMenuY(_name, 0.1) -- [0.0..1.0] top

    WarMenu.OpenMenu(_name)

    Citizen.CreateThread(function() 
        while not WarMenu.IsMenuAboutToBeClosed() do 
            Wait(0)
            if WarMenu.IsMenuOpened(_name) then
                for k,v in pairs(_inv) do
                    if WarMenu.Button(v["Name"] .. " (x" .. tostring(v["Qtty"]) .. ")") then end
                end
            end
            WarMenu.Display()
        end
    end)
end)


RegisterNetEvent("vorpinventory:inspectCartClient")
AddEventHandler("vorpinventory:inspectCartClient", function(name, inv)
    
    local _name = name
    local _inv = inv
    WarMenu.CreateMenu(_name, name)
    WarMenu.SetMenuX(_name, 0.7) -- [0.0..1.0] top left corner
    WarMenu.SetMenuY(_name, 0.1) -- [0.0..1.0] top

    WarMenu.OpenMenu(_name)

    Citizen.CreateThread(function() 
        while not WarMenu.IsMenuAboutToBeClosed() do 
            Wait(0)
            if WarMenu.IsMenuOpened(_name) then
                for k,v in pairs(_inv) do
                    if WarMenu.Button(v["Name"] .. " (x" .. tostring(v["Qtty"]) .. ")") then end
                end
            end
            WarMenu.Display()
        end
    end)
end)

RegisterNetEvent("vorpinventory:inspectPlayerClient")
AddEventHandler("vorpinventory:inspectPlayerClient", function(name, inv)
    
    local _name = name
    local _inv = inv
    WarMenu.CreateMenu(_name, "Inventario player")
    WarMenu.SetMenuX(_name, 0.7) -- [0.0..1.0] top left corner
    WarMenu.SetMenuY(_name, 0.1) -- [0.0..1.0] top

    WarMenu.OpenMenu(_name)

    Citizen.CreateThread(function() 
        while not WarMenu.IsMenuAboutToBeClosed() do 
            Wait(0)
            if WarMenu.IsMenuOpened(_name) then
                for k,v in pairs(_inv) do
                    if WarMenu.Button(v["Name"] .. " (x" .. tostring(v["Quantity"]) .. ")") then end
                end
            end
            WarMenu.Display()
        end
    end)
end)

RegisterNetEvent("inspecthorse")
AddEventHandler("inspecthorse", function()
    local closestPlayer, closestDistance = GetClosestPlayer()
    local playerCoords = GetEntityCoords(PlayerPedId(), true, true)
    if closestDistance < 2.0 and closestPlayer ~= -1 then
        TriggerServerEvent("vorpinventory:inspectHorse", GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent("inspectcart")
AddEventHandler("inspectcart", function()
    local playerCoords = GetEntityCoords(PlayerPedId(), true, true)
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestDistance < 2.0 and IsAnyVehicleNearPoint(playerCoords.x,playerCoords.y,playerCoords.z, 4.0) then
        TriggerServerEvent("vorpinventory:inspectCart", GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent("inspectplayer")
AddEventHandler("inspectplayer", function()
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestDistance < 2.0 and closestPlayer ~= -1 then
        TriggerServerEvent("vorpinventory:inspectPlayer", GetPlayerServerId(closestPlayer))
    end
end)

RegisterNetEvent("sdlicore:getGroupFromServer")
AddEventHandler("sdlicore:getGroupFromServer", function(group, job) 
    user_group = group
    user_job = job
end)

Citizen.CreateThread(function() 
    WarMenu.CreateMenu("sdlicore_menu", "Menu' principale")
    WarMenu.SetMenuX('sdlicore_menu', 0.76) -- [0.0..1.0] top left corner
    WarMenu.SetMenuY('sdlicore_menu', 0.15) -- [0.0..1.0] top
    WarMenu.CreateSubMenu('sdlicore_adminmenu', "sdlicore_menu", "Menu admin")
    WarMenu.CreateSubMenu("sdlicore_opzioniplayer", "sdlicore_menu", "Opzioni player")
    WarMenu.CreateSubMenu('sdlicore_saloon', "sdlicore_menu", "Amministrazione saloon")
    WarMenu.CreateSubMenu('sdlicore_armeria', "sdlicore_menu", "Amministrazione saloon")
    WarMenu.CreateSubMenu('sdlicore_blackjack', "sdlicore_menu", "Amministrazione blackjack")
    WarMenu.CreateSubMenu('sdlicore_capoindiano', "sdlicore_menu", "Menu indiani")
    WarMenu.CreateSubMenu('sdlicore_giornale', "sdlicore_menu", "Menu giornalista")
    WarMenu.CreateSubMenu('sdlicore_medico', "sdlicore_menu", "Menu medico")


    WarMenu.SetMenuWidth('sdlicore_menu', 0.24)
    WarMenu.SetMenuWidth('sdlicore_adminmenu', 0.24)
    WarMenu.SetMenuWidth('sdlicore_opzioniplayer', 0.24)
    WarMenu.SetMenuWidth('sdlicore_saloon', 0.24)
    WarMenu.SetMenuWidth('sdlicore_armeria', 0.24)
    WarMenu.SetMenuWidth('sdlicore_blackjack', 0.24)
    WarMenu.SetMenuWidth('sdlicore_medico', 0.24)
    WarMenu.SetMenuWidth('sdlicore_capoindiano', 0.24)
    WarMenu.SetMenuWidth('sdlicore_giornale', 0.24)

    local starteds=false
    while true do
        Wait(0) 
        if WarMenu.IsMenuOpened('sdlicore_menu') then
            WarMenu.Display()
            if user_group == "admin" then
				if WarMenu.MenuButton('> Menu admin', "sdlicore_adminmenu") then end
            end

            if user_job == "CapoSaloon" then
                if WarMenu.MenuButton('> Business Saloon', "sdlicore_saloon") then end
            elseif user_job == "CapoBlackJack" then 
                if WarMenu.MenuButton('> Business BlackJack', "sdlicore_blackjack") then end
            elseif user_job == "CapoArmaiolo" then 
                if WarMenu.MenuButton('> Business Armeria', "sdlicore_armeria") then end
            elseif user_job == "Medico" then
                if WarMenu.Button("> Menu medico") then
                    WarMenu.CloseMenu()
                    Wait(50)
                    TriggerEvent("vorp_ml_doctorjob:open")
                end
            elseif user_job == "CapoIndiano" then 
                if WarMenu.MenuButton('> Capo tribu', "sdlicore_capoindiano") then end
            elseif user_job == "Giornalista" then
                if WarMenu.MenuButton('> Menu giornalista', "sdlicore_giornale") then end
            end

            if WarMenu.Button("Menu vestiti") then

                TriggerEvent("vorp_clothesmenu")
            
            elseif WarMenu.Button('Menu accampamento') then

                WarMenu.CloseMenu()
                Wait(50)
                TriggerEvent('lhrcampamentos:openmenu')
            elseif WarMenu.Button("Mostra documento") then

                TriggerEvent("menu:id:start")

            elseif WarMenu.Button("Dai documento") then

                TriggerEvent("menu:id:get")

            elseif WarMenu.Button("Togli/Metti maschera") then

                ExecuteCommand("maschera")

            elseif WarMenu.Button("Togli metti bandana") then 

                TriggerEvent("menu:bandana:toggle")
                
            elseif WarMenu.Button("Loot player") then

                TriggerEvent("vorp:lootplayercl")

            elseif WarMenu.Button("Ispeziona player") then

                TriggerEvent("inspectplayer")
                TriggerServerEvent('3dme:shareDisplay', "Fruga nelle tasche")

            elseif WarMenu.Button("Ispeziona carrozza") then

                TriggerEvent("inspectcart")
                TriggerServerEvent('3dme:shareDisplay', "Fruga nel carretto")

            elseif WarMenu.Button("Ispeziona cavallo") then 

                TriggerEvent("inspecthorse")
                TriggerServerEvent('3dme:shareDisplay', "Fruga nella bisaccia")

            elseif WarMenu.Button("Camminate ed emotes") then

                Wait(50)

                TriggerEvent("atanims:openMenu", "")
                WarMenu.CloseMenu()

            elseif WarMenu.Button("Ricarica Skin") then

                ExecuteCommand("reloadcloths")               
            
            end
        elseif WarMenu.IsMenuOpened('sdlicore_adminmenu') then

            if WarMenu.Button("Setta lavoro") then
                local id = textEntry("Inserisci l'id del player")
                Wait(50)
                local job = textEntry("Inserisci il lavoro")
                TriggerServerEvent("vorp:setJob",id,job)
            
            elseif WarMenu.Button("Wipe player") then

                local id = textEntry("Inserisci l'id")
                TriggerServerEvent("vorp:wipePlayerDB", tonumber(id))
            
            elseif WarMenu.Button("Prova scenario") then
                TriggerEvent("vorpinputs:getInput", "Prova", "Inserisci lo scenario", function(cb)
                    local scenario = cb
                    if scnario ~= nil or scenario ~= "close" then
                        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey(tostring(scenario)), 10000, true, false, false, false)
                        Wait(10000)
                        ClearPedTasks(PlayerPedId())
                    end
                end)
            
            elseif WarMenu.Button("Cancella veicolo") then
               TriggerEvent('delvehicle')
            end
            WarMenu.Display()

        elseif WarMenu.IsMenuOpened("sdlicore_saloon") then
         

            if WarMenu.Button('Assumi dipendente') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"Saloon")
            elseif WarMenu.Button('Licenzia dipendente') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"unemployed")
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened("sdlicore_armeria") then 

            if WarMenu.Button('Assumi dipendente') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"Armaiolo")
            elseif WarMenu.Button('Licenzia dipendente') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"unemployed")
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened("sdlicore_blackjack") then 

            if WarMenu.Button('Assumi dipendente') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"blackjack")
            elseif WarMenu.Button('Licenzia dipendente') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"unemployed")
            end

            WarMenu.Display()
            
        elseif WarMenu.IsMenuOpened("sdlicore_capoindiano") then 

            if WarMenu.Button('Fai entrare nella tribu') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"Indiano")
            elseif WarMenu.Button('Caccia dalla tribu') then
                local id = textEntry("Inserisci l'id del player")
                TriggerServerEvent("vorp:setJob",id,"unemployed")
            end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened("sdlicore_giornale") then 

            if WarMenu.Button("Crea nuovo articolo") then 
                TriggerEvent('requestMessage')
            --[[elseif WarMenu.Button("Cancella Articolo") then
                TriggerEvent("vorpinputs:getInput", "Elimina", "Inserisci l'id dell'articolo da eliminare:", function(cb)
                    local id = tonumber(cb)
                    TriggerEvent('newspaper:delNews', id)
                end)]]--
            end

            WarMenu.Display()
        end        
    end
end)

Citizen.CreateThread(function()
    
    while true do
        Wait(0)
        if user_group == "admin" and user_group ~= nil then
            RegisterCommand("screeneffect", function(source, args) 
                if args[1] ~= nil and args[2] ~= nil then 
                    AnimpostfxPlay(args[1])
                    Wait(tonumber(args[2]))
                    AnimpostfxStop(args[1])
                end
            end)
        end
    end
end)

RegisterNetEvent("sdli_core:closeMenu")
AddEventHandler("sdli_core:closeMenu", function() 
    WarMenu.CloseMenu() 
end)

RegisterNetEvent("vorp:lootplayercl")
AddEventHandler("vorp:lootplayercl", function() 
    local closestPlayer, closestDistance = GetClosestPlayer()
    if IsEntityDead(GetPlayerPed(closestPlayer)) and closestDistance < 2.0 and closestPlayer ~= -1 then
        exports['progressBars']:startUI(10000, "Ispezionando cadavere...")
        --anim
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
        Wait(9800)
        TriggerServerEvent("vorpinventory:lootPlayer", GetPlayerServerId(closestPlayer))
    end
end)

function textEntry(text) 
    AddTextEntry("FMMC_MPM_TYP8", text)
        DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
                
		while (UpdateOnscreenKeyboard() == 0) do
		    DisableAllControlActions(0);
			    Citizen.Wait(0);
        end

        if (GetOnscreenKeyboardResult()) then
           return GetOnscreenKeyboardResult()
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


RegisterNetEvent("smokecigarette")
AddEventHandler("smokecigarette", function()
  smoke()
end)

RegisterNetEvent("smokecigar")
AddEventHandler("smokecigar", function() 
  smokecigar()
end)

function smokecigar()
  TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_SMOKE_CIGAR'), 40000, true, true, true, true)
end

function smoke()
  TaskStartScenarioInPlace(GetPlayerPed(), GetHashKey('WORLD_HUMAN_SMOKE_INTERACTION'), 40000, true, true, true, 2.0, true)
end

Citizen.CreateThread(function() 
    ClearPedTasks(PlayerPedId())
    while true do 
        Wait(0)
        if IsControlJustReleased(0, 0xCEE12B50) then
            TriggerEvent('sdlicore:playnearestscenario')
        end
    end
end)

RegisterNetEvent('sdlicore:playnearestscenario')
AddEventHandler('sdlicore:playnearestscenario', function() 
    Wait(500)
    local pos = GetEntityCoords(PlayerPedId())
    starteds = not starteds
    if starteds then
        TaskUseNearestScenarioToCoord(PlayerPedId(),pos.x,pos.y,pos.z,2.0,-1,true,true,true,true)
    else
        ClearPedTasks(PlayerPedId())
    end

end)

---BLIP SCUDERIE---
local blipScuderie = {
    {x=-385.4, y=761.1, z=115.6},
    {x=-877.8, y=-1392.0, z=43.8},
    {x=2503.4, y=-1430.4, z=46.2},
    {x=-5551.7, y=-3017, z=-1.3},
    {x=2957.9, y=1434.5, z=45.1},
    {x=-1822.5, y=-603.0, z= 154.5},
    {x = 493.1, y = 2226.1, z = 246.9},

}

Citizen.CreateThread(function() 
    Wait(10000)
    for k,v in pairs(blipScuderie) do 
        local blip = N_0x554d9d53f696d002(1664425300, v.x, v.y, v.z)
        SetBlipSprite(blip, 1012165077, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Scuderia")
    end
end)

--FINE BLIP SCUDERIE--

local distanceToCheck = 5.0

RegisterNetEvent('delvehicle')
AddEventHandler('delvehicle', function()

    local ped = PlayerPedId()
    local _source = source

    if DoesEntityExist(ped) and not IsEntityDead(ped) then
        local pos = GetEntityCoords(ped)
        if  IsPedSittingInAnyVehicle(ped) then

            local vehicle = GetVehiclePedIsIn(ped, false)

            if GetPedInVehicleSeat(vehicle, -1) == ped then
                SetEntityAsMissionEntity(vehicle, true, true)
                deleteCar(vehicle)
                if DoesEntityExist(vehicle) then
                    -- TriggerClientEvent("vorp:TipBottom", _source, 'Unable to delete vehicle try again', 4000)
                else
                    -- TriggerClientEvent("vorp:TipBottom", _source, 'Vehicle Deleted', 4000)
                end
            else
                -- TriggerClientEvent("vorp:TipBottom", _source, 'You must be in drivers seat', 4000) -- from server side
            end
        end
    end
end)

function deleteCar(entity)
    Citizen.InvokeNative(0xE20A909D8C4A70F8, Citizen.PointerValueIntInitialized(entity))
end
