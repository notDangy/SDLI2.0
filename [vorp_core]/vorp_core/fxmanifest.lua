game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
  'vorpcore_cl.net.dll',
  'Notifications.js',
  'vorpcore_luapi_cl.lua'
}

server_scripts {
  'vorpcore_sv.net.dll',
  'vorpcore_luapi.lua'
}

server_exports {'vorpAPI'}

files {
  'Newtonsoft.Json.dll',
  'ui/hud.html',
  'ui/js/progressbar.js',
  'ui/js/progressbar.min.js',
  'ui/js/progressbar.min.js.map',
  'ui/hud.html',
  'ui/css/style.css',
  'ui/fonts/rdrlino-regular-webfont.woff',
  'ui/icons/gold_2.png',
  'ui/icons/token.png',
}

ui_page 'ui/hud.html'
