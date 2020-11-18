local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9,["BACKSPACE"] = 0x156F7119 }

-------------------------------------------
----- CREAZIONE COMANDO E CHECK GROUP -----
-------------------------------------------

RegisterCommand('ped', function(source, args, rawCommand)
    TriggerServerEvent('admincheck1')
    end)

RegisterCommand('changeped', function (source, args, rawCommand)
    TriggerServerEvent('admincheck2')
    end)

RegisterCommand('ped1', function (source, args, rawCommand)
    TriggerServerEvent('ped1check')
    end)

RegisterCommand('ped2', function (source, args, rawCommand)
    TriggerServerEvent('ped2check')
    end)

RegisterCommand('ped3', function (source, args, rawCommand)
    TriggerServerEvent('ped3check')
    end)

-------------------------
----- APERTURA MENÚ -----
-------------------------

    RegisterNetEvent("pedmenu")
    AddEventHandler("pedmenu", function()
    WarMenu.OpenMenu('menuped')
    end)

---------------------------
----- COMANDO DIRETTO -----
---------------------------

-- ADMIN
    RegisterNetEvent("cambioped")
        AddEventHandler("cambioped", function()
	TriggerEvent("vorpinputs:getInput", "ok", "Hash del ped", function(cb)
    	print(cb)
		Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel(cb)
        end)
    end)

-- ped1
    RegisterNetEvent("cambiopedped1")
        AddEventHandler("cambiopedped1", function()
    
            Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
            setModel("CS_ValProstitute_02")

    end)

-- ped2
    RegisterNetEvent("cambiopedped2")
        AddEventHandler("cambiopedped2", function()
    
            Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
            setModel("CS_Fire_Breather")

    end)

-- ped3
    RegisterNetEvent("cambiopedped3")
        AddEventHandler("cambiopedped3", function()
    
            Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
            setModel("CS_ValProstitute_01")

    end)


----------------
----- MENÚ -----
----------------

Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('menuped', "Menú cambio ped")
    WarMenu.SetSubTitle('menuped', 'Cambia la skin')
	
    WarMenu.CreateSubMenu('men1', 'menuped', 'barbonGino')
    WarMenu.CreateSubMenu('men2', 'menuped', 'Fragam3r')
    WarMenu.CreateSubMenu('men3', 'menuped', 'Jig')
    WarMenu.CreateSubMenu('men4', 'menuped', 'Tic')
    WarMenu.CreateSubMenu('men6', 'menuped', 'Diablo')
    WarMenu.CreateSubMenu('men7', 'menuped', 'Poliziotti')
    WarMenu.CreateSubMenu('men5', 'menuped', 'Animali')

    while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('menuped') then            
		
		if WarMenu.MenuButton('barbonGino', 'men1') then
            end
		if WarMenu.MenuButton('Fragam3r', 'men2') then
            end	
        if WarMenu.MenuButton('Jig', 'men3') then
            end	
        if WarMenu.MenuButton('Tic', 'men4') then
            end
        if WarMenu.MenuButton('Diablo', 'men6') then
            end	
        if WarMenu.MenuButton('Poliziotti', 'men7') then
            end
        if WarMenu.MenuButton('Animali', 'men5') then
            end
        if WarMenu.Button('MySkin')then
                TriggerEvent("vorpcharacter:refreshPlayerSkin")
            end	

            WarMenu.Display()

        
        elseif WarMenu.IsMenuOpened('men1') then  

        if WarMenu.Button('Governatore William Walker') then
		
        TriggerEvent("cs_gino1")
        
        elseif WarMenu.Button('Driscoll Brawler') then
		
        TriggerEvent("cs_gino2")

        elseif WarMenu.Button('Guidatore VIP') then
		
        TriggerEvent("cs_gino3")

        elseif WarMenu.Button('Figlio Diablo') then
		
        TriggerEvent("cs_gino4")

        elseif WarMenu.Button('Dipendente Banca') then
		
        TriggerEvent("cs_gino5")
			
            end

            WarMenu.Display()
			
        elseif WarMenu.IsMenuOpened('men2') then            
		
        if WarMenu.Button('Colm O Driscoll') then
            
		TriggerEvent("cs_fra1")
        
        elseif WarMenu.Button('mud2bigguy') then
            
        TriggerEvent("cs_fra2")

        elseif WarMenu.Button('Theodore Levin') then

        TriggerEvent("cs_fra3")
        
        elseif WarMenu.Button('Native Males') then
            
        TriggerEvent("cs_fra4")
        
            end

            WarMenu.Display()
           


        elseif WarMenu.IsMenuOpened('men3') then

            WarMenu.Display()

        
        if WarMenu.Button('Magnifico') then
                
        TriggerEvent("cs_jig1")
        
        elseif WarMenu.Button('Aron') then
                
        TriggerEvent("cs_jig2")
        		
            end
            
        elseif WarMenu.IsMenuOpened('men4') then

            WarMenu.Display()

            if WarMenu.Button('Cinese') then
            
                TriggerEvent("cs_tic1")
                
            elseif WarMenu.Button('Jack') then
                    
                TriggerEvent("cs_tic2")

            elseif WarMenu.Button('Gianni Concheddu') then
                    
                TriggerEvent("cs_tic3")
        		
            end

        elseif WarMenu.IsMenuOpened('men6') then

            WarMenu.Display()

            if WarMenu.Button('Dondo') then
            
                TriggerEvent("cs_diablo1")
                
            elseif WarMenu.Button('Tasto vuoto') then
                    
                TriggerEvent("cs_diablo2")
        		
            end

        elseif WarMenu.IsMenuOpened('men7') then

            WarMenu.Display()

            if WarMenu.Button('U_M_M_SDPoliceChief_01') then
            
                TriggerEvent("cs_poliziotto1")
                
            elseif WarMenu.Button('U_M_M_SDBANKGUARD_01') then
                    
                TriggerEvent("cs_poliziotto2")

            elseif WarMenu.Button('U_M_M_EXECUTIONER_01') then
                    
                TriggerEvent("cs_poliziotto3")

            elseif WarMenu.Button('S_M_M_SkpGuard_01') then
                    
                TriggerEvent("cs_poliziotto4")

            elseif WarMenu.Button('S_M_M_DispatchPolice_01') then
                    
                TriggerEvent("cs_poliziotto5")

            elseif WarMenu.Button('S_M_M_AmbientSDPolice_01') then
                    
                TriggerEvent("cs_poliziotto6")
        		
            end
            
        elseif WarMenu.IsMenuOpened('men5') then

            WarMenu.Display()

            if WarMenu.Button('Cane 1') then
            
                TriggerEvent("cs_animale1")
                
            elseif WarMenu.Button('Cane 2') then
                    
                TriggerEvent("cs_animale2")
        
            elseif WarMenu.Button('Alligatore') then
        
                TriggerEvent("cs_animale3")
                
             elseif WarMenu.Button('Gatto') then
        
                TriggerEvent("cs_animale4")
        		
		    end
           			

       -- elseif whenKeyJustPressed(keys["J"]) then 
         --   WarMenu.OpenMenu('menu')
         end
		
	
        Citizen.Wait(0)
    end
