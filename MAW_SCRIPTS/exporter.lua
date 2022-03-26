-- This file is responsible for exporting data from inside DCS out into JSON so we can work with it later.

write_state = function()
    log("Writing State...")
    local stateFile = lfs.writedir()..[[Scripts\FellaFlight\MAW_SCRIPTS\state.json]]
    local fp = io.open(stateFile, 'w')
    -- fp.write("-- Writing state file out") -- this is a test
    fp:write(json:encode(game_state))
    fp:close()
    log("Done writing state.")
end

-- TODO look at converting this to moose
mist.scheduleFunction(write_state, {}, timer.getTime() + 524, 580)

-- TODO support more then just hawks for respawning
-- update list of active CTLD AA sites in the global game state
function enumerateCTLD()
    local CTLDstate = {}
    log("Enumerating CTLD")
    for _groupname, _groupdetails in pairs(ctld.completeAASystems) do
        if string.match(_groupname, "Hawk") then
            local CTLDsite = {}
            for k,v in pairs(_groupdetails) do
                CTLDsite[v['unit']] = v['point']
            end
            CTLDstate[_groupname] = CTLDsite
        end
    end
    game_state["Hawks"] = CTLDstate
    log("Done Enumerating CTLD")
end

ctld.addCallback(function(_args)
    if _args.action and _args.action == "unpack" then
        local name
        local groupname = _args.spawnedGroup:getName()
        if string.match(groupname, "Hawk") then
            name = "hawk"
        elseif string.match(groupname, "Avenger") then
            name = "avenger"
        elseif string.match(groupname, "M 818") then
            name = 'ammo'
        elseif string.match(groupname, "Gepard") then
            name = 'gepard'
        elseif string.match(groupname, "MLRS") then
            name = 'mlrs'
        elseif string.match(groupname, "Hummer") then
            name = 'jtac'
        elseif string.match(groupname, "Abrams") then
            name = 'abrams'
        elseif string.match(groupname, "Chaparral") then
            name = 'chaparral'
        elseif string.match(groupname, "Vulcan") then
            name = 'vulcan'
        elseif string.match(groupname, "M-109") then
            name = 'M-109'                              
        elseif string.match(groupname, "Roland") then
            name = 'roland'                              
        else
            return
        end

        table.insert(game_state["CTLD_ASSETS"], {
                name=name,
                pos=GetCoordinate(Group.getByName(groupname))
            })

        enumerateCTLD()
        write_state()
    end
end)

