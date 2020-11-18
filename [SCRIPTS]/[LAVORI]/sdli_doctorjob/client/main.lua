
---MENU MEDICO SU B-----
Citizen.CreateThread(function()
    local checkbox2 = false
    WarMenu.CreateMenu('perso', _U('titulo'))
    WarMenu.SetSubTitle('perso', _U('subtitulo'))
    WarMenu.CreateSubMenu('inv', 'perso', _U('sub_menu'))
    WarMenu.CreateSubMenu('inv1', 'perso', _U('sub_menu2'))
    --WarMenu.CreateSubMenu('inv2', 'perso', _U('sub_menu3'))


    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('perso') then
            
            if WarMenu.Button("Rianima persona") then
                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 and IsEntityDead(GetPlayerPed(closestPlayer)) then 
                    TriggerServerEvent("vorp_ml_doctorjob:reviveplayer", GetPlayerServerId(closestPlayer))
                        
                end	
                        
            elseif WarMenu.Button("Cura persona") then

                local closestPlayer, closestDistance = GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent("vorp_ml_doctorjob:healplayer", GetPlayerServerId(closestPlayer))
                end
            
            elseif WarMenu.Button("Chiudi") then 
                WarMenu.CloseMenu() 
            end
            WarMenu.Display()

        end

    
		
        Citizen.Wait(0)
    end
end)
----FINE MENU MEDICO SU B-----

RegisterNetEvent('vorp_ml_doctorjob:open')
AddEventHandler('vorp_ml_doctorjob:open', function(cb)
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


 RegisterNetEvent('vorp_ml_doctorjob:healed')
AddEventHandler('vorp_ml_doctorjob:healed', function()
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
    local Health = GetAttributeCoreValue(PlayerPedId(), 0)
    local newHealth = Health + 50
    local Stamina = GetAttributeCoreValue(PlayerPedId(), 1)
    local newStamina = Stamina + 50
    local Health2 = GetEntityHealth(PlayerPedId())
    local newHealth2 = Health2 + 50
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina) --core
    SetEntityHealth(PlayerPedId(), newHealth2)
    end
end)

RegisterNetEvent('vorp_ml_doctorjob:revived')
AddEventHandler('vorp_ml_doctorjob:revived', function()
local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
		--TriggerServerEvent("redemrp:doctorrevive", function()
		--end)
		--TriggerClientEvent("redemrp_respawn:revivepl", function()
		--end)
	local ply = PlayerPedId()
	local coords = GetEntityCoords(ply)
	
	DoScreenFadeOut(1000)
	Wait(1000)
	DoScreenFadeIn(1000)
	--isDead = false
	--timerCount = reviveWait
	NetworkResurrectLocalPlayer(coords, true, true, false)
	ClearTimecycleModifier()
	ClearPedTasksImmediately(ply)
	SetEntityVisible(ply, true)
	NetworkSetFriendlyFireOption(true)


	SetCamActive(gameplaycam, true)
	DisplayHud(true)
	DisplayRadar(true)
	-- TriggerServerEvent("redemrp_respawn:lupocamera", coords, lightning)
    exports.spawnmanager:setAutoSpawn(false)
   end
end)

RegisterNetEvent('ml_doctorjob:animation')
AddEventHandler('ml_doctorjob:animation', function(cb)
	RequestAnimDict("mech_revive@unapproved")
	while not HasAnimDictLoaded("mech_revive@unapproved") do
		RequestAnimDict("mech_revive@unapproved")
		Citizen.Wait(1)
	end
	TaskPlayAnim(PlayerPedId(), "mech_revive@unapproved", "revive", 0.5, 0.5, 4000, 1, 0, false, false, false)
end)

RegisterNetEvent('ml_doctorjob:revived')
AddEventHandler('ml_doctorjob:revived', function()
	Citizen.Wait(3500)
	--TriggerServerEvent("redemrp:doctorrevive", function()
	--end)
	--TriggerClientEvent("redemrp_respawn:revivepl", function()
	--end)
	local ply = PlayerPedId()
	local coords = GetEntityCoords(ply)
	
	DoScreenFadeOut(500)
	Wait(500)

	--isDead = false
	--timerCount = reviveWait
	NetworkResurrectLocalPlayer(coords, true, true, false)
	ClearTimecycleModifier()
	ClearPedTasksImmediately(ply)
	SetEntityVisible(ply, true)
	NetworkSetFriendlyFireOption(true)

	SetCamActive(gameplaycam, true)
	DisplayHud(true)
	DisplayRadar(true)
	--TriggerServerEvent("redemrp_respawn:lupocamera", coords, lightning)
	local dict = "amb_rest@world_human_sleep_ground@arm@player_temp@exit"
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
	TaskPlayAnim(PlayerPedId(), dict, "exit_right", 16.0, 2.0, 9500, 0, 0, true, 0, false, 0, false)
	Wait(500)
	DoScreenFadeIn(500)
end)


