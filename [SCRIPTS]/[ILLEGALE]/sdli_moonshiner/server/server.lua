Inventory = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('ranch:moonshineoriginal')
AddEventHandler("ranch:moonshineoriginal", function(name, weapon)
    local _source = tonumber(source)
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter         
    local count = Inventory.getItemCount(_source, "sugar")
    local count2 = Inventory.getItemCount(_source, "acqua")
    local count3 = Inventory.getItemCount(_source, "corn")
	if count >= 10 and count2 >= 6 and count3 >= 10 then		    
        Inventory.subItem(_source,"sugar", 10) -- number of water u need
        Inventory.subItem(_source,"acqua", 6)
        Inventory.subItem(_source,"corn", 10) -- number of water u need		
        TriggerClientEvent('shiner:moonshine', _source, "original")
            
    else
        --TriggerClientEvent("redemrp_notification:start", _source, 'Suggerimento: credo che tu stia sbagliando la ricetta.', 3, "warning")
        TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Suggerimento: credo che tu stia sbagliando la ricetta.", "menu_textures", "cross", 3000)
    end
end)


RegisterServerEvent("ranch:givemoonshineoriginal")
AddEventHandler("ranch:givemoonshineoriginal", function() 

    local _source = source
    Inventory.addItem(_source,"moonshine_original", 4)
   -- TriggerClientEvent("redemrp_notification:start", _source, "Moonshine cucinato!", 2, "success")
    TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Moonshine", "Moonshine cucinato!", "generic_textures", "tick", 2000)
end)

RegisterServerEvent('ranch:moonshinered')
AddEventHandler("ranch:moonshinered", function(name, weapon)
    local _source = tonumber(source)
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter         
    local count = Inventory.getItemCount(_source, "sugar")
    local count2 = Inventory.getItemCount(_source, "acqua")
    local count3 = Inventory.getItemCount(_source, "corn")
    local count4 = Inventory.getItemCount(_source, "ribes")
	if count >= 15 and count2 >= 7 and count3 >= 15 and count4 >= 10 then		    
        Inventory.subItem(_source,"sugar", 15) -- number of water u need
        Inventory.subItem(_source,"acqua", 7)
        Inventory.subItem(_source,"corn", 15) -- number of water u need
        Inventory.subItem(_source,"ribes", 10)		
        TriggerClientEvent('shiner:moonshine', _source, "red")
            
    else
     --   TriggerClientEvent("redemrp_notification:start", _source, 'Suggerimento: credo che tu stia sbagliando la ricetta.', 3, "warning")
        TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Suggerimento: credo che tu stia sbagliando la ricetta.", "menu_textures", "cross", 3000)
    end
end)

RegisterServerEvent("ranch:givemoonshinered")
AddEventHandler("ranch:givemoonshinered", function() 

    local _source = source
    Inventory.addItem(_source,"moonshine_red", 3)
   -- TriggerClientEvent("redemrp_notification:start", _source, "Moonshine cucinato!", 2, "success")
    TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Moonshine", "Moonshine cucinato!", "generic_textures", "tick", 2000)
end)

RegisterServerEvent('ranch:moonshineblue')
AddEventHandler("ranch:moonshineblue", function(name, weapon)
    local _source = tonumber(source)
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter         
    local count = Inventory.getItemCount(_source, "sugar")
    local count2 = Inventory.getItemCount(_source, "acqua")
    local count3 = Inventory.getItemCount(_source, "corn")
    local count4 = Inventory.getItemCount(_source, "vaniglia")
	if count >= 17 and count2 >= 7 and count3 >= 17 and count4 >= 12 then		    
        Inventory.subItem(_source,"sugar", 17) -- number of water u need
        Inventory.subItem(_source,"acqua", 7)
        Inventory.subItem(_source,"corn", 17) -- number of water u need
        Inventory.subItem(_source,"vaniglia", 12)		
        TriggerClientEvent('shiner:moonshine', _source, "blueflame")
            
    else
    --    TriggerClientEvent("redemrp_notification:start", _source, 'Suggerimento: credo che tu stia sbagliando la ricetta.', 3, "warning")
        TriggerClientEvent("vorp:NotifyLeft", _source, "~e~Errore!", "Suggerimento: credo che tu stia sbagliando la ricetta.", "menu_textures", "cross", 3000)
    end
end)


RegisterServerEvent("ranch:givemoonshineblueflame")
AddEventHandler("ranch:givemoonshineblueflame", function() 

    local _source = source
    Inventory.addItem(_source,"moonshine_blueflame", 2)
   -- TriggerClientEvent("redemrp_notification:start", _source, "Moonshine cucinato!", 2, "success")
    TriggerClientEvent("vorp:NotifyLeft", _source, "~t6~Moonshine", "Moonshine cucinato!", "generic_textures", "tick", 2000)
end)