local Config = {}
local inTable = false
local playerCards = {}
local dealerCards = {}
local playerCount = 0
local dealerCount = 0
local textWinLosePush = ""
local playerCardsText = ""
local dealerCardsText = ""
local gameFinished = false
local waiting = false
local alreadyPressed = false
local testo4 = ""
local stopBet = false
local cardsGiven = false


Config.Tables = {
    {-366.76,786.74,115.22}
}

--        for k,v in pairs(Config.Tables) do
--        local x,y,z = table.unpack(v)


function startPlay()
    resetGameVariables()
    inTable = true
    TriggerServerEvent('vorp_blackjack:Request_Sit')
end

function stopPlay()
    resetGameVariables()
    inTable = false
    TriggerServerEvent('vorp_blackjack:Request_Leave')
end

function resetGameVariables()
    playerCards = {}
    dealerCards = {}
    playerCount = 0
    dealerCount = 0
    textWinLosePush = ""
    playerCardsText = ""
    dealerCardsText = ""
    gameFinished = false
    waiting = false
    alreadyPressed = false
    stopBet = false
    cardsGiven = false
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

local isBJ = false
RegisterNetEvent("bj:checkgroupcl")
AddEventHandler("bj:checkgroupcl", function(bool)
    isBJ = bool
end)

Citizen.CreateThread(function() --Marker
    while true do
        Citizen.Wait(0) 
        Citizen.InvokeNative(0x2A32FAA57B937173,0x07DCE236,-237.6,768.0,117.1,0,0,0,0,0,0,1.0,1.0,1.0,0,0,250,250,0, 0, 2, 0, 0, 0, 0)
        if IsPlayerNearCoords(-237.6,768.0,117.1) then
            TriggerServerEvent("bj:checkgroupsv")
            if isBJ then
                DrawTxt("( Valentine Gambling ) Premi G per aprire il menu", 0.50, 0.90, 0.7, 0.7, true, 255, 255, 255, 255, true)
                if IsControlJustReleased(2, 0x760A9C6F) then
                    WarMenu.OpenMenu('blackjack')
                end    
            end
        end
 	end
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('blackjack', "Valentine Gambling")
    WarMenu.SetMenuX('blackjack', 0.1) -- [0.0..1.0] top left corner
    WarMenu.SetMenuY('blackjack', 0.1) -- [0.0..1.0] top

    while true do 
        Wait(0)
        if WarMenu.IsMenuOpened('blackjack') then
            if WarMenu.Button("Compra fiches ($0.80)","") then

                AddTextEntry("FMMC_MPM_TYP8", "Quante fiches vuoi comprare?")
                DisplayOnscreenKeyboard(1, "FMMC_MPM_TYP8", "", "", "", "", "", 30)
                
		        while (UpdateOnscreenKeyboard() == 0) do
			        DisableAllControlActions(0);
			        Citizen.Wait(0);
                end

                if (GetOnscreenKeyboardResult()) then
                    local fiches = tonumber(GetOnscreenKeyboardResult())
                    TriggerServerEvent("bj:buyfiches", fiches)
                end

	
            elseif WarMenu.Button("Vendi fiches ($1)","") then
                TriggerServerEvent("bj:sellfiches")
            end
            --Citizen.Trace(WarMenu.CurrentOption())

			WarMenu.Display()
        end
    end
end)


Citizen.CreateThread(function()
    Wait(30000)
    local ped = PlayerPedId()
    while true do
        Wait(0)
        while IsPlayerNearCoords(-243.72,771.26,118.22) do
            Citizen.Wait(0)    

            if not inTable then
                local text = "Premi G per giocare"
                if IsControlJustPressed(0, 0x760A9C6F) then
                    startPlay()
                end  
                DrawScaleText(text, 0.5, 0.925, 1.0)
            elseif inTable then
                -- Premi E per uscire\nPremi SPAZIO per la selezionare la puntata \nPremi G per giocare ancora
                local testo1 = "G per uscire"
                if IsControlJustPressed(0, 0x760A9C6F) then
                    stopPlay()
                end
                if IsControlJustPressed(0, 0x760A9C6F) and gameFinished then
                    startPlay()
                end
                DrawScaleText(testo1, 0.89, 0.9, 0.8)
                DrawScaleText(testo4, 0.89, 0.9, 0.8)
            elseif inTable and not IsPlayerNearCoords(-243.72,771.26,118.22) then
                inTable = false
                textWinLosePush = ""
                playerCardsText = ""
                dealerCardsText = ""
                stopPlay()
            end
            if inTable and waiting and not alreadyPressed then
                local text1 = "Premi SPAZIO per chiamare, attendi per stare"
                if IsControlJustPressed(0, 0xD9D0E1C0) and waiting then
                    TriggerServerEvent('vorp_blackjack:Choice', true)
                    alreadyPressed = true
                end
                DrawScaleText(text1, 0.5, 0.9, 0.8)
            elseif (inTable and not alreadyPressed and cardsGiven) then
                DrawScaleText("Attendi il tuo turno", 0.5, 0.9, 0.8)
            end
            if not IsPlayerNearCoords(-243.72,771.26,118.22) then
                stopPlay()
            end
        end
    end 
end)

