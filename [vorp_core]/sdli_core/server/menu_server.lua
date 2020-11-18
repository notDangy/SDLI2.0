VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
-- MADE BY DANGY X SDLI 2.0

local paychecks = {
    {group = "Sceriffo", paycheck = 3},
    {group = "Medico", paycheck = 2},
    {group = "Banchiere", paycheck = 2},
    {group = "Giornalista", paycheck = 1},
    {group = "Bordello", paycheck = 1.85},
    {group = "Saloon", paycheck = 1.5}
}

RegisterServerEvent("sdlicore:checkGroupMenu")
AddEventHandler("sdlicore:checkGroupMenu", function() 
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter
    TriggerClientEvent("sdlicore:getGroupFromServer", _source, User.getGroup, Character.job)
   
end)

RegisterServerEvent("vorpinventory:lootPlayer")
AddEventHandler("vorpinventory:lootPlayer", function(target) 
    local _source = source
    local User = VorpCore.getUser(target) 
    local Character = User.getUsedCharacter
    exports.ghmattimysql:execute("SELECT inventory FROM characters WHERE identifier=@identifier", {
        ['@identifier'] = Character.identifier
    }, function(ret)
        local inventory = json.decode(ret[1].inventory)
        
        if inventory ~= nil then -- LOOT ITEM INVENTARIO
            for k,v in pairs(inventory) do
                local saved = VorpInv.getItemCount(target, k)
                
                if VorpInv.canCarryItems(target, tonumber(v)) then
                    VorpInv.addItem(_source, k, tonumber(v))
                    if saved + tonumber(v) == VorpInv.getItemCount(_source,k) then 
                        VorpInv.subItem(target, k, tonumber(v))
                    end
                end
            end
        end
    end)

    TriggerEvent("vorp:addMoney", _source, 0, tonumber(Character.money)) -- LOOT SOLDI E GOLD
    TriggerEvent("vorp:removeMoney", target, 0, tonumber(Character.money))
    TriggerEvent("vorp:addMoney", _source, 1, tonumber(Character.gold))
    TriggerEvent("vorp:removeMoney", target, 1, tonumber(Character.gold))

    local weapons = VorpInv.getUserWeapons(target) --LOOT ARMI

    if weapons ~= nil then
        for k,v in pairs(weapons) do 
            VorpInv.giveWeapon(_source, tonumber(v["id"]), target)
        end
    end

    
end)

RegisterServerEvent("vorpinventory:inspectHorse")
AddEventHandler("vorpinventory:inspectHorse", function(target)
    local _source = source
    local User = VorpCore.getUser(target) 
    local Character = User.getUsedCharacter 

    local identifier = Character.identifier
    local horseName = ""
    local horseInv = {}
    exports.ghmattimysql:execute("SELECT name, inventory FROM stables WHERE identifier=@id AND type='Horse' AND isDefault = 1;", {id = identifier}, function(result) 
        for k,v in pairs(result) do 
            for a,b in pairs(v) do
                b = b:gsub("%[", "{") 
                b = b:gsub("%]", "}")
                    
                if a ~= "name" then
                    local label = ""
                    local quantity = 0
                    for c,d in pairs(json.decode(b)) do
                        table.insert(horseInv, {Name = d["label"], Qtty = d["count"]})
                    end
                else
                    horseName = b
                end
            end
        end
        TriggerClientEvent("vorpinventory:inspectHorseClient", _source, horseName, horseInv)
        horseInv = {}
    end)
 
end)

RegisterServerEvent("vorpinventory:inspectCart")
AddEventHandler("vorpinventory:inspectCart", function(target)
    local _source = source
    local User = VorpCore.getUser(target) 
    local Character = User.getUsedCharacter

    local identifier = Character.identifier
    local cartName = ""
    local cartInv = {}
    exports.ghmattimysql:execute("SELECT name, inventory FROM stables WHERE identifier=@id AND type='Cart' AND isDefault = 1;", {id = identifier}, function(result) 
        for k,v in pairs(result) do 
            for a,b in pairs(v) do
                b = b:gsub("%[", "{") 
                b = b:gsub("%]", "}")
                    
                if a ~= "name" then
                    local label = ""
                    local quantity = 0
                    for c,d in pairs(json.decode(b)) do
                        table.insert(cartInv, {Name = d["label"], Qtty = d["count"]})
                    end
                else
                    cartName = b
                end
            end
        end
        TriggerClientEvent("vorpinventory:inspectCartClient", _source, cartName, cartInv)
        cartInv = {}
    end)
end)


RegisterServerEvent("vorp:wipePlayer")
AddEventHandler("vorp:wipePlayer", function() 
    
    local _source = source

    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 

    for k,v in pairs(json.decode(Character.inventory)) do
        VorpInv.subItem(_source, k, tonumber(v))
    end

    local weapons = VorpInv.getUserWeapons(_source)

    if weapons ~= nil then
        for k,v in pairs(weapons) do 
            VorpInv.subWeapon(_source, tonumber(v["id"]))
        end
    end

    TriggerEvent("vorp:removeMoney", _source, 0, Character.money)
    TriggerEvent("vorp:removeMoney", _source, 1, Character.gold)

end)

RegisterServerEvent("vorpinventory:inspectPlayer")

