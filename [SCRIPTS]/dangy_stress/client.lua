
local stress = 0.0



RegisterNetEvent('dangy_stress:modify')
AddEventHandler('dangy_stress:modify', function(value) 
    if stress + tonumber(value) <= 100 and stress + tonumber(value) > 0 then
        stress = stress + tonumber(value)
        print("Stress modified: " .. tostring(stress))
    elseif stress + tonumber(value) > 0 then 
        stress = 100
        print("Stress modified: " .. tostring(stress))
    else
        stress = 0
    end

    SendNUIMessage({
        type = 'stress',
        value = stress
    })
end)

Citizen.CreateThread(function() 
    while true do 
        math.randomseed(GetGameTimer())
        Wait(math.random(5000,10000))
        TriggerServerEvent("dangy_stress:share", stress)
    end
end)

Citizen.CreateThread(function() 
    while true do 
        Wait(7000)
        local pos = GetEntityCoords(PlayerPedId())
        for k,v in pairs(Config.Places) do
         
            local distance = GetDistanceBetweenCoords(pos.x,pos.y,pos.z,v.x,v.y,v.z, false)
            if distance < v.range then
                TriggerEvent('dangy_stress:modify', -0.3)
            end
        end
    end
end)

Citizen.CreateThread(function() 
    Wait(10000)
    TriggerServerEvent('dangy_stress:requestStress')
end)


