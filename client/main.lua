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

--- Tracks player list open state
local player_list_open = false

--- @section Local functions

--- Creates and adds player headshots to player list then sends to ui
-- @param player_list: Table of data for connected players
local function open_playerlist(player_list)
    local headshots_ready = 0
    for i, player in ipairs(player_list) do
        local ped = GetPlayerPed(GetPlayerFromServerId(player.id))
        if DoesEntityExist(ped) then
            local headshot = RegisterPedheadshot(ped)
            CreateThread(function()
                local timeout = 10
                while not IsPedheadshotReady(headshot) and timeout > 0 do
                    Wait(200)
                    timeout = timeout - 1
                end
                if IsPedheadshotReady(headshot) then
                    player.headshot = 'https://nui-img/' .. GetPedheadshotTxdString(headshot) .. '/' .. GetPedheadshotTxdString(headshot)
                end
                UnregisterPedheadshot(headshot)
                headshots_ready = headshots_ready + 1
                if headshots_ready == #player_list then
                    SendNUIMessage({
                        action = 'open_playerlist',
                        players = player_list
                    })
                end
            end)
        else
            headshots_ready = headshots_ready + 1
        end
    end
end

--- @section NUI Callbacks

--- Removes focus when player list is closes
RegisterNUICallback('close_player_list', function()
    SetNuiFocus(false, false)
    player_list_open = false
end)

--- @section Keymapping

--- Callback player list from server and send to open function if exists
RegisterCommand('open_player_list', function()
    if player_list_open then return end
    player_list_open = true
    SetNuiFocus(true, true)
    utils.callback.cb('boii_playerlist:sv:get_players', {}, function(player_list)
        if player_list then
            open_playerlist(player_list)
        else
            print('Failed to get player list')
        end
    end)
end, false)
RegisterKeyMapping('open_player_list', 'Open Player List', 'keyboard', 'F5') -- Default key to open

