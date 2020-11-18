function DrawTxt(str, x, y, w, h, col1, col2, col3, a, center)
	local str = CreateVarString(10, "LITERAL_STRING", str)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(center)
	SetTextDropshadow(1, 0, 0, 0, 255)
	Citizen.InvokeNative(0xADA9255D, 1)
	DisplayText(str, x, y)
end

function formattime(timer)

	if (timer >= 60) then
		return string.format("%.1f", tostring(timer / 60)) .. " minuti"
	else
		return tostring(timer) .. " secondi"
	end

end

RegisterNetEvent("jail:SetJailClient")
AddEventHandler("jail:SetJailClient", function(jailName, time,closestJail,relLoc)
	TriggerServerEvent("jail:SetJail",jailName, time,closestJail,relLoc)
end)

NetworkClockTimeOverride(12, 0, 0, 1000)

local tick = 0
local inJail = false
local timer = 0
local release = false
jailLoc = {}
relLoc = {}
--local releaseLoc = Config.ReleaseLoc

RequestAnimDict("amb_rest@world_human_sleep_ground@arm@player_temp@exit")

RegisterNetEvent("jail:IsInJailClient")
AddEventHandler("jail:IsInJailClient", function(result, left, jailCoords, releaseLoc)

	
	local _jailCoords = jailCoords
	local _relLoc = releaseLoc
	if ((not result) and inJail) then
		release = true
	end

	inJail = result
	timer = left

	if inJail then
		jailLoc.x, jailLoc.y, jailLoc.z = _jailCoords.x, _jailCoords.y, _jailCoords.z
		relLoc.x1, relLoc.y1, relLoc.z1 = _relLoc.x1, _relLoc.y1, _relLoc.z1
	end
	
end)

-- MAIN

Citizen.CreateThread(function()
	
	Wait(45000)
	print("Triggering get jail...")
	TriggerServerEvent("vorp:getJail")

end)

Citizen.CreateThread(function() 
	while true do
		Wait(500)
		if inJail then
			TriggerServerEvent("jail:IsInJail", GetPlayerServerId(PlayerId()))
		end
	end
end)

Citizen.CreateThread(function()

	while true do

		Citizen.Wait(0)
	
		if (inJail) then
			
			
			local playerPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
			local dist = GetDistanceBetweenCoords(playerPos, jailLoc.x, jailLoc.y, jailLoc.z, true)

			--if (not(playerPos.x > bounds.x1 and playerPos.x < bounds.x2 and playerPos.y > bounds.y1 and playerPos.y < bounds.y2)) then
			if dist > 5 then
				RequestCollisionAtCoord(jailLoc.x, jailLoc.y, jailLoc.z)
				SetPedToRagdoll(PlayerPedId(), 2000, 2000, 0)
				PlaySoundFrontend("TITLE_SCREEN_EXIT", "DEATH_FAIL_RESPAWN_SOUNDS", true, 1)
				DoScreenFadeOut(500)
				Citizen.Wait(500)
			
				SetEntityInvincible(PlayerPedId(), true)
				SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
				SetEntityCoords(PlayerPedId(), jailLoc.x, jailLoc.y, jailLoc.z, false, false, false, true)
				ClearPedTasksImmediately(PlayerPedId())
				FreezeEntityPosition(PlayerPedId(), true)


				Citizen.Wait(1000)

				while (not HasCollisionLoadedAroundEntity(PlayerPedId())) do
					Citizen.Wait(10)
				end

				SetEntityHeading(PlayerPedId(), jailLoc.h)
				TaskPlayAnim(PlayerPedId(), "amb_rest@world_human_sleep_ground@arm@player_temp@exit", "exit_right", 16.0, 2.0, 9500, 0, 0, true, 0, false, 0, false)
				FreezeEntityPosition(PlayerPedId(), false)

				Citizen.Wait(200)

				while IsScreenFadedOut() do
					DoScreenFadeIn(2000)
				end

			else

				DrawTxt("Sei in prigione - " .. formattime(timer) .. " rimanenti", 0.5, 0.9, 0.5, 0.5, 255, 255, 255, 255, true)

			end

		end

		if (release) then

			release = false

			DoScreenFadeOut(500)
			Citizen.Wait(500)

			SetEntityInvincible(PlayerPedId(), false)
			TriggerServerEvent("jail:RemoveJail", GetPlayerServerId(PlayerId()))
			SetEntityCoordsNoOffset(PlayerPedId(), relLoc.x1, relLoc.y1, relLoc.z1, false, false, false, true)
			ClearPedTasksImmediately(PlayerPedId())
			FreezeEntityPosition(PlayerPedId(), true)

			Citizen.Wait(1000)

			while (not HasCollisionLoadedAroundEntity(PlayerPedId())) do
				Citizen.Wait(10)
			end

			--SetEntityHeading(PlayerPedId(), relLoc.h)
			FreezeEntityPosition(PlayerPedId(), false)

			Citizen.Wait(200)

			while IsScreenFadedOut() do
				DoScreenFadeIn(2000)
			end

		end

	end

end)