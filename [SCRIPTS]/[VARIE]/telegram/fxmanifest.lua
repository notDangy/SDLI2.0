game 'rdr3'
fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

ui_page "html/index.html"

client_script 'client.lua'

server_scripts {
    --'@mysql-async/lib/MySQL.lua',
    'server.lua'
}

files {
    "html/index.html",
    "html/styles.css",
    "html/eden.png",
    "html/telegram.png",
    "html/telegram_background.png",
    "html/telegram_divider.png",
    "html/telegram_footer.png",
    "html/telegram_header.png",
    "html/reset.css",
    "html/listener.js"
}
