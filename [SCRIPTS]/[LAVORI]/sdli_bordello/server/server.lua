VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

-- CRAFTING DAIQUIRI
RegisterServerEvent('bd_daiquiri')
AddEventHandler('bd_daiquiri', function()
    local _source = source
    local count = VORP.getItemCount(_source, "rum")
    local count2 = VORP.getItemCount(_source, "sugar")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 1 then
         
        VORP.subItem(_source, "rum", 1)
        VORP.subItem(_source, "sugar", 1)

        
        TriggerClientEvent("progressbar:startBordello", _source)

        Wait(15000)

        VORP.addItem(_source, "daiquiri", 2)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato un Daiquiri', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti serve 1 rum e 1 zucchero.', 4500)
    end      
end)

-- CRAFTING OLD FASHIODEN
RegisterServerEvent('bd_old')
AddEventHandler('bd_old', function()
    local _source = source
    local count = VORP.getItemCount(_source, "whisky")
    local count2 = VORP.getItemCount(_source, "sugar")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 1 then
         
        VORP.subItem(_source, "whisky", 1)
        VORP.subItem(_source, "sugar", 1)

        
        TriggerClientEvent("progressbar:startBordello", _source)

        Wait(15000)

        VORP.addItem(_source, "oldfashioned", 2)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato un Old Fashioned', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti serve 1 Whiskey e 1 zucchero.', 4500)
    end      
end)

-- CRAFTING PLANTER'S PUNCH
RegisterServerEvent('bd_planter')
AddEventHandler('bd_planter', function()
    local _source = source
    local count = VORP.getItemCount(_source, "rum")
    local count2 = VORP.getItemCount(_source, "sugar")
    local count3 = VORP.getItemCount(_source, "consumable_peach")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 1 and count3 >= 1 then
         
        VORP.subItem(_source, "rum", 1)
        VORP.subItem(_source, "sugar", 1)
        VORP.subItem(_source, "consumable_peach", 1)

        
        TriggerClientEvent("progressbar:startBordello", _source)

        Wait(15000)

        VORP.addItem(_source, "planterspunch", 2)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato un Planter\'s Punch', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti serve 1 rum, 1 zucchero e 1 pesca.', 4500)
    end      
end)

-- CRAFTING VODKA MARTINI
RegisterServerEvent('bd_vodkam')
AddEventHandler('bd_vodkam', function()
    local _source = source
    local count = VORP.getItemCount(_source, "vodka")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 then
         
        VORP.subItem(_source, "vodka", 1)

        
        TriggerClientEvent("progressbar:startBordello", _source)

        Wait(15000)

        VORP.addItem(_source, "vodkamartini", 2)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato un Vodka Martini', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti serve 1 vodka.', 4500)
    end      
end)

-- CRAFTING MOJITO
RegisterServerEvent('bd_mojito')
AddEventHandler('bd_mojito', function()
    local _source = source
    local count = VORP.getItemCount(_source, "rum")
    local count2 = VORP.getItemCount(_source, "sugar")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 1 then
         
        VORP.subItem(_source, "rum", 1)
        VORP.subItem(_source, "sugar", 1)

        
        TriggerClientEvent("progressbar:startBordello", _source)

        Wait(15000)

        VORP.addItem(_source, "mojito", 2)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato un Mojito', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti serve 1 rum e 1 zucchero.', 4500)
    end      
end)



RegisterServerEvent('bordello:checkgroup')
AddEventHandler('bordello:checkgroup', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter        
    if Character.job == "Bordello" then
        TriggerClientEvent('bordello:checkgroupcl', _source)
    end
  
end)