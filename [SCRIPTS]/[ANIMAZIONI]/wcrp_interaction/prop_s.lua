VORP = exports.vorp_inventory:vorp_inventoryApi()


VORP.RegisterUsableItem("cigarette", function(data)
	VORP.subItem(data.source, "cigarette", 1)
	TriggerClientEvent('prop:cigarettes', data.source)
end)

VORP.RegisterUsableItem("hairpomade", function(data)
	VORP.subItem(data.source, "hairpomade", 1)
	TriggerClientEvent('prop:hairpomade', data.source)
end)


VORP.RegisterUsableItem("cigar", function(data)
	VORP.subItem(data.source, "cigar", 1)
	TriggerClientEvent('prop:cigar', data.source)
end)


VORP.RegisterUsableItem("pocket_watch", function(data)
	TriggerClientEvent('prop:watch', data.source)
end)

VORP.RegisterUsableItem("pipe", function(data)
	TriggerClientEvent('prop:pipe', data.source)
end)

VORP.RegisterUsableItem("cheweingtobacco", function(data)
	VORP.subItem(data.source, "cheweingtobacco", 1)
	TriggerClientEvent('prop:chewingtobacco', data.source)
end)

--Prova
VORP.RegisterUsableItem("fan", function(data)
	TriggerClientEvent('prop:fan', data.source)
end)

VORP.RegisterUsableItem("book", function(data)
	TriggerClientEvent('prop:book', data.source)
end)

VORP.RegisterUsableItem("ledger", function(data)
	TriggerClientEvent('prop:ledger', data.source)
end)

VORP.RegisterUsableItem("orologio", function(data)
	TriggerClientEvent('prop:orologio', data.source)
end)

