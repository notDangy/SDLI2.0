--RegisterNetEvent('cmenuopen') AddEventHandler('cmenuopen', function() WarMenu.OpenMenu('ml') end)

-------------------------------------------------------- key

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

-------------------------------------- functio, blip
