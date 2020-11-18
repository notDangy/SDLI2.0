noteCoords = {}

AddEventHandler('chatMessage', function(player, playerName, message)
    if message:sub(1) == '/notepad' then
        TriggerClientEvent('notepad:open', player)
        CancelEvent()
    end
end)

RegisterServerEvent('notepad:getCoords')
AddEventHandler('notepad:getCoords', function()
    TriggerClientEvent('notepad:getCoords', source, noteCoords)
end)

RegisterServerEvent('notepad:saveCoord')
AddEventHandler('notepad:saveCoord', function(coord)
    noteCoords[#noteCoords + 1] = coord
end)

RegisterServerEvent('notepad:deleteCoord')
AddEventHandler('notepad:deleteCoord', function(coord)
    noteCoords[coord] = nil
end)
