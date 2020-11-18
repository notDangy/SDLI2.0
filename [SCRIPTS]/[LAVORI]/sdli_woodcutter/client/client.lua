local PrimeraMina = false
local Mina1 = false
local Arbol1, Arbol2, Arbol3, Arbol4, Arbol5, Arbol6, Arbol7, Arbol8, Arbol9, Arbol10 = nil, nil, nil, nil
local Mina2 = false
local Mina3 = false
local Mina4 = false
local Mina5 = false
local Mina6 = false
local Mina7 = false
local Mina8 = false
local Mina9 = false
local Mina10 = false
local FinMina = false
local blipname = "WoodC"

Citizen.CreateThread(function()
    local blip = Citizen.InvokeNative(0x554d9d53f696d002, -592068833, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z)
end)

local blips = {
    { name = 'Raccolta Legna', sprite = 1904459580, x=-1500.8, y=-791.4, z=101.9},
    { name = 'Processo Legna', sprite = 2107754879, x = -1827.6, y = -424.4, z= 160.7},
}


Citizen.CreateThread(function()
    for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
        SetBlipScale(blip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local pos = GetEntityCoords(PlayerPedId())
        Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 0.9, 18, 255, 1, 155, 0, 0, 2, 0, 0, 0, 0)

        if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z) < 1.0) then
            if true then
              --  DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
              DrawText3D(Config.Zonas['init'].x, Config.Zonas['init'].y, Config.Zonas['init'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    TriggerServerEvent('woodcutter:checkjob')
                end
            end
        end
        if PrimeraMina and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z) < 3.0) then
            --    DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
            DrawText3D(Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol1) -- aqui la he liado seguro
                   -- TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                  -- TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 5000)
                  TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000}) -- error/succes
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
					RemoveBlip(blip)
					blip2 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z)
                    SetBlipSprite(blip2, -570710357, 1)
					PrimeraMina = false
                    Mina2 = true
                end
            end
        elseif Mina2 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z) < 3.0) then
              --  DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
              DrawText3D(Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol2)
                  --  TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                  TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip2)
                    blip3 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z)
                    SetBlipSprite(blip3, -570710357, 1)
                    Mina2 = false
                    Mina3 = true
                end
            end
        elseif Mina3 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z - 1.0, 0, 0, 0, 0, 0, 0,2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z) < 3.0) then
               -- DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
               DrawText3D(Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol3)
                 --   TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                 TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip3)
                    blip4 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z)
                    SetBlipSprite(blip4, -570710357, 1)
                    Mina3 = false
                    Mina4 = true
                end
            end
        elseif Mina4 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z) < 3.0) then
             --   DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
             DrawText3D(Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol4)
                  --  TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                  TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip4)
                    blip5 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner5'].x, Config.Zonas['Miner5'].y, Config.Zonas['Miner5'].z)
                    SetBlipSprite(blip5, -570710357, 1)
                    Mina4 = false
                    Mina5 = true
                end
            end
        elseif Mina5 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner5'].x, Config.Zonas['Miner5'].y, Config.Zonas['Miner5'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner5'].x, Config.Zonas['Miner5'].y, Config.Zonas['Miner5'].z) < 3.0) then
           --     DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
           DrawText3D(Config.Zonas['Miner5'].x, Config.Zonas['Miner5'].y, Config.Zonas['Miner5'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol5)
                  --  TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                  TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip5)
                    blip6 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner6'].x, Config.Zonas['Miner6'].y, Config.Zonas['Miner6'].z)
                    SetBlipSprite(blip6, -570710357, 1)
                    Mina5 = false
                    Mina6 = true
                end
            end
        elseif Mina6 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner6'].x, Config.Zonas['Miner6'].y, Config.Zonas['Miner6'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner6'].x, Config.Zonas['Miner6'].y, Config.Zonas['Miner6'].z) < 3.0) then
              --  DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
              DrawText3D(Config.Zonas['Miner6'].x, Config.Zonas['Miner6'].y, Config.Zonas['Miner6'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol6)
                   -- TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                   TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip6)
                    blip7 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner7'].x, Config.Zonas['Miner7'].y, Config.Zonas['Miner7'].z)
                    SetBlipSprite(blip7, -570710357, 1)
                    Mina6 = false
                    Mina7 = true
                end
            end
        elseif Mina7 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner7'].x, Config.Zonas['Miner7'].y, Config.Zonas['Miner7'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner7'].x, Config.Zonas['Miner7'].y, Config.Zonas['Miner7'].z) < 3.0) then
               -- DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
               DrawText3D(Config.Zonas['Miner7'].x, Config.Zonas['Miner7'].y, Config.Zonas['Miner7'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol7)
                   -- TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                   TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip7)
                    blip8 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner8'].x, Config.Zonas['Miner8'].y, Config.Zonas['Miner8'].z)
                    SetBlipSprite(blip8, -570710357, 1)
                    Mina7 = false
                    Mina8 = true
                end
            end
        elseif Mina8 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner8'].x, Config.Zonas['Miner8'].y, Config.Zonas['Miner8'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner8'].x, Config.Zonas['Miner8'].y, Config.Zonas['Miner8'].z) < 3.0) then
               -- DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
               DrawText3D(Config.Zonas['Miner8'].x, Config.Zonas['Miner8'].y, Config.Zonas['Miner8'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol8)
                   -- TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                   TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip8)
                    blip9 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner9'].x, Config.Zonas['Miner9'].y, Config.Zonas['Miner9'].z)
                    SetBlipSprite(blip9, -570710357, 1)
                    Mina8 = false
                    Mina9 = true
                end
            end
        elseif Mina9 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner9'].x, Config.Zonas['Miner9'].y, Config.Zonas['Miner9'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner9'].x, Config.Zonas['Miner9'].y, Config.Zonas['Miner9'].z) < 3.0) then
               -- DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
               DrawText3D(Config.Zonas['Miner9'].x, Config.Zonas['Miner9'].y, Config.Zonas['Miner9'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol9)
                    --TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['goto'], 5, "warning")
                    TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['goto'], "inventory_items", "provision_rf_wood_cobalt", 2700)
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Vai al prossimo albero...", length = 10000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    RemoveBlip(blip9)
                    blip10 = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner10'].x, Config.Zonas['Miner10'].y, Config.Zonas['Miner10'].z)
                    SetBlipSprite(blip10, -570710357, 1)
                    Mina9 = false
                    Mina10 = true
                end
            end
        elseif Mina10 and IsPedOnFoot(PlayerPedId()) then
            Citizen.InvokeNative(0x2A32FAA57B937173, -1795314153, Config.Zonas['Miner10'].x, Config.Zonas['Miner10'].y, Config.Zonas['Miner10'].z - 1.0, 0, 0, 0, 0, 0, 0, 2.0, 2.0, 1.5, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
            if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Miner10'].x, Config.Zonas['Miner10'].y, Config.Zonas['Miner10'].z) < 3.0) then
               -- DrawTxt(Language.translate[Config.lang]['press'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
               DrawText3D(Config.Zonas['Miner10'].x, Config.Zonas['Miner10'].y, Config.Zonas['Miner10'].z, Language.translate[Config.lang]['press'])
                if IsControlJustPressed(0, 0xC7B5340A) then
                    animacion()
                    animacion3(Arbol10)
                   -- TriggerEvent("redemrp_notification:warning", Language.translate[Config.lang]['noveh'], 5)
                   -- TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['noveh'], 5, "warning")
                   TriggerEvent("vorp:NotifyLeft", "~o~Attenzione", Language.translate[Config.lang]['noveh'], "rpg_textures", "rpg_agitation", 3000)
                    --TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['carry'], 5, "success")
                    TriggerEvent("vorp:NotifyLeft", "~t6~Taglialegna", Language.translate[Config.lang]['carry'], "generic_textures", "tick", 3000)
                   -- TriggerEvent('notify:client:SendAlert', { type = 'error', text = "Assicurati di avere il mezzo adeguato per il trasporto", length = 40000})
                    --TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "Ottimo! Procedi alla zona di lavorazione per completare il lavoro", length = 60000})
                    PlaySoundFrontend("Give_Item_Enter", "HUD_Donate_Sounds", true, 1)
                    
                    RemoveBlip(blip10)
                    Mina10 = false
                    FinMina = true
                    TriggerEvent('dangy_stress:modify', 5.7)
                end
            end
        elseif FinMina == true then
            TriggerServerEvent('art_woodcutter:givewood')
            FinMina = false
            --TriggerEvent('art_woodcutter:comcrono')
        end 
    end
    
