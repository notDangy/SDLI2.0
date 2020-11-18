local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }


--menu

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
    if (Vdist(coords.x, coords.y, coords.z, -1108.4, -2137.4, 60.4) < 1.0) then  --YOUR CHORDS FOR MENU HERE
            DrawTxt("Premi [~e~G~q~] per accedere al mercato nero.", 0.50, 0.85, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustReleased(0, 0x760A9C6F) then -- g
                TriggerEvent("mercatonero:open")
            end
        end
    end
end)


Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('menu', "Mercato Nero")
    WarMenu.SetSubTitle('menu', 'Tutto a 1 euro!!!')
	
    WarMenu.CreateSubMenu('men1', 'menu', 'Armi Vip')
    WarMenu.CreateSubMenu('men2', 'menu', 'Armi Illegali')
    WarMenu.CreateSubMenu('men3', 'menu', 'Item Vari')
    WarMenu.CreateSubMenu('men4', 'menu', 'Armi Legali')
    WarMenu.CreateSubMenu('men5', 'menu', 'Spawn di Soldi')

    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('menu') then            
		
		if WarMenu.MenuButton('Armi Vip', 'men1') then
            end
		if WarMenu.MenuButton('Armi Illegali', 'men2') then
            end	
        if WarMenu.MenuButton('Item Vari', 'men3') then
            end	
        if WarMenu.MenuButton('Armi Legali', 'men4') then
            end	
        if WarMenu.MenuButton('Spawn di Soldi', 'men5') then
            end	

            WarMenu.Display()

        
        elseif WarMenu.IsMenuOpened('men1') then  

            WarMenu.Display()

        if WarMenu.Button('Coltello Mandibola (Jawbone)') then
		
        TriggerServerEvent("mn_jawbone")
        
        elseif WarMenu.Button('Arco Migliorato (Improved)') then
		
        TriggerServerEvent("mn_improved")
			
		elseif WarMenu.Button('Revolver Cattleman di Flaco (Mexican)') then
		
        TriggerServerEvent("mn_revmex")
            
        elseif WarMenu.Button('Revolver a doppia azione Azzardo (Gambler)') then
            
        TriggerServerEvent("mn_revgamb")

        elseif WarMenu.Button('Revolver Navy') then
            
        TriggerServerEvent("mn_revnavy")

        elseif WarMenu.Button('Doppietta esotica') then
            
        TriggerServerEvent("mn_doppeso")

            end

           
			
        elseif WarMenu.IsMenuOpened('men2') then    
            
            WarMenu.Display()
		
        if WarMenu.Button('Fucile Carcano') then
            
		TriggerServerEvent("mn_carc")
        
        elseif WarMenu.Button('Fucile Rolling Block') then
            
        TriggerServerEvent("mn_roll")

        elseif WarMenu.Button('Fucile Sprinfield') then

        TriggerServerEvent("mn_spring")
        
        elseif WarMenu.Button('Fucile a Pompa') then
            
        TriggerServerEvent("mn_shot")
        
        elseif WarMenu.Button('Fucile a Ripetizione') then
            
        TriggerServerEvent("mn_repshot")
        
        elseif WarMenu.Button('Fucile Semi-Auto') then
            
        TriggerServerEvent("mn_semiautoshot")

        elseif WarMenu.Button('Dinamite') then
            
        TriggerServerEvent("mn_dinamite")

        elseif WarMenu.Button('Molotov') then
            
        TriggerServerEvent("mn_molotov")
        
            end

           
           


        elseif WarMenu.IsMenuOpened('men3') then

            WarMenu.Display()
            
        elseif WarMenu.Button('Compra Grimaldello') then
                
        TriggerServerEvent("mn_grimaldello")
        
        elseif WarMenu.Button('Compra Semi di Mais [x10]') then
                
        TriggerServerEvent("mn_cornseed")
		
        elseif WarMenu.Button('Vendi Lingotti - xxx$') then
            
        TriggerServerEvent("mn_")
        
        elseif WarMenu.Button('Vendi Obbligazioni - xxx$') then
        
		TriggerServerEvent("mn_")
        
        elseif WarMenu.Button('Vendi Moonshine Original - xxx$') then
        
        TriggerServerEvent("mn_")
        
        elseif WarMenu.Button('Vendi Moonshine Red - xxx$') then
            
        TriggerServerEvent("mn_")
        
        elseif WarMenu.Button('Vendi Moonshine BlueFlame - xxx$') then
            
        TriggerServerEvent("mn_")
        		
            end

          
            
        end

        elseif WarMenu.IsMenuOpened('men4') then
        
            WarMenu.Display()

        if WarMenu.Button('Revolver Cattleman') then
            
		TriggerServerEvent("mn_cattleman")
        
        elseif WarMenu.Button('Revolver Lemat') then
            
        TriggerServerEvent("mn_lemat")

        elseif WarMenu.Button('Revolver Schofield') then
            
        TriggerServerEvent("mn_schofield")

        elseif WarMenu.Button('Pistola M1899') then
            
        TriggerServerEvent("mn_m1899")

        elseif WarMenu.Button('Pistola Semi-Automatica') then
            
        TriggerServerEvent("mn_semiautomatica")

        elseif WarMenu.Button('Pistola Volcanic') then
            
        TriggerServerEvent("mn_volcanic")

        elseif WarMenu.Button('Doppietta') then
            
        TriggerServerEvent("mn_doppietta")

        elseif WarMenu.Button('Ripetitore Henry') then
            
        TriggerServerEvent("mn_henry")

        elseif WarMenu.Button('Carabina a Ripetizione') then
            
        TriggerServerEvent("mn_carabina")

        elseif WarMenu.Button('Ripetitore Winchester') then
            
        TriggerServerEvent("mn_winchester")

        elseif WarMenu.Button('Fucile Bolt Action') then
            
        TriggerServerEvent("mn_boltaction")
        
            

            end
        
			
        elseif WarMenu.IsMenuOpened('men5') then            
        
            WarMenu.Display()

        if WarMenu.Button('1000 $') then
            
		TriggerServerEvent("mn_1k")
        
        elseif WarMenu.Button('10,000 $') then
            
        TriggerServerEvent("mn_10k")

        elseif WarMenu.Button('100,000 $') then

        TriggerServerEvent("mn_100k")
        
        elseif WarMenu.Button('1,000,000 $') then

        TriggerServerEvent("mn_1kk")
        

        end  
			

       -- elseif whenKeyJustPressed(keys["J"]) then 
         --   WarMenu.OpenMenu('menu')
         end
		
	
        Citizen.Wait(0)
    end
end)

--RegisterCommand("opentestmenu", function(source, args, rawCommand) -- slash COMMAND
AddEventHandler('mercatonero:open', function()
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

RegisterNetEvent('progressbar:start')
AddEventHandler('progressbar:start', function()

    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 27000, true, false, false, false)
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


