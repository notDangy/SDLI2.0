VorpInv = exports.vorp_inventory:vorp_inventoryApi()


local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('def_cookfood:pork')
AddEventHandler("def_cookfood:pork", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = VorpInv.getItemCount(_source, "meat_cinghiale")
		if count >= 1 then
		
			VorpInv.subItem(_source,"meat_cinghiale", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
            VorpInv.addItem(_source,"consumable_cinghiale", 1)
            TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Cotto!", "Hai cucinato la carne!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Hai bisogno della carne cruda", "menu_textures", "cross", 3000)
        end
    end)

RegisterServerEvent('def_cookfood:tacchino')
AddEventHandler("def_cookfood:tacchino", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = VorpInv.getItemCount(_source, "meat_tacchino")
		if count >= 1 then
		
			VorpInv.subItem(_source,"meat_tacchino", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
            VorpInv.addItem(_source,"consumable_tacchino", 1)
            TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Cotto!", "Hai cucinato la carne!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Hai bisogno della carne cruda", "menu_textures", "cross", 3000)
        end
    end)

RegisterServerEvent('def_cookfood:alce')
AddEventHandler("def_cookfood:alce", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = VorpInv.getItemCount(_source, "meat_alce")
		if count >= 1 then
		
			VorpInv.subItem(_source,"meat_alce", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
            VorpInv.addItem(_source,"consumable_alce", 1)
            TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Cotto!", "Hai cucinato la carne!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Hai bisogno della carne cruda", "menu_textures", "cross", 3000)
        end
    end)

RegisterServerEvent('def_cookfood:bluegill')
AddEventHandler("def_cookfood:bluegill", function(name, weapon)
    local _source = tonumber(source)
    --TriggerEvent('vorp:getCharacter', _source, function(user)
		local count = VorpInv.getItemCount(_source, "a_c_fishbluegil_01_sm")
		if count >= 1 then
		
			VorpInv.subItem(_source,"a_c_fishbluegil_01_sm", 1)
			
          TriggerClientEvent('def_cookfood:cookmeat', _source)
		  
          Citizen.Wait(26000)
		  
            VorpInv.addItem(_source,"consumable_bluegill", 1)
            TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Cotto!", "Hai cucinato la carne!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Hai bisogno della carne cruda", "menu_textures", "cross", 3000)
        end
    end)
--end)
------------------------------------------------------------------------------------
local data = {}
TriggerEvent("redemrp_inventory:getData",function(call)
    data = call
end)

RegisterServerEvent("RegisterUsableItem:cookedmeat")
AddEventHandler("RegisterUsableItem:cookedmeat", function(source)
    local _source = source
    TriggerClientEvent("theranch_cooking:setPHealth", _source)
    VorpInv.subItem(_source, "cookedmeat", 1)
    TriggerClientEvent("redemrp_notification:start", _source, "Hai mangiato", 3, "success")
end)


RegisterServerEvent("theranch_cooking:setHealthS")
AddEventHandler("theranch_cooking:setHealthS", function(source, target)
    local _source = source
    TriggerEvent("vorp:getCharacter", target, function()
        TriggerClientEvent("theranch_cooking:setHealthC", target)
    end)
    VorpInv.subItem(_source, "mbandage", 1)
    TriggerClientEvent("redemrp_notification:start", _source, "Hai mangiato", 3, "success")
end)

---------------------------------------ACQUA--------------------------------------------------

RegisterServerEvent('def_cookfood:getwater')
AddEventHandler("def_cookfood:getwater", function(name, weapon)
    local _source = tonumber(source)
    local User = VorpCore.getUser(_source)
    local Character = VorpCore.getUsedCharacter
    
        local count = VorpInv.getItemCount(_source, "dirtywater")

		if count >= 1 then
		
		    VorpInv.subItem(_source,"dirtywater", 1)
			
            TriggerClientEvent('def_cookfood:clean', _source)
		  
            Citizen.Wait(26000)
		  
            VorpInv.addItem(_source,"acqua", 1)
            TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Depurato!", "Hai depurato l'acqua!", "generic_textures", "tick", 3000)
        else
            TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Hai bisogno di acqua sporca", "menu_textures", "cross", 3000)
        end
end)

RegisterServerEvent("RegisterUsableItem:emptybottle")
AddEventHandler("RegisterUsableItem:emptybottle", function(source)
    TriggerClientEvent('ml_camping:Getwater', source)
end)

RegisterNetEvent("collect")
AddEventHandler("collect", function()

    if VorpInv.getItemCount(source, "emptybottle") > 0 then
        VorpInv.addItem(source,"dirtywater", 1)
        TriggerClientEvent("vorp:NotifyLeft", source, "~t6~Ottimo!", "Hai raccolto acqua sporca!", "generic_textures", "tick", 3000)
        VorpInv.subItem(source,"emptybottle", 1)
    else
        TriggerClientEvent("vorp:NotifyLeft", source, "~t6~Ottimo!", "Non hai una bottiglia vuota!", "generic_textures", "tick", 3000)
    end
end)