local mining = false

-------------------------------- RACCOLTA ------------------------------
------ BLIP IN MAPPA ------

Citizen.CreateThread(function()
    local blip = N_0x554d9d53f696d002(1664425300, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z)
    SetBlipSprite(blip, 1220803671, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Miniera") 
end)
----- LAVORO ---------
----- BLIP 1 ---------
RegisterNetEvent("minatore:updatejob")
AddEventHandler("minatore:updatejob", function()
    mining = true 
    animazione()
    TriggerServerEvent("vorp:itemreward")
    TriggerEvent('dangy_stress:modify', 1)
    mining = false
end)
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
            Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, Config.Zonas['Miniera1'].x, Config.Zonas['Miniera1'].y, Config.Zonas['Miniera1'].z - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miniera1'].x, Config.Zonas['Miniera1'].y, Config.Zonas['Miniera1'].z) < 2.0) and not mining then
                DrawText3D(Config.Zonas['Miniera1'].x, Config.Zonas['Miniera1'].y, Config.Zonas['Miniera1'].z, Language.translate[Config.lang]['premi'])
              -- DrawTxt(Language.translate[Config.lang]['premi'], 0.4, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    TriggerServerEvent("minatore:checkjob")
                end
            end
       
            end
end)
--- BLIP 2 ----------
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
            Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, Config.Zonas['Miniera2'].x, Config.Zonas['Miniera2'].y, Config.Zonas['Miniera2'].z - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miniera2'].x, Config.Zonas['Miniera2'].y, Config.Zonas['Miniera2'].z) < 2.0) and not mining then
                --DrawTxt(Language.translate[Config.lang]['premi'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
                DrawText3D(Config.Zonas['Miniera2'].x, Config.Zonas['Miniera2'].y, Config.Zonas['Miniera2'].z, Language.translate[Config.lang]['premi'])
               -- DrawTxt(Language.translate[Config.lang]['premi'], 0.5, 0.95, 0.7, 0.7, true, 255, 255, 255, 255, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    TriggerServerEvent("minatore:checkjob")
                end
            end
       
            end
end)
--- BLIP 3 ----------
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
            Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, Config.Zonas['Miniera3'].x, Config.Zonas['Miniera3'].y, Config.Zonas['Miniera3'].z - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miniera3'].x, Config.Zonas['Miniera3'].y, Config.Zonas['Miniera3'].z) < 2.0) and not mining then
              -- DrawTxt(Language.translate[Config.lang]['premi'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
              DrawText3D(Config.Zonas['Miniera3'].x, Config.Zonas['Miniera3'].y, Config.Zonas['Miniera3'].z, Language.translate[Config.lang]['premi'])
              -- DrawTxt(Language.translate[Config.lang]['premi'], 0.5, 0.95, 0.7, 0.7, true, 255, 255, 255, 255, false)
                if IsControlJustPressed(0, 0xC7B5340A) then
                    TriggerServerEvent("minatore:checkjob")
                end
            end
       
            end
end)

---- FUNZIONI ----
function animazione()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PICKAXE_WALL'), 20000, true, false, false, false)
    exports['progressBars']:startUI(20000, Language.translate[Config.lang]['mining'])
    Wait(20000)
    ClearPedTasks(PlayerPedId())
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)


    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end
----------------------------------- PROCESSO ----------------------------------------------
Citizen.CreateThread(function()
    WarMenu.CreateMenu('perso', 'Processo Minerali')
	WarMenu.CreateSubMenu('pp', 'perso', 'Processo Pietra')
	WarMenu.CreateSubMenu('pf', 'perso', 'Processo Ferro')
	 while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
-- Open
     if WarMenu.IsMenuOpened('perso') then
--	1 layer
		if WarMenu.MenuButton('Processa la Pietra Sedimentaria', 'pp') then
		end
		if WarMenu.MenuButton('Processa la Magnetite e la Grafite', 'pf') then
		end
		if WarMenu.Button('Chiudi') then
			Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, false)
			WarMenu.CloseMenu()
		end	
--	1.1 layer	
		WarMenu.Display()
		elseif WarMenu.IsMenuOpened('pp') then
			if WarMenu.Button('Processa') then
				TriggerServerEvent('vane_processa:pietra')
				animacion()
			end
			if WarMenu.Button('Indietro') then
				WarMenu.CloseMenu()
				WarMenu.OpenMenu('perso')
			end	
			if WarMenu.Button('Chiudi') then
				Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, false)
				WarMenu.CloseMenu()
			end	
--- 1.2 layer			
				WarMenu.Display()
		elseif WarMenu.IsMenuOpened('pf') then
			if WarMenu.Button('Processa') then
				TriggerServerEvent('vane_processa:ferro')
				animacion()
			end
			if WarMenu.Button('Indietro') then
				WarMenu.CloseMenu()
				WarMenu.OpenMenu('perso')
			end	
			if WarMenu.Button('Chiudi') then
				Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, false)
				WarMenu.CloseMenu()
			end	
-- 1.3 layer		
		WarMenu.Display()
		elseif WarMenu.IsMenuOpened('pd') then
			if WarMenu.Button('Processa') then
				TriggerServerEvent('vane_processa:diamante')
				animacion()
			end
			if WarMenu.Button('Indietro') then
				WarMenu.CloseMenu()
				WarMenu.OpenMenu('perso')
			end	
			if WarMenu.Button('Chiudi') then
				Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, false)
				WarMenu.CloseMenu()
			end
