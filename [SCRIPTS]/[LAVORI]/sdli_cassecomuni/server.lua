VorpInv = exports.vorp_inventory:vorp_inventoryApi()
VORP = exports.vorp_core:vorpAPI()


local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)


------------------------------------------------------- AGGIORNA INVENTARIO PLAYER/CASSA ----------------------------------------

RegisterServerEvent("sdli_casse:GetInventory")
AddEventHandler("sdli_casse:GetInventory", function ()
	local _source = source
    local User = VorpCore.getUser(_source) 
	local Character = User.getUsedCharacter
	        	
			exports.ghmattimysql:execute('SELECT inventory FROM characters WHERE identifier = @identifier', {
				['@identifier'] = {Character.identifier}
			},
			function(pinret)
				local jsonpinv = {}
				if pinret[1]~= nil and pinret[1].inventory ~= nil then
					jsonpinv = pinret[1].inventory
					local tableInv = {}
					for k,v in pairs(json.decode(jsonpinv)) do 
						TriggerEvent('vorpinventory:getLabelFromId', k, function(name) 
							table.insert(tableInv, {Id = k, Label = name, Quantity = v})
						end)
					end

					local weapons = VorpInv.getUserWeapons(_source)
					for k,v in pairs(weapons) do
						table.insert(tableInv, {Id = "["..v["id"]..","..v["name"].."]",Label= getWeaponNameFromId(v["name"]),Quantity=1})
					end

					TriggerClientEvent("saveinventario", _source, tableInv)
			
				end
			end)
end)

RegisterServerEvent("sdli_casse:GetInventoryCassa")
AddEventHandler("sdli_casse:GetInventoryCassa", function(k,v)
	local _source = source
	exports.ghmattimysql:execute('SELECT inventory FROM casse WHERE id = @id AND permission = @group', {
		['@id'] = {k},
		['@group'] = {v}
	},
	function(hinret)
		local jsonhinv = {}
		if hinret[1]~= nil and hinret[1].inventory ~= nil then
			jsonhinv = hinret[1].inventory
			local inv = {}
			if hinret[1].inventory ~= nil then
				for a,b in pairs(json.decode(hinret[1].inventory)) do
					if not isAWeapon(a) then 
						TriggerEvent('vorpinventory:getLabelFromId', a, function(name)
							table.insert(inv, {Id = a, Name = name, Quantity = b})
						end)
					else 
						local tmpstr
						tmpstr = string.gsub(a,"%[","")
						tmpstr = string.gsub(tmpstr,"%]","")
						local splitted = stringSplit(tmpstr,",")
						
						local namew = tostring(splitted[2])
						table.insert(inv, {Id = a, Name = getWeaponNameFromId(namew), Quantity = b})
					end
				end
			end
			TriggerClientEvent("savehouseinventario", _source, inv)
		end	
	end)
end)

------------------------------------------------------ DEPOSITA E PRELEVA ---------------------------------------