end)

canProcess = false
RegisterNetEvent("checklogcl")
AddEventHandler("checklogcl", function(result)
    canProcess = result
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z - 1.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.5, 255, 23, 23, 155, 0, 0, 2, 0, 0, 0, 0)
        local pos = GetEntityCoords(PlayerPedId())
        if (Vdist(pos.x, pos.y, pos.z, Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z) < 3.0) then
           -- DrawTxt(Language.translate[Config.lang]['pressf'], 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
           DrawText3D(Config.Zonas['Entrega'].x, Config.Zonas['Entrega'].y, Config.Zonas['Entrega'].z,Language.translate[Config.lang]['pressf'])
            if IsControlJustPressed(0, 0xC7B5340A) then
                animacion2()
                --DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                --TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['completejob'] ..dinero.."$ | "..xp.."XP", 5)
                TriggerServerEvent("checklogsv")
                Wait(1000)
                if canProcess then
                   -- TriggerEvent('notify:client:SendAlert', { type = 'succes', text = "La fase di lavorazione è finita procedi alla vendita", length = 10000})
                    --TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['completejob'], 5, "success")
                    TriggerEvent("vorp:NotifyLeft", "~t6~Taglialegna", Language.translate[Config.lang]['completejob'], "generic_textures", "tick", 3000)
                    PlaySoundFrontend("HUD_DRAW", "HUD_DUEL_SOUNDSET", true, 1)
                    TriggerServerEvent('art_woodcutter:cobrar')
                else
                   -- TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['nomateriale'], 5, "error")
                   TriggerEvent("vorp:NotifyLeft", "~e~Errore", Language.translate[Config.lang]['nomateriale'], "menu_textures", "cross", 3000)
                  --  TriggerEvent('notify:client:SendAlert', { type = 'error', text = "Non hai abbastanza matriale da processare!", length = 10000})
                end
            end
        end
    end
