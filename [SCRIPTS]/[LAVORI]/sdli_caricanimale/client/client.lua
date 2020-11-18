

Citizen.CreateThread(function()
	while true do 
		Wait(0)
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
		forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
		local Pos2 = GetEntityCoords(ped)
		local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
		local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
		local A,hit,C,C,spot = GetShapeTestResult(rayCast)                
		local model = GetEntityModel(spot)
		cartcoords = GetEntityCoords(spot)
		if isModelValid(model) then
			local animal = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
			if animal ~= false then
				DrawText3D(cartcoords.x,cartcoords.y,cartcoords.z,"Permi G per caricare l'animale")
				
				if IsControlJustReleased(0,0x760A9C6F) then
					animalcheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
					pedid = NetworkGetNetworkIdFromEntity(animalcheck)
					Citizen.InvokeNative(0xC7F0B43DCDC57E3D, PlayerPedId(), animalcheck, GetEntityCoords(PlayerPedId()), 10.0, true)
					Wait(2000)
					TriggerServerEvent('EveryoneTeleportEntity',pedid,cartcoords.x,cartcoords.y,cartcoords.z+1.5)
					SetEntityCoords(animalcheck,cartcoords.x,cartcoords.y,cartcoords.z+1.5,false)
					Wait(2000)
				end
				

				forwardoffset = GetOffsetFromEntityInWorldCoords(ped,0.0,2.0,0.0)
				local Pos2 = GetOffsetFromEntityInWorldCoords(ped, -0.0, 0.0,0.5)
				local targetPos = GetOffsetFromEntityInWorldCoords(obj3, -0.0, 1.1,-0.1)
				local rayCast = StartShapeTestRay(Pos2.x, Pos2.y, Pos2.z, forwardoffset.x, forwardoffset.y, forwardoffset.z,-1,ped,7)
				A,hit,B,C,spot = GetShapeTestResult(rayCast)
				NetworkRequestControlOfEntity(animalcheck)
				model = GetEntityModel(spot)
			else
				PromptSetEnabled(AnimalPrompt, false)
				PromptSetVisible(AnimalPrompt, false)
				prompt = false
			end
		else
			PromptSetEnabled(AnimalPrompt, false)
			PromptSetVisible(AnimalPrompt, false)
			prompt = false
		end
	end
end)


RegisterNetEvent('EveryoneTeleportEntity')
AddEventHandler('EveryoneTeleportEntity', function(netid,x,y,z)
	ent = NetworkGetEntityFromNetworkId(netid)
	Wait(150)
	SetEntityCoords(ent,x,y,z)
end)
----------------------------------------------------------------------------------------

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end

local cartModels = {
	GetHashKey("cart03"),
	GetHashKey("chuckwagon000x"),
	GetHashKey("gatchuck"),
	GetHashKey("cart01")
}

function isModelValid(model) 
	for k,v in pairs(cartModels) do 
		if v == model then 
			return true 
		end
	end
	return false
end



