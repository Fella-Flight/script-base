-- Setup the module path for reading files
local module_folder = lfs.writedir()..[[Scripts\FellaFlight\MAW_SCRIPTS\]]
package.path = module_folder .. "?.lua;" .. package.path
local ctld_config = require("ctld_config")

local statefile = io.open(lfs.writedir() .. "Scripts\\FellaFlight\\MAW_SCRIPTS\\state.json", 'r')

-- remove nukes
require("slmod_kick_for_nukes")
require("Weapons_Damage_Updated")

-- TODO figure out what this does one day
-- Disable slots
-- for _,ac in ipairs(late_unlockables) do
--     trigger.action.setUserFlag(ac,100)
--     log("Disabled slot ["..ac.."].")
-- end

if statefile then
    trigger.action.outText("Found a statefile.  Processing it instead of starting a new game", 5)

else 
    trigger.action.outText("No state file detected.  Creating new situation", 5)
    
end
log("Creating last airbase state")
-- mist.scheduleFunction(updateLastAirbaseState, {}, timer.getTime() + 3)

-- TODO Comment this out after we know wtf it does
-- -- Kick off supports
-- mist.scheduleFunction(function()
--     -- Friendly
--     TexacoSpawn:Spawn()
--     ShellSpawn:Spawn()
--     OverlordSpawn:Spawn()
--     CagAWACSSpawn:Spawn()
--     ArcoSpawn:Spawn()
--     -- Enemy
--     RussianTheaterAWACSSpawn:Spawn()
-- end, {}, timer.getTime() + 30)

-- mist.scheduleFunction(function()
--   RussianTheaterCASSpawn:Spawn()
--   RussianTheaterCASSpawnF14:Spawn()
-- --   RussianTheaterCASSU24Spawn:Spawn()
--   log("Spawned CAS Groups...")
-- end, {}, timer.getTime() + 1800, 1280)
-- -- Kick off the commanders
-- mist.scheduleFunction(russian_commander, {}, timer.getTime() + 1, 1000) -- CHANGE ME BACK

-- -- Check base ownership
-- mist.scheduleFunction(processLogiSlots, {}, timer.getTime() + 10, 60)

log("init.lua complete")

