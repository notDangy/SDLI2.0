VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

-- CRAFTING VODKA
RegisterServerEvent('wc_vodka')
AddEventHandler('wc_vodka', function()
    local _source = source
    local count = VORP.getItemCount(_source, "cereali")
    local count2 = VORP.getItemCount(_source, "sugar")
    local count3 = VORP.getItemCount(_source, "patate")
    local count4 = VORP.getItemCount(_source, "acqua")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 2 and count2 >= 1 and count3 >= 2 and count4 >= 1 then
         
        VORP.subItem(_source, "cereali", 2)
        VORP.subItem(_source, "sugar", 1)
        VORP.subItem(_source, "patate", 2)
        VORP.subItem(_source, "acqua", 1)

        
        TriggerClientEvent("progressbar:startSaloon", _source)

        Wait(20000)

        VORP.addItem(_source, "vodka", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato della Vodka', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 2 patate, 1 acqua pulita, 2 cereali ed 1 zucchero.', 4500)
    end      
end)


-- CRAFTING WISKEY
RegisterServerEvent('wc_wiskey')
AddEventHandler('wc_wiskey', function()
    local _source = source
    local count = VORP.getItemCount(_source, "cereali")
    local count2 = VORP.getItemCount(_source, "acqua")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 2 and count2 >= 2 then
         
        VORP.subItem(_source, "cereali", 2)
        VORP.subItem(_source, "acqua", 2)

        
        TriggerClientEvent("progressbar:startSaloon", _source)

        Wait(20000)

        VORP.addItem(_source, "whisky", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato del Whiskey', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 2 acqua pulita e 2 cereali.', 4500)
    end      
end)


-- CRAFTING BIRRA
RegisterServerEvent('wc_birra')
AddEventHandler('wc_birra', function()
    local _source = source
    local count = VORP.getItemCount(_source, "cereali")
    local count2 = VORP.getItemCount(_source, "acqua")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 2 and count2 >= 2 then
         
        VORP.subItem(_source, "cereali", 2)
        VORP.subItem(_source, "acqua", 2)

        
        TriggerClientEvent("progressbar:startSaloon", _source)

        Wait(20000)

        VORP.addItem(_source, "birra", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato della Birra', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 2 acqua pulita e 2 cereali.', 4500)
    end      
end)


-- CRAFTING RHUM
RegisterServerEvent('wc_rhum')
AddEventHandler('wc_rhum', function()
    local _source = source
    local count = VORP.getItemCount(_source, "sugar")
    local count2 = VORP.getItemCount(_source, "acqua")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 2 then
         
        VORP.subItem(_source, "sugar", 1)
        VORP.subItem(_source, "acqua", 2)

        
        TriggerClientEvent("progressbar:startSaloon", _source)

        Wait(20000)

        VORP.addItem(_source, "rum", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato del Rum', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 2 acqua pulita e 1 zucchero.', 4500)
    end      
end)

-- CRAFTING SIDRO DI MELE
RegisterServerEvent('wc_sidro')
AddEventHandler('wc_sidro', function()
    local _source = source
    local count = VORP.getItemCount(_source, "sugar")
    local count2 = VORP.getItemCount(_source, "acqua")
    local count3 = VORP.getItemCount(_source, "mela")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 2 and count3 >= 2 then
         
        VORP.subItem(_source, "sugar", 1)
        VORP.subItem(_source, "acqua", 2)
        VORP.subItem(_source, "mela", 2)

        
        TriggerClientEvent("progressbar:startSaloon", _source)

        Wait(20000)

        VORP.addItem(_source, "sidro", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato del Sidro di Mele', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 2 acqua pulita, 2 mela e 1 zucchero.', 4500)
    end      
end)

-- CRAFTING STUFATO DI CARNE
RegisterServerEvent('wc_stufatodicervo')
AddEventHandler('wc_stufatodicervo', function()
    local _source = source
    local count = VORP.getItemCount(_source, "meat_cervo")
    local count2 = VORP.getItemCount(_source, "patate")
    local count3 = VORP.getItemCount(_source, "pomodori")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 2 and count2 >= 2 and count3 >= 2 then
         
        VORP.subItem(_source, "meat_cervo", 2)
        VORP.subItem(_source, "patate", 2)
        VORP.subItem(_source, "pomodori", 2)

        
        TriggerClientEvent("progressbar:startSaloon", _source)

        Wait(20000)

        VORP.addItem(_source, "stufatodicarne", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato dello Stufato di Carne', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 2 cervo, 2 patate e 2 pomodoro.', 4500)
    end      
end)

-- CRAFTING STUFATO DI PESCE
RegisterServerEvent('wc_stufatodipesce')
AddEventHandler('wc_stufatodipesce', function()
    local _source = source
    local count = VORP.getItemCount(_source, "a_c_fishrockbass_01_sm")
    local count2 = VORP.getItemCount(_source, "patate")
    local count3 = VORP.getItemCount(_source, "carote")

    local ammoList = {
    ["nothing"] = 0
    }

    local compsList = {
    ["nothing"] = 0
    }
        
    if count >= 1 and count2 >= 2 and count3 >= 2 then
         
        VORP.subItem(_source, "a_c_fishrockbass_01_sm", 1)
        VORP.subItem(_source, "patate", 2)
        VORP.subItem(_source, "carote", 2)

        
        TriggerClientEvent("progressbar:startSaloon", _source)

        Wait(20000)

        VORP.addItem(_source, "stufatodipesce", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai preparato dello Stufato di Pesce', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 1 rockbass, 2 patata e 2 carota.', 4500)
    end      
end)

RegisterServerEvent('saloon:checkgroup')
AddEventHandler('saloon:checkgroup', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter        
    if Character.job == "Saloon" or Character.job=="CapoSaloon" then
        TriggerClientEvent('saloon:checkgroupcl', _source)
    end
  
end)