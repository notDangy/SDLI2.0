local attachedProp = nil
local attachedProp2 = nil

local openedNote = false
local getCoords = nil

local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 0xCEFD9220, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/notepad', 'Write a note', {
})
end)

Citizen.CreateThread(function()
    while true do
        local sleepThread = 500
        --SetNuiFocus(false, false)
        TriggerServerEvent('notepad:getCoords')
        local playerPed = PlayerPedId()
        local pos = GetEntityCoords(playerPed)

        if getCoords ~= nil then
            for k, v in pairs(getCoords) do
                local noteDist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true)

                SetPlayerTalkingOverride(playerPed, true)

                if noteDist < 5 then
                    sleepThread = 5
                   -- DrawMarker(20, v.x, v.y, v.z - 0.3, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 200, false, true, 2, true, false, false, false)                --end
                    Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, v.x, v.y + 0.5, v.z - 1, 0, 0, 0, 0, 0, 0, 1.3, 1.3, 2.0, 93, 0, 0, 155, 0, 0, 2, 0, 0, 0, 0)            --end
                    --Draw3DText (v.x, v.y, v.z  , '~r~[E]~w~ Take Note')

                    if noteDist < 1.0 then
                        --DisplayHelpText("~r~[E]~w~ Take Note")
                        DrawText("~r~[E]~w~ Take Note",0.5,0.88)
                        

                        if IsControlPressed(0, Keys['E']) then
                            TriggerServerEvent('notepad:deleteCoord', k)
                            TriggerEvent('notepad:pickup', v.noteTxt, k)
                            --Draw3DText (v.x, v.y, v.z  , '~r~[E]~w~ Take Note')
                        end
                    end
                end
            end
        end
        Citizen.Wait(sleepThread)
    end
end)

RegisterNetEvent('notepad:open')
AddEventHandler('notepad:open', function()
    SetNuiFocus(true, false)
    SendNUIMessage({ type = 'showpage' })

    openedNote = true

    TriggerEvent('notepad:anim')
end)

RegisterNetEvent('notepad:pickup')
AddEventHandler('notepad:pickup', function(txt, id)
    SetNuiFocus(true, false)

    openedNote = true

    SendNUIMessage({
        type = 'pickup',
        notetxt = txt,
        noteid = id
    })

    TriggerEvent('notepad:pickupanim')
end)

RegisterNetEvent('notepad:pickupanim')
AddEventHandler('notepad:pickupanim', function()
    RequestAnimDict("pickup_object")
    while not HasAnimDictLoaded("pickup_object") do
        Citizen.Wait(0)
    end

    TaskPlayAnim(GetPlayerPed(-1), "pickup_object", "pickup_low", 8.0, -8, -1, 9, 0, 0, 0, 0)
    Wait(2000)
    ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('notepad:dropnote')
AddEventHandler('notepad:dropnote', function(txt)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)

    newNote = {
        x = pos.x,
        y = pos.y,
        z = pos.z,
        noteTxt = txt
    }

    TriggerServerEvent("notepad:saveCoord", newNote)
end)

RegisterNetEvent('notepad:getCoords')
AddEventHandler('notepad:getCoords', function(coords)
    if coords ~= nil then
        getCoords = coords
    end
end)

RegisterNUICallback('getNote', function(data)
    TriggerEvent('notepad:dropnote', data)
    openedNote = false
end)

RegisterNUICallback('destroynote', function(data)
    TriggerServerEvent('notepad:deleteCoord', data)
    openedNote = false
end)

RegisterNUICallback('NUIFocusOff', function()
    SetNuiFocus(false, false)
    openedNote = false

    ClearPedTasksImmediately(GetPlayerPed(-1))
    DeleteObject(attachedProp)
    DeleteObject(attachedProp2)
end)

--[[function DisplayHelpText(Text)
	BeginTextCommandDisplayHelp('STRING')
	AddTextComponentSubstringPlayerName(Text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end
--]]

--[[function Draw3DText(x, y, z, text,messageTimeout)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*1
    local fov = (1/GetGameplayCamFov())*100
    local scale = 2.1
   
    if onScreen then
        --SetTextScale(0.0*scale, 0.25*scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextScale(0.0, 0.35)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 50, 50, 50, 0)
    end
end
--]]

function DrawText(text,x,y)
    SetTextScale(0.35,0.35)
    SetTextColor(255,255,255,255)--r,g,b,a
    SetTextCentre(true)--true,false
    SetTextDropshadow(1,0,0,0,200)--distance,r,g,b,a
    SetTextFontForCurrentCommand(0)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end