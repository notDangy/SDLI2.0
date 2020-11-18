------------------CREATED BY HALCON FOR THE VORP COMMUNITY------------------------------- 
----------------------------------

RegisterNetEvent("dar:galletta")
AddEventHandler("dar:galletta", function()
        local playerPed = PlayerPedId()
		local Stamina = GetAttributeCoreValue(GetMount(PlayerPedId()), 1)
		local Heal = GetAttributeCoreValue(GetMount(PlayerPedId()), 0)
		local newStamina = Stamina + 10
		local newHeal = Heal + 20
		local isMounted = IsPedOnMount(playerPed)
		TaskAnimalInteraction(PlayerPedId(), GetMount(PlayerPedId()),-224471938, 0, 0)
        if isMounted then
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 1, newStamina)  
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 0, newHeal)  

        PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
			else
				TriggerServerEvent("devolver:galletta")
				TriggerEvent("vorp:TipBottom", "Devi essere a cavallo per nutrirlo!", 5000)
			end
end)


-----------------------------------------

RegisterNetEvent("dar:mela")
AddEventHandler("dar:mela", function()
        local playerPed = PlayerPedId()
		local Stamina = GetAttributeCoreValue(GetMount(PlayerPedId()), 1)
		local Heal = GetAttributeCoreValue(GetMount(PlayerPedId()), 0)
		local newStamina = Stamina + 10
		local newHeal = Heal + 40
		local isMounted = IsPedOnMount(playerPed)
		TaskAnimalInteraction(PlayerPedId(), GetMount(PlayerPedId()),-224471938, 0, 0)
        if isMounted then
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 1, newStamina)  
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 0, newHeal)  

        PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
			else
				TriggerServerEvent("devolver:mela")
				TriggerEvent("vorp:TipBottom", "Devi essere a cavallo per nutrirlo!", 5000)
			end
end)

--------------------------------------------

RegisterNetEvent("dar:carote")
AddEventHandler("dar:carote", function()
        local playerPed = PlayerPedId()
		local Stamina = GetAttributeCoreValue(GetMount(PlayerPedId()), 1)
		local Heal = GetAttributeCoreValue(GetMount(PlayerPedId()), 0)
		local newStamina = Stamina + 20
		local newHeal = Heal + 50
		local isMounted = IsPedOnMount(playerPed)
		TaskAnimalInteraction(PlayerPedId(), GetMount(PlayerPedId()),-224471938, 0, 0)
        if isMounted then
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 1, newStamina)  
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 0, newHeal)  

        PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
			else
				TriggerServerEvent("devolver:carote")
				TriggerEvent("vorp:TipBottom", "Devi essere a cavallo per nutrirlo!", 5000)
			end
end)

RegisterNetEvent("dar:sugar")
AddEventHandler("dar:sugar", function()
        local playerPed = PlayerPedId()
		local Stamina = GetAttributeCoreValue(GetMount(PlayerPedId()), 1)
		local Heal = GetAttributeCoreValue(GetMount(PlayerPedId()), 0)
		local newStamina = Stamina + 50
		local newHeal = Heal + 5
		local isMounted = IsPedOnMount(playerPed)
		TaskAnimalInteraction(PlayerPedId(), GetMount(PlayerPedId()),-224471938, 0, 0)
        if isMounted then
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 1, newStamina)  
		Citizen.InvokeNative(0xC6258F41D86676E0, GetMount(PlayerPedId()), 0, newHeal)  

        PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
			else
				TriggerServerEvent("devolver:sugar")
				TriggerEvent("vorp:TipBottom", "Devi essere a cavallo per nutrirlo!", 5000)
			end
end)