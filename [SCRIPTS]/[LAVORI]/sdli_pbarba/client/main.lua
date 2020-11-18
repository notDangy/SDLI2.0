--local pickerblips = {
    --{["CaveName"] = "SouthfieldFlats", x = 349.3, y = -1261.9, z = 44.0, ["HasRares"] = true}
--}


local spawnedPlants = 0
local Plants = {}
local InArea = false
local active = false
local entity
local HasRarePlants = false
local currentZoneProcess = nil

--Citizen.CreateThread(function()
    --while true do
        --Citizen.Wait(5000)
        --local ped = Ped()
        --local pos = GetEntityCoords(ped)
        --for k,v in pairs(pickerblips) do
            --if GetDistanceZTrue(pos,v) < 80.0 then
			--print("B")
                --InArea = true
                --SpawnPlanets()
                --HasRarePlants = v.HasRares
            --end
        --end
    --end
--end)

Citizen.CreateThread(function()
    for _, info in pairs(Config.ProcessLocations) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)

----check distance for both caves, if both false dont run thread & delete objects (Saves performance???), prolly a better way todo this but fuck it
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        local ped = Ped()
        local pos = GetEntityCoords(ped)
        if InArea then
            local SouthfieldFlats = {x = 349.3, y = -1261.9, z = 44.0}

            if GetDistanceZTrue(pos,SouthfieldFlats) > 100.0 then
                InArea = false
                for k, v in pairs(Plants) do
                    DeleteObject(v)
                end
                spawnedPlants = 0
            end
        end
    end
end)


---check distance from spawned Plant 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
        if InArea then
            local ped = Ped()
            local pos = GetEntityCoords(ped)
            local nearbyObject, nearbyID
            for i=1, #Plants, 1 do
                local EntCoords = GetEntityCoords(Plants[i])
                if GetDistanceZTrue(pos,EntCoords) < 3 then
                    nearbyObject, nearbyID = Plants[i], i
                    if nearbyObject then
                        DrawText3D(EntCoords.x, EntCoords.y, EntCoords.z, 'Premi [Freccia Destra] per raccogliere')
                        if whenKeyJustPressed("RIGHT") then
                            local W = math.random(8000,15000)
                            MineAndAttach()
                            Wait(100)
                            FreezeEntityPosition(ped,true)
                            Wait(W)
                            FreezeEntityPosition(ped,false)
                            DeleteObject(entity)
                            ClearPedTasks(ped)
                            SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
                            DeleteObject(nearbyObject)
                            table.remove(Plants, nearbyID)
                            spawnedPlants = spawnedPlants - 1
                            TriggerServerEvent("Picker:give", HasRarePlants)
                        end
                    end
                end
            end
        end
    end
end)

function SpawnPlanets()
    while spawnedPlants < 20 do
        local PlantCoords = GeneratePlantCoords()
        local obj = CreateObject(GetHashKey('crp_sugarcane_ac_sim'), PlantCoords.x, PlantCoords.y,PlantCoords.z, false, false, false)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        table.insert(Plants, obj)
        spawnedPlants = spawnedPlants + 1
	end
end


function GeneratePlantCoords()
	while true do
		Citizen.Wait(1)

		local PlantCoordX, PlantCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-40, 40)

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-40, 40)
        for k, v in pairs(pickerblips) do
            if GetDistance(GetEntityCoords(Ped()),v) < 80.0 then
                PlantCoordX = v.x + modX
                PlantCoordY = v.y + modY
            end
        end

		local coordZ = GetCoordZ(PlantCoordX, PlantCoordY)
		local coord = vector3(PlantCoordX, PlantCoordY, coordZ)

        --if ValidatePlantCoord(coord) then
			return coord
		--end
	end
end

--[[
function ValidatePlantCoord(PlantCoord)
	if spawnedPlants > 0 then
        local validate = true
        local outsideinterior = Citizen.InvokeNative(0xF291396B517E25B2,PlantCoord.x, PlantCoord.y, PlantCoord.z) --ISENTITYOUTSIDE

		for k, v in pairs(Plants) do
            if GetDistance(PlantCoord,GetEntityCoords(v)) < 5 then
				validate = false
            end
            if outsideinterior then
                validate = false
            end
        end

        for k,v in pairs(pickerblips) do
            if GetDistance(PlantCoord,v) > 50 then
                if not k then 
                    validate = false
                end
            end
        end

		return validate
	else
		return true
	end
end
]]
--function GetCoordZ(x, y)

    --for height = 1, 1000 do
		--local foundGround, groundZ = GetGroundZAndNormalFor_3dCoord(x, y, height+0.0)

		--if foundGround then
            --return groundZ
		--end
	--end
--end