end)

RegisterNetEvent('art_woodcutter:comienzo')
AddEventHandler('art_woodcutter:comienzo', function(source)
    PlaySoundFrontend("CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true, 1)
    --TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['gopos'], 5, "success")
   TriggerEvent("vorp:NotifyLeft", "Taglialegna", Language.translate[Config.lang]['gopos'], "inventory_items", "provision_rf_wood_cobalt", 3000)
    blip = Citizen.InvokeNative(0x554d9d53f696d002, 203020899, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z)
    SetBlipSprite(blip, -570710357, 1)
    PrimeraMina = true
    Mina1 = true
    SpawnearArboles("p_tree_pine_ponderosa_06") -- Spawneo de arboles al empezar
end)


--RegisterNetEvent('art_woodcutter:comcrono')
--AddEventHandler('art_woodcutter:comcrono', function()
--	local timer = 999

--	Citizen.CreateThread(function()
--		while timer > 0 and Entrega do
	--		Citizen.Wait(1000)

	--		if timer > 0 then
	--			timer = timer - 1
	--		end
--		end
--	end)
--
--	Citizen.CreateThread(function()
	--	while Entrega do
	--		Citizen.Wait(0)
		--	DrawTxt(Language.translate[Config.lang]['temp']..timer..Language.translate[Config.lang]['seconds'], 0.4, 0.92, 0.4, 0.4, true, 255, 255, 255, 150, false)
        --    if timer < 1 then
      --          TriggerEvent("redemrp_notification:start", Language.translate[Config.lang]['lose'], 5)
	--			Mina1, Mina2, Mina3, Mina4, FinMina, Entrega, PrimeraMina = false, false, false, false, false, false, false
	--			DeleteVehicle(spawncar)
	--			RemoveBlip(blip6)
    --            SetEntityCoords(PlayerPedId(), Config.Zonas['Vehicle'].x, Config.Zonas['Vehicle'].y, Config.Zonas['Vehicle'].z)
	--		end
--		end
--	end)
--end)

function animacion()

    local playerPed = PlayerPedId()
    local prop_name = 'p_axe02x'
    local x,y,z = table.unpack(GetEntityCoords(playerPed))
    local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_Finger12")

    RequestAnimDict("amb_work@world_human_tree_chop@male_a@idle_b")
    while not HasAnimDictLoaded("amb_work@world_human_tree_chop@male_a@idle_b") do
        Citizen.Wait(100)
    end
    TaskPlayAnim(playerPed, "amb_work@world_human_tree_chop@male_a@idle_b", "idle_f", 8.0, -8.0, 10000, 0, 0, true, 0, false, 0, false)
    AttachEntityToEntity(prop, playerPed,boneIndex, 0.200, -0.0, 0.5010, 1.024, -160.0, -70.0, true, true, false, true, 1, true)

    exports['progressBars']:startUI(10000, Language.translate[Config.lang]['mining'])
    Wait(10000)
    ClearPedSecondaryTask(playerPed)
    DeleteObject(prop)
