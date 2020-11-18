Inventory = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local Loot = {
    {item = "fungo_mazza", name = "Fungo Mazza di Tamburo", amountToGive = math.random(1,3)},
    {item = "vaniglia", name = "Fiore di Vaniglia", amountToGive = math.random(1,3)},
    {item = "ginseng_americano", name = "Ginseng Americano", amountToGive = math.random(1,3)},
    {item = "ginseng_alaska", name = "Ginseng dell'Alaska", amountToGive = math.random(1,3)},
    {item = "ribes", name = "Ribes Dorato", amountToGive = math.random(1,3)},
    {item = "salvia", name = "Salvia Coccinea", amountToGive = math.random(1,3)},
    {item = "p_belladonna", name = "Belladonna", amountToGive = math.random(1,3)}
}

local LootRare = {
    {item = "fungo_mazza", name = "Fungo Mazza di Tamburo", amountToGive = math.random(5,8)},
    {item = "vaniglia", name = "Fiore di Vaniglia", amountToGive = math.random(5,8)},
    {item = "ginseng_americano", name = "Ginseng Americano", amountToGive = math.random(5,8)},
    {item = "ginseng_alaska", name = "Ginseng dell'Alaska", amountToGive = math.random(5,8)},
    {item = "ribes", name = "Ribes Dorato", amountToGive = math.random(5,8)},
    {item = "salvia", name = "Salvia Coccinea", amountToGive = math.random(5,8)},
    {item = "p_belladonna", name = "Belladonna", amountToGive = math.random(5,8)}
}



RegisterServerEvent('Picker:give')
AddEventHandler('Picker:give', function(HR, item)
    local _source = source
    local FinalLoot = LootToGive(_source,HR)
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter
    if HR then
        for k,v in pairs(LootRare) do
            if v.item == item then
                Inventory.addItem(_source, item,v.amountToGive)
                LootsToGiveR = {}
              --  TriggerClientEvent("redemrp_notification:start", _source, "Hai ricevuto "..tostring(v.amountToGive) .. " " .. v.name.."!", 4)
                break
            end
        end
    else
        for k,v in pairs(Loot) do
            if v.item == FinalLoot then
                Inventory.addItem(_source, FinalLoot,v.amountToGive)
                LootsToGive = {}
              --  TriggerClientEvent("redemrp_notification:start", _source, "Hai ricevuto "..tostring(v.amountToGive) .. " " .. v.name.."!", 4)
                break
            end
        end
    end

end)

function LootToGive(source,HasRares) -- kek
    local LootsToGive = {}
    local LootsToGiveR = {}
    if HasRares then
        for k,v in pairs(LootRare) do
            table.insert(LootsToGiveR,v.item)
        end
    else
        for k,v in pairs(Loot) do
            table.insert(LootsToGive,v.item)
        end
    end

    if LootsToGive[1] ~= nil then
        local value = math.random(1,#LootsToGive)
        local picked = LootsToGive[value]
        return picked
    elseif LootsToGiveR[1] ~= nil then
        local value = math.random(1,#LootsToGiveR)
        local picked = LootsToGiveR[value]
        return picked
    end
end

RegisterServerEvent("CottonPickin:checkcannasv")
AddEventHandler("CottonPickin:checkcannasv", function() 

	local _source = source
    local cannaprova = Inventory.getItemCount(_source, "barbabietole")
    if cannaprova >= 10 then
		TriggerClientEvent("CottonPickin:checkcanna", _source, true)
	else
    --	TriggerClientEvent("redemrp_notification:start", _source, Config.CannaNotFound, 3, "warning")
        TriggerClientEvent("vorp:Tip", source, Config.CannaNotFound, 3000)
	end

	
end)

RegisterServerEvent('CottonPickin:startProcessing')
AddEventHandler('CottonPickin:startProcessing', function()
	local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter        
    local barbabietole = Inventory.getItemCount(_source, "barbabietole")
    
    if Inventory.getItemCount(_source, "sugar") + math.floor(barbabietole/2) <= 20 then 
        Inventory.subItem(_source, "barbabietole", barbabietole)
        TriggerClientEvent("CottonPickin:processAnimation", _source, cannaprova)
        Citizen.Wait(10000)
        Inventory.addItem(_source, "sugar", math.floor(barbabietole/2))
    else
        TriggerClientEvent("vorp:TipRight", _source, "Non puoi processare, non hai abbastanza spazio nell'inventario!", 4000)
    end
	
end)
