VorpInv = exports.vorp_inventory:vorp_inventoryApi()
VORP = exports.vorp_core:vorpAPI()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_ml_doctorjob:checkjob")
AddEventHandler("vorp_ml_doctorjob:checkjob", function()
    local _source = source
	local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 

	if Character.job == 'Dottore' then
		TriggerClientEvent('vorp_ml_doctorjob:open', _source)
	end

  
end)


RegisterServerEvent( 'vorp_ml_doctorjob:healplayer' )
AddEventHandler( 'vorp_ml_doctorjob:healplayer', function (target)
  TriggerClientEvent('vorp_ml_doctorjob:healed', target)
        --print('server heal test')
end)

RegisterServerEvent( "vorp_ml_doctorjob:reviveplayer" )
AddEventHandler( "vorp_ml_doctorjob:reviveplayer", function(target)
	
	local _source = source
	local _target = target

		
	local medikit = VorpInv.getItemCount(_source, "siringa")

	if medikit > 0 then
		TriggerClientEvent('vorp:resurrectPlayer', _target)
		VorpInv.subItem(_source, "siringa", 1)
		TriggerClientEvent('ml_doctorjob:animation', _source)
		TriggerClientEvent('ml_doctorjob:revived', _target)
	
	else
		TriggerClientEvent("redemrp_notification:start", _source, "Non hai la siringa!", 3, "warning")
	end
	
end)

RegisterServerEvent('doctor:buysiringhe')
AddEventHandler('doctor:buysiringhe', function(n) 

	local _source = source
	local price = 1.5
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	
	if VorpInv.canCarryItems(_source, n) and VorpInv.getItemCount(_source, "siringa") + n <= 10 and Character.money >= n*price then 
		VorpInv.addItem(_source, "siringa", n)
		TriggerEvent('vorp:removeMoney', _source, 0, n*price)
	else

	end

end)

RegisterServerEvent('doctor:checkgroup')
AddEventHandler('doctor:checkgroup', function() 
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter

	print(Character.job)
	if Character.job == "Medico" then 
		TriggerClientEvent('doctor:openmenuclinica', _source)
	end
end)

---CRAFT TONICI---
RegisterServerEvent('doctor:tonicovita')
AddEventHandler('doctor:tonicovita', function() 

	local _source = source

	local count = VorpInv.getItemCount(_source, "acqua")
	local count1 = VorpInv.getItemCount(_source, "fungo_mazza")
	local count2 = VorpInv.getItemCount(_source, "ginseng_americano")

	print(count,count1,count2)

	if count >= 3 and count1 >= 2 and count2 >= 3 and VorpInv.getItemCount(_source, "tonico_c1") + 1 <= 5 then 

		VorpInv.subItem(_source, "acqua", 3)
		VorpInv.subItem(_source, "fungo_mazza", 2)
		VorpInv.subItem(_source, "ginseng_americano", 3)

		TriggerClientEvent("progressbar:startMedico", _source)

        Wait(20000)
		
		VorpInv.addItem(_source, "tonico_c1",1)
	end
end)

RegisterServerEvent('doctor:tonicovita1')
AddEventHandler('doctor:tonicovita1', function() 

	local _source = source

	local count = VorpInv.getItemCount(_source, "acqua")
	local count1 = VorpInv.getItemCount(_source, "vaniglia")
	local count2 = VorpInv.getItemCount(_source, "ginseng_alaska")

	if count >= 4 and count1 >= 3 and count2 >= 4 and VorpInv.getItemCount(_source, "tonico_c1") + 1 <= 5 then 

		VorpInv.subItem(_source, "acqua", 4)
		VorpInv.subItem(_source, "vaniglia", 3)
		VorpInv.subItem(_source, "ginseng_alaska", 4)

		TriggerClientEvent("progressbar:startMedico", _source)

        Wait(20000)
		
		VorpInv.addItem(_source, "tonico_c2",1)
	end
end)

RegisterServerEvent('doctor:elysirenergia')
AddEventHandler('doctor:elysirenergia', function() 

	local _source = source

	local count = VorpInv.getItemCount(_source, "acqua")
	local count1 = VorpInv.getItemCount(_source, "fungo_mazza")
	local count2 = VorpInv.getItemCount(_source, "ribes")

	if count >= 2 and count1 >= 3 and count2 >= 5 and VorpInv.getItemCount(_source, "tonico_c1") + 1 <= 5 then 

		VorpInv.subItem(_source, "acqua", 2)
		VorpInv.subItem(_source, "fungo_mazza", 3)
		VorpInv.subItem(_source, "ribes", 5)

		TriggerClientEvent("progressbar:startMedico", _source)

        Wait(20000)
		
		VorpInv.addItem(_source, "tonico_s1",1)
	end
end)

RegisterServerEvent('doctor:elysirenergia1')
AddEventHandler('doctor:elysirenergia1', function() 

	local _source = source

	local count = VorpInv.getItemCount(_source, "acqua")
	local count1 = VorpInv.getItemCount(_source, "vaniglia")
	local count2 = VorpInv.getItemCount(_source, "salvia")

	if count >= 4 and count1 >= 3 and count2 >= 6 and VorpInv.getItemCount(_source, "tonico_c1") + 1 <= 5 then 

		VorpInv.subItem(_source, "acqua", 4)
		VorpInv.subItem(_source, "vaniglia", 3)
		VorpInv.subItem(_source, "salvia", 6)

		TriggerClientEvent("progressbar:startMedico", _source)

        Wait(20000)

		VorpInv.addItem(_source, "tonico_s2", 1)
	end
end)

RegisterServerEvent('doctor:estrattoveleno')
AddEventHandler('doctor:estrattoveleno', function() 

	local _source = source

	local count = VorpInv.getItemCount(_source, "acqua")
	local count1 = VorpInv.getItemCount(_source, "snakepoison")
	local count2 = VorpInv.getItemCount(_source, "p_belladonna")

	if count >= 5 and count1 >= 5 and count2 >= 3 and VorpInv.getItemCount(_source, "tonico_c1") + 1 <= 5 then 

		VorpInv.subItem(_source, "acqua", 5)
		VorpInv.subItem(_source, "snakepoison", 5)
		VorpInv.subItem(_source, "p_belladonna", 3)

		TriggerClientEvent("progressbar:startMedico", _source)

        Wait(20000)
		
		VorpInv.addItem(_source, "veleno_s",1)
	end
end)

---FINE CRAFT TONICI---