end

--[[function animacion2()
    TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_PLANE_WOOD'), 7000, true, false, false, false)
    exports['progressBars']:startUI(7000, Language.translate[Config.lang]['placing'])
    Wait(7000)
    ClearPedTasksImmediately(PlayerPedId())
end]]--

function animacion2()
    RequestAnimDict("amb_work@world_human_wood_plane@working@male_a@base")
    while not HasAnimDictLoaded("amb_work@world_human_wood_plane@working@male_a@base") do
        Citizen.Wait(1)
		RequestAnimDict("amb_work@world_human_wood_plane@working@male_a@base")
    end
	while not HasModelLoaded("p_woodplane01x") do
	   RequestModel("p_woodplane01x")
	   Citizen.Wait(1)
	end
    TaskPlayAnim(PlayerPedId(), "amb_work@world_human_wood_plane@working@male_a@base", "base", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
	local object = CreateObject("p_woodplane01x", x, y, z, true, true, true)
	AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 1, 0, 0, 1)
	--TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), 7000, true, false, false, false)
    exports['progressBars']:startUI(10000, Language.translate[Config.lang]['placing'])
    Wait(10000)
	DeleteObject(object)
	ClearPedTasks(PlayerPedId())
end

function animacion3(object)
    local rot = 1.01
    while true do
        Wait(10)
        rot = rot + 1
        SetEntityRotation(object, rot, 0.0, 0.0, 1, true)
        if(rot >= 90) then
            break
        end

    end
    DeleteObject(object)
end

function SpawnearArboles(hash)
    local obj = GetHashKey(hash)
    Wait(500)
    RequestModel(obj)
    if not HasModelLoaded(obj) then 
        RequestModel(obj) 
    end

    while not HasModelLoaded(obj) do 
        Citizen.Wait(1) 
    end

    Arbol1 = CreateObject(obj, Config.Zonas['Miner1'].x, Config.Zonas['Miner1'].y, Config.Zonas['Miner1'].z +1.0, true, true, true)
    Arbol2 = CreateObject(obj, Config.Zonas['Miner2'].x, Config.Zonas['Miner2'].y, Config.Zonas['Miner2'].z +1.0, true, true, true)
    Arbol3 = CreateObject(obj, Config.Zonas['Miner3'].x, Config.Zonas['Miner3'].y, Config.Zonas['Miner3'].z +1.0, true, true, true)
    Arbol4 = CreateObject(obj, Config.Zonas['Miner4'].x, Config.Zonas['Miner4'].y, Config.Zonas['Miner4'].z +1.0, true, true, true)
    Arbol5 = CreateObject(obj, Config.Zonas['Miner5'].x, Config.Zonas['Miner5'].y, Config.Zonas['Miner5'].z +1.0, true, true, true)
    Arbol6 = CreateObject(obj, Config.Zonas['Miner6'].x, Config.Zonas['Miner6'].y, Config.Zonas['Miner6'].z +1.0, true, true, true)
    Arbol7 = CreateObject(obj, Config.Zonas['Miner7'].x, Config.Zonas['Miner7'].y, Config.Zonas['Miner7'].z +1.0, true, true, true)
    Arbol8 = CreateObject(obj, Config.Zonas['Miner8'].x, Config.Zonas['Miner8'].y, Config.Zonas['Miner8'].z +1.0, true, true, true)
    Arbol9 = CreateObject(obj, Config.Zonas['Miner9'].x, Config.Zonas['Miner9'].y, Config.Zonas['Miner9'].z +1.0, true, true, true)
    Arbol10 = CreateObject(obj, Config.Zonas['Miner10'].x, Config.Zonas['Miner10'].y, Config.Zonas['Miner10'].z +1.0, true, true, true)
    PlaceObjectOnGroundProperly(Arbol1)
    PlaceObjectOnGroundProperly(Arbol2)
    PlaceObjectOnGroundProperly(Arbol3)
    PlaceObjectOnGroundProperly(Arbol4)
    PlaceObjectOnGroundProperly(Arbol5)
    PlaceObjectOnGroundProperly(Arbol6)
    PlaceObjectOnGroundProperly(Arbol7)
    PlaceObjectOnGroundProperly(Arbol8)
    PlaceObjectOnGroundProperly(Arbol9)
    PlaceObjectOnGroundProperly(Arbol10)
    SetEntityAsMissionEntity(Arbol1, true)
    SetEntityAsMissionEntity(Arbol2, true)
    SetEntityAsMissionEntity(Arbol3, true)
    SetEntityAsMissionEntity(Arbol4, true)
    SetEntityAsMissionEntity(Arbol5, true)
    SetEntityAsMissionEntity(Arbol6, true)
    SetEntityAsMissionEntity(Arbol7, true)
    SetEntityAsMissionEntity(Arbol8, true)
    SetEntityAsMissionEntity(Arbol9, true)
    SetEntityAsMissionEntity(Arbol10, true)