RegisterServerEvent("sdli_casse:DepositaItem")
AddEventHandler("sdli_casse:DepositaItem", function (idhouse, k,qt,b)
	local _source = source
	local count = VorpInv.getItemCount(source, k)
	if count == nil then count = 0 end
		if count >= qt or isAWeapon(k) then

				if isAWeapon(k) then
					local tmpstr
					tmpstr = string.gsub(k,"%[","")
					tmpstr = string.gsub(tmpstr,"%]","")
					local splitted = stringSplit(tmpstr,",")
					local idw = tonumber(splitted[1])
					VorpInv.subWeapon(_source,idw)
				else
					VorpInv.subItem(source,k,qt)
				end
				exports.ghmattimysql:execute('SELECT inventory,maxitems FROM casse WHERE id = @idhouse AND permission = @group', {
					['@idhouse'] = {idhouse},
					['@group'] = {b.name}
				},
				function(inret)
					local jsonVar = {}
					if inret[1] ~= nil and inret[1].inventory ~= nil and getItemAomount(json.decode(inret[1].inventory)) + tonumber(qt) <= tonumber(inret[1].maxitems) then
						jsonVar = json.decode(inret[1].inventory)
						if jsonVar[k] ~= nil then
							jsonVar[k] = jsonVar[k] + qt

							if not isAWeapon(k) then
								TriggerEvent("vorpinventory:getLabelFromId", k, function(name) 
								
									TriggerClientEvent("vorp:TipRight", _source, "hai depositato "..qt.." "..name, 4000)

								end)
							else
								TriggerClientEvent("vorp:TipRight", _source, "hai depositato "..qt.." "..k, 4000)
							end
							TriggerClientEvent('cassecomuni:refreshmenu',_source,k,tonumber(qt))
						else
							jsonVar[k] = qt
							if string.sub(k,1,1) ~= "[" then
								TriggerEvent("vorpinventory:getLabelFromId", k, function(name) 
								
									TriggerClientEvent("vorp:TipRight", _source, "hai depositato "..qt.." "..name, 4000)

								end)
							else
								TriggerClientEvent("vorp:TipRight", _source, "hai depositato "..qt.." "..k, 4000)
							end
							TriggerClientEvent('cassecomuni:refreshmenu',_source,k,tonumber(qt))
						end
					elseif getItemAomount(inret[1].inventory) + tonumber(qt) <= tonumber(inret[1].maxitems) then
						jsonVar[k] = qt
						if string.sub(k,1,1) ~= "[" then
								TriggerEvent("vorpinventory:getLabelFromId", k, function(name) 
								
									TriggerClientEvent("vorp:TipRight", _source, "hai depositato "..qt.." "..name, 4000)

								end)
							else
								TriggerClientEvent("vorp:TipRight", _source, "hai depositato "..qt.." "..k, 4000)
							end
						TriggerClientEvent('cassecomuni:refreshmenu',_source,k,tonumber(qt))
					else
						TriggerClientEvent("vorp:TipRight", _source, "Non c'è abbastanza spazio, limite massimo item: " .. tostring(inret[1].maxitems) , 4000)
					end

					exports.ghmattimysql:execute('UPDATE casse SET inventory = @inventory WHERE id = @idhouse', {
						['@idhouse'] = {idhouse},
						['@inventory'] = {json.encode(jsonVar)}
					})
					
					end)	
		else
			TriggerClientEvent("vorp:TipRight", source, "Quantità non valida", 4000)
		end
end) 

RegisterServerEvent("sdli_casse:PrelevaItem")
AddEventHandler("sdli_casse:PrelevaItem", function(k, a,qt,v)
	local _source = source

	math.randomseed(os.time())
	local r = math.floor(math.random()*50)
	Wait(r)

	
	if isAWeapon(a) then
		
		local tmpstr
		tmpstr = string.gsub(a,"%[","")
		tmpstr = string.gsub(tmpstr,"%]","")
		local splitted = stringSplit(tmpstr,",")
	
		local idw = tonumber(splitted[1])
		TriggerEvent("vorpCore:giveWeapon", _source, idw, 0);
	else
		VorpInv.addItem(_source,a,qt)
	end
		TriggerClientEvent("vorp:TipRight", _source, "hai prelevato x"..qt.." di "..a, 4000)
		TriggerClientEvent('cassecomuni:refreshmenu', _source)
		exports.ghmattimysql:execute('SELECT inventory FROM casse WHERE id = @id AND permission = @group', {
			['@id'] = {k},
			['@group'] = {v.name}
		},
			function(prret)
				local Prejson = {}
				if prret[1] ~= nil and prret[1].inventory ~= nil then
					Prejson = json.decode(prret[1].inventory)
					if Prejson[a] ~= nil then
						Prejson[a] = Prejson[a] - qt
					else
						Prejson[a] = qt
					end
				else
					Prejson[a] = qt
				end
	
		exports.ghmattimysql:execute('UPDATE casse SET inventory = @inventory WHERE id = @idhouse AND permission = @permission', {
			['@idhouse'] = {tonumber(k)},
			['@permission'] = {v.name},
			['@inventory'] = {json.encode(Prejson)}
		})
	end)				
end)


