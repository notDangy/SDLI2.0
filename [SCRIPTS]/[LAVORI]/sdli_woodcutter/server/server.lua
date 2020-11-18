VorpInv = exports.vorp_inventory:vorp_inventoryApi()
local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('woodcutter:checkjob')
AddEventHandler('woodcutter:checkjob', function() 
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter

    TriggerEvent('dangy_stress:getStress', _source, function(stress)
        if Character.job ~= "Armaiolo" and stress < 80 then 
            TriggerClientEvent('art_woodcutter:comienzo',_source)
        else
            TriggerClientEvent("vorp:TipRight", _source, "Sei affaticato! Torna quando ti sarai riposato", 4000)
        end
    end)
end)

RegisterServerEvent('art_woodcutter:cobrar')
AddEventHandler('art_woodcutter:cobrar', function()
    local _source = source
        
    local count = VorpInv.getItemCount(_source, "ceppino")
    local count1 = VorpInv.getItemCount(_source, "cepcedr")
    local count2 = VorpInv.getItemCount(_source, "cepabe")

    

    if VorpInv.canCarryItems(_source, count+count1+count2) and VorpInv.getItemCount(_source, "listpino") + count*2 <= 40 and VorpInv.getItemCount(_source, "listcedr") + count1*2 <= 40 and VorpInv.getItemCount(_source, "listabe") + count2*2 <= 40 then

        VorpInv.subItem(_source, "ceppino", count)
        VorpInv.subItem(_source, "cepcedr", count1)
        VorpInv.subItem(_source, "cepabe", count2)
        Wait(100)

        if count*2 > 0 then VorpInv.addItem(_source, "listpino", count*2) end
        if count1*2> 0 then VorpInv.addItem(_source, "listcedr", count1*2) end
        if count2*2 > 0 then VorpInv.addItem(_source, "listabe", count2*2) end
    else
        TriggerClientEvent("vorp:TipRight", _source, 'Non hai abbastanza spazio nell\'inventario', 4000)
    end
    
end)



RegisterServerEvent('art_woodcutter:givewood')
AddEventHandler('art_woodcutter:givewood', function()
    local _source = source

    math.randomseed(os.time())
    local pino = math.random(5,7)
    local abete = math.random(3,5)
    local cedro = math.random(2,3)

    VorpInv.addItem(_source, "ceppino", pino)
    VorpInv.addItem(_source, "cepabe", abete)
    VorpInv.addItem(_source, "cepcedr", cedro)

end)

RegisterServerEvent("checklogsv")
AddEventHandler("checklogsv", function()
    local _source = source
        local count = VorpInv.getItemCount(_source, "ceppino")
        local count1 = VorpInv.getItemCount(_source, "cepcedr")
        local count2 = VorpInv.getItemCount(_source, "cepabe")
        if count > 0 or count1 > 0 or count2 > 0 then
            TriggerClientEvent("checklogcl", _source, true)
        else
            TriggerClientEvent("checklogcl", _source, false)
        end
end)

RegisterServerEvent("weaponsmith:checkp")
AddEventHandler("weaponsmith:checkp", function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 		
    
    if Character.job == 'Armaiolo' or Character.job == "CapoArmaiolo" then
	    TriggerClientEvent('weaponsmith:openp',_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Non sei armaiolo', 4000)
	end	
		
end)

RegisterServerEvent('artwoodc:processoarmaiolo')
AddEventHandler('artwoodc:processoarmaiolo', function(pino, abete, cedro, item) 

    local _source = source
    local pinoa = VorpInv.getItemCount(_source, "listpino")
    local abetea = VorpInv.getItemCount(_source, "listabe")
    local cedra = VorpInv.getItemCount(_source, "listcedr")

    if pinoa >= pino and abetea >= abete and cedra >= cedro and VorpInv.canCarryItems(_source,1) then 
        --START PROCESSO
        TriggerClientEvent('artwoodc:animazionep',_source)
        Wait(40000)

        VorpInv.subItem(_source, "listpino", tonumber(pino))
        VorpInv.subItem(_source, "listabe", tonumber(abete))
        VorpInv.subItem(_source, "listcedr", tonumber(cedro))

        VorpInv.addItem(_source, item, 1)

        TriggerClientEvent("vorp:TipRight", _source, 'Materiale processato!', 5000)

    else
        TriggerClientEvent("vorp:TipRight", _source, 'Non hai abbastanza materiali!', 5000)
        --NON ABBASTANZA MATERIALI
    end

end)