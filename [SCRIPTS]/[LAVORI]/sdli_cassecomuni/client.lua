local inv = {}
local houseinv = {}
--- WAR MENU --------
Citizen.CreateThread(function()
    WarMenu.CreateMenu('perso', 'Cassa comune')
	WarMenu.CreateSubMenu('do', 'perso', 'Deposita Oggetti')
	WarMenu.CreateSubMenu('po', 'perso', 'preleva Oggetti')

	 while true do

        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())	
--
    if WarMenu.IsMenuOpened('perso') then
		--Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, true)
--		
		if WarMenu.MenuButton('Deposita Oggetti', 'do') then
		end
		if WarMenu.MenuButton('Preleva Oggetti', 'po') then
		end
		if WarMenu.Button('Chiudi') then
			--Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, false)
			WarMenu.CloseMenu()
		end
--		
		WarMenu.Display()
		elseif WarMenu.IsMenuOpened('do') then
				for k,v in pairs(inv) do
					for a,b in pairs (Config.house) do
						local ped = GetPlayerPed()
						local coords = GetEntityCoords(PlayerPedId())
						if (Vdist(coords.x, coords.y, coords.z, b.x, b.y, b.z) < 1.3) and v ~= 0 then
							if WarMenu.Button(v.Label.." x"..v.Quantity) then
								TriggerEvent("vorpinputs:getInput", "Deposita", "Quantita", function(cb)
									local qt = tonumber(cb)
									--table.remove(inv,k)
									if qt ~= nil then
										TriggerServerEvent("sdli_casse:DepositaItem", a, v.Id, qt,b)
									end
									
								end)
							end
						end
					end	
				end

			if WarMenu.Button('Chiudi') then
				--Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, false)
				WarMenu.CloseMenu()
			end	
-- 		
			WarMenu.Display()
		elseif WarMenu.IsMenuOpened('po') then
				for k,v in pairs(Config.house) do
					local ped = GetPlayerPed()
					local coords = GetEntityCoords(PlayerPedId())
					if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.3) then
						for a,b in pairs(houseinv) do
								
							if b["Quantity"] ~= 0 then
								if WarMenu.Button(b["Name"].." x"..b["Quantity"]) then 
									TriggerEvent("vorpinputs:getInput", "Preleva", "Quantita", function(cb)
										local qt = tonumber(cb)
										if qt ~= nil and b["Quantity"] >= qt then
											TriggerServerEvent("sdli_casse:PrelevaItem", k, b["Id"], qt,v)
										else
											TriggerEvent("vorp:TipRight", "Non ce ne sono cosi tanti", 5000)
										end
									end)
								end
							end
								--WarMenu.Display()
						end
					end	
				end	
			if WarMenu.Button('Chiudi') then
				--Citizen.InvokeNative(0x7D9EFB7AD6B19754, ped, false)
				WarMenu.CloseMenu()
			end	
			WarMenu.Display()
		end
			--WarMenu.Display()
		--end
		Citizen.Wait(0)
		
	end	
end)


RegisterNetEvent("enter:house")
AddEventHandler("enter:house", function()
    SetTextScale(0.5, 0.5)
    --SetTextFontForCurrentCommand(1)
    local msg = 'Premi [G] Per aprire la cassa'
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", msg, Citizen.ResultAsLong())

    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)
  
RegisterNetEvent('cassecomuni:refreshmenu')
AddEventHandler('cassecomuni:refreshmenu', function(Id,qt)
	WarMenu.OpenMenu('perso')
	if Id ~= nil and qt ~= nil then
		for k,v in pairs(inv) do 
			if v.Id == Id then
				if v.Quantity == tonumber(qt) then
					table.remove(inv,k)
				else
					v.Quantity = v.Quantity - tonumber(qt)
				end
			end
		end
	end

	for k,v in pairs(Config.house) do
		local ped = GetPlayerPed()
		local coords = GetEntityCoords(PlayerPedId())
		if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.3) then
			TriggerServerEvent("sdli_casse:GetInventoryCassa",k,v.name)
		end
	end
end)




function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, 0x760A9C6F) then
        return true
    else
        return false
    end
end

function refreshMenu(menu) 
	WarMenu.CloseMenu()
	Wait(50)
	WarMenu.OpenMenu(menu)
end

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
			for _, info in pairs(Config.house) do
				Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, info.x, info.y, info.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
				if (Vdist(pos.x, pos.y, pos.z, info.x, info.y, info.z) < 2.0) then
					TriggerEvent("enter:house")
					--DrawTxt(Language.translate[Config.lang]['premi'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
					if whenKeyJustPressed(key) then
						for k,v in pairs (Config.house) do
							local ped = GetPlayerPed()
							local coords = GetEntityCoords(PlayerPedId())
								if (Vdist(coords.x, coords.y, coords.z, v.x, v.y, v.z) < 1.3) then
									TriggerServerEvent("sdli_casse:CheckJob", k, v)
								end	
						end
					end 
				end
			
            end
       
            end
end)
-------------------------------------------
RegisterNetEvent("saveinventario")
AddEventHandler("saveinventario", function(personalinventario) 
	inv = personalinventario
	
end)

RegisterNetEvent("savehouseinventario")
AddEventHandler("savehouseinventario", function(housinventario)
	houseinv = housinventario
end)	

RegisterNetEvent("vane:closeinven")
AddEventHandler("vane:closeinven", function(source)
	WarMenu.CloseMenu()
end)

RegisterNetEvent("vane:openperso")
AddEventHandler("vane:openperso", function(source)
	
	TriggerServerEvent("sdli_casse:GetInventory")
	TriggerEvent('cassecomuni:refreshmenu')
	WarMenu.OpenMenu('perso')
end)

RegisterNetEvent("vane:opencompra")
AddEventHandler("vane:opencompra", function(source)
	WarMenu.OpenMenu('compra')
end)