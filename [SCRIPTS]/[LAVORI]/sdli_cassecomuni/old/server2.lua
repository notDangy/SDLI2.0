VorpInv = exports.vorp_inventory:vorp_inventoryApi()
VORP = exports.vorp_core:vorpAPI()

RegisterServerEvent("dangi:GetInventory")
AddEventHandler("dangi:GetInventory", function ()
	TriggerEvent("vorp:getCharacter",source,function(user)
	print(user.inventory)
	local inventario = json.decode(user.inventory)
		TriggerClientEvent("saveinventario", source, inventario)
	end)
end)


RegisterServerEvent("vane:deposita_item")
AddEventHandler("vane:deposita_item", function (k,qt)
	local count = VorpInv.getItemCount(source, k)
		if count >= qt then
			VorpInv.subItem(source,k,qt)
			TriggerClientEvent("vorp:TipRight", source, "hai depositato x"..qt.." di "..k, 4000)
				exports.ghmattimysql:execute('SELECT inventory FROM house', {
				--['@idhouse'] = {v.name}
				},function(inret)
					if inret[1] ~= nil then
						json.encode(inret[1])
						--------
						local var = {}
						var[k] = qt
						exports.ghmattimysql:execute('UPDATE house SET inventory = @inventory ', {
						--['@idhouse'] = {b.name},
						['@inventory'] = {json.encode(var)}
						}) 
					end
				end)

		
			
		else
			TriggerClientEvent("vorp:TipRight", source, "Quantità non valida", 4000)
		end
end) 

RegisterServerEvent("vane:acquista")
AddEventHandler("vane:acquista", function (v)

	TriggerEvent("vorp:getCharacter",source,function(user)
	ow = user.identifier
	mo = user.money
		if mo >= v.price then	
		TriggerEvent("vorp:removeMoney", source, 0, v.price);
		TriggerClientEvent("vorp:TipRight", source, "Hai acquistato l\'immobile", 4000)
			exports.ghmattimysql:execute('UPDATE house SET owner = @owner, avaiable = 0 WHERE idhouse = @idhouse', {
			['@idhouse'] = {v.name},
			['@owner'] = {ow}
			}) 
		TriggerClientEvent("vane:closeinven",source)
		 else
			TriggerClientEvent("vorp:TipRight", source, "Non hai abbastanza soldi", 4000)
			TriggerClientEvent("vane:closeinven",source)
		end	
	end)
end)

RegisterServerEvent("vane:checkproprietario")
AddEventHandler("vane:checkproprietario", function(v)
	TriggerEvent("vorp:getCharacter",source,function(user)
		local id = user.identifier
		local _source = source

		exports.ghmattimysql:execute('SELECT * FROM house WHERE idhouse = @idhouse', {
		['@idhouse'] = {v.name}
		},function(ret)
	
		
			if ret[1].avaiable then
			
				TriggerClientEvent("vane:opencompra",_source)
			else
				exports.ghmattimysql:execute('SELECT owner FROM house WHERE idhouse = @idhouse', {
				['@idhouse'] = {v.name}
				},function(ret2)
					if ret2[1].owner == id then
		
						TriggerClientEvent("vane:openperso",_source)
					else
						TriggerClientEvent("vorp:TipRight", source, "Questa casa è già acquistata", 4000)
					end
				end)
			end
		end)

	end)
end)