----------------------------------------  CHECK LAVORO CASSA ---------------------------------------------------

RegisterServerEvent("sdli_casse:CheckJob")
AddEventHandler("sdli_casse:CheckJob", function(k, v)
	local _source = source
	local User = VorpCore.getUser(_source)
	local Character = User.getUsedCharacter
	local id = Character.identifier
	exports.ghmattimysql:execute('SELECT * FROM casse WHERE id = @id AND permission = @group;' , {
		['@id'] = {tonumber(k)},
		['@group'] = {v.name}
	},
	function(ret)
		if ret[1].permission == Character.job or "Capo"..tostring(ret[1].permission) == tostring(Character.job) then
			TriggerClientEvent("vane:openperso",_source)
		end
	end)
end)


function getItemAomount(cassa) 
	local items = 0
	if type(cassa) ~= "table" then cassa = json.decode(cassa) end
	for k,v in pairs(cassa) do 
		items = items + tonumber(v)
	end
	return items
end

function isAWeapon(str)
	local c = string.sub(str,1,1)
	if c == "[" then 
		return true
	else
		return false
	end
end

function stringSplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

function all_trim(s)
	return s:match( "^%s*(.-)%s*$" )
end

function getWeaponNameFromId(weapon) 
	local weaponNames = {
		{id = "WEAPON_REVOLVER_LEMAT", name = "Revolver Lemant"},
		{id = "WEAPON_MELEE_KNIFE", name = "Coltello"},
		{id = "WEAPON_KIT_CAMERA", name = "Cinepresa"},
		{id = "WEAPON_MELEE_LANTERN_ELECTRIC", name = "Lanterna elettrica"},
		{id = "WEAPON_MELEEE_TORCH", name = "Torcia"},
		{id = "WEAPON_THROWN_THROWING_KNIEVES", name = "Coltelli da lancio"},
		{id = "WEAPON_LASSO", name = "Lasso"},
		{id = "WEAPON_THROWN_TOMAHAWK", name = "Tomahawk"},
		{id = "WEAPON_PISTOL_M1899", name = "Pistola M1899"},
		{id = "WEAPON_PISTOL_MAUSER", name = "Pistola mauser"},
		{id = "WEAPON_PISTOL_VOLCANIC", name = "Pistola volcanic"},
		{id = "WEAPON_REPEATER_CARABINE", name = "Carabina a ripetizione"},
		{id = "WEAPON_REPETER_EVANS", name = "ripetitore evans"},
		{id = "WEAPON_REPEATER_HENRY", name = "Ripetitore Henry"},
		{id = "WEAPON_RIFLE_VARMINT", name = "Fucile Varmint"},
		{id = "WEAPON_REPEATER_WINCHESTER", name = "Ripetitore winchester"},
		{id = "WEAPON_REVOLVER_CATTLEMAN", name = "Revolver cattleman"},
		{id = "WEAPON_REVOLVER_DOUBLEACTION", name = "Revolver Doppia Azione"},
		{id = "WEAPON_REVOLVER_SCHOFIELD", name = "Revolver Schofield"},
		{id = "WEAPON_RIFLE_BOLTACTION", name = "Fucile Boltaction"},
		{id = "WEAPON_SNIPERRIFLE_CARCANO", name = "Fucile carcano"},
		{id = "WEAPON_SNIPERRIFLE_ROLLINGBLOCK", name = "Fucile Rollingblock"},
		{id = "WEAPON_RIFLE_SPRINGFIELD", name = "Fucile springfield"},
		{id = "WEAPON_SHOTGUN_PUMP", name = "Fucile a pompa"},
		{id = "WEAPON_BOW", name = "Arco"},
		{id = "WEAPON_MELEE_HATCHET", name = "Accetta"},
		{id = "WEAPON_SHOTGUN_SAWEDOFF", name = "Fucile a pompa sawedoff"},
	}

	local name 

	for k,v in pairs(weaponNames) do
		if weapon == v.id then 
			name = v.name
		end
	end

	if name == nil then name = weapon end

	return name
end