Citizen.CreateThread(function()
    local blip = N_0x554d9d53f696d002(1664425300, -240.6, 769.8, 118.1)
    SetBlipSprite(blip, 595820042, 1)
    SetBlipScale(blip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Valentine Gambling")
end)

--[[Citizen.CreateThread(function() 
	local EntityModel = string.upper("s_m_m_rhddealer_01")
	RequestModel(GetHashKey(EntityModel))
	while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
		Wait(1)
		RequestModel(GetHashKey(EntityModel))
	end
    local spawnedped = CreatePed(GetHashKey(EntityModel), -244.6, 770.88, 117.08, 289.07, true, false, true, true)
	Citizen.InvokeNative(0x283978A15512B2FE, spawnedped, true)
	FreezeEntityPosition(spawnedped, true)
end)]]--

Citizen.CreateThread(function()
    Wait(30000)
    while true do
        Wait(0)
        while IsPlayerNearCoords(-243.72,771.26,118.22) do
            Citizen.Wait(0)
            if (inTable and cardsGiven) then 
                DrawScaleText("Le tue carte sono:" .. playerCardsText, 0.5, 0.8, 0.8) --player text
                DrawScaleText("Somma: " .. playerCount, 0.5, 0.85, 0.8) --player text
                DrawScaleText("Le carte del banco sono:" .. dealerCardsText, 0.5, 0.0, 0.8) --dealer text
                DrawScaleText("Somma: " .. dealerCount, 0.5, 0.05, 0.8) --dealer text
                DrawScaleText(textWinLosePush, 0.5, 0.5, 1.0) 
            elseif (inTable) then
                DrawScaleText("Attendi l'inizio della mano" .. playerCardsText, 0.5, 0.9, 0.8) --player text
            end
        end
    end    
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(PlayerPedId()))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 1.5 then
        return true
    end
end

function DrawScaleText(text, x, y, size)
    local xc = x / 1.0;
    local yc = y / 1.0;
    SetScriptGfxDrawOrder(3)
    SetTextScale(size, size)
    SetTextCentre(true)
    SetTextColor(255, 255, 255, 100)
    SetTextFontForCurrentCommand(6)
    DisplayText(CreateVarString(10, 'LITERAL_STRING', text), xc, yc)
    SetScriptGfxDrawOrder(3)
end

RegisterNetEvent('vorp_blackjack:ReceiveCard')
AddEventHandler('vorp_blackjack:ReceiveCard', function(card,type)
    cardsGiven = true
    if type == "player" then
        table.insert(playerCards, card)
        if string.len(card) > 4 then
            if tonumber(string.sub(card, 1, 2)) == 10 then
                playerCardsText = playerCardsText.." "..card
            elseif tonumber(string.sub(card, 1, 2)) == 11 then
                playerCardsText = playerCardsText.." ".."J"..string.sub(card, 3, 5)
            elseif tonumber(string.sub(card, 1, 2)) == 12 then
                playerCardsText = playerCardsText.." ".."Q"..string.sub(card, 3, 5)
            elseif tonumber(string.sub(card, 1, 2)) == 13 then
                playerCardsText = playerCardsText.." ".."K"..string.sub(card, 3, 5)
            end
        else
            playerCardsText = playerCardsText.." "..card
        end
    else
        table.insert(dealerCards, card)
        if string.len(card) > 4 then
            if tonumber(string.sub(card, 1, 2)) == 10 then
                dealerCardsText = dealerCardsText.." "..card
            elseif tonumber(string.sub(card, 1, 2)) == 11 then
                dealerCardsText = dealerCardsText.." ".."J"..string.sub(card, 3, 5)
            elseif tonumber(string.sub(card, 1, 2)) == 12 then
                dealerCardsText = dealerCardsText.." ".."Q"..string.sub(card, 3, 5)
            elseif tonumber(string.sub(card, 1, 2)) == 13 then
                dealerCardsText = dealerCardsText.." ".."K"..string.sub(card, 3, 5)
            end
        else
            dealerCardsText = dealerCardsText.." "..card
        end
    end
end)


RegisterNetEvent('vorp_blackjack:ReceiveWin')
AddEventHandler('vorp_blackjack:ReceiveWin', function(gameResolution)
    textWinLosePush = gameResolution
end)

RegisterNetEvent('vorp_blackjack:ReceiveCountedCards')
AddEventHandler('vorp_blackjack:ReceiveCountedCards', function(count,type)
    if type == "player" then
        playerCount=count
    else
        dealerCount=count
    end
end)



RegisterNetEvent('vorp_blackjack:GameFinished')
AddEventHandler('vorp_blackjack:GameFinished', function(status)
    gameFinished = status
end)

RegisterNetEvent('vorp_blackjack:WaitingForResponse')
AddEventHandler('vorp_blackjack:WaitingForResponse', function(status)
    alreadyPressed = false
    waiting = status
end)

RegisterNetEvent('vorp_blackjack:Reset_Game_Var')
AddEventHandler('vorp_blackjack:Reset_Game_Var', function()
    resetGameVariables()
end)

RegisterNetEvent('vorp_blackjack:Bet')
AddEventHandler('vorp_blackjack:Bet', function(max)
    local x = true
    while x do
        AddTextEntry("FMMC_KEY_TIP8", "Inserisci la scommessa(max:"..max..")")
        DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", 3)

        while (UpdateOnscreenKeyboard() == 0) do
            DisableAllControlActions(0);
            Wait(0);
        end

        while (UpdateOnscreenKeyboard() == 2) do
            Wait(0);
        end
        while (UpdateOnscreenKeyboard() == 1) do
            Wait(0)
            if (GetOnscreenKeyboardResult()) then
                local bet = tonumber(GetOnscreenKeyboardResult())
                if bet then
                    if bet >= 1 and bet <= max then
                        if (stopBet) then
                            TriggerServerEvent("vorp_blackjack:Get_Bet", 0)
                        else
                            TriggerServerEvent("vorp_blackjack:Get_Bet", bet)
                        end
                        x = false
                    end
                end
                break
            end
        end
    end

end)

RegisterNetEvent("vorp_blackjack:Stop_Bet")
AddEventHandler("vorp_blackjack:Stop_Bet", function()
    stopBet = true
end)

