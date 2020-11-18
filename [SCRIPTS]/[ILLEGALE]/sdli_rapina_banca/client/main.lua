StartRobbing = {}
local robbing = false

RegisterNetEvent("policenotification")
AddEventHandler("policenotification", function(coords, bank)
	TriggerEvent("vorp:TipBottom", 'Telegramma dalla Banca di '..getNearestBank(coords)..': RAPINA IN CORSO', 5000)
	local blip = Citizen.InvokeNative(0x45f13b7e0a15c880, -1282792512, coords.x, coords.y, coords.z, 50.0)
	Wait(60000)--Timer del blip per gli sceriffi
	RemoveBlip(blip)
end)

function getNearestBank(coords) 
	local pos = GetEntityCoords(PlayerPedId())
	local closestDistance, closestBank = -1,""
	for k,v in pairs(Config.Locations) do 
		local distance = GetDistanceBetweenCoords(coords.x,coords.y,coords.z,pos.x,pos.y,pos.z,true)
		if closestDistance == 1 or distance <= closestDistance then 
			closestDistance = distance
			closestBank = v.bank
		end
	end
	return closestBank
end

RegisterNetEvent('StartRobbing')
AddEventHandler('StartRobbing', function()	
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
		if robbing == false then
			
            TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), -1, true, false, false, false)
			robbing = true
			TriggerServerEvent("policenotify", GetPlayers(), coords)
		   	exports['progressBars']:startUI(180000, "Prendendo i soldi...")
            Citizen.Wait(180000)
			ClearPedSecondaryTask(PlayerPedId())
			robbing = false
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent("mlpayout")

		end
end)


function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

-- bank 1
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		for k,v in pairs(Config.Locations) do 
			local betweencoords = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) --val
			if betweencoords < 2.0 then
				DrawTxt(Config.Robbank1, 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
				if IsControlJustReleased(0, 0xC7B5340A) then
				TriggerServerEvent("lockpick", function()  --check/del lockpick	
			end)
		end
-----SPAWN NPC	
		-- local arma = "WEAPON_RIFLE_VARMINT"
		-- local police ="U_M_M_RhdSheriff_01"	
		
		-- if not HasModelLoaded(police) then 
			-- RequestModel(police) 
		-- end
	
		-- while not HasModelLoaded(police) do 
			-- Citizen.Wait(1) 
		-- end
		-- NPC = CreatePed(police,-307.27,782.3,118.75,184.12,true,true,true,true)
		-- NPC2 = CreatePed(police,-308.96,782.4,118.76,187.99,true,true,true,true)
		-- NPC3 = CreatePed(police,-310.82,792.15,117.75,194.53,true,true,true,true)
		-- Citizen.InvokeNative(0x283978A15512B2FE,NPC, true)
		-- Citizen.InvokeNative(0x283978A15512B2FE,NPC2, true)
		-- Citizen.InvokeNative(0x283978A15512B2FE,NPC3, true)
		-- GiveWeaponToPed_2(NPC, arma, 20, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
		-- SetCurrentPedWeapon(NPC, arma, true)
		-- GiveWeaponToPed_2(NPC2, arma, 20, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
		-- SetCurrentPedWeapon(NPC2, arma, true)
		-- GiveWeaponToPed_2(NPC3, arma, 20, true, true, 1, false, 0.5, 1.0, 1.0, true, 0, 0)
		-- SetCurrentPedWeapon(NPC3, arma, true)
		-- TaskCombatPed(NPC,PlayerPedId())
		-- TaskCombatPed(NPC2,PlayerPedId())
		-- TaskCombatPed(NPC3,PlayerPedId())	

	
-------					
			end
		end
	end
end)

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, GetPlayerServerId(i))
        end
    end

    return players
end

RegisterNetEvent("rapine:sendPlayersToserver")
AddEventHandler("rapine:sendPlayersToserver", function() 
	TriggerServerEvent("rapine:countsceriffi", GetPlayers())
end)