AddEventHandler("vorpinventory:inspectPlayer", function(target)
    --Wait(1000) 
    local _source = source
    local User = VorpCore.getUser(target) 
    local Character = User.getUsedCharacter 

    local name = Character.identifier
    
    exports.ghmattimysql:execute("SELECT inventory FROM characters WHERE identifier=@identifier", {
        ['@identifier'] = Character.identifier
    }, function(ret)
        print(ret[1].inventory)
        local tableInv = {}
        table.insert(tableInv, {Name="Soldi", Quantity = Character.money})
        for k,v in pairs(json.decode(ret[1].inventory)) do
            local _v = v
            TriggerEvent("vorpinventory:getLabelFromId", k, function(item)
                table.insert(tableInv,  {Name = item, Quantity = _v})
            end)
        end
        
        local weapons = VorpInv.getUserWeapons(target)
        if weapons ~= nil then
            for k,v in pairs(weapons) do 
                table.insert(tableInv, {Name = getWeaponNameFromId(v["name"]), Quantity = "1"})
            end
        end
        TriggerClientEvent("vorpinventory:inspectPlayerClient", _source, name, tableInv)

    end)
end)


RegisterServerEvent('sdli_core:payCheck')
AddEventHandler('sdli_core:payCheck', function() 

    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter

    for k,v in pairs(paychecks) do 
        if v.group == Character.job then 
            TriggerEvent("vorp:addMoney", _source, 0, tonumber(v.paycheck)) -- LOOT SOLDI E GOLD
            TriggerClientEvent("vorp:TipRight", _source, "Hai ricevuto lo stipendio da " .. v.group .. ": "  .. tostring(v.paycheck).."$", 4000)
        end
    end

end)

--SIGARO E SIGARETTE

--[[Citizen.CreateThread(function() 
    Wait(2000)
    VorpInv.RegisterUsableItem("cigarette", function(data) 
        local _source = data.source
        VorpInv.subItem(_source, "cigarette", 1)
        TriggerClientEvent("smokecigarette", _source)
    end)

    VorpInv.RegisterUsableItem("cigar", function(data) 
        local _source = data.source
        VorpInv.subItem(_source, "cigar", 1)
        TriggerClientEvent("smokecigar", _source)
    end)
end)]]--
---


local weaponNames = {
    {hash="WEAPON_MELEE_KNIFE", name="Coltello"},
}

function getWeaponName(hash) 
    for k,v in pairs(weaponNames) do 
        if hash == v.hash then
            return v.name
        end
    end
end


function getWeaponNameFromId(weapon) 
	local weaponNames = {
		{id = "WEAPON_REVOLVER_LEMAT", name = "Revolver Lemant"},
		{id = "WEAPON_MELEE_KNIFE", name = "Coltello"},
		{id = "WEAPON_KIT_CAMERA", name = "Cinepresa"},
		{id = "WEAPON_MELEE_LANTERN_ELECTRIC", name = "Lanterna elettrica"},
		{id = "WEAPON_MELEEE_TORCH", name = "Torcia"},
		{id = "WEAPON_THROWN_THROWING_KNIEVES", name = "Coltelli da lancio"},
		{id = "WEAPON_LASSO", name = "Lasso"},
		{id = "WEAPON_THROWN_TOMAHAWK", name = "Tomahawk"},
		{id = "WEAPON_PISTOL_M1899", name = "Pistola M1899"},
		{id = "WEAPON_PISTOL_MAUSER", name = "Pistola mauser"},
		{id = "WEAPON_PISTOL_VOLCANIC", name = "Pistola volcanic"},
		{id = "WEAPON_REPEATER_CARABINE", name = "Carabina a ripetizione"},
		{id = "WEAPON_REPETER_EVANS", name = "ripetitore evans"},
		{id = "WEAPON_REPEATER_HENRY", name = "Ripetitore Henry"},
		{id = "WEAPON_RIFLE_VARMINT", name = "Fucile Varmint"},
		{id = "WEAPON_REPEATER_WINCHESTER", name = "Ripetitore winchester"},
		{id = "WEAPON_REVOLVER_CATTLEMAN", name = "Revolver cattleman"},
		{id = "WEAPON_REVOLVER_DOUBLEACTION", name = "Revolver Doppia Azione"},
		{id = "WEAPON_REVOLVER_SCHOFIELD", name = "Revolver Schofield"},
		{id = "WEAPON_RIFLE_BOLTACTION", name = "Fucile Boltaction"},
		{id = "WEAPON_SNIPERRIFLE_CARCANO", name = "Fucile carcano"},
		{id = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK", name = "Fucile Rollingblock"},
		{id = "WEAPON_RIFLE_SPRINGFIELD", name = "Fucile springfield"},
		{id = "WEAPON_SHOTGUN_PUMP", name = "Fucile a pompa"},
		{id = "WEAPON_BOW", name = "Arco"},
		{id = "WEAPON_MELEE_HATCHET", name = "Accetta"},
		{id = "WEAPON_SHOTGUN_SAWEDOFF", name = "Fucile a pompa sawedoff"},
	}

	local name 

	for k,v in pairs(weaponNames) do
		if weapon == v.id then 
			name = v.name
		end
	end

	if name == nil then name = weapon end

	return name
end




