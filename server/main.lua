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

-- Import utility library from 'boii_utils' resource.
local utils = exports.boii_utils:get_utils()

--- @section Callbacks

local function get_players(_src, data, cb)
    local players_data = {}
    local players = GetPlayers()
    for _, player in ipairs(players) do
        local source_player = tonumber(player)
        local identity = utils.fw.get_identity(source_player)
        local job_id = utils.fw.get_player_job_name(source_player)
        local job_details = utils.fw.get_shared_job_data(job_id)
        local user = utils.connections.get_user(source_player)
        local ping = GetPlayerPing(source_player)
        if identity and job_details then
            players_data[#players_data + 1] = {
                name = identity.first_name .. ' ' .. identity.last_name,
                job = { id = job_id, label = job_details and job_details.label or 'N/A' },
                rank = user.rank,
                ping = ping,
                id = source_player
            }
        end
    end
    if cb then
        cb(players_data)
    end
end
utils.callback.register('boii_playerlist:sv:get_players', get_players)

RegisterCommand('testutils', function(source, args, raw)
    local players = GetPlayers()
    for _, player in ipairs(players) do
        local utilsplayer = utils.fw.get_player(tonumber(player))
        print('player found: ' .. json.encode(utilsplayer))
    end
end)