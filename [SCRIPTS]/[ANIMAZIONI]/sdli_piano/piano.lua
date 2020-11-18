--Discord : Tahsin ✇ DoaherisTR#0681



local play = false

Citizen.CreateThread(function()
    while true do
      
        Citizen.Wait(1)
        
        if IsPlayerNearCoords(-312.3, 799.01, 118.46) then
            if not play then 
                TriggerEvent('vorp:TipBottom', "[G] Suona il pianoforte", 100)
            end 
            if IsControlJustPressed(0, 0x760A9C6F) then
                play = true
                TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey('PROP_HUMAN_PIANO'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, 0, true, true, 0, true) 
            end
        end
        
        
        if IsPlayerNearCoords(1346.95, -1371.76, 80.49) then
            if not play then 
                TriggerEvent('vorp:TipBottom', "[G] Suona il pianoforte", 100)
            end
            if IsControlJustPressed(0, 0x760A9C6F) then
                play = true
                TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey('PROP_HUMAN_PIANO'), 1346.87 - 0.08, -1371.09, 79.92 + 0.03, 351.35, 0, true, true, 0, true)

            end
        end

        if IsPlayerNearCoords(1346.95, -1371.76, 80.49) then
            if not play then 
                TriggerEvent('vorp:TipBottom', "[G] Suona il pianoforte", 100)
            end
            if IsControlJustPressed(0, 0x9959A6F0) then
                play = true
                TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), 1346.87 - 0.08, -1371.09, 79.92 + 0.03, 351.35, 0, true, true, 0, true)
                 
            end
        end
 if IsPlayerNearCoords(-312.3, 799.01, 118.46) then
            if not play then 
                TriggerEvent('vorp:TipBottom', "[G] Suona il pianoforte", 100)
            end 
            if IsControlJustPressed(0, 0x9959A6F0) then
                play = true
                TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), -312.22 - 0.08, 799.01, 118.43 + 0.03, 102.37, 0, true, true, 0, true) 
            end
        end

    end    
end)
    
Citizen.CreateThread(function()    
    while true do 
        Citizen.Wait(1)
        if play then

            TriggerEvent('vorp:TipBottom', "[W] Smetti di suonare", 100)
            if IsControlJustPressed(0, 0x8FD015D8) then
                play = false
                ClearPedTasks(GetPlayerPed())
                SetCurrentPedWeapon(GetPlayerPed(), -1569615261, true)
            end    
        end
    end
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(GetPlayerPed(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 3 then
        return true
    end
end