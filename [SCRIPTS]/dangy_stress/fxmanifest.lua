fx_version "adamant"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

game "rdr3"

ui_page 'ui/index.html'

client_scripts {
	'config.lua',
	'client.lua'
}

server_scripts {
    'server.lua'
}

files {
    'ui/index.html',
    'ui/style.css',
    'ui/stress.png',
    'ui/circle-progress.js',
    'ui/circle-progress.min.js',
}