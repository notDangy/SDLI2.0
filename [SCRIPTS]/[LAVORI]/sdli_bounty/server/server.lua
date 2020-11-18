VORP = exports.vorp_core:vorpAPI()
VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent('vorp_bountyhunting:AddSomeMoney')
AddEventHandler('vorp_bountyhunting:AddSomeMoney', function(enemies)
    local _source = source
    local price = Config.Price
    local xp = Config.Xp
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter  

    TriggerEvent("vorp:addMoney", _source, 0, price*enemies)
end)

RegisterServerEvent("vane:checkjob")
AddEventHandler("vane:checkjob", function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter   
    local count = VorpInv.getItemCount(_source, "licenzataglie")
    -- print(Character.job)
--    if Character.job == 'CacciatoreDiTaglie' or Character.job == 'Sceriffo' then
        
    if count >= 1 then

        TriggerClientEvent('MissionStart', _source)

    else
        -- print('not authorized')
        TriggerClientEvent("vorp:Tip", _source, "Non hai una licenza da Cacciatore di Taglie", 4000) -- from server side
    end
end)