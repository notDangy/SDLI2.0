VORP = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local DoorInfo	= {}

RegisterServerEvent('vorp_doorlocks:updatedoorsv')
AddEventHandler('vorp_doorlocks:updatedoorsv', function(source, doorID, cb)
    local _source = tonumber(source)
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter

	if not IsAuthorized(Character.job, Config.DoorList[doorID]) then
		TriggerClientEvent('chatMessage', source, "", {0, 0, 200}, "^1Non hai la chiave!^0")
        return
    else 
        TriggerClientEvent('vorp_doorlocks:changedoor', _source, doorID)
    end
	
end)

RegisterServerEvent('vorp_doorlocks:updateState')
AddEventHandler('vorp_doorlocks:updateState', function(doorID, state, cb)
    local _source = tonumber(source)
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter 		
	
	if type(doorID) ~= 'number' then
		return
	end

	if not IsAuthorized(Character.job, Config.DoorList[doorID]) then
		return
	end

	DoorInfo[doorID] = {}

	TriggerClientEvent('vorp_doorlocks:setState', -1, doorID, state)
    
end)

function IsAuthorized(jobName, doorID)
	for _,job in pairs(doorID.authorizedJobs) do
		print(job, jobName)
		if job == jobName then
			return true
		end
	end

	return false
end
