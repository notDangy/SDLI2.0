local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
Inventory = exports.vorp_inventory:vorp_inventoryApi()

--############################## Server Callbacks ##############################--
-- check items for mash in inventory
RegisterServerEvent('moonshiner:check_mashItems')
AddEventHandler("moonshiner:check_mashItems", function(mash, itemArray, time, minXP, maxXP, message)
    local _source = source
    local hasAllItems = false
    for k,v in pairs(itemArray) do
        local count = Inventory.getItemCount(_source, k)
        if count >= v then
            hasAllItems = true
        else 
            hasAllItems = false
            break
        end
    end
    if hasAllItems then
        for k,v in pairs(itemArray) do
            Inventory.subItem(_source, k, v)
        end
        TriggerClientEvent("moonshiner:startMash", _source, mash, itemArray, time, minXP, maxXP, message)
    else
        TriggerClientEvent("vorp:TipBottom", _source, message, 4000)
    end
end)

-- check items for moonshine in inventory
RegisterServerEvent('moonshiner:check_moonshineItems')
AddEventHandler("moonshiner:check_moonshineItems", function(moonshine, itemArray, moonshineTime, message)
    local _source = source
    local hasAllItems = false
    for k,v in pairs(itemArray) do
        local count = Inventory.getItemCount(_source, k)
        if count >= v then
            hasAllItems = true
        else 
            hasAllItems = false
            break
        end
    end
    if hasAllItems then
        for k,v in pairs(itemArray) do
            Inventory.subItem(_source, k, v)
        end
        TriggerClientEvent("moonshiner:startBrewing", _source, moonshine, itemArray, moonshineTime)
    else
        TriggerClientEvent("vorp:TipBottom", _source, message, 4000)
    end
end)
--############################## END Server Callbacks ##############################--


--############################## Item Management ##############################--
RegisterServerEvent('moonshiner:giveMoonshine')
AddEventHandler("moonshiner:giveMoonshine", function(moonshineName, minXP, maxXP)
    local _source = source
    local xp = math.random(minXP, maxXP)
    local Character = VorpCore.getUser(_source).getUsedCharacter

    Character.addXp(xp)
    Inventory.addItem(_source, moonshineName, 1)
end)

RegisterServerEvent('moonshiner:giveMash')
AddEventHandler("moonshiner:giveMash", function(mashName, minXP, maxXP)
    local _source = source
    local xp = math.random(minXP, maxXP)
    local Character = VorpCore.getUser(_source).getUsedCharacter

    Character.addXp(xp)
    Inventory.addItem(_source, mashName, 1)
end)

RegisterServerEvent('moonshiner:givePropBack')
AddEventHandler("moonshiner:givePropBack", function(propName)
    local _source = source

    Inventory.addItem(_source, propName, 1)
end)

RegisterServerEvent('moonshiner:giveHarvestItems')
AddEventHandler("moonshiner:giveHarvestItems", function(itemName, itemCount)
    local _source = source
    Inventory.addItem(_source, itemName, itemCount)
    --TriggerClientEvent("vorp:TipBottom", _source, _U('got_Harvest_Item_Info', itemCount.." "..itemName), 4000)
end)
--############################## END Item Management ##############################--