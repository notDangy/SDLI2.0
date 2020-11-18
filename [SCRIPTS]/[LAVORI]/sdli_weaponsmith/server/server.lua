VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


--Revolver
RegisterServerEvent('wc_cattlemanmake')
AddEventHandler('wc_cattlemanmake', function()
    local _source = source
    print('gotid')
    print ("buongiorno")
    local count = VORP.getItemCount(_source, "calciopistolastandard")
    local count2 = VORP.getItemCount(_source, "corpopistola")
    local count3 = VORP.getItemCount(_source, "cannapistola")
    local count4 = VORP.getItemCount(_source, "cattleblueprint")

    local ammoList = {
    ["ammo_bullet_revolver"] = 100
    }

    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciopistolastandard", 1)
        VORP.subItem(_source, "corpopistola", 2)
        VORP.subItem(_source, "cannapistola", 1)
        VORP.subItem(_source, "cattleblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_CATTLEMAN", ammoList, compsList) --Check limit of weapons of your inventory becaouse this not work if you have max weapons.

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_CATTLEMAN", playerped) Not needed, create weapon gives automatically to your inventory.

        --Wait(100)

        --VORP.addBullets(source, "WEAPON_REVOLVER_CATTLEMAN", "AMMO_REVOLVER", 100) Ammo is gived

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai creato una Revolver Cattleman', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, 'Hai bisogno: 1 Calcio Pistola Standard, 2 Corpo Pistola, 1 Canna Pistola, 1 Progetto Cattleman', 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_lematmake')
AddEventHandler('wc_lematmake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciopistolastandard")
    local count2 = VORP.getItemCount(_source, "corpopistola")
    local count3 = VORP.getItemCount(_source, "cannapistola")
    local count4 = VORP.getItemCount(_source, "lematblueprint")
    local ammoList = {
    ["ammo_bullet_revolver"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciopistolastandard", 1)
        VORP.subItem(_source, "corpopistola", 2)
        VORP.subItem(_source, "cannapistola", 1)
        VORP.subItem(_source, "lematblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_LEMAT", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Revolver Lemat', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Pistola Standard, 2 Corpo Pistola, 1 Canna Pistola, 1 Progetto Revolver Lemat", 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_schofieldmake')
AddEventHandler('wc_schofieldmake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciopistolastandard")
    local count2 = VORP.getItemCount(_source, "corpopistola")
    local count3 = VORP.getItemCount(_source, "cannapistola")
    local count4 = VORP.getItemCount(_source, "schofieldblueprint")
    local ammoList = {
    ["ammo_bullet_revolver"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciopistolastandard", 1)
        VORP.subItem(_source, "corpopistola", 2)
        VORP.subItem(_source, "cannapistola", 1)
        VORP.subItem(_source, "schofieldblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REVOLVER_SCHOFIELD", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Revolver Schofield', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Pistola Standard, 2 Corpo Pistola, 1 Canna Pistola, 1 Progetto Revolver Schofield", 4500)
        --print('noitemsrequired')
    end      
end)

--PISTOLE
RegisterServerEvent('wc_m1899make')
AddEventHandler('wc_m1899make', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciopistolamigliorato")
    local count2 = VORP.getItemCount(_source, "corpopistola")
    local count3 = VORP.getItemCount(_source, "cannapistola")
    local count4 = VORP.getItemCount(_source, "m1899blueprint")
    local ammoList = {
    ["ammo_bullet_pistol"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciopistolamigliorato", 1)
        VORP.subItem(_source, "corpopistola", 2)
        VORP.subItem(_source, "cannapistola", 1)
        VORP.subItem(_source, "m1899blueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_PISTOL_M1899", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Pistola M1899', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Pistola Migliorato, 2 Corpo Pistola, 1 Canna Pistola, 1 Progetto Pistola M1899", 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_semiautomake')
AddEventHandler('wc_semiautomake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciopistolamigliorato")
    local count2 = VORP.getItemCount(_source, "corpopistola")
    local count3 = VORP.getItemCount(_source, "cannapistola")
    local count4 = VORP.getItemCount(_source, "semiautoblueprint")
    local ammoList = {
    ["ammo_bullet_pistol"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciopistolamigliorato", 1)
        VORP.subItem(_source, "corpopistola", 2)
        VORP.subItem(_source, "cannapistola", 1)
        VORP.subItem(_source, "semiautoblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_PISTOL_SEMIAUTO", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Pistola Semi-Automatica', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Pistola Migliorato, 2 Corpo Pistola, 1 Canna Pistola, 1 Progetto Pistola Semi-Auto", 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_volcanicmake')
AddEventHandler('wc_volcanicmake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciopistolamigliorato")
    local count2 = VORP.getItemCount(_source, "corpopistola")
    local count3 = VORP.getItemCount(_source, "cannapistola")
    local count4 = VORP.getItemCount(_source, "volcanicblueprint")
    local ammoList = {
    ["ammo_bullet_pistol"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciopistolamigliorato", 1)
        VORP.subItem(_source, "corpopistola", 2)
        VORP.subItem(_source, "cannapistola", 1)
        VORP.subItem(_source, "volcanicblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_PISTOL_VOLCANIC", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Pistola Volcanic', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Pistola Migliorato, 2 Corpo Pistola, 1 Canna Pistola, 1 Progetto Volcanic", 4500)
        --print('noitemsrequired')
    end      
end)

--FUCILI A POMPA
RegisterServerEvent('wc_doublebarrelmake')
AddEventHandler('wc_doublebarrelmake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciofucilestandard")
    local count2 = VORP.getItemCount(_source, "corpofucile")
    local count3 = VORP.getItemCount(_source, "cannafucile")
    local count4 = VORP.getItemCount(_source, "doublebarrelblueprint")
    local ammoList = {
    ["ammo_shotgun"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciofucilestandard", 1)
        VORP.subItem(_source, "corpofucile", 2)
        VORP.subItem(_source, "cannafucile", 1)
        VORP.subItem(_source, "doublebarrelblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_SHOTGUN_DOUBLEBARREL", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Doppietta', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Fucile Standard, 2 Corpo Fucile, 1 Canna Fucile, 1 Progetto Doppietta", 4500)
        --print('noitemsrequired')
    end      
end)

--FUCILI
RegisterServerEvent('wc_henrymake')
AddEventHandler('wc_henrymake', function()
    local _source = source
    print('gotid')
    local count = VORP.getItemCount(_source, "calciofucilestandard")
    local count2 = VORP.getItemCount(_source, "corpofucile")
    local count3 = VORP.getItemCount(_source, "cannafucile")
    local count4 = VORP.getItemCount(_source, "henryblueprint")
    local ammoList = {
    ["ammo_bullet_repeater"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciofucilestandard", 1)
        VORP.subItem(_source, "corpofucile", 2)
        VORP.subItem(_source, "cannafucile", 1)
        VORP.subItem(_source, "henryblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REPEATER_HENRY", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REPEATER_HENRY", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Ripetitore Henry', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Fucile Standard, 2 Corpo Fucile, 1 Canna Fucile, 1 Progetto Ripetitore Henry", 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_carabinemake')
AddEventHandler('wc_carabinemake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciofucilestandard")
    local count2 = VORP.getItemCount(_source, "corpofucile")
    local count3 = VORP.getItemCount(_source, "cannafucile")
    local count4 = VORP.getItemCount(_source, "carabineblueprint")
    local ammoList = {
    ["ammo_bullet_repeater"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciofucilestandard", 1)
        VORP.subItem(_source, "corpofucile", 2)
        VORP.subItem(_source, "cannafucile", 1)
        VORP.subItem(_source, "carabineblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REPEATER_CARBINE", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REVOLVER_DOUBLEACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Carabina a Ripetizione', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Fucile Standard, 2 Corpo Fucile, 1 Canna Fucile, 1 Progetto Carabina Ripetizione", 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_winchestermake')
AddEventHandler('wc_winchestermake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciofucilemigliorato")
    local count2 = VORP.getItemCount(_source, "corpofucile")
    local count3 = VORP.getItemCount(_source, "cannafucile")
    local count4 = VORP.getItemCount(_source, "winchesterblueprint")
    local ammoList = {
    ["ammo_bullet_repeater"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciofucilemigliorato", 1)
        VORP.subItem(_source, "corpofucile", 2)
        VORP.subItem(_source, "cannafucile", 1)
        VORP.subItem(_source, "winchesterblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_REPEATER_WINCHESTER", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_REPEATER_WINCHESTER", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Winchester', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Fucile Migliorato, 2 Corpo Fucile, 1 Canna Fucile, 1 Progetto Winchester", 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent('wc_boltmake')
AddEventHandler('wc_boltmake', function()
    local _source = source
    --print('gotid')
    local count = VORP.getItemCount(_source, "calciofucilemigliorato")
    local count2 = VORP.getItemCount(_source, "corpofucile")
    local count3 = VORP.getItemCount(_source, "cannafucile")
    local count4 = VORP.getItemCount(_source, "boltblueprint")
    local ammoList = {
    ["ammo_bullet_repeater"] = 100
    }
    local compsList = {
    ["nothing"] = 0
    }

        
    if count >= 1 and count2 >= 2 and count3 >= 1 and count4 >= 1 then
         
        VORP.subItem(_source, "calciofucilemigliorato", 1)
        VORP.subItem(_source, "corpofucile", 2)
        VORP.subItem(_source, "cannafucile", 1)
        VORP.subItem(_source, "boltblueprint", 1)

        
        TriggerClientEvent("progressbar:start", _source)

        Wait(20000)

        VORP.createWeapon(_source, "WEAPON_RIFLE_BOLTACTION", ammoList, compsList)

        --Wait(100)

        --VORP.giveWeapon(source, "WEAPON_RIFLE_BOLTACTION", sourceTarget)

        --Wait(100)

        --ORP.addBullets(source, "WEAPON_REVOLVER_DOUBLEACTION", "AMMO_REVOLVER", 100)

        --Wait(200)

        TriggerClientEvent("vorp:TipBottom", _source, 'Hai costruito Bolt Action', 2000)
        
    
    else
        TriggerClientEvent("vorp:TipBottom", _source, "Hai bisogno: 1 Calcio Fucile Migliorato, 2 Corpo Fucile, 1 Canna Fucile, 1 Progetto Bolt Action", 4500)
        --print('noitemsrequired')
    end      
end)

RegisterServerEvent("weaponsmith:check")
AddEventHandler("weaponsmith:check", function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 		
    
    if Character.job == 'Armaiolo' or Character.job == "CapoArmaiolo" then
	    TriggerClientEvent('weaponsmith:open',_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Non sei armaiolo', 4000)
	end	
		
end)


    

