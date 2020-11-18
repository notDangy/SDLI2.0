local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }


--menu

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, 465.4, 2249.8, 248.3) < 1.0) then  --YOUR CHORDS FOR MENU HERE
            DrawTxt("Premi [~e~G~q~] per iniziare a creare.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                --TriggerEvent("indiani:open")
                TriggerServerEvent('indiani:checkgroup')
            end
        end
    end
end)

RegisterNetEvent('indiani:checkgroupcl')
AddEventHandler('indiani:checkgroupcl', function() 
    TriggerEvent("indiani:open")
end)


Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('menu', "Wapiti")
    WarMenu.SetSubTitle('menu', 'Creazione')
	
    WarMenu.CreateSubMenu('hgmake', 'menu', 'Tonici')
    WarMenu.CreateSubMenu('hgmake2', 'menu', 'Frecce')
    
    WarMenu.SetMenuY('menu', 0.2)


    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('menu') then

           WarMenu.Display()

            if WarMenu.MenuButton('Tonici', 'hgmake') then
                end
            if WarMenu.MenuButton('Armi', 'hgmake2') then
                end	


        
        elseif WarMenu.IsMenuOpened('hgmake') then

            if WarMenu.Button('Estratto della terra') then
		
		        TriggerServerEvent("wc_tonico_aug")

            end

            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('hgmake2') then
            
            if WarMenu.Button('Arco e Frecce') then
                
		        TriggerServerEvent("wc_arcofreccebase")
		
            elseif WarMenu.Button('Arco e Frecce Avvelenate') then
            
		        TriggerServerEvent("wc_arcofrecceavvelenate")
        
            --elseif WarMenu.Button('Arco') then
            
                --TriggerServerEvent("wc_arco")
        
            elseif WarMenu.Button('Tomahawk') then
            
		        TriggerServerEvent("wc_tomahawk")
        
            end

            WarMenu.Display()
			

       -- elseif whenKeyJustPressed(keys["J"]) then 
         --   WarMenu.OpenMenu('menu')
        end
		
	
        Citizen.Wait(0)
    end
end)

--RegisterCommand("opentestmenu", function(source, args, rawCommand) -- slash COMMAND
AddEventHandler('indiani:open', function()
    local _source = source
            if weapsmith ~= 0 then
                SetEntityAsMissionEntity(weapsmith)
                DeleteObject(weapsmith)
                weapsmith = 0
                end
                local playerPed = PlayerPedId()
                Citizen.Wait(0)
                ClearPedTasksImmediately(PlayerPedId())
                
                WarMenu.OpenMenu('menu')
                TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_HAMMER_TABLE'), -1, true, false, false, false)
           
                local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
                --local prop = CreateObject(GetHashKey("p_cs_note01x"), x, y, z, true, false, true)
                SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
                PlaceObjectOnGroundProperly(prop)
                weapsmith = prop
    
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

RegisterNetEvent('progressbar:startIndiani')
AddEventHandler('progressbar:startIndiani', function()

    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_CAMP_SEAT_CHAIR_CRAFT_POISON_KNIVES'), 27000, true, false, false, false)
    exports['progressBars']:startUI(20000, "Preparando...")
    Citizen.Wait(20000)
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