-- blip		
			WarMenu.Display()
			elseif (Vdist(coords.x, coords.y, coords.z, 2950.5, 1378.9, 56.3) < 1.0) then 
               TriggerEvent("enter:processominerali")
               if whenKeyJustPressed(key) and not WarMenu.IsMenuOpened('perso') then
			        TriggerEvent('vane_miniera:open')
               end 
		
		end
		Citizen.Wait(0)
		
	end	
end)

RegisterNetEvent("enter:processominerali")
  AddEventHandler("enter:processominerali", function()
    SetTextScale(0.5, 0.5)
    --SetTextFontForCurrentCommand(1)
    local msg = 'Premi [G] per lavorare'
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
  end)

  RegisterNetEvent('vane_miniera:open')
AddEventHandler('vane_miniera:open', function(cb)

	WarMenu.OpenMenu('perso')
end)
	
function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, 0x760A9C6F) then
        return true
    else
        return false
    end
end
---- FUNZIONI ----
function animacion()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), 7000, true, false, false, false) 
    exports['progressBars']:startUI(7000, "Processando...")
    Wait(7000)
    ClearPedTasksImmediately(PlayerPedId())
end

------ BLIP IN MAPPA ------

Citizen.CreateThread(function()
    local blip = N_0x554d9d53f696d002(1664425300, 2950.5, 1378.9, 56.3)
    SetBlipSprite(blip, 2107754879, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Processo Minatore") 
end)

---PROCESSO MINERALI ARMAIOLO---

Citizen.CreateThread(function()
    while true do
        Wait(0)
        Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, 2951.1, 1316.2, 44.8 - 1.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.5, 255, 23, 23, 155, 0, 0, 2, 0, 0, 0, 0)
        local pos = GetEntityCoords(PlayerPedId())
        if (Vdist(pos.x, pos.y, pos.z, 2951.1, 1316.2, 44.8) < 1.0) then
            DrawTxt("Premi [INVIO] per aprire il processo miniera", 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
            if IsControlJustReleased(0, 0xC7B5340A) then
                Wait(50)
                TriggerServerEvent('weaponsmith:checkp2')
                
            end
        end
    end
end)


RegisterNetEvent('weaponsmith:openp2')
AddEventHandler('weaponsmith:openp2', function() 
    WarMenu.OpenMenu('processom')
end)

Citizen.CreateThread(function() 

    WarMenu.CreateMenu("processom", "Processo Miniera")
    
    while true do
        Wait(0)
        if WarMenu.IsMenuOpened('processom') then

            if WarMenu.Button("Crea corpo fucile") then

                TriggerServerEvent('miniera:processoarmaiolo', 8, 15, "corpofucile")

            elseif WarMenu.Button("Crea corpo pistola") then

                TriggerServerEvent('miniera:processoarmaiolo', 5, 10, "corpopistola")


            elseif WarMenu.Button("Crea canna fucile") then

                TriggerServerEvent('miniera:processoarmaiolo', 15, 5, "cannafucile")


            elseif WarMenu.Button("Crea canna pistola") then 

                TriggerServerEvent('miniera:processoarmaiolo', 10, 5, "cannapistola")

                
            elseif WarMenu.Button("Chiudi") then
                WarMenu.CloseMenu()
            end
            WarMenu.Display()
        end
    end

end)

RegisterNetEvent('miniera:animazionep')
AddEventHandler('miniera:animazionep', function() 
    animacion3()
end)

function animacion3()
    RequestAnimDict("amb_work@world_human_wood_plane@working@male_a@base")
    while not HasAnimDictLoaded("amb_work@world_human_wood_plane@working@male_a@base") do
        Citizen.Wait(1)
		RequestAnimDict("amb_work@world_human_wood_plane@working@male_a@base")
    end
	while not HasModelLoaded("p_woodplane01x") do
	   RequestModel("p_woodplane01x")
	   Citizen.Wait(1)
	end
    TaskPlayAnim(PlayerPedId(), "amb_work@world_human_wood_plane@working@male_a@base", "base", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
	local object = CreateObject("p_woodplane01x", x, y, z, true, true, true)
	AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 1, 0, 0, 1)
	--TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), 7000, true, false, false, false)
    exports['progressBars']:startUI(10000, 'Processando...')
    Wait(10000)
	DeleteObject(object)
	ClearPedTasks(PlayerPedId())
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
    --DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end