VORP = exports['vorp_core']:vorpAPI()


local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local jail = {}



local jailLocs = {
	
	["valentine1"] = {x=-272.3, y=807.6, z=119.4, x1=-276.3, y1=800.6, z1=119.4},
	["valentine2"] = {x=-273.1, y=812.0, z=119.4, x1=-276.3, y1=800.6, z1=119.4},
	

	["rhodes1"] = {x=1355.6, y=-1302.3, z=77.8, x1=1358.2, y1=-1308.3, z1=77.7},

	["saintdenis1"] = {x=2502.0, y=-1306.4, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},
	["saintdenis2"] = {x=2503.8, y=-1311.0, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},
	["saintdenis3"] = {x=2499.8, y=-1310.9, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},
	["saintdenis4"] = {x=2498.2, y=-1306.6, z=49.0, x1=2519.3, y1=-1308.8, z1=49.9},

	["strawberry1"] = {x=-1812.8, y=-355.2, z=161.4, x1=-1805.3, y1=-351.3, z1=161.4},
	["strawberry2"] = {x=-1811.7, y=-350.4, z=161.5, x1=-1805.3, y1=-351.3, z1=161.4},

	["tumbelweed1"] = {x=-5531.4, y=-2920.4, z=-1.4, x1=-5526.7, y1=-2934.0, z1=199.3},
	["tumbleweed2"] = {x=-5528.4, y=-2926.0, z=-1.4, x1=-5526.7, y1=-2934.0, z1=199.3},
	["tumbleweed3"] = {x=-5529.8, y=-2923.1, z=-1.4, x1=-5526.7, y1=-2934.0, z1=199.3},
	
	["blackwater1"] = {x=-762.7, y=-1263.4, z=44.0, x1=-754.8, y1=-1269.1, z1=44.0},
	["blackwater2"] = {x=-766.7, y=-1264.0, z=44.0, x1=-754.8, y1=-1269.1, z1=44.0},

	["annesburg1"] = {x=2901.5, y=1310.9, z=44.9, x1=-754.8, y1=-1269.1, z1=44.0},
	["annesburg2"] = {x=2902.9, y=1314.7, z=44.9, x1=-754.8, y1=-1269.1, z1=44.0},
}


RegisterServerEvent("vorp:updateJail")
AddEventHandler("vorp:updateJail", function(playerId, steamid, jailName, jailTime)

	local identifier = steamid
	exports.ghmattimysql:execute("UPDATE characters SET jail=@jailname, jailtime=@jailtime WHERE identifier=@id", 
		{['@jailname'] = jailName,['@jailtime'] = tonumber(jailTime), ['@id'] = identifier}, 
		function(result) 
			
	end)
end)

local jailName = ""
local jailTime = 0
local counter = 0
RegisterServerEvent("vorp:getJail")
AddEventHandler("vorp:getJail", function()
	local _source = source
	counter = counter+1
	Wait(counter*50)
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter		
	local identifier = Character.identifier
	exports.ghmattimysql:execute("SELECT jail,jailtime FROM characters WHERE identifier=@id", {['@id']=identifier}, function(result)

		local rformatted = json.encode(result)
		

		for k,v in pairs(result) do 
			for a,b in pairs(v) do
				if a == "jail" then
					jailName = b
				elseif a == "jailtime" then
					jailTime = b
				end
			end
		end


		if jailTime ~= -1 then
			local jailData = getJailData(jailName)
			local jailCoords = {}
			local relLoc = {}

			if jailData ~= nil then
				jailCoords.x,jailCoords.y,jailCoords.z = jailData.x,jailData.y,jailData.z
				relLoc.x1,relLoc.y1,relLoc.z1 = jailData.x1,jailData.y1,jailData.z1
				if jailData ~= nil then
					TriggerEvent("jail:SetJail", _source, jailName, jailTime, jailCoords, relLoc)
				end
			end
		end

	end)
	counter = counter-1
end)

function getJailData(jail) 
	for k,v in pairs(jailLocs) do 
		if jail == k then 
			return v
		end
	end
end

function getJailNameFromCoords(x,y,z) 
	for k,v in pairs(jailLocs) do
		if v.x == x and v.y == y and v.z == z then 
			return k
		end
	end
end

RegisterServerEvent("jail:SetJail")
AddEventHandler("jail:SetJail", function(playerId, name, length, jailCoords, relLoc)
	local _source = playerId
	local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter
	if Character ~= nil then
		table.insert(jail, {Release = (GetGameTimer() + (length * 1000)), Player = Character.identifier, Coords = jailCoords, ReleaseLoc = relLoc})
		TriggerClientEvent("jail:IsInJailClient",_source,true,(GetGameTimer() + (length * 1000)),jailCoords,relLoc)
		TriggerEvent("vorp:updateJail", playerId, Character.identifier, name, length)
	end
	
end)

RegisterServerEvent('jail:IsInJail')
AddEventHandler('jail:IsInJail', function(playerId)
	local _source = source
	local User = VorpCore.getUser(playerId) 
	if User ~= nil then
		local Character = User.getUsedCharacter
		local id = Character.identifier

		for k,v in ipairs(jail) do
			if (v["Player"] == id and v["Release"] > GetGameTimer()) then
				TriggerClientEvent("jail:IsInJailClient", playerId, true, math.ceil((v["Release"] - GetGameTimer()) / 1000), v["Coords"], v["ReleaseLoc"])
				TriggerEvent("vorp:updateJail", playerId, Character.identifier, getJailNameFromCoords(v["Coords"].x, v["Coords"].y, v["Coords"].z), math.ceil((v["Release"] - GetGameTimer()) / 1000))
				--Character.setJailTime(math.ceil((v["Release"] - GetGameTimer()) / 1000))
				return
			end
		end

	end

	TriggerClientEvent("jail:IsInJailClient", _source, false)

	

end)


--[[RegisterServerEvent('jail:checkJailLogin')
AddEventHandler('jail:checkJailLogin', function(source, jailName,jailTime)
	TriggerEvent('vorp:getCharacter', source, function(user)
		if user then
			--[[local jailTime = --[Character.getJailTime()
			local jailName = Character.getJailLoc()
			local jailCoords = {}
			local releaseLoc = {}
			
			if jailTime and jailTime ~= -1 then

				for name,info in pairs(jailLocs) do
					if name == jailName then
						jailCoords.x, jailCoords.y, jailCoords.z = info.x, info.y, info.z
						releaseLoc.x1, releaseLoc.y1, releaseLoc.z1 = info.x1, info.y1, info.z1
						table.insert(jail, {Release = (GetGameTimer() + (jailTime * 1000)), Player = Character.identifier, Coords = jailCoords, ReleaseLoc = releaseLoc})
						break
					end
				end
			end
		end
	end)
end)]]--

RegisterServerEvent('jail:RemoveJail')
AddEventHandler('jail:RemoveJail', function(playerId)

	local User = VorpCore.getUser(playerId) 
    local Character = User.getUsedCharacter
	if Character ~= nil then
		local id = Character.identifier

		for k,v in ipairs(jail) do
			if (v["Player"] == id) then
				table.remove(jail, k)
				TriggerEvent("vorp:updateJail", playerId, Character.identifier, "", -1)
				break
			end
		end

	end

end)


AddEventHandler("playerDropped", function(reason)

	local _source = source

	local steamid
	for k,v in pairs(GetPlayerIdentifiers(_source)) do
			
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamid = v
		end
	end
		
	
	if _source ~= nil then
		
		for k,v in ipairs(jail) do
			if v["Player"] == steamid then
				table.remove(jail, k)
			end
		end
	end
end)
