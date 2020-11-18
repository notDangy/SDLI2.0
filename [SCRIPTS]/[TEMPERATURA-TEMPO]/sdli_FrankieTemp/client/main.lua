local roundtemp = 0


local ClothesCats = {
	0x9925C067, --hat
	0x2026C46D, --shirt
	0x1D4C528A, -- pants
	0x777EC6EF, -- boots 
	0xE06D30CE, -- coat
	0x662AC34, --open coat
	0xEABE0032, --gloves 
	0x485EE834, --vest
	0xAF14310B, -- poncho
	0x3C1A74CD --mantelli
}

---check clothes
Citizen.CreateThread(function()
    while true do
		Wait(1500)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local temp = Citizen.InvokeNative(0xB98B78C3768AF6E0,coords.x,coords.y,coords.z)
		roundtemp = foo(temp)
		--print(roundtemp)
		
		for k,v in pairs(ClothesCats) do
			local IsWearingClothes = Citizen.InvokeNative(0xFB4891BD7578CDC1 ,PlayerPedId(), v)
			if IsWearingClothes then 
				roundtemp = roundtemp + 1
			end
		end
    end
end)





Citizen.CreateThread(function() 
	while true do 
		Wait(60000)

		if tonumber(roundtemp) <= -8 then
			--TriggerEvent("redemrp_notification:start", "Stai congelando copriti al più pesto,altrimenti è la fine!", 5, "error")
			TriggerEvent("vorp:NotifyLeft", "~t7~Temperatura", "Stai congelando copriti al più pesto, altrimenti è la fine!", "rpg_textures", "rpg_cold", 4000)
			--TriggerClientEvent("vorp:NotifyLeft", _source, "~t7~Temperatura", "Stai congelando copriti al più pesto,altrimenti è la fine!", "menu_textures", "cross", 3000)
		elseif tonumber(roundtemp) <= -6 then 
			--TriggerEvent("redemrp_notification:start", "Hai freddo, dovresti coprirti!", 5, "error")
			TriggerEvent("vorp:NotifyLeft", "~pa~Temperatura", "Hai freddo, dovresti coprirti!", "rpg_textures", "rpg_cold", 4000)
		elseif tonumber(roundtemp) <= -4 then 
		--.	TriggerEvent("redemrp_notification:start", "Stai sentendo molto freddo, dovresti coprirti di più!", 5, "error")
			TriggerEvent("vorp:NotifyLeft", "~t3~Temperatura", "Stai sentendo molto freddo, dovresti coprirti di più!", "rpg_textures", "rpg_cold", 4000)
	--	elseif tonumber(roundtemp) <= 20 then 
	--		TriggerEvent("vorp:NotifyLeft", "~o~Temperatura", "Stai sentendo caldo, dissetati spesso!", "rpg_textures", "rpg_hot", 3000)
	--	elseif tonumber(roundtemp) <= 25 then 
		--	TriggerEvent("vorp:NotifyLeft", "~d~Temperatura", "Hai caldo, cerca un riparo e dissetati spesso!", "rpg_textures", "rpg_hot", 3000)
		--elseif tonumber(roundtemp) <= 30 then 
			--TriggerEvent("vorp:NotifyLeft", "~t2 ~Temperatura", "Hai troppo caldo cerca un riparo, altrimenti è la fine!", "rpg_textures", "rpg_hot", 3000)
		end

	end
end)

--Citizen.CreateThread(function() 
--	while true do 
--		Wait(5000)
--	if tonumber(roundtemp) >= 21 and tonumber(roundtemp) <= 24.9 then 
--		TriggerEvent("vorp:NotifyLeft", "~o~Temperatura", "Stai sentendo caldo, dissetati spesso!", "rpg_textures", "rpg_hot", 2500)
	--elseif tonumber(roundtemp) <= 25 then 
--	elseif tonumber(roundtemp) >= 25 and tonumber(roundtemp) <= 27.9 then 
--		TriggerEvent("vorp:NotifyLeft", "~d~Temperatura", "Hai caldo, cerca un riparo e dissetati spesso!", "rpg_textures", "rpg_hot", 2500)
	--elseif tonumber(roundtemp) <= 28 then 
 --   elseif tonumber(roundtemp) >= 28 then 
--		TriggerEvent("vorp:NotifyLeft", "~t2 ~Temperatura", "Hai troppo caldo cerca un riparo, altrimenti è la fine!", "rpg_textures", "rpg_hot", 2500)
--	end

  --end 
--end)


---damage, effects
Citizen.CreateThread(function()
	while true do
		Wait(5000)
		ped = PlayerPedId()
		health = GetEntityHealth(ped)
		coords = GetEntityCoords(ped)
		if tonumber(roundtemp) <= -8 then
			SetEntityHealth(ped,health  - 5)
			Citizen.InvokeNative(0xa4d3a1c008f250df, 8) -- deadeye logo
		elseif tonumber(roundtemp) <= -6 then
			SetEntityHealth(ped,health  - 2)
			Citizen.InvokeNative(0xa4d3a1c008f250df, 8) -- deadeye logo
		elseif tonumber(roundtemp) <= -4 then
			SetEntityHealth(ped,health  - 1)
			Citizen.InvokeNative(0xa4d3a1c008f250df, 8) -- deadeye logo
		end
		if health > 0 and health < 50 and tonumber(roundtemp) > 0 then 
			SetEntityHealth(ped,health  - 1)
			Citizen.InvokeNative(0xa4d3a1c008f250df, 6)  ---hp bleed core
			PlayPain(ped, 9, 1, true, true)
			Citizen.InvokeNative(0x4102732DF6B4005F,"MP_Downed",0, true) --play
		else
			if Citizen.InvokeNative(0x4A123E85D7C4CA0B,"MP_Downed") then --ifrunning
				Citizen.InvokeNative(0xB4FD7446BAB2F394,"MP_Downed") --- stop
			end
		end
	end
end)

function foo(n)
    return string.format("%.1f", n / 10^8)
end