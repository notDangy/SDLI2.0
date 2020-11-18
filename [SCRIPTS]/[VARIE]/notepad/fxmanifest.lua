fx_version 'adamant'
games { 'rdr3', 'gta5' }
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

description 'A notepad script for writing together and sharing notes'

ui_page 'ui/index.html'

client_script 'client.lua'
server_script 'server.lua'

files {
    'ui/img/bg.png',
    'ui/index.html',
    'ui/css/style.css',
    'ui/css/bootstrap.css',
    'ui/js/main.js',
    'ui/js/bootstrap.js',
  }
