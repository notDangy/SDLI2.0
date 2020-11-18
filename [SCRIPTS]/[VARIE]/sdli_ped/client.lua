Citizen.CreateThread(function()
     WarMenu.CreateMenu('perso', 'Ped Menu')
	 WarMenu.CreateSubMenu('an', 'perso', 'Animali')
	 WarMenu.CreateSubMenu('pd', 'perso', 'Ped Generici')
	 WarMenu.CreateSubMenu('ps', 'perso', 'Ped Staffer')
	 WarMenu.CreateSubMenu('gi', 'ps', 'Ped Gino') 
	 WarMenu.CreateSubMenu('f3', 'ps', 'Ped Fragam3r')
	 WarMenu.CreateSubMenu('jg', 'ps', 'Ped Jig')
	 WarMenu.CreateSubMenu('tc', 'ps', 'Ped Tic')
while true do

        local ped = GetPlayerPed()
--Open
    if WarMenu.IsMenuOpened('perso') then
--layer 1
		if WarMenu.MenuButton('Animali', 'an') then
		end
		if WarMenu.MenuButton('Ped Generici', 'pd') then
		end
		if WarMenu.MenuButton('Ped Staffer', 'ps') then
		end
		if WarMenu.Button('MySkin')then
		TriggerEvent("vorpcharacter:refreshPlayerSkin")
		end
		if WarMenu.Button('Chiudi') then
			WarMenu.CloseMenu()
		end
			WarMenu.Display()
--layer 1.1
				elseif WarMenu.IsMenuOpened('an') then
				for k,v in pairs(Config.animali) do
					if WarMenu.Button(v.name) then
						Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
						setModel(v.hash)					
					end
				end
			WarMenu.Display()
-- 1.2 layer
				elseif WarMenu.IsMenuOpened('pd') then
				for k,v in pairs(Config.ped) do
					if WarMenu.Button(v.name) then
					Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
					setModel(v.hash)
					end
				end
			WarMenu.Display()
-- 1.3 layer
				elseif WarMenu.IsMenuOpened('ps') then
				if WarMenu.MenuButton('Ped Gino', 'gi') then
				end
				if WarMenu.MenuButton('Ped Tic', 'tc') then
				end
				if WarMenu.MenuButton('Ped Jig', 'jg') then
				end
				if WarMenu.MenuButton('Ped Fragam3r', 'f3') then
				end
				WarMenu.Display()
				
				
				elseif WarMenu.IsMenuOpened('gi') then
						for k,v in pairs(Config.pedgino) do
							if WarMenu.Button(v.name) then
								Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
								setModel(v.hash)
							end
						end
				
			WarMenu.Display()
			
				elseif WarMenu.IsMenuOpened('tc') then
						for k,v in pairs(Config.tic) do
							if WarMenu.Button(v.name) then
								Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
								setModel(v.hash)
							end
						end
				
			WarMenu.Display()
				elseif WarMenu.IsMenuOpened('jg') then
						for k,v in pairs(Config.jig) do
							if WarMenu.Button(v.name) then
								Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
								setModel(v.hash)
							end
						end
				
			WarMenu.Display()
				elseif WarMenu.IsMenuOpened('f3') then
						for k,v in pairs(Config.pedfragamer) do
							if WarMenu.Button(v.name) then
								Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
								setModel(v.hash)
							end
						end
				
			WarMenu.Display()			
--Fine
	end
		 Citizen.Wait(0)
	 	
end
end)
 
 
RegisterNetEvent("openmenu")
AddEventHandler("openmenu", function()
WarMenu.OpenMenu('perso')
end)




RegisterNetEvent("tuzia")
AddEventHandler("tuzia", function()
	TriggerEvent("vorpinputs:getInput", "ok", "Hash del ped", function(cb)
    	print(cb)
		Citizen.InvokeNative(0xD3A7B003ED343FD9 , PlayerPedId(),  0x1FC12C9C, true, true, true)
		setModel(cb)
    end)
end)

RegisterCommand('ped', function(source, args, rawCommand)
TriggerServerEvent('checkgroup')
end)


RegisterCommand('changeped', function (source, args, rawCommand)
TriggerServerEvent('checkgroup2')

end)




function setModel(name)
	local model = GetHashKey(name)
	local player = PlayerId()
	
	if not IsModelValid(model) then return end
	PerformRequest(model)
	
	if HasModelLoaded(model) then
		-- SetPlayerModel(player, model, false)
		Citizen.InvokeNative(0xED40380076A31506, player, model, false)
		Citizen.InvokeNative(0x283978A15512B2FE, PlayerPedId(), true)
		SetModelAsNoLongerNeeded(model)
	end
end

function PerformRequest(hash)
    RequestModel(hash, 0) -- RequestModel
    local times = 1
    while not Citizen.InvokeNative(0x1283B8B89DD5D1B6, hash) do -- HasModelLoaded
        Citizen.InvokeNative(0xFA28FE3A6246FC30, hash, 0) -- RequestModel
        times = times + 1
        Citizen.Wait(0)
        if times >= 100 then break end
    end
end

