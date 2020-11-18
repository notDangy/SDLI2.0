local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['E'] = 0xDFF812F9 }

local pressTime = 0
local pressLeft = 0

local recentlySpawned = 0

local boatModel;
local boatSpawn = {}
local NumberboatSpawn = 0

--Config Boats Here

local boates = {
		[1] = {
		['Text'] = "~q~Canoa a Tronco d'Albero ~t1~[$5,20]", --1--
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 5.20,
			['Model'] = "CANOETREETRUNK",
			['Level'] = 0
		}
	},

		[2] = {
		['Text'] = "~q~Canoa Lunga 1 ~t1~[$6,34]", --2--
		['SubText'] = "",
		['Desc'] = "level require [5]",
		['Param'] = {
			['Price'] = 6.34,
			['Model'] = "PIROGUE",
			['Level'] = 0
		}
	},
	
		[3] = {
		['Text'] = "~q~Canoa Lunga 2 ~t1~[$6,50]", --3--
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 6.50,
			['Model'] = "pirogue2",
			['Level'] = 0
		}
	},

		[4] = {
		['Text'] = "~q~Canoa Classica ~t1~[$7,20]", --4--
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Price'] = 7.20,
			['Model'] = "CANOE",
			['Level'] = 0
		}
	},
	    [5] = {
		['Text'] = "~q~Barca a Remi delle Paludi 1 ~t1~[$15,32]", --5--
		['SubText'] = "",
		['Desc'] = "",
		['Param'] = {
			['Price'] = 15.32,
			['Model'] = "rowboatSwamp02",
			['Level'] = 0
		}
	},

		[6] = {
		['Text'] = "~q~Barca a Remi delle Paludi 2 ~t1~[$17,21]", --6--
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 17.21,
			['Model'] = "rowboatSwamp",
			['Level'] = 0
		}
	},

		[7] = {
		['Text'] = "~q~Barca a Remi Classica ~t1~[$20,34]", --7--
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 20.34,
			['Model'] = "rowboat",
			['Level'] = 0
		}
	},

		[8] = {
		['Text'] = "~q~Barca a Vapore Chiusa ~t1~[$450,0]", --8--
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 450.0,
			['Model'] = "keelboat",
			['Level'] = 0
		}
	},

		[9] = {
		['Text'] = "~q~Barca a Vapore Classica ~t1~[$500,0]", --9--
		['SubText'] = "",
		['Desc'] = "level require [0]",
		['Param'] = {
			['Price'] = 500.0,
			['Model'] = "boatsteam02x",
			['Level'] = 0
		}
	}
}
local function IsNearZone ( location )

	local player = PlayerPedId()
	local playerloc = GetEntityCoords(player, 0)

	for i=1,#location do
		if #(playerloc - location[i]) < 3.0 then
			return true
		end
	end

end

local function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

	local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

	SetTextScale(w, h)
	SetTextColor(col1, col2, col3, a)

	SetTextCentre(centre)

	if enableShadow then
		SetTextDropshadow(1, 0, 0, 0, 255)
	end

	Citizen.InvokeNative(0xADA9255D, 10);

	DisplayText(str, x, y)

end

local function ShowNotification( _message )
	local timer = 200
	while timer > 0 do
		DisplayHelp(_message, 0.50, 0.90, 0.6, 0.6, true, 161, 3, 0, 255, true, 10000)
		timer = timer - 1
		Citizen.Wait(0)
	end
end

Citizen.CreateThread( function()
	WarMenu.CreateMenu('id_boat', 'Negozio Barche')
	while true do
		if WarMenu.IsMenuOpened('id_boat') then
			for i = 1, #boates do
				if WarMenu.Button(boates[i]['Text'], boates[i]['SubText']) then
					TriggerServerEvent('elrp:buyboat', boates[i]['Param']) 
			end
			end
			WarMenu.Display()
		end
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do

		if IsNearZone( Config.Coords ) then
			DisplayHelp(Config.Shoptext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
			if IsControlJustReleased(0, keys['G']) then
				WarMenu.OpenMenu('id_boat')
			end
		end

		Citizen.Wait(0)
	end
end)

-- | Blips | --

-- Citizen.CreateThread(function()
	-- CreateBlips ( )
-- end)

-- | Notification | --

RegisterNetEvent('UI:DrawNotification')
AddEventHandler('UI:DrawNotification', function( _message )
	ShowNotification( _message )
end)

-- | Spawn boat | --

RegisterNetEvent( 'elrp:spawnBoat' )
AddEventHandler( 'elrp:spawnBoat', function ( boat )

	local player = PlayerPedId()

	local model = GetHashKey( boat )
	local x,y,z = table.unpack( GetOffsetFromEntityInWorldCoords( player, 0.0, 4.0, 0.5 ) )

	local heading = GetEntityHeading( player ) + 90

	local oldIdOfTheboat = idOfTheboat
	
	local idOfTheboat = NumberboatSpawn + 1

	RequestModel( model )

	while not HasModelLoaded( model ) do
		Wait(500)
	end

	if ( boatSpawn[idOfTheboat] ~= oldIdOfTheboat ) then
		DeleteEntity( boatSpawn[idOfTheboat].model )
	end

	boatModel = CreateVehicle( model, x, y, z, heading, 1, 1 )

	SET_PED_DEFAULT_OUTFIT (boatModel)
	--Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, boatModel)
	
	boatSpawn[idOfTheboat] = { id = idOfTheboat, model = boatModel }

end )


function SET_PED_DEFAULT_OUTFIT ( boat )
	return Citizen.InvokeNative(0xAF35D0D2583051B0, boat, true )
end


-- | Timer | --

RegisterCommand("barca", function(source, args, raw)
    if recentlySpawned <= 0 then
				recentlySpawned = 60 --3600
				TriggerServerEvent('elrp:dropboat')
			else
				TriggerEvent('chat:systemMessage', 'Devi aspettare ' .. recentlySpawned .. ' secondi prima di mettere in acqua la tua barca.')
				TriggerEvent('chat:addMessage', {
					color = { 171, 59, 36 },
					multiline = true,
					args = {"Anti-Spam", 'Devi aspettare ' .. recentlySpawned .. ' secondi prima di mettere in acqua la tua barca.'}
				})
			end
   end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
		if recentlySpawned > 0 then
			recentlySpawned = recentlySpawned - 1
		end
    end
end)

local boatshopblips = {
    {["ShopName"] = "Negozio Barche", x = 2802.51, y = -1407.3, z = 45.44, ["HasRares"] = false}
}

Citizen.CreateThread(function()
	for _, info in pairs(boatshopblips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
		SetBlipSprite(blip, 2005921736, 1)
	  SetBlipScale(blip, 0.2)
	  Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.ShopName)
	end  
end)

