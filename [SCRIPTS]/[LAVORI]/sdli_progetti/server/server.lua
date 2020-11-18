VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


-- BLUEPRINT CATTLEMAN
RegisterServerEvent('wc_cattlemanbp')
AddEventHandler('wc_cattlemanbp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 33 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 33)

        VORP.addItem(_source, "cattleblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Revolver Cattleman.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 33$.', 4500)
    end      
end)

-- BLUEPRINT LEMAT
RegisterServerEvent('wc_lematbp')
AddEventHandler('wc_lematbp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 51 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 51)

        VORP.addItem(_source, "lematblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Revolver Lemat.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 51$.', 4500)
    end      
end)

-- BLUEPRINT SCHOFIELD
RegisterServerEvent('wc_schofieldbp')
AddEventHandler('wc_schofieldbp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 66 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 66)

        VORP.addItem(_source, "schofieldblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Revolver Schofield.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 66$.', 4500)
    end      
end)

-- BLUEPRINT M1899
RegisterServerEvent('wc_m1899bp')
AddEventHandler('wc_m1899bp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 66.25 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 66.25)

        VORP.addItem(_source, "m1899blueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Pistola M1899.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 66,25$.', 4500)
    end      
end)

-- BLUEPRINT SEMI AUTO
RegisterServerEvent('wc_semiautobp')
AddEventHandler('wc_semiautobp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 55.25 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 55.25)

        VORP.addItem(_source, "semiautoblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Pistola Semi Auto.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 55,25$.', 4500)
    end      
end)

-- BLUEPRINT VOLCANIC
RegisterServerEvent('wc_volcanicbp')
AddEventHandler('wc_volcanicbp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 75.25 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 75.25)

        VORP.addItem(_source, "volcanicblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Pistola Volcanic.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 75,25$.', 4500)
    end      
end)

-- BLUEPRINT DOUBLEBARREL
RegisterServerEvent('wc_doublebarrelcbp')
AddEventHandler('wc_doublebarrelbp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 86.7 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 86.7)

        VORP.addItem(_source, "doublebarrelblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Doppietta.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 86.7$.', 4500)
    end      
end)

-- BLUEPRINT HENRY
RegisterServerEvent('wc_henrybp')
AddEventHandler('wc_henrybp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 161.7 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 161.7)

        VORP.addItem(_source, "henryblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Henry.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 161,70$.', 4500)
    end      
end)

-- BLUEPRINT CARABINE
RegisterServerEvent('wc_carabinebp')
AddEventHandler('wc_carabinebp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 101.7 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 101.7)

        VORP.addItem(_source, "carabineblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Carabina.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 101,7$.', 4500)
    end      
end)

-- BLUEPRINT WINCHESTER
RegisterServerEvent('wc_winchesterbp')
AddEventHandler('wc_winchesterbp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 166.15 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 166.15)

        VORP.addItem(_source, "winchesterblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Winchester.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 166,15$.', 4500)
    end      
end)

-- BLUEPRINT BOLT
RegisterServerEvent('wc_boltbp')
AddEventHandler('wc_boltbp', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 215.15 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 215.15)

        VORP.addItem(_source, "boltblueprint", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato un progetto per Bolt Action.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 215,15$.', 4500)
    end      
end)

-- OLIO PER ARMI
RegisterServerEvent('wc_olioarmi')
AddEventHandler('wc_olioarmi', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    if money >= 0.5 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 0.5)

        VORP.addItem(_source, "cleanshort", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai comprato olio per armi.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Ti servono 0,5$.', 4500)
    end      
end)

RegisterServerEvent('blueprint:checkgroup')
AddEventHandler('blueprint:checkgroup', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 
    print(Character.job)       
    if Character.job == "Armaiolo" or Character.job == "CapoArmaiolo" then
        TriggerClientEvent('blueprint:checkgroupcl', _source)
    end
  
end)