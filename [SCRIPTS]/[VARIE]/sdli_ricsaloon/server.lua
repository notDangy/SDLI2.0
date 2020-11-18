local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("ricettariosaloon:checkgroupsv")
AddEventHandler("ricettariosaloon:checkgroupsv", function() 
    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter

    if Character.job == "Saloon" then 
        TriggerClientEvent("ricettariosaloon:checkgroupcl", _source)
    else
        TriggerClientEvent("vorp:TipRight", _source, "Non sei del Saloon", 4000)
    end
end)