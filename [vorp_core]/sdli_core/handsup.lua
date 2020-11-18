Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsControlJustPressed(0,0x8CC9CD42))  then

            local ped = PlayerPedId()
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
    
                RequestAnimDict( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" )
    
                while ( not HasAnimDictLoaded( "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs" ) ) do 
                    Citizen.Wait( 100 )
                end
    
                if IsEntityPlayingAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
                    ClearPedSecondaryTask(ped)
                else
                    TaskPlayAnim(ped, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 8.0, -8.0, 120000, 31, 0, true, 0, false, 0, false)
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if (IsControlJustPressed(0,0x26E9DC00))  then

            local ped = PlayerPedId()
            if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then
    
                RequestAnimDict( "mech_loco_m@generic@reaction@pointing@unarmed@stand" )
    
                while ( not HasAnimDictLoaded( "mech_loco_m@generic@reaction@pointing@unarmed@stand" ) ) do 
                    Citizen.Wait( 100 )
                end
                
             
                TaskPlayAnim(ped, "mech_loco_m@generic@reaction@pointing@unarmed@stand", "point_fwd_0", 1.0, 8.0, 1500, 31, 0, true, 0, false, 0, false)
                
            end
        end
    end
end)

-- Citizen.CreateThread(function()
--     RequestAnimDict('facials@gen_male@variations@normal')
--     RequestAnimDict('mpfacial')

--     local talkingPlayers = {}

--     while true do
--         Citizen.Wait(100)
--         local myId = PlayerId()

--         for player in ipairs(GetActivePlayers()) do
--             local boolTalking = SetPlayerTalkingOverride(player)

--             if player ~= myId then
--                 if boolTalking and not talkingPlayers[player] then
--                     SetPlayerTalkingOverride(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
--                     talkingPlayers[player] = true
--                 elseif not boolTalking and talkingPlayers[player] then
--                     SetPlayerTalkingOverride(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
--                     talkingPlayers[player] = nil
--                 end
--             end
--         end
--     end
-- end)
