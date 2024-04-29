--[[
     ____   ____ _____ _____   _   _____  ________      ________ _      ____  _____  __  __ ______ _   _ _______ 
    |  _ \ / __ \_   _|_   _| | | |  __ \|  ____\ \    / /  ____| |    / __ \|  __ \|  \/  |  ____| \ | |__   __|
    | |_) | |  | || |   | |   | | | |  | | |__   \ \  / /| |__  | |   | |  | | |__) | \  / | |__  |  \| |  | |   
    |  _ <| |  | || |   | |   | | | |  | |  __|   \ \/ / |  __| | |   | |  | |  ___/| |\/| |  __| | . ` |  | |   
    | |_) | |__| || |_ _| |_  | | | |__| | |____   \  /  | |____| |___| |__| | |    | |  | | |____| |\  |  | |   
    |____/ \____/_____|_____| | | |_____/|______|   \/   |______|______\____/|_|    |_|  |_|______|_| \_|  |_|   
                              | |                                                                                
                              |_|               PLAYERLIST
]]

fx_version 'cerulean'
games { 'gta5', 'rdr3' }

name 'boii_playerlist'
version '0.1.0'
description 'BOII | Development - Utility: Player List'
author 'boiidevelopment'
repository 'https://github.com/boiidevelopment/boii_playerlist'
lua54 'yes'

ui_page 'html/index.html'

files {
    'html/**/**/**',
}

server_scripts {
    'server/main.lua'
}

client_scripts {
    'client/main.lua'
}

escrow_ignore {
    'client/*',
    'server/*'
}