local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28,  ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }--['G'] = 0x5415BE48,


--menu

-- Citizen.CreateThread(function()
	-- while true do
		-- Citizen.Wait(1)
        -- local coords = GetEntityCoords(PlayerPedId())
    -- if (Vdist(coords.x, coords.y, coords.z, 2789.64, -1265.07, 49.79) < 2.0) then  --YOUR CHORDS FOR MENU HERE
            -- DrawTxt("Premi [~e~G~q~] per aprire l'armaiolo.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            -- if IsControlJustReleased(0, 0x760A9C6F) then -- g
                -- TriggerEvent("weaponsmith:check")
                -- print('openedwarmenu')

            -- end
        -- end
    -- end
-- end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, -277.2, 779.3, 119.5) < 2.0) then
            DrawTxt("Premi [~e~G~q~] per aprire l'armaiolo.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                TriggerServerEvent("weaponsmith:check")

            end
        end
    end
end)



Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('menu', "Armaiolo")
    WarMenu.SetSubTitle('menu', 'Costruisci Armi')
	
    --WarMenu.CreateSubMenu('hgmake', 'menu', 'Armi Corpo a Corpo')
	WarMenu.CreateSubMenu('hgmake2', 'menu', 'Revolver')
    WarMenu.CreateSubMenu('hgmake3', 'menu', 'Pistole')
    WarMenu.CreateSubMenu('hgmake4', 'menu', 'Fucili a Pompa')
    WarMenu.CreateSubMenu('hgmake5', 'menu', 'Fucili')


    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('menu') then
		
	--	if WarMenu.MenuButton('Armi Corpo a Corpo', 'hgmake') then
       --     end
		if WarMenu.MenuButton('Revolver', 'hgmake2') then
            end	
		if WarMenu.MenuButton('Pistole', 'hgmake3') then
            end
        if WarMenu.MenuButton('Fucili a Pompa', 'hgmake4') then
            end	
        if WarMenu.MenuButton('Fucili', 'hgmake5') then
            end

            WarMenu.Display()
     --   elseif WarMenu.IsMenuOpened('hgmake') then

       -- if WarMenu.Button('Make') then
		
	--	    TriggerServerEvent("wc_")
			
		--elseif WarMenu.Button('Make') then
		
        --    TriggerServerEvent("wc_")
        
      --  elseif WarMenu.Button('Make') then
		
           -- TriggerServerEvent("wc_")
        --end

        --WarMenu.Display()
			
	elseif WarMenu.IsMenuOpened('hgmake2') then
		
        if WarMenu.Button('Costruisci Revolver Cattleman') then
		
            TriggerServerEvent("wc_cattlemanmake")
                
        elseif WarMenu.Button('Costruisci Revolver Lemat') then
            
            TriggerServerEvent("wc_lematmake")
            
        elseif WarMenu.Button('Costruisci Revolver Schofield') then
            
            TriggerServerEvent("wc_schofieldmake")
		end

        WarMenu.Display()
			
	elseif WarMenu.IsMenuOpened('hgmake3') then
        
        if WarMenu.Button('Costruisci Pistola M1899') then
		
            TriggerServerEvent("wc_m1899make")
        
        elseif WarMenu.Button('Costruisci Pistola Semi-Auto') then
		
            TriggerServerEvent("wc_semiautomake")
        
        elseif WarMenu.Button('Costruisci Pistola Volcanic') then
		
		    TriggerServerEvent("wc_volcanicmake")
        end

        WarMenu.Display()

    elseif WarMenu.IsMenuOpened('hgmake4') then

        if WarMenu.Button('Costruisci Doppietta') then
            TriggerServerEvent("wc_doublebarrelmake")
        end

        WarMenu.Display()

    elseif WarMenu.IsMenuOpened('hgmake5') then

        if WarMenu.Button('Costruisci Ripetitore Henry') then
            
            TriggerServerEvent("wc_henrymake")

        elseif WarMenu.Button('Costruisci Carabina a Ripetizione') then
            TriggerServerEvent("wc_carabinemake")

        elseif WarMenu.Button('Costruisci Winchester') then
            TriggerServerEvent("wc_winchestermake")

        elseif WarMenu.Button('Costruisci Bolt Action') then
            TriggerServerEvent("wc_boltmake")
        end

        WarMenu.Display()

       
        end
		Citizen.Wait(0)
    end
end)

--RegisterCommand("opentestmenu", function(source, args, rawCommand) -- slash COMMAND
RegisterNetEvent('weaponsmith:open')
AddEventHandler('weaponsmith:open', function()
    local _source = source
            if weapsmith ~= 0 then
                SetEntityAsMissionEntity(weapsmith)
                DeleteObject(weapsmith)
                weapsmith = 0
            end
                local playerPed = PlayerPedId()
                Citizen.Wait(0)
                --ClearPedTasksImmediately(PlayerPedId())
                WarMenu.OpenMenu('menu')
                TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_WRITE_NOTEBOOK'), -1, true, false, false, false) --WORLD_HUMAN_WRITE_NOTEBOOK
           
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

RegisterNetEvent('progressbar:start')
AddEventHandler('progressbar:start', function()

    local playerPed = PlayerPedId()
    --TaskStartScenarioInPlace(playerPed, GetHashKey('PROP_HUMAN_SEAT_BENCH_FIDDLE'), 27000, true, false, false, false) --WORLD_HUMAN_HAMMER_TABLE, WORLD_HUMAN_CROUCH_INSPECT
    --TaskPlayAnim(PlayerPedId(), "amb_camp@prop_camp_micah_seat_chair@clean_gun@male_a@base", "base", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
    exports['progressBars']:startUI(20000, "Costruendo...")
    animazioneconprop()
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



function animazioneconprop()
    RequestAnimDict("amb_camp@prop_camp_micah_seat_chair@clean_gun@male_a@base")
    while not HasAnimDictLoaded("amb_camp@prop_camp_micah_seat_chair@clean_gun@male_a@base") do
        Citizen.Wait(1)
		RequestAnimDict("amb_camp@prop_camp_micah_seat_chair@clean_gun@male_a@base")
    end
	while not HasModelLoaded("W_REVOLVER_CATTLEMAN02") do
	   RequestModel("W_REVOLVER_CATTLEMAN02")
	   Citizen.Wait(1)
	end
    TaskPlayAnim(PlayerPedId(), "amb_camp@prop_camp_micah_seat_chair@clean_gun@male_a@base", "base", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
	local object = CreateObject("W_REVOLVER_CATTLEMAN02", x, y, z, true, true, true)
	AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 1, 0, 0, 1)
	--TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), 7000, true, false, false, false)
    Wait(20000)
	DeleteObject(object)
	ClearPedTasks(PlayerPedId())
end