function MineAndAttach()
    if not IsPedMale(Ped()) then
        local waiting = 0
        local dict = "amb_work@world_human_pickaxe@wall@male_d@base"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
                TriggerEvent("redemrp_notification:start", "Hai rotto l'animazione, Rilogga", 4, "warning")
                break
            end      
        end

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        --local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
        --local modelHash = GetHashKey("P_PICKAXE01X")
        LoadModel(modelHash)
        entity = CreateObject(modelHash, coords.x, coords.y,coords.z, true, false, false)
        SetEntityVisible(entity, true)
        SetEntityAlpha(entity, 255, false)
        Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
        SetModelAsNoLongerNeeded(modelHash)
        AttachEntityToEntity(entity,ped, boneIndex, -0.030, -0.300, -0.010, 0.0, 100.0, 68.0, false, false, false, true, 2, true)  ---6th rotates axe point
        TaskPlayAnim(ped, dict, "base", 1.0, 8.0, -1, 1, 0, false, false, false)
    else
        TaskStartScenarioInPlace(Ped(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 60000, true, false, false, false)
    end
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(Plants) do
			DeleteObject(v)
		end
	end
end)

--PROCESSO
local ShopPromptProcess
local hasAlreadyEnteredMarkerProcess, lastZoneProcess
local currentZoneProcess = nil

function SetupShopPromptProcess()
    Citizen.CreateThread(function()
        local str = Config.ProcessText
        ShopPromptProcess = PromptRegisterBegin()
        PromptSetControlAction(ShopPromptProcess, Config.PanControl)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ShopPromptProcess, str)
        PromptSetEnabled(ShopPromptProcess, false)
        PromptSetVisible(ShopPromptProcess, false)
        PromptSetHoldMode(ShopPromptProcess, true)
        PromptRegisterEnd(ShopPromptProcess)

    end)
end

AddEventHandler('sdli_pbarba:hasEnteredMarkerProcess', function(zone)
    currentZoneProcess = zone
end)

function exitZone()
    if active then
        PromptSetEnabled(ShopPromptProcess, false)
        PromptSetVisible(ShopPromptProcess, false)
        active = false
    end
	currentZoneProcess = nil
end

Citizen.CreateThread(function()
    SetupShopPromptProcess()
    while true do
        Wait(0)
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        local isInMarker, currentZoneProcess = false
        for k,v in pairs(Config.ProcessLocations) do
            if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.5) then
                isInMarker  = true
                currentZoneProcess = k
                lastZoneProcess    = k
            end
        end
		if isInMarker and not hasAlreadyEnteredMarkerProcess then
            hasAlreadyEnteredMarkerProcess = true
			TriggerEvent('sdli_pbarba:hasEnteredMarkerProcess', currentZoneProcess)
		end
        if not isInMarker and hasAlreadyEnteredMarkerProcess then
            hasAlreadyEnteredMarkerProcess = false
			exitZone()
		end
    end
end)

Citizen.CreateThread(function()
    
	while true do
        Wait(0)
        if currentZoneProcess then
            if not active then
                PromptSetEnabled(ShopPromptProcess, true)
                PromptSetVisible(ShopPromptProcess, true)
                active = true
            end
            if PromptHasHoldModeCompleted(ShopPromptProcess) then
                WarMenu.OpenMenu("canna_process")
                PromptSetEnabled(ShopPromptProcess, false)
                PromptSetVisible(ShopPromptProcess, false)
                active = false

				currentZoneProcess = false
			end
        else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function() 
	WarMenu.CreateMenu('canna_process', "Processo Zucchero")
	while true do
		if WarMenu.IsMenuOpened("canna_process") then
			if WarMenu.Button("Lavora zucchero") then
				TriggerServerEvent("sdli_pbarba:checkcannasv")
				WarMenu.CloseMenu()
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)

local hasCanna = false

RegisterNetEvent("sdli_pbarba:checkcanna")
AddEventHandler("sdli_pbarba:checkcanna", function(result) 
    hasCanna = result
	cannaProcessing()
end)

function cannaProcessing()
    Citizen.CreateThread(function()
		if hasCanna then
			TriggerServerEvent("sdli_pbarba:startProcessing")
			Citizen.Wait(30000)
		end
	end)
end

RegisterNetEvent('sdli_pbarba:processAnimation')
AddEventHandler('sdli_pbarba:processAnimation', function(canna)
	local location = Config.ProcessLocations[lastZoneProcess]
	local coords = GetEntityCoords(PlayerPedId())
	if location then
		if (Vdist(coords.x, coords.y, coords.z, location.x, location.y, location.z) < 1.5) then
            if canna and canna >= 2 then
                print()
                TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CANNED_FOOD_COOKING"), 30000, true, false, false, false)
                exports['progressBars']:startUI(30000, "Lavorazione in corso...")
			else
				hasCanna = nil
			end
		else
			TriggerEvent("sdli_pbarba:start", Config.TooFar, 3, "warning")
			hasCanna = nil
		end
	end
end)
