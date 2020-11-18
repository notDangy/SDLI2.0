VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("vorp_ml_policejob:checkjob")
AddEventHandler("vorp_ml_policejob:checkjob", function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter         
    -- print(Character.job)
    if Character.job == 'Sceriffo' then
        TriggerClientEvent('vorp_ml_policejob:open', _source)
    else
        -- print('not authorized')
        --  TriggerClientEvent("vorp:Tip", _source, _U('no_autorizado'), 4000) -- from server side
    end

end)

RegisterServerEvent("vorp_ml_policejob:checkjob2")
AddEventHandler("vorp_ml_policejob:checkjob2", function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter    
    -- print(Character.job)
    if Character.job == 'Sceriffo' then
        TriggerClientEvent('vorp_ml_policejob:open2', _source)
    else
        -- print('not authorized')
        --TriggerClientEvent("vorp:Tip", _source, _U('no_autorizado'), 4000) -- from server side
    end
end)

--cuff

RegisterServerEvent('vorp_ml_policejob:cuffplayer')
AddEventHandler('vorp_ml_policejob:cuffplayer', function(target)
        local _source = source
        TriggerClientEvent('vorp_ml_policejob:cuff', target)
        -- print('servercuff')
        TriggerClientEvent("vorp:Tip", _source, _U('poner_esposas'), 4000) -- from server side
end)

RegisterServerEvent('vorp_ml_policejob:metervehiculo')
AddEventHandler('vorp_ml_policejob:metervehiculo', function(target)
        TriggerClientEvent('vorp_ml_policejob:meter', target)
        -- print('servercuff')
        
end)

RegisterServerEvent('vorp_ml_policejob:sacarvehiculo')
AddEventHandler('vorp_ml_policejob:sacarvehiculo', function(target)
    TriggerClientEvent('vorp_ml_policejob:sacar', target)
    -- print('servercuff')
        
end)

RegisterServerEvent('vorp_ml_policejob:uncuffplayer')
AddEventHandler('vorp_ml_policejob:uncuffplayer', function(target)
    local _source = source
    TriggerClientEvent('vorp_ml_policejob:uncuff', target)
    -- print('serveruncuff')
    TriggerClientEvent("vorp:Tip", _source, _U('quitar_esposas'), 4000) -- from server side
end)

--lasso


RegisterServerEvent('vorp_ml_policejob:lassoplayer')
AddEventHandler('vorp_ml_policejob:lassoplayer', function(target)
    local _source = source
    --TriggerClientEvent('vorp_ml_policejob:lasso', target)
	TriggerClientEvent('vorp_ml_policejob:hogtie', target)
    -- print('serverlasso')
    TriggerClientEvent("vorp:Tip", _source, _U('atado'), 4000) -- from server side
end)
----------------- DOCUMENTI ---------------
RegisterServerEvent("vanelicenze:cacciatoreditaglie")
AddEventHandler("vanelicenze:cacciatoreditaglie", function(target)
    local _source = source
	local count = VorpInv.getItemCount(source, "licenzataglie")
		if count == 0 then
			VorpInv.addItem(_source, 'licenzataglie',1)
			TriggerClientEvent("vorp:TipRight", _source, "Hai ritirato una Licenza da Cacciatore di Taglie", 4000)
		else
			TriggerClientEvent("vorp:TipRight", _source, "Ne hai gia uno", 4000)
		end
end)

RegisterServerEvent("vanelicenze:documenti")
AddEventHandler("vanelicenze:documenti", function(target)
    local _source = source
	local count = VorpInv.getItemCount(source, "documento")
		if count < 5 then
			VorpInv.addItem(_source, 'documento',1)
			TriggerClientEvent("vorp:TipRight", _source, "Hai validato il documento", 4000)
		else
			TriggerClientEvent("vorp:TipRight", _source, "Ne hai gia abbastanza", 4000)
		end
end)

RegisterServerEvent("vanelicenze:cacciatore")
AddEventHandler("vanelicenze:cacciatore", function(target)
    local _source = source
	local count = VorpInv.getItemCount(source, "licenzacaccia")
		if count == 0 then
			VorpInv.addItem(_source, 'licenzacaccia',1)
			TriggerClientEvent("vorp:TipRight", _source, "Hai ritirato una Licenza da Cacciatore", 4000)
		else
			TriggerClientEvent("vorp:TipRight", _source, "Ne hai gia uno", 4000)
		end
end)