--[[
    while true do
        Wait(10)
        rot = rot + 1
        SetEntityRotation(object, rot, 0.0, 0.0, 1, true)
        print(GetEntityRotation(object))
        if(rot >= 90) then
            break
        end
    end

    DeleteObject(object)
    ]]--

end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)


    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end


Citizen.CreateThread(function()
    while true do
        Wait(0)
        Citizen.InvokeNative(0x2A32FAA57B937173, 0x07DCE236, -1816.9, -422.3, 160.0 - 1.0, 0, 0, 0, 0, 0, 0, 4.0, 4.0, 1.5, 255, 23, 23, 155, 0, 0, 2, 0, 0, 0, 0)
        local pos = GetEntityCoords(PlayerPedId())
        if (Vdist(pos.x, pos.y, pos.z, -1816.9,-422.3,160.0) < 3.0) then
          --  DrawTxt("Premi [INVIO] per aprire il processo taglialegna", 0.3, 0.95, 0.4, 0.4, true, 255, 255, 255, 150, false)
          DrawText3D(-1816.9,-422.3,160.0, "Premi [~e~INVIO~q~] per aprire il processo taglialegna")
            if IsControlJustReleased(0, 0xC7B5340A) then
                Wait(50)
                TriggerServerEvent('weaponsmith:checkp')
                
            end
        end
    end
end)

RegisterNetEvent('weaponsmith:openp')
AddEventHandler('weaponsmith:openp', function() 
    WarMenu.OpenMenu('processom')
end)

Citizen.CreateThread(function() 

    WarMenu.CreateMenu("processom", "Armaiolo")
    
    while true do
        Wait(0)
        if WarMenu.IsMenuOpened('processom') then

            if WarMenu.Button("Crea calcio fucile standard") then
                TriggerServerEvent('artwoodc:processoarmaiolo', 0, 15, 0, "calciofucilestandard")
            
            elseif WarMenu.Button("Crea calcio fucile migliorato") then
                TriggerServerEvent('artwoodc:processoarmaiolo', 15, 15, 8, "calciofucilemigliorato")

            elseif WarMenu.Button("Crea calcio pistola standard") then

                TriggerServerEvent('artwoodc:processoarmaiolo', 10, 0, 0, "calciopistolastandard")

            elseif WarMenu.Button("Crea calcio pistola migliorato") then

                TriggerServerEvent('artwoodc:processoarmaiolo', 10, 10, 5, "calciopistolamigliorato")
                
            elseif WarMenu.Button("Chiudi") then
                WarMenu.CloseMenu()
            end
            WarMenu.Display()
        end
    end

end)

RegisterNetEvent('artwoodc:animazionep')
AddEventHandler('artwoodc:animazionep', function() 
    animacion3pr()
end)

function animacion3pr()
    RequestAnimDict("amb_work@world_human_wood_plane@working@male_a@base")
    while not HasAnimDictLoaded("amb_work@world_human_wood_plane@working@male_a@base") do
        Citizen.Wait(1)
		RequestAnimDict("amb_work@world_human_wood_plane@working@male_a@base")
    end
	while not HasModelLoaded("p_woodplane01x") do
	   RequestModel("p_woodplane01x")
	   Citizen.Wait(1)
	end
    TaskPlayAnim(PlayerPedId(), "amb_work@world_human_wood_plane@working@male_a@base", "base", 1.0, 8.0, -1, 1, 0, false, 0, false, 0, false)
	local object = CreateObject("p_woodplane01x", x, y, z, true, true, true)
	AttachEntityToEntity(object, PlayerPedId(), GetEntityBoneIndexByName(PlayerPedId(), "PH_R_Hand"), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 1, 0, 0, 1)
	--TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('PROP_HUMAN_SACK_STORAGE_IN'), 7000, true, false, false, false)
    exports['progressBars']:startUI(40000, 'Processando...')
    Wait(40000)
	DeleteObject(object)
	ClearPedTasks(PlayerPedId())
end

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
    --DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 100, 1, 1, 190, 0)
end