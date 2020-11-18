local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("ricettario:checkgroupsv")
AddEventHandler("ricettario:checkgroupsv", function() 
    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter

    if Character.job == "Medico" then 
        TriggerClientEvent("ricettario:checkgroupcl", _source)
    else
        TriggerClientEvent("vorp:TipRight", _source, "Non sei medico", 4000)
    end
end)