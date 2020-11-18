Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
        local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
        local model = GetEntityModel(holding)
        local pedtype = GetPedType(holding)
        if holding then
            for i, row in pairs(Animal) do
                if model == Animal[i]["model"] then
                    for a = 1, #shops do 
                        local myV = vector3(coords)
                        local shopV = vector3(shops[a]["x"], shops[a]["y"], shops[a]["z"])
                        local isIllegal = shops[a]["illegal"]
                        local dst = Vdist(shopV, myV)
                        if dst < 2 and not Animal[i]["illegal"] then
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then -- VENDITA LEGALE CARCASSE
								
                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
								Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
                                if not holding then
									TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece)
									TriggerServerEvent("hunting:xp", endpiece)
                                --	TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                                    TriggerEvent('dangy_stress:modify', 0.6)
                                    TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)
									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                              
                            end
                        elseif not shops[a]["illegal"] and dst < 2 then
                            Wait(50)
                            TriggerEvent("hunting:showprompt", "Macellaio: Non accettiamo queste pelli o carcasse qui!")
                        elseif dst < 1 then
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then 

                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
								
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
								Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
								if not holding then
									TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece)
									TriggerServerEvent("hunting:xp", endpiece)
                                --	TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                                   -- TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"], 2000)
                                   TriggerEvent('dangy_stress:modify', 0.6)
                                   TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)
									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                             
                            end
                        end
                    end
                elseif quality == Animal[i]["poor"] then
                    for a = 1, #shops do 
                        local myV = vector3(coords)
                        local shopV = vector3(shops[a]["x"], shops[a]["y"], shops[a]["z"])
                        local dst = Vdist(shopV, myV)
                        if dst < 2 and not Animal[i]["illegal"] then
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then

                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
                                Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
                                if not holding then
									TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece*0.9)
									TriggerServerEvent("hunting:xp", endpiece)
                                --	TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                                    --TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"], 2000)
                                    TriggerEvent('dangy_stress:modify', 0.6)
                                    TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)
									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                             
                            end
                        elseif dst < 2 and not shops[a]["illegal"] then
                            Wait(50)
                            TriggerEvent("hunting:showprompt", "Macellaio: Non accettiamo queste pelli qui!")
                        elseif dst < 1 then
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then

                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
                                Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
                                if not holding then
									TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece*0.9)
									TriggerServerEvent("hunting:xp", endpiece)
                                --	TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                                  --  TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"], 2000)
                                    TriggerEvent('dangy_stress:modify', 0.6)
                                    TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)
									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                                
                            end 
                        end
                    end
                elseif quality == Animal[i]["good"] then
                    for a = 1, #shops do 
                        local myV = vector3(coords)
                        local shopV = vector3(shops[a]["x"], shops[a]["y"], shops[a]["z"])
                        local dst = Vdist(shopV, myV)
                        if dst < 2 and not Animal[i]["illegal"] then
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then

                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
                                Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
                                if not holding then
									TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece*1.5)
									TriggerServerEvent("hunting:xp", endpiece)
                                --	TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                               --    TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"], 2000)
                               TriggerEvent('dangy_stress:modify', 0.6)
                               TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)
									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                            end
                        elseif dst < 2 and not shops[a]["illegal"] then
                            Wait(50)
                            TriggerEvent("hunting:showprompt", "Macellaio: Non accettiamo queste pelli qui!")
                        elseif dst < 1 then 
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then

                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
                                Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
                                if not holding then
									TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece*1.5)
									TriggerServerEvent("hunting:xp", endpiece)
                                   -- TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                                 --   TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"], 2000)
                                 TriggerEvent('dangy_stress:modify', 0.6)
                                 TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)
									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                            
                            end 
                        end 
                    end
                elseif quality == Animal[i]["perfect"] then
                    for a = 1, #shops do 
                        local myV = vector3(coords)
                        local shopV = vector3(shops[a]["x"], shops[a]["y"], shops[a]["z"])
                        local dst = Vdist(shopV, myV)
                        if dst < 2 and not Animal[i]["illegal"] then
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then
                                
                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
                                Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
                                if not holding then
									TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece*2.5)
									TriggerServerEvent("hunting:xp", endpiece)
                                --	TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                                --    TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"], 2000)
                                TriggerEvent('dangy_stress:modify', 0.6)
                                TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)

									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                              
                            end
                        elseif dst < 2 and not shops[a]["illegal"] then
                            Wait(50)
                            TriggerEvent("hunting:showprompt", "Macellaio: Non accettiamo queste pelli qui!")
                        elseif dst < 1 then
                            TriggerEvent("hunting:showprompt", "Premi [G] per vendere la carcassa/la pelle al macellaio.")
                            entity = holding
                            if IsControlJustReleased(0, 0x760A9C6F) then

                                local endpiece = shops[a]["gain"] * Animal[i]["reward"]
                                --DetachEntity(entity, 1, 1)
                                SetEntityAsMissionEntity(entity, true, true)
                                DeleteEntity1(entity)
								Wait(1000)
								holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped) -- ISPEDHOLDING
                                if not holding then
									--TriggerServerEvent("hunting:add", Animal[i]["item"])
									TriggerServerEvent("hunting:money", endpiece*2.5)
									TriggerServerEvent("hunting:xp", endpiece)
                                    --TriggerEvent("redemrp_notification:start", "Hai venduto il tuo "..Animal[i]["name"], 2, "success")
                                --    TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"], 2000)
                                TriggerEvent('dangy_stress:modify', 0.6)
                                    TriggerEvent("vorp:Tip", "Hai venduto il tuo "..Animal[i]["name"].." per ~t6~$"..Animal[i]["reward"], 2000)
									Wait(500)
								else
									TriggerEvent("hunting:showprompt", "Macellaio: Non ci serve altra merce, torni più tardi!")
									Wait(5000)
								end
                            
                            end 
                        end
                    end
                end
            end
        elseif holding == false then
            for a = 1, #shops do 
                local myV = vector3(coords)
                local shopV = vector3(shops[a]["x"], shops[a]["y"], shops[a]["z"])
                local dst = Vdist(shopV, myV)
                if dst < 1 then
                    TriggerEvent("hunting:showprompt", "Non hai nessuna pelle o carcassa.")
                else
                    Wait(50)
                end
            end
            Wait(50)
        end
    end
