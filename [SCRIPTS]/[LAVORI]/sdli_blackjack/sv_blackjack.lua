--
local isBlackjackActivated = false
local startedGame = false
local dealerCards = {}
local dealerHasAce = false
local dealerFakeBust = false
local countDealerCards = 0
local playersData = {}
local waitingPlayers = {}

VorpInv = exports.vorp_inventory:vorp_inventoryApi();
VORP = exports.vorp_core:vorpAPI()


local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

function collectBet()
    
    for i, v in ipairs(playersData) do
        TriggerClientEvent("vorp_blackjack:Bet", v.playerId,25)
    end
    Citizen.Wait(15000)
    for i, v in ipairs(playersData) do
        TriggerClientEvent("vorp_blackjack:Stop_Bet", v.playerId)
    end
end

function giveCards() -- Questi valori vanno passati al client
    startedGame = true
    

    dealerCards[1]=peekCard("dealer")
    
    for i, v in ipairs(playersData) do
        
        v.playerCards[1] = peekCard("player", v.playerId)
        v.playerCards[2]= peekCard("player", v.playerId)

        TriggerClientEvent('vorp_blackjack:ReceiveCard', v.playerId, v.playerCards[1], "player")
        Citizen.Wait(1000)
        TriggerClientEvent('vorp_blackjack:ReceiveCard', v.playerId, v.playerCards[2], "player")
        Citizen.Wait(1000)
        TriggerClientEvent('vorp_blackjack:ReceiveCard', v.playerId, dealerCards[1], "dealer")
        Citizen.Wait(1000)
        TriggerClientEvent('vorp_blackjack:ReceiveCountedCards', v.playerId, v.countPlayerCards, "player")
        TriggerClientEvent('vorp_blackjack:ReceiveCountedCards', v.playerId, countDealerCards, "dealer")
        --print("Carte giocatore".. v.playerId .. v.playerCards[1] .. " " .. v.playerCards[2].. "\nCarte tavolo: " .. dealerCards[1] .. " ")
    end
    
    
    
    dealerCards[2]=peekCard("dealer")
end

