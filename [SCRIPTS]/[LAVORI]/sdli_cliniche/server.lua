VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("clinics:pay")
AddEventHandler("clinics:pay", function() 
    local _source = source 
    local price = 3
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter

    if Character.money >= price then
        TriggerEvent("vorp:removeMoney", _source, 0, price)
        TriggerClientEvent("clinics:heal", _source)
    else
        TriggerClientEvent("redemrp_notification:start", _source,  "Non hai abbastanza soldi (" .. tostring(price) .. "$)", 3, "error")
    end
    
end)

RegisterServerEvent("clinics:pay:revive")
AddEventHandler("clinics:pay:revive", function(closestPlayer)
    local _closestPlayer = closestPlayer 
    local _source = source 
    local price = 3.5
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter         
    if Character.money >= price then
        print(_source, _closestPlayer)
        TriggerEvent("vorp:removeMoney", _source, 0, price)
		TriggerClientEvent('vorp:resurrectPlayer', _closestPlayer)
        TriggerClientEvent('ml_doctorjob:animation', _source)
        TriggerClientEvent('ml_doctorjob:revived', _closestPlayer)
    else
        TriggerClientEvent("redemrp_notification:start", _source,  "Non hai abbastanza soldi (" .. tostring(price) .. "$)", 3, "error")
    end
    
end)