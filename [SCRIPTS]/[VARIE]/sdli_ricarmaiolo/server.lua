local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("ricettarioarmaiolo:checkgroupsv")
AddEventHandler("ricettarioarmaiolo:checkgroupsv", function() 
    local _source = source

    local User = VorpCore.getUser(_source)
    local Character = User.getUsedCharacter

    if Character.job == "Armaiolo" then 
        TriggerClientEvent("ricettarioarmaiolo:checkgroupcl", _source)
    else
        TriggerClientEvent("vorp:TipRight", _source, "Non sei Armaiolo", 4000)
    end
end)