function startGame()
    isBlackjackActivated = true
    while #playersData ~= 0 or #waitingPlayers ~= 0 do
        if (#playersData ~= 0) then

            collectBet()
            giveCards()
            local j = 3
            for i, v in ipairs(playersData) do
                while v.countPlayerCards < 21 and not v.continue do
                    if (v.isInTable) then
                    TriggerClientEvent('vorp_blackjack:WaitingForResponse', v.playerId, true)
                    Citizen.Wait(5000)
                    TriggerClientEvent('vorp_blackjack:WaitingForResponse', v.playerId, false)
                    end
                    if v.continue == true then
                        v.continue = false
                        v.playerCards[j]=peekCard("player", v.playerId)
                        Citizen.Wait(1000)
                        TriggerClientEvent('vorp_blackjack:ReceiveCard', v.playerId, v.playerCards[j], "player")
                        TriggerClientEvent('vorp_blackjack:ReceiveCountedCards', v.playerId, v.countPlayerCards, "player")
                        if getNumber(v.playerCards[j],v.playerHasAce) == 1 then
                            v.playerHasAce = true
                        end
                        j = j+1
                        -- Citizen.Wait(3000)
                        --print("Somma carte player: ", countPlayerCards)
                    else
                        v.continue = true
                    end
                end
            end

            for i, v in ipairs(playersData) do
                if (v.isInTable) then
                    TriggerClientEvent('vorp_blackjack:ReceiveCard', v.playerId, dealerCards[2], "dealer")
                    Citizen.Wait(1000)
                    TriggerClientEvent('vorp_blackjack:ReceiveCountedCards', v.playerId, countDealerCards, "dealer")
                end
            end

            Citizen.Wait(2000)

            j = 3
            while countDealerCards < 17 do 
                
                dealerCards[j]=peekCard("dealer")
                --print("Nuova carta pesacata dal tavolo: " .. dealerCards[j])
                for i, v in ipairs(playersData) do
                    if (v.isInTable) then
                        TriggerClientEvent('vorp_blackjack:ReceiveCard', v.playerId, dealerCards[j], "dealer")
                        TriggerClientEvent('vorp_blackjack:ReceiveCountedCards', v.playerId, countDealerCards, "dealer")
                        Citizen.Wait(1000)
                    end
                end
                if getNumber(dealerCards[j],dealerHasAce) == 1 then
                    dealerHasAce = true
                end
                j = j+1

            end

            for i, v in ipairs(playersData) do
                    --print("Somma carte tavolo: " .. countDealerCards)
                if (v.isInTable) then
                    if v.countPlayerCards > 21 and v.isInTable then
                        TriggerClientEvent('vorp_blackjack:ReceiveWin', v.playerId, "Il banco ha vinto")
                        payBet(v.playerId, v.betAmount, "lose")
                    elseif countDealerCards > 21 and v.isInTable then
                        TriggerClientEvent('vorp_blackjack:ReceiveWin', v.playerId, "Hai vinto")
                        payBet(v.playerId, v.betAmount, "win")
                    elseif countDealerCards > v.countPlayerCards and v.isInTable then
                        TriggerClientEvent('vorp_blackjack:ReceiveWin', v.playerId, "Il banco ha vinto")
                        payBet(v.playerId, v.betAmount, "lose")
                    elseif countDealerCards < v.countPlayerCards and v.isInTable then
                        TriggerClientEvent('vorp_blackjack:ReceiveWin', v.playerId, "Hai Vinto")
                        payBet(v.playerId, v.betAmount, "win")
                    elseif countDealerCards == v.countPlayerCards and v.isInTable then
                        TriggerClientEvent('vorp_blackjack:ReceiveWin', v.playerId, "Push")
                    end
                    TriggerClientEvent('vorp_blackjack:GameFinished', v.playerId, true)
                else 
                    payBet(v.playerId, v.betAmount, "lose")
                end   
            end
            Citizen.Wait(7000)
            checkPlayers()
            addPlayerInGame()
        end
        addPlayerInGame()
        resetGame()
    end
    isBlackjackActivated = false
end

function payBet(playerId, money, condition)
    --SCRIVERE EVENTO CHE DA SOLDI AL CLIENT LA QUANTITA' E' QUESTA
    print(tostring(money) .. " " .. tostring(condition))
    if condition == "lose" then
        local User = VorpCore.getUser(playerId) 
        local Character = User.getUsedCharacter            
        if Character ~= nil then    
            --Character.removeMoney(money)
            if money > 0 then
                VorpInv.subItem(playerId, "fiche", money)
                --TriggerClientEvent("vorp_notification:start", playerId, "Hai perso " .. tostring(money) .. " fiches!", 3, "error")
            end
        end
      
    elseif condition == "win" then
        --AGGIUNGERE QUESTA QUANTITA' DI SOLDI : money
        local User = VorpCore.getUser(playerId) 
        local Character = User.getUsedCharacter 
        if Character ~= nil then
            --Character.addMoney(money)
            if money > 0 then
                VorpInv.addItem(playerId, "fiche", money)
                --TriggerClientEvent("vorp_notification:start", playerId, "Hai ottenuto " .. tostring(money) .. " fiches!", 3, "success")
            end

        end
        
    end

end


function getNumber(card,hasAce)
    local value = 0
    if string.len(card) > 4 then
        value = 10
    else
        if string.sub(card,1, 1) == "1" and not hasAce then
            value = 11
        else 
            value = tonumber(string.sub(card, 1, 1))  
        end
    end
    return value
end

function resetGame()
    startedGame = false
    dealerCards = {}
    dealerHasAce = false
    dealerFakeBust = false
    countDealerCards = 0
    for i, v in ipairs(playersData) do
        v.playerCards = {}
        v.continue = false
        v.playerHasAce = false
        v.playerFakeBust = false
        v.countPlayerCards = 0
        v.betAmount = 0
        TriggerClientEvent('vorp_blackjack:Reset_Game_Var', v.playerId)
    end
end

Citizen.CreateThread(function()
    math.randomseed(os.clock()*100000000000)
end)

function randomCard()
    local n = math.random(4)
    local seed = ""
    if n == 1 then
        seed = "♠"
    elseif n == 2 then
        seed = "♥"
    elseif n == 3 then
        seed = "♦"
    elseif n == 4 then
        seed = "♣"
    end
    return tostring(math.random(13))..seed
end

function peekCard(type, playerId)
    card = randomCard()

    if (type == "player") then 
        for i, v in ipairs(playersData) do 
            if (playerId == v.playerId) then
                v.countPlayerCards = v.countPlayerCards+getNumber(card,v.playerHasAce)
                if getNumber(card, v.playerHasAce) == 11 then
                    v.playerHasAce = true
                end
                if v.countPlayerCards > 21 and v.playerHasAce and not v.playerFakeBust then
                    v.countPlayerCards = v.countPlayerCards-10
                    v.playerFakeBust = true
                end
                break
            end
        end
    else
        countDealerCards = countDealerCards+getNumber(card,dealerHasAce)
        if getNumber(card, dealerHasAce) == 11 then
            dealerHasAce = true
        end
        if countDealerCards > 21 and dealerHasAce and not dealerFakeBust then
            countDealerCards = countDealerCards-10
            dealerFakeBust = true
        end
    end
    return card
end

function checkPlayers()
    for i, v in ipairs(playersData) do
        if v.isInTable == false then
            table.remove(playersData, i)
        end
    end
end

function addPlayerInGame()
    for i, v in ipairs(waitingPlayers) do
        table.insert(playersData, {playerId = v.playerId, playerCards={}, continue=false, playerHasAce=false, playerFakeBust=false, countPlayerCards=0, betAmount = 0, isInTable = true})
        table.remove(waitingPlayers, i)
    end
end

RegisterServerEvent("bj:checkgroupsv")
AddEventHandler("bj:checkgroupsv", function()
    local User = VorpCore.getUser(source) 
    local Character = User.getUsedCharacter

    if Character.job == 'blackjack' then
        TriggerClientEvent("bj:checkgroupcl", source, true)
    else
        TriggerClientEvent("bj:checkgroupcl", source, false)
    end
    
end)

RegisterServerEvent("bj:buyfiches")
AddEventHandler("bj:buyfiches", function(fiches)
        local _source = source 
        local User = VorpCore.getUser(_source) 
	    local Character = User.getUsedCharacter 
        local money = Character.money
        local currentfiches = VorpInv.getItemCount(_source, "fiche")
        if money >= fiches then
            VorpInv.addItem(_source, "fiche", fiches)
            local fichesadded = VorpInv.getItemCount(_source,"fiche") - currentfiches

            if fichesadded < fiches then 
                TriggerClientEvent("vorp:TipBottom", _source, "Inventario pieno!", 5000)
            end
            VORP.removeMoney(_source, 0, fichesadded*0.8) 
            --TriggerClientEvent("vorp_notification:start", source, "Hai comprato " .. tostring(fiches) .. " fiches!", 3, "success")
        end
end)

cansell = true
RegisterServerEvent("bj:sellfiches")
AddEventHandler("bj:sellfiches", function()
    
    local _source = source
    local User = VorpCore.getUser(_source) 
    local Character = User.getUsedCharacter 
    local fiches = VorpInv.getItemCount(_source, "fiche")
    
    
    if fiches > 0 and cansell then
        cansell = false 
        VorpInv.subItem(_source, "fiche", fiches)
        VORP.addMoney(_source,0,fiches)
        --TriggerClientEvent("vorp_notification:start", _source, "Hai venduto " .. tostring(fiches) .. " fiches!", 3, "success")
        Wait(1000)
        cansell = true
    end
end)

RegisterNetEvent('vorp_blackjack:ReceiveStayOrCard')
AddEventHandler('vorp_blackjack:ReceiveStayOrCard', function(decision)
    continue = decision
end)

RegisterNetEvent('vorp_blackjack:Choice')
AddEventHandler('vorp_blackjack:Choice', function(choice)
    for i, v in ipairs(playersData) do
        if v.playerId == source then
            v.continue = choice
            break
        end
    end
end)

RegisterNetEvent('vorp_blackjack:Request_Sit')
AddEventHandler('vorp_blackjack:Request_Sit', function()
    table.insert(waitingPlayers, {playerId = source})
    if not isBlackjackActivated then
        startGame()
    end
end)

RegisterNetEvent('vorp_blackjack:Request_Leave')
AddEventHandler('vorp_blackjack:Request_Leave', function()
    for i, v in ipairs(playersData) do
        if v.playerId == source then
            v.isInTable = false
        end
    end
    for i, v in ipairs(waitingPlayers) do 
        if v.playerId == source then
            table.remove(waitingPlayers, i)
        end
    end
end)

RegisterNetEvent('vorp_blackjack:Get_Bet')
AddEventHandler('vorp_blackjack:Get_Bet', function(bet)
    local playerMoney = 0
    for i, v in ipairs(playersData) do
        if v.playerId == source then
            playerMoney = VorpInv.getItemCount(v.playerId, "fiche")
            if playerMoney >= bet then
                v.betAmount = bet
            else
                v.betAmount = 0
            end
        end
    end
    
end)

AddEventHandler('playerDropped', function(reason)
    for i, v in ipairs(playersData) do
        if v.playerId == source then
            v.isInTable = false
        end
    end
    for i, v in ipairs(waitingPlayers) do 
        if v.playerId == source then
            table.remove(waitingPlayers, i)
        end
    end
end)
