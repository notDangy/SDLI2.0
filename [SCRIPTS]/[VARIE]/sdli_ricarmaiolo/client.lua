-- 2625.7 -1231.4 53.4
--CONFIG--
x=-279.6 
y=782.9 
z=119.6 

----------

Citizen.CreateThread(function()
	SendNUIMessage({
		action = "init",
		resourceName = GetCurrentResourceName()
	})
end)

opened = false

function ToggleBacheca()
    opened = not opened
    if opened then
        SetNuiFocus(true, true)
    else
        SetNuiFocus(false)
    end
    SendNUIMessage({
        action = "action1",
        open = opened
    })
end


Citizen.CreateThread(function() --Marker
    while true do
        Citizen.Wait(0) 
 		Citizen.InvokeNative(0x2A32FAA57B937173,0x07DCE236,x, y + 0.0,z - 1.0,0,0,0,0,0,0,1.0,1.0,1.0,0,0,250,250,0, 0, 2, 0, 0, 0, 0)
 	end
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
        local betweencoords = GetDistanceBetweenCoords(coords, x, y, z, true)
        if betweencoords < 1.0 then
            DrawTxt("Premi G per leggere gli appunti", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
            if IsControlJustPressed(2, 0x760A9C6F) then
                TriggerServerEvent("ricettarioarmaiolo:checkgroupsv")
            end
        end
	end
end)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

RegisterNUICallback('escape1', function(data, cb)
    ToggleBacheca()
end)

RegisterNetEvent('ricettarioarmaiolo:checkgroupcl')
AddEventHandler('ricettarioarmaiolo:checkgroupcl', function() 
    ToggleBacheca()
end)