----MENU CLINICA DI VALENTINE----

Citizen.CreateThread(function() 

    while true do 
        Wait(0)
        Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, -291.2,816.3,119.4 - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)

        local pos = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,-291.2,816.3,119.4,true)
        if distance < 1.0 then 
            local msg = "Premi [G] per accedere al ricettario"
            local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
        
            Citizen.InvokeNative(0xFA233F8FE190514C, str)
            Citizen.InvokeNative(0xE9990552DEC71600)

            if IsControlJustReleased(0, 0x760A9C6F) then 
                TriggerServerEvent('doctor:checkgroup')
            end
        end
    end

end)

RegisterNetEvent('doctor:openmenuclinica')
AddEventHandler('doctor:openmenuclinica', function() 
    print("dd")
    WarMenu.OpenMenu('medic')

    local playerPed = PlayerPedId()
    Citizen.Wait(0)
    --ClearPedTasksImmediately(PlayerPedId())
    WarMenu.OpenMenu('menu')
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_WRITE_NOTEBOOK'), -1, true, false, false, false) --WORLD_HUMAN_WRITE_NOTEBOOK

end)

Citizen.CreateThread(function() 
    WarMenu.CreateMenu('medic', "Medico")
    WarMenu.SetSubTitle('medic', 'Laboratorio')
    WarMenu.SetMenuY('medic', 0.2)
    WarMenu.SetMenuWidth('medic', 0.20)
    local selezionando = false
    while true do 
        Wait(0)
        if WarMenu.IsMenuOpened('medic') then 
            
            if WarMenu.Button("Prepara Tonico Vita") then 
                TriggerServerEvent('doctor:tonicovita')
            elseif WarMenu.Button("Prepara Tonico Vita+") then
                TriggerServerEvent('doctor:tonicovita1')
            elseif WarMenu.Button("Prepara Elysir Energia") then
                TriggerServerEvent('doctor:elysirenergia')
            elseif WarMenu.Button("Prepara Elysir Energia+") then
                TriggerServerEvent('doctor:elysirenergia1')
            elseif WarMenu.Button("Prepara Estratto di veleno") then
                TriggerServerEvent('doctor:estrattoveleno')
            elseif WarMenu.Button("Acquista siringhe") then
                local siringhe = tonumber(textEntry("Quante siringhe vuoi acquistare?"))
                TriggerServerEvent('doctor:buysiringhe', siringhe)
            end
            WarMenu.Display()
        end
    end
end)

Citizen.CreateThread(function()
    while true do
	local playerPed = PlayerPedId()
        Citizen.Wait(0)
		
        if whenKeyJustPressed(keys['BACKSPACE']) then
            if weapsmith ~= 0 then
            SetEntityAsMissionEntity(weapsmith)
            DeleteObject(weapsmith)
			ClearPedTasksImmediately(PlayerPedId())
            weapsmith = 0
            end
     end
	end
end)

--PROGRESS BAR--

RegisterNetEvent('progressbar:startMedico')
AddEventHandler('progressbar:startMedico', function()

    local playerPed = PlayerPedId()
    --TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
    exports['progressBars']:startUI(20000, "Preparando...")
    animazionemedicine()
    Citizen.Wait(20000)
    ClearPedTasksImmediately(PlayerPedId())

end)

----FINE MENU CLINICA DI VALENTINE----

function DrawTxt(str, x, y, size, enableShadow, r, g, b, a, centre, font)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(1, size)
    SetTextColor(math.floor(r), math.floor(g), math.floor(b), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    SetTextFontForCurrentCommand(font)
    DisplayText(str, x, y)
end

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

--ANIMAZIONE PROGRESSBAR
function animazionemedicine()
    
    RequestAnimDict("amb_work@world_human_mortar_pestle@female_b@wip_base")

    while not HasAnimDictLoaded("amb_work@world_human_mortar_pestle@female_b@wip_base") do
        Citizen.Wait(1)
		RequestAnimDict("amb_work@world_human_mortar_pestle@female_b@wip_base")
    end
	
    TaskPlayAnim(PlayerPedId(), "amb_work@world_human_mortar_pestle@female_b@wip_base", "wip_base", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
    
    Wait(20000)
	
	ClearPedTasks(PlayerPedId())
end
