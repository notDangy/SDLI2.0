--ml
local campfire = 0
local tent = 0
local cauldron = 0
local hitch = 0
local Table = 0
local chair = 0
local still = 0


Citizen.CreateThread(function()
	local sexe =  IsPedMale(PlayerPedId())
    local checkbox2 = false
    WarMenu.CreateMenu('ml', "Campeggio")
    WarMenu.SetSubTitle('ml', 'Menu')
	
    WarMenu.CreateSubMenu('inv1', 'ml', 'Colloca')
    WarMenu.CreateSubMenu('inv2', 'ml', 'Smonta')
	WarMenu.CreateSubMenu('inv3', 'ml', 'Smonta Tutto')


    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
		local sexe =  IsPedMale(PlayerPedId())
		
        if WarMenu.IsMenuOpened('ml') then
            
            if WarMenu.MenuButton('Piazza Oggetti', 'inv1') then
            end
            if WarMenu.MenuButton('Smonta Oggetti', 'inv2') then
            end	
            if WarMenu.MenuButton('Smonta Tutto', 'inv3') then
            end	

            if WarMenu.Button("Raccogli acqua sporca") then TriggerEvent("ml_camping:Getwater") end

            WarMenu.Display()
        elseif WarMenu.IsMenuOpened('inv1') then

            if WarMenu.Button('Piazza Fuoco da Campo') then
            TriggerEvent("ml_camping:setcampfire")
            
            elseif WarMenu.Button('Piazza Tenda') then
            TriggerEvent("ml_camping:settent")
            
            elseif WarMenu.Button('Piazza Tenda 2') then
            TriggerEvent("ml_camping:settent2")
            
            elseif WarMenu.Button('Piazza Tenda 3') then
            TriggerEvent("ml_camping:settent3")
            
            elseif WarMenu.Button('Piazza Tenda Indiana') then
            TriggerEvent("ml_camping:settentindi")
            
            elseif WarMenu.Button('Piazza Tenda Indiana 2') then
            TriggerEvent("ml_camping:settentindi2")
            
            elseif WarMenu.Button('Piazza Tenda Indiana 3') then
            TriggerEvent("ml_camping:settentindi3")
            
            elseif WarMenu.Button('Piazza Calderone') then 
            TriggerEvent("ml_camping:setcauldron")
            
            elseif WarMenu.Button('Piazza Paletto') then
            TriggerEvent("ml_camping:sethitch")
            
            elseif WarMenu.Button('Piazza Tavolo') then
            TriggerEvent("ml_camping:settable")
            
            elseif WarMenu.Button('Piazza Sedia') then
                TriggerEvent("ml_camping:setchair")
        
            
            
            end

            WarMenu.Display()
                
        elseif WarMenu.IsMenuOpened('inv2') then
            if WarMenu.Button('Togli Fuoco da Campo') then
                TriggerEvent("ml_camping:delcampfire")
            
            elseif WarMenu.Button('Togli Tenda') then
                TriggerEvent("ml_camping:deltent")
            
            elseif WarMenu.Button('Togli Tenda 2') then
                TriggerEvent("ml_camping:deltent2")
            
            elseif WarMenu.Button('Togli Tenda 3') then
                TriggerEvent("ml_camping:deltent3")
            
            elseif WarMenu.Button('Togli Tenda Indiana') then
                TriggerEvent("ml_camping:deltentindi")
            
            elseif WarMenu.Button('Togli Tenda Indiana 2') then
                TriggerEvent("ml_camping:deltentindi2")
            
            elseif WarMenu.Button('Togli Tenda Indiana 3') then
                TriggerEvent("ml_camping:deltentindi3")
            
            elseif WarMenu.Button('Togli Calderone') then 
                TriggerEvent("ml_camping:delcauldron")
            
            elseif WarMenu.Button('Togli Paletto') then
                TriggerEvent("ml_camping:delhitch")
            
            elseif WarMenu.Button('Togli Tavolo') then
                TriggerEvent("ml_camping:deltable")
            
            elseif WarMenu.Button('Togli Sedia') then
                TriggerEvent("ml_camping:delchair")
            
        
            end

            WarMenu.Display()
                
        elseif WarMenu.IsMenuOpened('inv3') then
                if WarMenu.Button('Smonta Tutto') then
                    TriggerEvent("ml_camping:delfullcamp")
                end

                WarMenu.Display()
        end
    end
end)

RegisterNetEvent('lhrcampamentos:openmenu')
AddEventHandler('lhrcampamentos:openmenu', function() 
    WarMenu.OpenMenu('ml')
end)

--setting 

RegisterNetEvent('ml_camping:setcampfire')
AddEventHandler('ml_camping:setcampfire', function()
if campfire ~= 0 then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Campo da Fuoco...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_campfire02x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    campfire = prop

end)

RegisterNetEvent('ml_camping:settent')
AddEventHandler('ml_camping:settent', function()
 if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Tenda...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_s_posse_tent_bountyhunter07x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop

end)

RegisterNetEvent('ml_camping:settent2')
AddEventHandler('ml_camping:settent2', function()
 if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Tenda...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_s_posse_tent_bountyhunter06x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop

end)

RegisterNetEvent('ml_camping:settent3')
AddEventHandler('ml_camping:settent3', function()
 if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Tenda...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp005_s_posse_tent_trader07x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop

end)

