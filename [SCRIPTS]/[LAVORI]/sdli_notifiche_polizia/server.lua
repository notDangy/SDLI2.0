local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent("Witness:CheckJob")
AddEventHandler("Witness:CheckJob", function(players, coords)
    for each, player in ipairs(players) do
        local User = VorpCore.getUser(player) 
        local Character = User.getUsedCharacter 
        if Character ~= nil then
			local group = Character.job
				
			if group == "Sceriffo" then 
				TriggerClientEvent("Witness:ToggleNotification", player, coords)
            end
            
        end
       
    end
end)