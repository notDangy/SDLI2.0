local stressList = {}

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('dangy_stress:share')
AddEventHandler('dangy_stress:share', function(value) 
    local _source = source
        for k,v in pairs(stressList) do 
            if _source == v.id then
                stressList[k].stress = value
                return 0
            end
        end
        table.insert(stressList, {id = _source, stress = value})

end)

RegisterServerEvent('dangy_stress:getStress')
AddEventHandler('dangy_stress:getStress', function(source, cb)
    for k,v in pairs(stressList) do
        if tonumber(source) == v.id then 
            cb(v.stress)
        end
    end
end)

RegisterServerEvent('dangy_stress:requestStress')

AddEventHandler('dangy_stress:requestStress', function() 
    local _source = source
    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter
    local identifier = Character.identifier

    exports.ghmattimysql:execute("SELECT stress FROM characters WHERE identifier = @id", 
    {
        ['@id'] = identifier,

    }, function(ret) 
        TriggerClientEvent('dangy_stress:modify', _source, tonumber(ret[1].stress))
    end)
end)

AddEventHandler('playerDropped', function(reason) 
    local stress = 0
    local _source = source
    for k,v in pairs(stressList) do 
        if tonumber(source) == v.id then 
            stress = v.stress
            table.remove(stressList, k)
        end
    end

    local steamid
	for k,v in pairs(GetPlayerIdentifiers(_source)) do
			
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamid = v
		end
    end
    
    exports.ghmattimysql:execute("UPDATE characters SET stress = @stress WHERE identifier = @id", 
    {
        ['@stress'] = stress,
        ['@id'] = steamid,

    })

end)