RegisterNetEvent('ml_camping:settentindi')
AddEventHandler('ml_camping:settentindi', function()
 if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Tenda Indiana...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_ambtentoilskin01x"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop

end)

RegisterNetEvent('ml_camping:settentindi2')
AddEventHandler('ml_camping:settentindi2', function()
 if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Tenda Indiana...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("mp001_p_mp_tent_leento03x"), x, y, z, true, false, true) --p_ambtentrug01x
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop

end)

RegisterNetEvent('ml_camping:settentindi3')
AddEventHandler('ml_camping:settentindi3', function()
 if tent ~= 0 then
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Tenda Indiana...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("p_tentmountainmen02x"), x, y, z, true, false, true) --p_ambtentburlap01x
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    tent = prop

end)

RegisterNetEvent('ml_camping:setcauldron')
AddEventHandler('ml_camping:setcauldron', function()
if cauldron ~= 0 then
        SetEntityAsMissionEntity(cauldron)
        DeleteObject(cauldron)
        cauldron = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Calderone...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("S_CAMPFIRECOMBINED01X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    cauldron = prop

end)

RegisterNetEvent('ml_camping:sethitch')
AddEventHandler('ml_camping:sethitch', function()
if hitch ~= 0 then
        SetEntityAsMissionEntity(hitch)
        DeleteObject(hitch)
        hitch = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Paletto...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("P_HITCHINGPOST05X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    hitch = prop

end)

RegisterNetEvent('ml_camping:settable')
AddEventHandler('ml_camping:settable', function()
if Table ~= 0 then
        SetEntityAsMissionEntity(Table)
        DeleteObject(Table)
        Table = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Tavolo...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("S_BFTABLE01X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    Table = prop

end)

RegisterNetEvent('ml_camping:setchair')
AddEventHandler('ml_camping:setchair', function()
if chair ~= 0 then
        SetEntityAsMissionEntity(chair)
        DeleteObject(chair)
        chair = 0
    end
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 30000, true, false, false, false)
    exports['progressBars']:startUI(30000, "Piazzando Sedia...")
    Citizen.Wait(30000)
    ClearPedTasksImmediately(PlayerPedId())
    local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, -1.55))
    local prop = CreateObject(GetHashKey("P_WOODENCHAIR01X"), x, y, z, true, false, true)
    SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
    PlaceObjectOnGroundProperly(prop)
    chair = prop

end)

--deleting

RegisterNetEvent('ml_camping:delcampfire')
AddEventHandler('ml_camping:delcampfire', function()
if campfire == 0 then
        print("There is no campfire.")
    else
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        campfire = 0
    end

end)

RegisterNetEvent('ml_camping:deltent')
AddEventHandler('ml_camping:deltent', function()
if tent == 0 then
        print("There is no tent.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end

end)

RegisterNetEvent('ml_camping:deltent2')
AddEventHandler('ml_camping:deltent2', function()
if tent == 0 then
        print("There is no tent.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end

end)

RegisterNetEvent('ml_camping:deltent3')
AddEventHandler('ml_camping:deltent3', function()
if tent == 0 then
        print("There is no tent.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end

end)

RegisterNetEvent('ml_camping:deltentindi')
AddEventHandler('ml_camping:deltentindi', function()
if tent == 0 then
        print("There is no tent.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end

end)

RegisterNetEvent('ml_camping:deltentindi2')
AddEventHandler('ml_camping:deltentindi2', function()
if tent == 0 then
        print("There is no tent.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end

end)

RegisterNetEvent('ml_camping:deltentindi3')
AddEventHandler('ml_camping:deltentindi3', function()
if tent == 0 then
        print("There is no tent.")
    else
        SetEntityAsMissionEntity(tent)
        DeleteObject(tent)
        tent = 0
    end

end)

RegisterNetEvent('ml_camping:delcauldron')
AddEventHandler('ml_camping:delcauldron', function()
if cauldron == 0 then
        print("There is no cauldorn.")
    else
        SetEntityAsMissionEntity(cauldron)
        DeleteObject(cauldron)
        cauldron = 0
    end

end)

RegisterNetEvent('ml_camping:delhitch')
AddEventHandler('ml_camping:delhitch', function()
if hitch == 0 then
        print("There is no hitch.")
    else
        SetEntityAsMissionEntity(hitch)
        DeleteObject(hitch)
        hitch = 0
    end

end)

RegisterNetEvent('ml_camping:deltable')
AddEventHandler('ml_camping:deltable', function()
if Table == 0 then
        print("No hay ninguna mesa.")
    else
        SetEntityAsMissionEntity(Table)
        DeleteObject(Table)
        Table = 0
    end

end)

RegisterNetEvent('ml_camping:delchair')
AddEventHandler('ml_camping:delchair', function()
if chair == 0 then
        print("No hay ninguna silla.")
    else
        SetEntityAsMissionEntity(chair)
        DeleteObject(chair)
        chair = 0
    end

end)

-- deleting all

RegisterNetEvent('ml_camping:delfullcamp')
AddEventHandler('ml_camping:delfullcamp', function()

    TriggerEvent("ml_camping:delcampfire")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltent")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltent2")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltent3")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltentindi")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltentindi2")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltentindi3")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltentindi4")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:delcauldron")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:delhitch")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:deltable")

    Citizen.Wait(0)

    TriggerEvent("ml_camping:delchair")

end)