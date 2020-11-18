local pickerblips = {
    {["CaveName"] = "Fungo", x = -45.2, y = 630.2, z = 51, ["HasRares"] = false, prop='s_flyamush',item='fungo_mazza'}, --vanno bene
    {["CaveName"] = "Vaniglia", x = 2375.9, y = -525.7, z = 41.8, ["HasRares"] = false, prop='s_inv_bloodflower01bx',item='vaniglia'}, 
    {["CaveName"] = "GinsengAmericano", x = -2150.7, y = 558.5, z = 117.1, ["HasRares"] = false, prop='s_ginseng01x',item='ginseng_americano'},
    {["CaveName"] = "GinsengAlaska", x = -990.2, y = 2198.1, z = 341.1, ["HasRares"] = false, prop='crp_ginseng_ba_sim',item='ginseng_alaska'},
    {["CaveName"] = "Ribes", x = 3218.3, y = 1470.6, z = 53.2, ["HasRares"] = false, prop='crp_berry_aa_sim',item='ribes'},
    {["CaveName"] = "Salvia", x = -5175.1, y = -3919.5, z = 7.4, ["HasRares"] = false, prop='s_inv_redsage01dx',item='salvia'}, --vanno bene
    {["CaveName"] = "Belladonna", x = 342.2, y = -770.5, z = 42.9, ["HasRares"] = false, prop='desertsage_p',item='p_belladonna'} 

}


local spawnedPlants = 0
local Plants = {}
local InArea = false
local active = false
local entity
local HasRarePlants = false
local currentZoneProcess = nil

function getItem(playerpos) 
    local closestDistance, closestItem = -1,""
    for k,v in pairs(pickerblips) do 
        local distance = GetDistanceBetweenCoords(playerpos.x,playerpos.y,playerpos.z,v.x,v.y,v.z,true) 
        if closestDistance == -1 or distance < closestDistance then 
            closestDistance = distance
            closestItem = v.item
        end
    end
    return closestItem
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        local ped = Ped()
        local pos = GetEntityCoords(ped)
        for k,v in pairs(pickerblips) do
            if GetDistanceBetweenCoords(pos.x,pos.y,pos.z,v.x,v.y,v.z,false) < 80.0 then
                InArea = true
                
                SpawnObject(v.prop)
                HasRarePlants = v.HasRares
            end
        end
    end
end)

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
        local pos = GetEntityCoords(PlayerPedId())
        if InArea then
            --local SouthfieldFlats = {x = 349.3, y = -1261.9, z = 44.0}

            local nearestFieldCoords = getNearestFiedCoords()
            if GetDistanceBetweenCoords(pos.x,pos.y,pos.z, nearestFieldCoords.x,nearestFieldCoords.y,nearestFieldCoords.z) > 100.0 then
                InArea = false
                for a, b in pairs(Plants) do
                    DeleteObject(b)
                end
                spawnedPlants = 0
            end
            
        end
    end
end)

function getNearestFiedCoords() 
    local closestDistance,closestCoords = -1,{x=-1,y=-1,z=-1}
    local playerpos = GetEntityCoords(PlayerPedId())
    for k,v in pairs(pickerblips) do 
        local distance = GetDistanceBetweenCoords(playerpos.x,playerpos.y,playerpos.z,v.x,v.y,v.z,true) 
        if closestDistance == -1 or distance < closestDistance then 
            closestDistance = distance
            closestCoords.x,closestCoords.y,closestCoords.z = v.x,v.y,v.z
        end
    end

    return closestCoords
end

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
                            TriggerServerEvent("Picker:give", HasRarePlants, getItem(pos))
                        end
                    end
                end
            end
        end
    end
end)

function SpawnObject(object)
    while spawnedPlants < 10 do  --20
        local PlantCoords = GeneratePlantCoords()
        local obj = CreateObject(GetHashKey(object), PlantCoords.x, PlantCoords.y,PlantCoords.z, false, false, false)
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
            if GetDistance(GetEntityCoords(Ped()),v) < 80.0 then  --80
                PlantCoordX = v.x + modX
                PlantCoordY = v.y + modY
                
		        local coordZ = GetCoordZ(PlantCoordX, PlantCoordY)
                local coord = vector3(PlantCoordX, PlantCoordY, coordZ)
                return coord
            end
        end


        --if ValidatePlantCoord(coord) then
        return vector3(0,0,0)
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
function GetCoordZ(x, y)

    for height = 1, 1000 do
		local foundGround, groundZ = GetGroundZAndNormalFor_3dCoord(x, y, height+0.0)

		if foundGround then
            return groundZ
		end
	end
end

function MineAndAttach()
    if not IsPedMale(Ped()) then
        local waiting = 0
        local dict = "amb_work@world_human_pickaxe@wall@male_d@base"
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            waiting = waiting + 100
            Citizen.Wait(100)
            if waiting > 5000 then
              --  TriggerEvent("redemrp_notification:start", "Hai rotto l'animazione, Rilogga", 4, "warning")
                TriggerEvent("vorp:NotifyLeft", "~e~Errore", "Hai rotto l'animazione, ~e~Rilogga", "menu_textures", "cross", 3000)
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

AddEventHandler('CottonPickin:hasEnteredMarkerProcess', function(zone)
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
			TriggerEvent('CottonPickin:hasEnteredMarkerProcess', currentZoneProcess)
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
				TriggerServerEvent("CottonPickin:checkcannasv")
				WarMenu.CloseMenu()
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)

local hasCanna = false

RegisterNetEvent("CottonPickin:checkcanna")
AddEventHandler("CottonPickin:checkcanna", function(result) 
    hasCanna = result
	cannaProcessing()
end)

function cannaProcessing()
    Citizen.CreateThread(function()
		if hasCanna then
			TriggerServerEvent("CottonPickin:startProcessing")
			Citizen.Wait(5000)
		end
	end)
end

RegisterNetEvent('CottonPickin:processAnimation')
AddEventHandler('CottonPickin:processAnimation', function(canna)
	local location = Config.ProcessLocations[lastZoneProcess]
	local coords = GetEntityCoords(PlayerPedId())
	if location then
		if (Vdist(coords.x, coords.y, coords.z, location.x, location.y, location.z) < 1.5) then
			TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CANNED_FOOD_COOKING"), 10000, true, false, false, false)
            exports['progressBars']:startUI(10000, "Processando...")
		else
			TriggerEvent("CottonPickin:start", Config.TooFar, 3, "warning")
			hasCanna = nil
		end
	end
end)
