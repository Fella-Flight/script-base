-- This file sets up the general fella flight system
-- Inspired from the Hoggit style of a central spot for your server logs

-- Setup JSON library to be able to parse json
local jsonlib = lfs.writedir() .. [[Scripts\FellaFlight\json.lua]]
json = loadfile(jsonlib)()

-- Setup logging
logFile = io.open(lfs.writedir() .. [[Logs\FellaFlight-MAW.log]], "w")
--JSON = (loadfile "JSON.lua")()

_stats_add = function(statobj, objtype, val)
    statobj[objtype].alive = statobj[objtype].alive + val
    return statobj[objtype].alive
end


GameStats = {
    increment = function(self, objtype)
        return _stats_add(game_stats, objtype, 1)
    end,
    decrement = function(self, objtype)
        return _stats_add(game_stats, objtype, -1)
    end,
    get = function(self)
        game_stats.caps.nominal = max_caps_for_player_count(get_player_count())
        return game_stats
    end
}


-- GAW = {}
function log(str)
    if str == nil then
        str = "nil"
    end
    if logFile then
        logFile:write(os.date("!%Y-%m-%dT%TZ") .. " | " .. str .. "\r\n")
        logFile:flush()
    end
    env.info(str)
end
