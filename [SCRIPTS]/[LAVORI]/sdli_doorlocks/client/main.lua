local prompt = false
local OpenPrompt
local timeHeld = 0

function SetupOpenPrompt()
    Citizen.CreateThread(function()
        local str = 'Apri / Chiudi'
        OpenPrompt = PromptRegisterBegin()
        PromptSetControlAction(OpenPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(OpenPrompt, str)
        PromptSetEnabled(OpenPrompt, false)
        PromptSetVisible(OpenPrompt, false)
        PromptSetHoldMode(OpenPrompt, true)
        PromptRegisterEnd(OpenPrompt)
    end)
end

-- Get objects every second, instead of every frame
Citizen.CreateThread(function()
	while true do
		for _,doorID in ipairs(Config.DoorList) do
			if doorID.doors then
				for k,v in ipairs(doorID.doors) do
					if not v.object or not DoesEntityExist(v.object) then
						local shapeTest = StartShapeTestBox(v.objCoords, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, 16)
						local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
						v.object = entityHit
					end
				end
			else
				if not doorID.object or not DoesEntityExist(doorID.object) then
					local shapeTest = StartShapeTestBox(doorID.objCoords, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, 16)
					local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
					doorID.object = entityHit
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	SetupOpenPrompt()
	while true do
		Citizen.Wait(0)
		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true

		for k,doorID in ipairs(Config.DoorList) do
			local distance

			if doorID.doors then
				distance = #(playerCoords - doorID.doors[1].objCoords)
			else
				distance = #(playerCoords - doorID.objCoords)
			end

			local maxDistance, displayText = 1.25, 'sbloccata'

			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < 50 then
				letSleep = false

				if doorID.doors then
					for _,v in ipairs(doorID.doors) do
						FreezeEntityPosition(v.object, doorID.locked)
						DoorSystemSetDoorState(v.object, doorID.locked)


						if doorID.locked and v.objYaw and GetEntityRotation(v.object).z ~= v.objYaw then
							SetEntityRotation(v.object, 0.0, 0.0, v.objYaw, 2, true)
						end
					end
				else
					FreezeEntityPosition(doorID.object, doorID.locked)
					DoorSystemSetDoorState(doorID.object, doorID.locked)


					if doorID.locked and doorID.objYaw and GetEntityRotation(doorID.object).z ~= doorID.objYaw then
						SetEntityRotation(doorID.object, 0.0, 0.0, doorID.objYaw, 2, true)
					end
				end
			end

			if distance < maxDistance then

				if doorID.locked then
					displayText = 'bloccata'
				end

				DrawText3D(doorID.textCoords.x, doorID.textCoords.y, doorID.textCoords.z, displayText)
				if distance < 1.75 then
					if prompt == false then
						PromptSetEnabled(OpenPrompt, true)
						PromptSetVisible(OpenPrompt, true)

													prompt = true
					end
					if PromptHasHoldModeCompleted(OpenPrompt) and timeHeld < 1 then
						timeHeld = timeHeld + 5
						PromptSetEnabled(OpenPrompt, false)
						PromptSetVisible(OpenPrompt, false)
						prompt = false
						TriggerEvent("vorp_doorlocks:updatedoor", GetPlayerServerId(), k)
					end
					if timeHeld > 0 then
						timeHeld = timeHeld - 1
					end
				else 
					if prompt then
						PromptSetEnabled(OpenPrompt, false)
						PromptSetVisible(OpenPrompt, false)
						prompt = false
					end
					timeHeld = 0
				end
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('vorp_doorlocks:updatedoor')
AddEventHandler('vorp_doorlocks:updatedoor', function(source, door) 
    TriggerServerEvent("vorp_doorlocks:updatedoorsv", source, door, function(cb) end) --Perms check
end)

RegisterNetEvent('vorp_doorlocks:changedoor')
AddEventHandler('vorp_doorlocks:changedoor', function(doorID)
	local name   = Config.DoorList[doorID]
	name.locked = not name.locked
	TriggerServerEvent('vorp_doorlocks:updateState', doorID, name.locked, function(cb) end)
end)

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

-- Set state for a door
RegisterNetEvent('vorp_doorlocks:setState')
AddEventHandler('vorp_doorlocks:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)
