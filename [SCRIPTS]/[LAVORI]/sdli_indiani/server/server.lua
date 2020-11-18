VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


-- CRAFTING TONICO INDIANI
RegisterServerEvent('wc_tonico_aug')
AddEventHandler('wc_tonico_aug', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "acqua")
    local count2 = VORP.getItemCount(_source, "oppio")
    local count3 = VORP.getItemCount(_source, "p_belladonna")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 4 and count2 >= 5 and count3 >= 4 then
         
        VORP.subItem(_source, "acqua", 4)
        VORP.subItem(_source, "oppio", 5)
        VORP.subItem(_source, "p_belladonna", 4)

        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.addItem(_source, "tonico_aug", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato Estratto della terra.', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 4 acqua, 5 oppio, 4 belladonna. ', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING FRECCE NORMALI
RegisterServerEvent('wc_arcofreccebase')
AddEventHandler('wc_arcofreccebase', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "feather")
    local count2 = VORP.getItemCount(_source, "ceppino")
    local count3 = VORP.getItemCount(_source, "ferro")

    local ammoList = {
    ["AMMO_ARROW"] = 40
    }

    local compsList = {
    ["nothing"] = 0
    }
    
    if count >= 5 and count2 >= 2 and count3 >= 2 then
         
        VORP.subItem(_source, "feather", 5)
        VORP.subItem(_source, "ceppino", 2)
        VORP.subItem(_source, "ferro", 2)
        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_BOW", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato 40 frecce ed un arco.', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 5 piume, 2 ceppi di pino, 2 ferro.', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING FRECCE AVVELENATE
RegisterServerEvent('wc_arcofrecceavvelenate')
AddEventHandler('wc_arcofrecceavvelenate', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "feather")
    local count2 = VORP.getItemCount(_source, "ceppino")
    local count3 = VORP.getItemCount(_source, "veleno_s")
    local count4 = VORP.getItemCount(_source, "ferro")

    local ammoList = {
    ["AMMO_ARROW_POISON"] = 8
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 3 and count2 >= 2 and count3 >= 1 and count4 >= 2 then
         
        VORP.subItem(_source, "feather", 3)
        VORP.subItem(_source, "ceppino", 2)
        VORP.subItem(_source, "veleno_s", 1)
        VORP.subItem(_source, "ferro", 2)
        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_BOW", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato 8 frecce avvelenate ed un arco.', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 3 piume, 2 ceppi di pino, 2 ferro, 1 estratto di veleno.', 4500)
        print('noitemsrequired')
    end      
end)

-- CRAFTING ARCO
--RegisterServerEvent('wc_arco')
--AddEventHandler('wc_arco', function()
--    local _source = source
--    print('gotid')
--    local count = VORP.getItemCount(_source, "ceppino")
--    local count2 = VORP.getItemCount(_source, "acciaio")

--    local ammoList = {
--    ["nothing"] = 0
--    }

--    local compsList = {
--    ["nothing"] = 0
--    }

--    if count >= 10 and count2 >= 2 then
         
--        VORP.subItem(_source, "ceppino", 10)
--        VORP.subItem(_source, "acciaio", 2)

        
--        TriggerClientEvent("progressbar:start", _source)

--        Wait(20000)

--        VORP.createWeapon(_source, "WEAPON_BOW", ammoList, compsList)

--        TriggerClientEvent("vorp:TipBottom", _source, 'Hai creato un arco', 2000)
        
    
--    else
--        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 10 pino e 2 acciaio.', 4500)
--        print('noitemsrequired')
--    end      
--end)

-- CRAFTING TOMAHAWK
RegisterServerEvent('wc_tomahawk')
AddEventHandler('wc_tomahawk', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "ceppino")
    local count2 = VORP.getItemCount(_source, "ferro")
    local count3 = VORP.getItemCount(_source, "acciaio")

    local ammoList = {
    ["AMMO_TOMAHAWK"] = 1
    }

    local compsList = {
    ["nothing"] = 0
    }
   
    if count >= 1 and count2 >= 2 and count3 >= 3 then
         
        VORP.subItem(_source, "ceppino", 1)
        VORP.subItem(_source, "ferro", 2)
        VORP.subItem(_source, "acciaio", 3)

        
        TriggerClientEvent("progressbar:startIndiani", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_THROWN_TOMAHAWK", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai creato un tomahawk.', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 1 ceppo di pino, 3 acciaio e 2 ferro.', 4500)
        print('noitemsrequired')
    end      
end)

RegisterServerEvent('indiani:checkgroup')
AddEventHandler('indiani:checkgroup', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter        
    if Character.job == "Indiano" or Character.job=="CapoIndiano" then
        TriggerClientEvent('indiani:checkgroupcl', _source)
    end
  
end)