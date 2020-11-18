local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }

--BLIP
local blips = {
	{ name = 'Bordello Bastille', sprite = -2030232380, x = 2634.2, y = -1224.9, z = 53.4 }
}

Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)

--menu

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, -1866.8, -1726.4, 86.1) < 1.0) then  --YOUR CHORDS FOR MENU HERE
            DrawTxt("Premi [~e~G~q~] per accedere al Bar del Bordello.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                --TriggerEvent("saloon:open")
                TriggerServerEvent('bordello:checkgroup')
            end
        end
    end
end)

RegisterNetEvent('bordello:checkgroupcl')
AddEventHandler('bordello:checkgroupcl', function() 
    TriggerEvent("bordello:open")
end)


Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('menu', "Bar Bordello")
    WarMenu.SetSubTitle('menu', 'Ricette')
	
    WarMenu.CreateSubMenu('hgmake', 'menu', 'Bevande')
	WarMenu.CreateSubMenu('hgmake2', 'menu', 'Cibi')


    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('menu') then

            
            if WarMenu.MenuButton('Bevande', 'hgmake') then end
            if WarMenu.MenuButton('Cibi', 'hgmake2') then end	

            WarMenu.Display()

        
        elseif WarMenu.IsMenuOpened('hgmake') then

            if WarMenu.Button('Daiquiri') then
		
		        TriggerServerEvent("bd_daiquiri")            

		    elseif WarMenu.Button('Old Fashioned') then
		
                TriggerServerEvent("bd_old")
            
            elseif WarMenu.Button('Planter\'s Punch') then
            
                TriggerServerEvent("bd_planter")
    
            elseif WarMenu.Button('Vodka Martini') then
        
                TriggerServerEvent("bd_vodkam")

            elseif WarMenu.Button('Mojito') then

                TriggerServerEvent('bd_mojito')

            end
            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('hgmake2') then
            
            if WarMenu.Button('Attualmente non ci sono cibi nel menú') then
                
                TriggerServerEvent("bd_")
            end

		    WarMenu.Display()
        end
		
	
        Citizen.Wait(0)
    end
end)

--RegisterCommand("opentestmenu", function(source, args, rawCommand) -- slash COMMAND
AddEventHandler('bordello:open', function()
    local _source = source
        local playerPed = PlayerPedId()
            Citizen.Wait(0)
                --ClearPedTasksImmediately(PlayerPedId())
                WarMenu.OpenMenu('menu')
                --TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_WRITE_NOTEBOOK'), -1, true, false, false, false)
                animazionemenu()
           
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
                --local prop = CreateObject(GetHashKey("p_cs_note01x"), x, y, z, true, false, true)
                
    
    --end, false)
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


--- Settings ProgressBars ---

--- Flesh --- 

RegisterNetEvent('progressbar:startBordello')
AddEventHandler('progressbar:startBordello', function()

    local playerPed = PlayerPedId()
    --TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CANNED_FOOD_COOKING'), -1, true, false, false, false)
    exports['progressBars']:startUI(15000, "Preparando...")
    animazionecucina()
    Citizen.Wait(15000)
    ClearPedTasksImmediately(PlayerPedId())

end)


function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

--[[RegisterNetEvent("crafting:time")
AddEventHandler("crafting:time", function()

    local playerPed = PlayerPedId()
    exports['progressBars']:startUI(27000, "Crafting...")


end)--]]

RegisterNetEvent("wc_craftitem:prompt")
AddEventHandler("wc_craftitem:prompt", function(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
   SetTextScale(w, h)
   SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
   SetTextCentre(centre)
   if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
   Citizen.InvokeNative(0xADA9255D, 10);
   DisplayText(str, x, y)
end

function animazionemenu()
    
    RequestAnimDict("amb_camp@prop_camp_foodprep@resting@male_b@idle_d")

    while not HasAnimDictLoaded("amb_camp@prop_camp_foodprep@resting@male_b@idle_d") do
        Citizen.Wait(1)
		RequestAnimDict("amb_camp@prop_camp_foodprep@resting@male_b@idle_d")
    end
	
    TaskPlayAnim(PlayerPedId(), "amb_camp@prop_camp_foodprep@resting@male_b@idle_d", "idle_l", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
    
    Wait(15000)
	
	ClearPedTasks(PlayerPedId())
end

function animazionecucina()
    
    RequestAnimDict("amb_camp@prop_camp_foodprep@working@seasoning@male_b@idle_c")

    while not HasAnimDictLoaded("amb_camp@prop_camp_foodprep@working@seasoning@male_b@idle_c") do
        Citizen.Wait(1)
		RequestAnimDict("amb_camp@prop_camp_foodprep@working@seasoning@male_b@idle_c")
    end
	
    TaskPlayAnim(PlayerPedId(), "amb_camp@prop_camp_foodprep@working@seasoning@male_b@idle_c", "idle_h", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
    
    Wait(15000)
	
	ClearPedTasks(PlayerPedId())
end


