local show = true
local active = false
local liczba = 1
local ProgressColor = {100, 1, 1}
local global_text
local global_timer
local global_type
------------EXAMPLE------------------------
--	  local timer = 5 
--	  local type = "success" 
--    local text = "Simple test redemrp_notification"
--    TriggerEvent("redemrp_notification:start", text, timer, type)
--------------OR-------------------------

--    TriggerEvent("redemrp_notification:start", "Simple test redemrp_notification" , 5)

-------------TEST COMMAND-------------
--[[

RegisterCommand('test_notification', function(source, args)
 local text = ''
    for i = 1,#args do
        text = text .. ' ' .. args[i]
    end
   TriggerEvent("redemrp_notification:start", text , 5, "success")
end)

]]


RegisterNetEvent('redemrp_notification:start')
AddEventHandler('redemrp_notification:start',  function(_text, _timer, _type)
global_type = _type
global_text = _text
global_timer =_timer
if _type == "error" then
	ProgressColor =  {100, 1, 1}
elseif _type == "success" then
	ProgressColor =  {37, 87, 5}
elseif _type == "warning" then
	ProgressColor =  {191, 143, 0}
else
	ProgressColor =  {100, 1, 1}
end
    if active then
	  Citizen.CreateThread(function()
        active = false
        hideUI()
		 Citizen.Wait(100)
		TriggerEvent("redemrp_notification:start", global_text , global_timer, global_type)
		end)
    else
        active = true
        liczba = GetLengthOfLiteralString(_text)
        print(liczba)
        ShowUI(_text, liczba)
        bg(_timer)
    end
end)




function hideUI()
    SendNUIMessage({
        type = "ui",
        display = false

    })
    show = false
    active = false
end

function ShowUI(text)
    local _text = text
    local _liczba = liczba*1.1
    if _liczba < 80 then
        _liczba = 80
    end
    SendNUIMessage({
        type = "ui",
        display = true,
        text = _text,
        liczba = _liczba
    })
    show = true
end


function bg(_timer)
    local offset = 0
    local height = liczba*0.0015
    local load_offset = 0.6
    if height < 0.1 then
        height = 0.1
    end
    if liczba < 100 and liczba > 75 then
        offset = 0.01
        load_offset = 0.60
    end
    if liczba > 100 and liczba < 145 then
        offset = liczba*0.0002
    end
    if liczba >= 145 then
        offset = liczba*0.0003
    end
    if liczba > 200 then
        offset = liczba*0.0004
        load_offset = 0.58
    end
    print(offset)
    HasStreamedTextureDictLoaded("generic_textures")
    HasStreamedTextureDictLoaded("feeds")
    Citizen.CreateThread(function()
        local timer = _timer*100
        local loading = 0.22
        local del = loading/timer
        while  show and timer > 0 do
            Citizen.Wait(0)
            DrawSprite("feeds", "toast_bg", 0.15, 0.57+offset, 0.25, height, 0.2, 000, 2, 2, 255, 1)
            DrawSprite("generic_textures", "hud_menu_4a", 0.15, load_offset +(offset*2), loading, 0.01, 0.2, ProgressColor[1], ProgressColor[2], ProgressColor[3], 190, 0)
            timer = timer - 1
            loading = loading - del
        end

        hideUI()
    end)

end


