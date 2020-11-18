VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

--------------------
----- ARMI VIP -----
--------------------

-- COLTELLO JAWBONE
RegisterServerEvent('mn_jawbone')
AddEventHandler('mn_jawbone', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_MELEE_KNIFE_JAWBONE", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un Coltello Mandibola', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- ARCO MIGLIORATO
RegisterServerEvent('mn_improved')
AddEventHandler('mn_improved', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_BOW_IMPROVED", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un Arco Migliorato', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- CATTLEMAN MEXICAN
RegisterServerEvent('mn_revmex')
AddEventHandler('mn_revmex', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REVOLVER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_CATTLEMAN_MEXICAN", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una revolver mexican', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- DOUBLE ACTION AZZARDO
RegisterServerEvent('mn_revgamb')
AddEventHandler('mn_revgamb', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REVOLVER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_DOUBLEACTION_GAMBLER", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una revolver gambler', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- REVOLVER NAVY
RegisterServerEvent('mn_revnavy')
AddEventHandler('mn_revnavy', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REVOLVER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_NAVY", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una revolver navy', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- DOPPIETTA ESOTICA
RegisterServerEvent('mn_doppeso')
AddEventHandler('mn_doppeso', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_SHOTGUN"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una doppietta exotic', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-------------------------
----- ARMI ILLEGALI -----
-------------------------

-- CARCANO
RegisterServerEvent('mn_carc')
AddEventHandler('mn_carc', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_RIFLE"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_SNIPERRIFLE_CARCANO", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un Carcano', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- ROLLING BLOCK
RegisterServerEvent('mn_roll')
AddEventHandler('mn_roll', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_RIFLE"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_SNIPERRIFLE_ROLLINGBLOCK", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un Rolling Block', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- SPRINGFIELD
RegisterServerEvent('mn_spring')
AddEventHandler('mn_spring', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_RIFLE"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_RIFLE_SPRINGFIELD", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato uno Springfield', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- POMPA
RegisterServerEvent('mn_shot')
AddEventHandler('mn_shot', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_SHOTGUN"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_SHOTGUN_PUMP", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un fucile a pompa', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- POMPA A RIPETIZIONE
RegisterServerEvent('mn_repshot')
AddEventHandler('mn_repshot', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_SHOTGUN"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_SHOTGUN_REPEATING", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato uno shotgun a ripetizione', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- SEMI AUTO SHOTGUN
RegisterServerEvent('mn_semiautoshot')
AddEventHandler('mn_semiautoshot', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_SHOTGUN"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_SHOTGUN_SEMIAUTO", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un semi-auto shotgun', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- DINAMITE
RegisterServerEvent('mn_dinamite')
AddEventHandler('mn_dinamite', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_DYNAMITE"] = 8
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_THROWN_DYNAMITE", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato della dinamite', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- MOLOTOV
RegisterServerEvent('mn_molotov')
AddEventHandler('mn_molotov', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_MOLOTOV"] = 8
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_THROWN_MOLOTOV", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato delle Molotov', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)


-------------------------
----- ITEM ILLEGALI -----
-------------------------

-- GRIMALDELLO
RegisterServerEvent('mn_grimaldello')
AddEventHandler('mn_grimaldello', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.addItem(_source, "lockpick", 1)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un grimaldello', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- SEMI DI MAIS
RegisterServerEvent('mn_cornseed')
AddEventHandler('mn_cornseed', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.addItem(_source, "cornseed", 10)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato dei semi di mais', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-------------------------
------ ARMI LEGALI ------
-------------------------

-- REVOLCER CATTLEMAN
RegisterServerEvent('mn_cattleman')
AddEventHandler('mn_cattleman', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REVOLVER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_CATTLEMAN", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una cattleman', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- LEMAT
RegisterServerEvent('mn_lemat')
AddEventHandler('mn_lemat', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REVOLVER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_LEMAT", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una lemat', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- SCHOFIELD
RegisterServerEvent('mn_schofield')
AddEventHandler('mn_schofield', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REVOLVER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_SCHOFIELD", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una schofield', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- m1899
RegisterServerEvent('mn_m1899')
AddEventHandler('mn_m1899', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_PISTOL"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_PISTOL_M1899", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una M1899', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- SEMIAUTO
RegisterServerEvent('mn_semiautomatica')
AddEventHandler('mn_semiautomatica', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_PISTOL"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_PISTOL_SEMIAUTO", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una Semi Automatica', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- VOLCANIC
RegisterServerEvent('mn_volcanic')
AddEventHandler('mn_volcanic', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_PISTOL"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_PISTOL_VOLCANIC", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una Volcanic', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- DOPPIETTA
RegisterServerEvent('mn_doppietta')
AddEventHandler('mn_doppietta', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_SHOTGUN"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_SHOTGUN_DOUBLEBARREL", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una doppietta', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- HENRY
RegisterServerEvent('mn_henry')
AddEventHandler('mn_henry', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REPEATER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REPEATER_HENRY", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un Henry', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- CARABINA
RegisterServerEvent('mn_carabina')
AddEventHandler('mn_carabina', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REPEATER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REPEATER_CARBINE", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato una carabina', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- WINCHESTER
RegisterServerEvent('mn_winchester')
AddEventHandler('mn_winchester', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_REPEATER"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_REPEATER_WINCHESTER", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un Winchester', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- BOLT ACTION
RegisterServerEvent('mn_boltaction')
AddEventHandler('mn_boltaction', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["AMMO_RIFLE"] = 100
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:removeMoney", _source, 0, 1)

        VORP.createWeapon(_source, "WEAPON_RIFLE_BOLTACTION", ammoList, compsList)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai Comprato un Bolt Action', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-------------------------
--------- SOLDI ---------
-------------------------

-- 1 k
RegisterServerEvent('mn_1k')
AddEventHandler('mn_1k', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:addMoney", _source, 0, 1000)

        TriggerClientEvent("vorp:TipBottom", _source, 'Ora sei ricco, comprati della dignitá, coglione.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- 10 k
RegisterServerEvent('mn_10k')
AddEventHandler('mn_10k', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:addMoney", _source, 0, 10000)

        TriggerClientEvent("vorp:TipBottom", _source, 'Ora sei ricco, comprati della dignitá, coglione.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- 100 k
RegisterServerEvent('mn_100k')
AddEventHandler('mn_100k', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:addMoney", _source, 0, 100000)

        TriggerClientEvent("vorp:TipBottom", _source, 'Ora sei ricco, comprati della dignitá, coglione.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)

-- 1 MILIONE
RegisterServerEvent('mn_1kk')
AddEventHandler('mn_1kk', function()

    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local money = Character.money
   
    local ammoList = {
        ["nothing"] = 0
        }
    
    local compsList = {
        ["nothing"] = 0
        }

    if money >= 1 then
        
        TriggerEvent("vorp:addMoney", _source, 0, 1000000)

        TriggerClientEvent("vorp:TipBottom", _source, 'Ora sei ricco, comprati della dignitá, coglione.', 2000)        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Non hai nemmeno 1$, poveraccio.', 4500)
    end      
end)
