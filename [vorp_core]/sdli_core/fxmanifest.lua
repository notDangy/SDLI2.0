fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

files {
	'config/mp_male.json',
	'config/mp_female.json',
	'config/ClothingStores.json',
	'config/Barbers.json',
	'client/Newtonsoft.Json.dll',
}

client_scripts {
	'client/skinOverlays.lua',
	'client/skinClient.lua',
	'client/MenuAPI.dll',
	'client/UtilsClient.net.dll',
	'client/CharacterClient.net.dll',
	'client/MenuClient.net.dll',
	'client/warmenu.lua',
	'client/menu_client.lua',
	'handsup.lua'
}

server_scripts {
	'server/UtilsServer.net.dll',
	'server/CharacterServer.net.dll',
	'server/MenuServer.net.dll',
	'server/menu_server.lua',
}