end)

------------------
----- EVENTI -----
------------------

-- GINO

AddEventHandler('cs_gino1', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_IANGRAY")
    
end)

AddEventHandler('cs_gino2', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("U_M_M_ODriscollBrawler_01")
    
end)

AddEventHandler('cs_gino3', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("A_M_M_BiVFancyDRIVERS_01")
    
end)

AddEventHandler('cs_gino4', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_WapitiBoy")
    
end)

AddEventHandler('cs_gino5', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("S_M_M_BankClerk_01")
    
end)

-- FRAGAM3R

AddEventHandler('cs_fra1', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_ColmODriscoll")
    
end)

AddEventHandler('cs_fra2', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_mud2bigguy")
    
end)

AddEventHandler('cs_fra3', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_theodorelevin")
    
end)

AddEventHandler('cs_fra4', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("MSP_NATIVE1_MALES_01")
    
end)

-- JIG

AddEventHandler('cs_jig1', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_Magnifico")
    
end)

AddEventHandler('cs_jig2', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_AberdeenPigFarmer")
    
end)



-- TIC

AddEventHandler('cs_tic1', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("A_M_O_SDChinatown_01")
    
end)

AddEventHandler('cs_tic2', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_jackmarston")
    
end)

AddEventHandler('cs_tic3', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_CAJUN")
    
end)

-- DIABLO

AddEventHandler('cs_diablo1', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("CS_SUNWORSHIPPER")
    
end)

-- POLIZIOTTI

AddEventHandler('cs_poliziotto1', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("U_M_M_SDPoliceChief_01")
    
end)

AddEventHandler('cs_poliziotto2', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("U_M_M_SDBANKGUARD_01")
    
end)

AddEventHandler('cs_poliziotto3', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("U_M_M_EXECUTIONER_01")
    
end)

AddEventHandler('cs_poliziotto4', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("S_M_M_SkpGuard_01")
    
end)

AddEventHandler('cs_poliziotto5', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("S_M_M_DispatchPolice_01")
    
end)

AddEventHandler('cs_poliziotto6', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("S_M_M_AmbientSDPolice_01")
    
end)

-- ANIMALI

AddEventHandler('cs_animale1', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("A_C_DogAustralianSheperd_01")
    
end)

AddEventHandler('cs_animale2', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("A_C_DogAmericanFoxhound_01")
    
end)

AddEventHandler('cs_animale3', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("A_C_Alligator_01")
    
end)

AddEventHandler('cs_animale4', function()

    Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel("A_C_Cat_01")
    
end)




























--------------------------------
----- FUNZIONE CAMBIO SKIN -----
--------------------------------

function setModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then return end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		-- SetPlayerModel(player, model, false)
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end

function PerformRequest(hash)
    RequestModel(hash, 0) -- RequestModel
    local times = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do -- HasModelLoaded
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel
        times = times + 1
        Citizen.Wait(0)
        if times >= 100 then break end
    end
end


















































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