end)

Citizen.CreateThread(function()
    for _, info in pairs(shops) do
        if not info["illegal"] then
            local blip = N_0x554d9d53f696d002(-678244495, info.x, info.y, info.z)
            SetBlipSprite(blip, SellerIcon, 1)
            SetBlipScale(blip, 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip, SellerName)
        end
    end  
end)

Citizen.CreateThread(function() 
	for k,v in pairs(shops) do
		local EntityModel = string.upper(v.ped)
		RequestModel(GetHashKey(EntityModel))
		while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
			Wait(1)
			RequestModel(GetHashKey(EntityModel))
		end
		local spawnedped = CreatePed(GetHashKey(EntityModel), v.x, v.y, v.z -1, true, false, true, true)
		Citizen.InvokeNative(0x283978A15512B2FE, spawnedped, true)
		if v["illegal"] then SetEntityHeading(spawnedped, 120.9) end
		FreezeEntityPosition(spawnedped, true)
	end	
end)

RegisterNetEvent("hunting:showprompt")
AddEventHandler("hunting:showprompt", function(msg)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)
  

function DeleteEntity1(entity)
	NetworkRequestControlOfEntity(entity)
	while not NetworkHasControlOfEntity(entity) do
		Wait(1)
	end   
			                             
    if(IsEntityAVehicle(entity))then
        SetEntityAsMissionEntity(entity, true, true)
        while not IsEntityAMissionEntity(entity) do
            Wait(1)
        end		
        DeleteVehicle(entity)
    else					                             
        DetachEntity(entity, 1, 1)
        SetEntityAsNoLongerNeeded(entity)
        SetEntityCoords(entity,0,0,0,0,0,0,0)
    end
end
  --SNIPPET FROM CRYPTOGENICS, HOW I BUILT IT--
--[[Citizen.CreateThread(function()
    Wait(500)
    while true do
        Wait(100)
        local entity = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
        local model = GetEntityModel(entity)
        local carriedEntityHash = Citizen.InvokeNative(0x31FEF6A20F00B963, entity)
        local type = GetPedType(entity)
            if type == 28 then
                print(" ")
                print("Carcass Model")
                print(model)
        else
            print(" ")
            print("Not holding carcass")
        end
        if carriedEntityHash then
            print(" ")
            print("Pelt Model")
            print(carriedEntityHash)
        elseif carriedEntityHash == nil then
            print(" ")
            print("Not holding Provision")
            Wait(1000)
        end
    end
end)]]--
