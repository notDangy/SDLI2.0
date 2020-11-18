VorpInv = exports.vorp_inventory:vorp_inventoryApi()


local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	VorpInv.RegisterUsableItem("pomseed", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "crp_tomatoes_har_aa_sim", "crp_tomatoes_har_aa_sim", "crp_tomatoes_aa_sim", "pomseed")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("broccoliseed", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "crp_broccoli_aa_sim", "crp_broccoli_aa_sim", "crp_broccoli_aa_sim", "broccoliseed")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("caroteseed", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "crp_carrots_sap_ba_sim", "crp_carrots_ba_sim", "crp_carrots_aa_sim", "caroteseed")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("barbaseed", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "crp_carrots_sap_ba_sim", "crp_carrots_sap_ba_sim", "crp_carrots_sap_ba_sim", "barbaseed")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("patateseed", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "crp_carrots_sap_ba_sim", "crp_potato_aa_sim", "crp_potato_aa_sim", "patateseed")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("cerealiseed", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "crp_wheat_sap_long_aa_sim", "crp_wheat_sap_long_ab_sim", "crp_wheat_dry_aa_sim", "cerealiseed")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("cornseed", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "CRP_CORNSTALKS_CB_SIM", "CRP_CORNSTALKS_CA_SIM", "CRP_CORNSTALKS_AB_SIM", "cornseed")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("p_oppio", function(data) 
		local _source = data.source
		TriggerEvent('dangy_stress:getStress', _source, function(stress)
			if stress < 100 then
				TriggerClientEvent('poke_planting:planto1', data.source, "prariepoppy_p", "prariepoppy_p", "prariepoppy_p", "p_oppio")
			end
		end)
	end)

	VorpInv.RegisterUsableItem("wateringcan", function(data) 
		local _source = data.source
		TriggerClientEvent('poke_planting:regar1',data.source)
	end)

	
end)

RegisterServerEvent("poke_planting:removeSeed")
AddEventHandler("poke_planting:removeSeed", function(seed)
	local _source = source
	VorpInv.subItem(_source, seed, 1)
end)




RegisterServerEvent('poke_planting:giveitem')
AddEventHandler('poke_planting:giveitem', function(tipo)
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter         
	local count = math.random(1, 5) --3,8
	
	if tipo == "crp_tomatoes_aa_sim" then
		--TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' pomodori', 3)
		VorpInv.addItem(_source, "pomodori", count)
	elseif tipo == "crp_broccoli_aa_sim" then
	--	TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' broccoli', 3)
		VorpInv.addItem(_source, "broccoli", count)
	elseif tipo == "crp_carrots_aa_sim" then
	--	TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' carote', 3)
		VorpInv.addItem(_source, "carote", count)
	elseif tipo == "crp_carrots_sap_ba_sim" then
	--	TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' barbabietole', 3)
		VorpInv.addItem(_source, "barbabietole", count)	
	elseif tipo == "crp_potato_aa_sim" then
	--	TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' patate', 3)
		VorpInv.addItem(_source, "patate", count)
	elseif tipo == "crp_wheat_dry_aa_sim" then
	--	TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' cereali', 3)
		VorpInv.addItem(_source, "cereali", count)	
	elseif tipo == "CRP_CORNSTALKS_AB_SIM" then
	--	TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' di mais', 3)
		VorpInv.addItem(_source, "corn", count)
	elseif tipo == "prariepoppy_p" then
--	TriggerClientEvent("redemrp_notification:start", _source, 'Hai raccolto '..count..' di oppio', 3)
	VorpInv.addItem(_source, "oppio", count)
	end

end)
