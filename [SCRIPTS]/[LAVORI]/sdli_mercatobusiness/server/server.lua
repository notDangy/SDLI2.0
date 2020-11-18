VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


------------------
----- SALOON -----
------------------

-- VODKA
RegisterServerEvent('ms_vodka')
AddEventHandler('ms_vodka', function()
    local _source = source
    local count = VORP.getItemCount(_source, "vodka")
   
    if count >= 5 then
         
        VORP.subItem(_source, "vodka", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 vodka', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 vodka.', 850)
    end      
end)

-- WHISKY
RegisterServerEvent('ms_whisky')
AddEventHandler('ms_whisky', function()
    local _source = source
    local count = VORP.getItemCount(_source, "whisky")
   
    if count >= 5 then
         
        VORP.subItem(_source, "whisky", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 whisky', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 whisky.', 850)
    end      
end)

-- BIRRA
RegisterServerEvent('ms_birra')
AddEventHandler('ms_birra', function()
    local _source = source
    local count = VORP.getItemCount(_source, "birra")
   
    if count >= 5 then
         
        VORP.subItem(_source, "birra", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 birra', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 birra.', 850)
    end      
end)

-- RUHM
RegisterServerEvent('ms_rum')
AddEventHandler('ms_rum', function()
    local _source = source
    local count = VORP.getItemCount(_source, "rum")
   
    if count >= 5 then
         
        VORP.subItem(_source, "rum", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 rum', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 rum.', 850)
    end      
end)

-- SIDRO DI MELE
RegisterServerEvent('ms_sidro')
AddEventHandler('ms_sidro', function()
    local _source = source
    local count = VORP.getItemCount(_source, "sidro")
   
    if count >= 5 then
         
        VORP.subItem(_source, "sidro", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 sidro', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 sidro.', 850)
    end      
end)

--------------------
----- BORDELLO -----
--------------------

-- DAIQUIRI
RegisterServerEvent('ms_daiquiri')
AddEventHandler('ms_daiquiri', function()
    local _source = source
    local count = VORP.getItemCount(_source, "daiquiri")
   
    if count >= 5 then
         
        VORP.subItem(_source, "daiquiri", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 Daiquiri', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 Daiquiri.', 850)
    end      
end)

-- OLD FASHIONED
RegisterServerEvent('ms_of')
AddEventHandler('ms_of', function()
    local _source = source
    local count = VORP.getItemCount(_source, "oldfashioned")
   
    if count >= 5 then
         
        VORP.subItem(_source, "oldfashioned", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 Old Fashioned', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 Old Fashioned.', 850)
    end      
end)

-- PLANTER'S PUNCH
RegisterServerEvent('ms_pp')
AddEventHandler('ms_pp', function()
    local _source = source
    local count = VORP.getItemCount(_source, "planterspunch")
   
    if count >= 5 then
         
        VORP.subItem(_source, "planterspunch", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 planter\'s punch', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 planter\'s punch.', 850)
    end      
end)

-- VODKA MARTINI
RegisterServerEvent('ms_vm')
AddEventHandler('ms_vm', function()
    local _source = source
    local count = VORP.getItemCount(_source, "vodkamartini")
   
    if count >= 5 then
         
        VORP.subItem(_source, "vodkamartini", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 vodkamartini', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 vodkamartini.', 850)
    end      
end)

-- MOJITO
RegisterServerEvent('ms_mojito')
AddEventHandler('ms_mojito', function()
    local _source = source
    local count = VORP.getItemCount(_source, "mojito")
   
    if count >= 5 then
         
        VORP.subItem(_source, "mojito", 5)

        TriggerEvent("vorp:addMoney", _source, 0, 8)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai venduto 5 mojito', 500)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 mojito.', 850)
    end      
end)


-----------------------
----- GROUP CHECK -----
-----------------------

RegisterServerEvent('mercatobusiness:checkgroup')
AddEventHandler('mercatobusiness:checkgroup', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter        
    if Character.job == "Bordello" or Character.job == "CapoSaloon" or Character.job == "Saloon" then
        TriggerClientEvent('mercatobusiness:checkgroupcl', _source)
    end
  
end)