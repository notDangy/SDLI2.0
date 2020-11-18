
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)
--- RACCOLTA -----
RegisterServerEvent('vorp:itemreward')
AddEventHandler('vorp:itemreward', function()
	local _source = source
	local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 

	math.randomseed(os.time())     
	local rng = math.random(1, 20)

	if rng == 1 then
		TriggerClientEvent("vorp:TipRight", source, "Non hai trovato nulla", 5000)
					
	elseif rng > 1 and rng < 10 then
		local count = VorpInv.getItemCount(source, "rocks")
		if count >= 30 then
			TriggerClientEvent("vorp:TipRight", source, "Non hai abbastanza spazio", 5000)
		else
			TriggerClientEvent("vorp:TipRight", source, "Hai trovato della Pietra Sedimentaria", 5000)
			VorpInv.addItem(_source, 'rocks', math.random(3,5) )
		end
						
	elseif rng >= 10 and rng < 15 then
		local count = VorpInv.getItemCount(source, "magnetite")
		if count >= 20 then
			TriggerClientEvent("vorp:TipRight", source, "Non hai abbastanza spazio", 5000)
		else
			TriggerClientEvent("vorp:TipRight", source, "Hai trovato della Magnetite", 5000)
			VorpInv.addItem(_source, 'magnetite', math.random(1,3))
		end
					
	elseif rng >= 15 and rng <= 20 then
		local count = VorpInv.getItemCount(source, "grafite")
		if count >= 20 then
			TriggerClientEvent("vorp:TipRight", source, "Non hai abbastanza spazio", 5000)
		else
			TriggerClientEvent("vorp:TipRight", source, "Hai trovato della Grafite ", 5000)
			VorpInv.addItem(_source, 'grafite', math.random(1,3) )
		end
	end
end)

--------- PROCESSO ------
RegisterServerEvent("minatore:checkjob")
AddEventHandler("minatore:checkjob", function()
    local _source = source
	local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter  

	TriggerEvent('dangy_stress:getStress', _source, function(stress)
		if Character.job ~= "Armaiolo" and stress < 100 then
			TriggerClientEvent("minatore:updatejob", _source)
		else
			TriggerClientEvent("vorp:TipRight", _source, "Sei affaticato! Torna quando ti sarai riposato", 4000)
		end
	end)
	
	
end)

RegisterServerEvent("vane_processa:pietra")
AddEventHandler("vane_processa:pietra", function()
	local _source = source
	local count = VorpInv.getItemCount(source, "rocks")
	TriggerEvent('dangy_stress:getStress', _source, function(stress)
		if count > 0 and VorpInv.getItemCount(_source, "carbone") + count*2 <= 40 and VorpInv.canCarryItems(_source, count) and stress < 100 then 
			VorpInv.subItem(_source, "rocks", count)
			VorpInv.addItem(_source, "carbone", count*2)
			TriggerClientEvent("vorp:TipRight", source, "Hai processato le pietre", 4000)
		else
			TriggerClientEvent("vorp:TipRight", source, "Sei troppo stanco o non possiedi abbastanza materiale", 4000)
		end
	end)
end)

RegisterServerEvent("vane_processa:ferro")
AddEventHandler("vane_processa:ferro", function()
	local _source = source
	local count = VorpInv.getItemCount(source, "magnetite")
	local count2 = VorpInv.getItemCount(source, "grafite")
	TriggerEvent('dangy_stress:getStress', _source, function(stress)

		if count >= 5 and count2 >= 5 and stress < 100 then 

			VorpInv.subItem(_source, "magnetite", 5)
			VorpInv.subItem(_source, "grafite", 5)

			VorpInv.addItem(_source, "ferro", 3)
			VorpInv.addItem(_source, "acciaio", 3)
			
			TriggerClientEvent("vorp:TipRight", source, "Hai processato del ferro", 4000)
		else
			TriggerClientEvent("vorp:TipRight", source, "Sei troppo stanco o non possiedi abbastanza materiale", 4000)
		end
	end)
end)


RegisterServerEvent("weaponsmith:checkp2")
AddEventHandler("weaponsmith:checkp2", function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 		
    
    if Character.job == 'Armaiolo' or Character.job == "CapoArmaiolo" then
	    TriggerClientEvent('weaponsmith:openp2',_source)
	else
		TriggerClientEvent("vorp:TipRight", _source, 'Non sei armaiolo', 4000)
	end	
		
end)

RegisterServerEvent('miniera:processoarmaiolo')
AddEventHandler('miniera:processoarmaiolo', function(acciaio, ferro, item) 

    local _source = source
    local acciaioa = VorpInv.getItemCount(_source, "acciaio")
    local ferroa = VorpInv.getItemCount(_source, "ferro")

    if acciaioa >= acciaio and ferroa >= ferro then 
        --START PROCESSO
        TriggerClientEvent('miniera:animazionep',_source)
        Wait(10000)

        VorpInv.subItem(_source, "acciaio", tonumber(acciaio))
        VorpInv.subItem(_source, "ferro", tonumber(ferro))

        VorpInv.addItem(_source, item, 1)

        TriggerClientEvent("vorp:TipRight", _source, 'Materiale processato!', 5000)

    else
        TriggerClientEvent("vorp:TipRight", _source, 'Non ha abbastanza materiali!', 5000)
        --NON ABBASTANZA MATERIALI
    end

end)


