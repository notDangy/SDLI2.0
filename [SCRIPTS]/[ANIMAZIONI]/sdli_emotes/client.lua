local emotes = {}
local loop = false
local showMenu = false
local isPlayingAnim = false

for k,v in pairs(Config.UpperEmotes2) do emotes[k] = v end
for k,v in pairs(Config.UpperEmotes) do emotes[k] = v end
for k,v in pairs(Config.FullEmotes) do emotes[k] = v end

function GetKeys(tab)
	local keys = {}
	for k,v in pairs(tab) do
		table.insert(keys, k)
	end
	return keys
end

function GetNames(tab)
	local names = {}
	for k,v in pairs(tab) do
		table.insert(names, v["Name"])
	end
	return names
end

function CloseMenu()
	showMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({
		type = "destroy"
	})
end

for k,v in pairs(emotes) do
	RequestAnimDict(v["Dict"])
end

local wheel =
{
	data = {
		style = {
			sizePx = 900, --600
			slices = {
			  default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 4, ['opacity'] = 0.40 },
			  hover = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 4, ['opacity'] = 0.60 },
			  selected = { ['fill'] = '#ff0000', ['stroke'] = '#000000', ['stroke-width'] = 4, ['opacity'] = 0.60 }
			},
			titles = {
			  default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
			  hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
			  selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
			},
			icons = {
				width = 64,
				height = 64
			}
		},
		wheels = {
			{
				navAngle = 270,
				minRadiusPercent = 0.05,
				maxRadiusPercent = 0.2,
				labels = {"Annulla \nanimazione", "Esci"},
				commands = {"cancel", ""}
			},
			{
				navAngle = 0,
				minRadiusPercent = 0.2, --0.3,0.2
				maxRadiusPercent = 0.4, --0.6
				labels = GetNames(Config.FullEmotes),
				commands = GetKeys(Config.FullEmotes)
			},
			{
				navAngle = 0,
				minRadiusPercent = 0.4, --0.6,0.4
				maxRadiusPercent = 0.6, --0.9
				labels = GetNames(Config.UpperEmotes),
				commands = GetKeys(Config.UpperEmotes)
			},
			{
				navAngle = 0,
				minRadiusPercent = 0.6, --0.9,0.6
				maxRadiusPercent = 0.8, --1.2
				labels = GetNames(Config.UpperEmotes2),
				commands = GetKeys(Config.UpperEmotes2)
			}
		}
	}
}

AddEventHandler('menu:openemotes', function()
	if not showMenu then
		if (not IsPedDeadOrDying(PlayerPedId(), true) and not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId(), true)) then

			showMenu = true
			SendNUIMessage({
				type = "init",
				data = wheel.data,
				resourceName = GetCurrentResourceName()
			})
			SetNuiFocus(true, true)

		end
	end
end)
--[[[RegisterCommand('playemote', function(source, args)
	if args[1] and args[2] then
		RequestAnimDict(args[1])
		while not HasAnimDictLoaded(args[1]) do
			RequestAnimDict(args[1])
			Citizen.Wait(1)
		end
		TaskPlayAnim(PlayerPedId(), args[1], args[2], 1.0, 8.0, -1, 1, 0, false, false, false)
		Citizen.Wait(10000)
		ClearPedTasksImmediately(PlayerPedId())
	end
end)]]

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not showMenu then
			if not IsPedDeadOrDying(PlayerPedId(), true) then
				if IsControlJustPressed(0, Config.Button) then
					showMenu = true
					SendNUIMessage({
						type = "init",
						data = wheel.data,
						resourceName = GetCurrentResourceName()
					})
					SetNuiFocus(true, true)
				end
			end
		end
	end
end)

RegisterNUICallback("closemenu", function(data)
	CloseMenu()
end)

RegisterNUICallback('sliceclicked', function(data)

	for k,v in pairs(emotes) do

		if tostring(data.command) == tostring(k) then
			if not(IsPedOnMount(PlayerPedId()) and (v["Type"] <= 1)) then
				if v["Type"] == -21 then
					isPlayingAnim = true
					TaskStartScenarioInPlace(PlayerPedId(), GetHashKey(v["Anim"]), v["Dur"], true, false, false, false)
				else
					local trans = 1.0
					if v["Trans"] ~= nil then
						trans = v["Trans"]
					end
					isPlayingAnim = true
					TaskPlayAnim(PlayerPedId(), v["Dict"], v["Anim"], trans, 1.0, v["Dur"], v["Type"], 0.0, true, 0, false, 0, false)
				end
			end 
			break
		end

	end

	if tostring(data.command) == "cancel" then
		isPlayingAnim = false
		TaskPlayAnim(PlayerPedId(), emotes[2]["Dict"], emotes[2]["Anim"], 1.0, 1.0, 1, 0, 0.0, true, 0, false, 0, false)
		TaskPlayAnim(PlayerPedId(), emotes[2]["Dict"], emotes[2]["Anim"], 1.0, 1.0, 1, 24, 0.0, true, 0, false, 0, false)
		ClearPedTasks(PlayerPedId())
	end

	CloseMenu()

end)

Citizen.CreateThread(function() 
	while true do
		Wait(0)
		if isPlayingAnim and IsControlJustPressed(0, 0x8CC9CD42) then
			isPlayingAnim = false
			ClearPedTasks(PlayerPedId())
		end
	end
end)