local module_folder = lfs.writedir()..[[Scripts\]]
package.path = module_folder .. "?.lua;" .. package.path
-- Leave this alone!
-- Why does every DCS Script start with that? It feels really
-- odd to point to this specific thing to not touch.
-- Anyway, you should only be editing this file if you know what
-- you're doing. You can ask me for help.
WeaponPoints = {}

WeaponPoints.log = mist.Logger:new("WeaponPoints", "info")
local log = WeaponPoints.log
local AddWeaponPoints = function(pointValue, category)
    return {
        ["points"] = pointValue,
        ["category"] = category
    }
end
-- Begin configuration
-- The maximum points in each category that a plane is allowed to carry.
WeaponPoints.MaxPoints = {
   ["Air"] = 30,
   ["Ground"] = 60,
}

--Defines overrides for particular airframes.
--If an airframe is omitted, we default to WeaponPoints.MaxPoints
--If a category is omitted, we inherit from WeaponPoints.MaxPoints for that category.
WeaponPoints.AirframeOverrides = {
    ["A-10C"]   = { ["Ground"] = 80 },
    ["A-10C_2"] = { ["Ground"] = 80 },
    ["A-10A"]   = { ["Ground"] = 80 },
    ["AH-64D_BLK_II"]   = { ["Ground"] = 150 } ,
}

-- The time that someone can be in the air with an overpowered loadout
-- before they are punished. A WARN_TIME of zero will mean players are
-- instantly punished.
WeaponPoints.WARN_TIME = 30 --seconds

-- Loads a points configuration into the points system.
-- It will
WeaponPoints.LoadConfig = function(config, clear)
    if clear then
        log:info("Clearing configuration.")
        WeaponPoints.Points = {}
    end
    for k,v in pairs(config) do
        WeaponPoints.Points[k] = v
    end
end

WeaponPoints.LoadJsonConfig = function(jsonStr, clear)
    local json = require "json"
    local config = json:decode(jsonStr)
    WeaponPoints.LoadConfig(config, clear)
end

--The list of point values for weapon weapon by name.
WeaponPoints.Points = {
    --Air-to-air
    ["AIM-120C-5"]          = AddWeaponPoints(5, "Air"),
    ["AIM-120B"]            = AddWeaponPoints(5, "Air"),
    ["SD-10"]               = AddWeaponPoints(5, "Air"),
    ["AIM-54C-Mk47"]        = AddWeaponPoints(5, "Air"),
    ["AIM-54A-Mk47"]        = AddWeaponPoints(5, "Air"),
    ["AIM-54A-Mk60"]        = AddWeaponPoints(5, "Air"),

    --Air-to-ground apache shit
    ["M230_HEDP M789"]              = AddWeaponPoints( 2/7, "Ground"),
    ["M230_TP M788"]              = AddWeaponPoints( 2/7, "Ground"),
    ["AGM-114K"]              = AddWeaponPoints( 5, "Ground"),
    ["HYDRA-70 M151"]  = AddWeaponPoints(2/7, "Ground"),
    -- Air-to Ground 
    ["GBU-12"]              = AddWeaponPoints( 5, "Ground"),
    ["GBU-16"]              = AddWeaponPoints(10, "Ground"),
    ["GBU-10"]              = AddWeaponPoints(10, "Ground"),
    ["GBU-24 Paveway III"]  = AddWeaponPoints(10, "Ground"),
    ["GBU-38"]              = AddWeaponPoints(10, "Ground"),
    ["GBU-54B"]             = AddWeaponPoints(10, "Ground"),
    ["GBU-31(V)1/B"]        = AddWeaponPoints(15, "Ground"),
    ["GBU-31(V)2/B"]        = AddWeaponPoints(15, "Ground"),
    ["GBU-31(V)3/B"]        = AddWeaponPoints(15, "Ground"),
    ["GBU-31(V)4/B"]        = AddWeaponPoints(15, "Ground"),
    ["GBU-32(V)2/B"]        = AddWeaponPoints(15, "Ground"),
    ["CBU-87"]              = AddWeaponPoints( 5, "Ground"),
    ["CBU-99"]              = AddWeaponPoints( 5, "Ground"),
    ["CBU-103"]             = AddWeaponPoints( 5, "Ground"),
    ["CBU-97"]              = AddWeaponPoints(15, "Ground"),
    ["CBU-105"]             = AddWeaponPoints(15, "Ground"),
    ["AGM-62 Walleye II"]   = AddWeaponPoints(10, "Ground"),
    ["HYDRA-70 MPP APKWS"]  = AddWeaponPoints(5/7, "Ground"),
    ["HYDRA-70 HE APKWS"]   = AddWeaponPoints(5/7, "Ground"),
    ["AGM-65D"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-65E"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-65L"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-65F"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-65G"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-65H"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-65K"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-154C"]            = AddWeaponPoints(25, "Ground"),
    ["AGM-154A"]            = AddWeaponPoints(25, "Ground"),
    ["AGM-122"]             = AddWeaponPoints( 5, "Ground"),
    ["AGM-88C"]             = AddWeaponPoints(10, "Ground"),
    ["AGM-84D"]             = AddWeaponPoints(15, "Ground"),
    ["CM-802AKG"]           = AddWeaponPoints(30, "Ground"),
    ["C-802AK"]             = AddWeaponPoints(15, "Ground"),
    ["C-701IR"]             = AddWeaponPoints(10, "Ground"),
    ["C-701T"]              = AddWeaponPoints(10, "Ground"),
    ["LD-10"]               = AddWeaponPoints(10, "Ground"),
    ["LS-5-600"]            = AddWeaponPoints(25, "Ground"),
    ["GB-6W"]               = AddWeaponPoints(25, "Ground"),
    ["GB-6-HE"]             = AddWeaponPoints(25, "Ground"),
    ["GB-6-SFW"]            = AddWeaponPoints(30, "Ground"),
}

--END CONFIGURATION
--Don't do any edits below here unless you know what you're doing.

-- Unit table for all blue planes
WeaponPoints.BluePlanes = function() return mist.makeUnitTable({'[blue][plane]'}) end
-- #RADIO MENU HANDLING

WeaponPoints.SendLoadoutInfo = function(group)
    local response = function()
        local units = group:getUnits()
        for _, unit in pairs(units) do
            WeaponPoints.OutputCurrentPoints(unit)
        end
    end
    return response
end

WeaponPoints.GroupsWithRadios = {}

WeaponPoints.WhatsMyLoadout = function(grp)
    local response = function()
        local units = grp:getUnits()
        for _, unit in pairs(units) do
            -- Only check units with playernames
            local playerName = unit:getPlayerName()
            if playerName then
                local unitWeaponDetails = "Weapon Details For: " ..playerName.."\n\n"
                for _, weapon in pairs(unit:getAmmo()) do
                    local weaponName = weapon["desc"]["displayName"]
                    local weaponCount = weapon["count"]
                    local lookup = WeaponPoints.PointsLookup(weaponName)
                    local points = WeaponPoints.RoundPoints(lookup["points"], 3)
                    local total = WeaponPoints.RoundPoints(points * weaponCount)
                    unitWeaponDetails = unitWeaponDetails .. "Weapon: ["..weaponName.."] Count: ["..weaponCount.."] Points Each: ["..points.."] Totalling ["..total.."]\n"
                end
                logToUnit(unit, unitWeaponDetails)
            end
        end
    end
    return response
end

WeaponPoints.DisplayPoints = function(grp)
    local response = function()
        local categories = {}
        for wpName,wpData in pairs(WeaponPoints.Points) do
            local data = {
                ["name"] = wpName,
                ["points"] = wpData["points"]
            }
            local category = wpData["category"]
            if categories[category] == nil then
                categories[category] = {}
            end
            table.insert(categories[category], data)
        end
        local unit = grp:getUnit(1)
        local message = "Weapon Point Information\nIf a weapon is not listed here it is 0 points.\n"
        for category, weapons in pairs(categories) do
            local maxPointsMessage = ""
            if unit then
                local maxPoints = WeaponPoints.GetMaxPoints(unit)
                maxPointsMessage = "(Max: " .. maxPoints[category] .. ")"
            else
                maxPointsMessage = "" -- dunno if there's a better way to handle the impossible.
            end
            message = message .. "\n====================================\n"

            message = message .. "Category: " .. category .. maxPointsMessage .. "\n"
            table.sort(weapons, function(wp1, wp2) return wp1["name"]<wp2["name"] end)
            for _,wp in pairs(weapons) do
                message = message .. wp["name"] .. ": " .. WeaponPoints.RoundPoints(wp["points"],3) .. "\n"
            end
        end
        trigger.action.outTextForGroup(grp:getID(), message, 20)
    end
    return response
end

WeaponPoints.AddRadioMenus = function(grp)
    --Already got their radios. Skip.
    if WeaponPoints.GroupsWithRadios[grp:getName()] then return end
    local topLevel = missionCommands.addSubMenuForGroup(grp:getID(), "Armament", nil)
    missionCommands.addCommandForGroup(grp:getID(), "Check Loadout", topLevel, WeaponPoints.SendLoadoutInfo(grp))
    missionCommands.addCommandForGroup(grp:getID(), "Detailed Loadout", topLevel, WeaponPoints.WhatsMyLoadout(grp))
    missionCommands.addCommandForGroup(grp:getID(), "List Points", topLevel, WeaponPoints.DisplayPoints(grp))
    WeaponPoints.GroupsWithRadios[grp:getName()] = true
end

WeaponPoints.GroupBirthHandler = function(Event)
    if Event.id ~= world.event.S_EVENT_BIRTH then return end
    if not Event.initiator then return end
    if not Event.initiator.getGroup then return end
    local grp = Event.initiator:getGroup()
    if grp then
        for _,u in ipairs(grp:getUnits()) do
            if u:getPlayerName() and u:getPlayerName() ~= "" then
                WeaponPoints.AddRadioMenus(grp)
            end
        end
    end
end

for _,unitName in pairs(WeaponPoints.BluePlanes()) do
    local unit = Unit.getByName(unitName)
    if unit and unit:getGroup() then
        WeaponPoints.AddRadioMenus(unit:getGroup())
    end
end
mist.addEventHandler(WeaponPoints.GroupBirthHandler)
-- END RADIO

-- Looks up the points value for a given weapon name.
-- If not defined in WeaponPoints["Points"], then we give back the setting in {{WeaponPoints.DefaultValue}}.
WeaponPoints.PointsLookup = function(weaponName)
    local maybePoints = WeaponPoints.Points[weaponName]
    if maybePoints then return maybePoints else return WeaponPoints.DefaultValue end
end


--The value we use if the points for a weapon are not
--defined in WeaponPoints["Points"]
WeaponPoints.DefaultValue = AddWeaponPoints(0, "None")

-- Returns the total points used
-- The table returned from this has the following schema:
-- {
--   ["Category1"] = PointsUsedInCategory1,
--   ["Category2"] = PointsUsedInCategory2
-- }
WeaponPoints.PointsForAmmo = function(ammo)
    if ammo == nil then return 0 end
    local points = {}
    for _,weapon in pairs(ammo) do
        local weaponName = weapon["desc"]["displayName"]
        local weaponCount = weapon["count"]
        local lookup = WeaponPoints.PointsLookup(weaponName)
        local category = lookup["category"]
        local weaponPoints = lookup["points"] * weaponCount
        if points[category] == nil then
            points[category] = WeaponPoints.RoundPoints(weaponPoints)
        else
            points[category] = points[category] + (weaponPoints)
        end
    end
    return points
end

WeaponPoints.RoundPoints = function(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

-- Similar to [[log]] but takes a unit reference as the target of the message
-- Since groups are the lowest level that we can send messages to, we will
-- be sending the message to all units that share a group with the provided unit.
function logToUnit(unit, msg, clear)
    local grp = unit:getGroup()
    if grp == nil then
    else
        trigger.action.outTextForGroup(grp:getID(), msg, 10, clear)
    end
end

-- Given a unit, return an ammo table indicating how many points in each category
-- are allowed. Both the [[WeaponPoints.MaxPoints]] and [[WeaponPoints.AirframeOverrides]] are
-- used to determine the total points.
WeaponPoints.GetMaxPoints = function(unit)
    local airframe = unit:getTypeName()
    local overrides = WeaponPoints.AirframeOverrides[airframe]
    local defaults = mist.utils.deepCopy(WeaponPoints.MaxPoints)
    if overrides == nil then return defaults end
    for category,pts in pairs(overrides) do
        defaults[category] = pts
    end
    return defaults
end

-- Sends a message to the unit's group with a table of their current points.
-- We will be sending the message to the unit's group.
-- Intended to be used from the radio.
WeaponPoints.OutputCurrentPoints = function(unit)
	local output = WeaponPoints.GetPointsOutput(unit)
    logToUnit(unit, output)
end

-- Given the two ammo tables from the pilot's current points and the maximum allowed points,
-- Create the substitution table for the template.
WeaponPoints.GetOutputData = function(pilotPoints, maxPoints)
    return {
        airmax = maxPoints["Air"],
		groundmax = maxPoints["Ground"],
		air = pilotPoints["Air"] or 0,
		ground = (pilotPoints["Ground"] or 0),
		airRem = maxPoints["Air"] - (pilotPoints["Air"] or 0), -- Either of these could be nil
		grndRem = maxPoints["Ground"] - (pilotPoints["Ground"] or 0) -- If the pilot doesn't take air/ground
    }
end



--Hold the template in memory for later usage.
--This template's spacing is likely off in your editor but lined up properly in DCS.
--If you change the layout please make sure you run it through DCS for a test.
WeaponPoints.PointsOutputTemplate = (function()
    local template = [[Your points are as follows:
----------------------------------------------------------------------------
                         Air         Ground
Max                   $airmax         $groundmax
You                    $air           $ground
==================================
Remaining          $airRem        $grndRem

For a detailed loadout please use the F10 radio menu and select "Armament" and "Detailed Loadout"
]]
    return template
end)()

-- For a given unit, return a filled out template showing that unit's points usage.
WeaponPoints.GetPointsOutput = function(unit)
    local ammo = unit:getAmmo()
    local pilotPoints = WeaponPoints.PointsForAmmo(ammo)
    local maxPoints = WeaponPoints.GetMaxPoints(unit)
    local outputData = WeaponPoints.GetOutputData(pilotPoints,maxPoints)
    return WeaponPoints.TemplateApply(WeaponPoints.PointsOutputTemplate, outputData)
end

-- Apply a substitution object into a template.
-- Any occurences of `$variable` in the template will have
-- data["variable"] substituted in.
WeaponPoints.TemplateApply = function(template, data)
    return template:gsub('$(%w+)', data)
end

-- Compares the provided ammo object [Unit:GetAmmo()] with a table
-- describing the maximum points for each category.
-- Check [WeaponPoints.GetMaxPoints(Unit)]
-- The resulting table is in the form:
-- { [WeaponCategory] = RemainingPoints }
-- RemainingPoints is the number of points the unit has remaining in that category.
-- If RemainingPoints for a category is negative, the unit has exceeded their allowed capacity.
WeaponPoints.ComparePoints = function(pilotPoints, maxPoints)
    local ammoCompare = {}
    for category,maxCategoryPoints in pairs(maxPoints) do
        local pilotCategoryPoints = pilotPoints[category] or 0
        local remainingPoints = maxCategoryPoints - pilotCategoryPoints
        ammoCompare[category] = remainingPoints
    end
    return ammoCompare
end


--Table to hold all the people we're currently warning.
WeaponPoints.WarnedInAir = {}

WeaponPoints.IsOverPowered = function(unit)
    local ammo = unit:getAmmo()
    if not ammo then
        env.info("[+] WeaponPoints -- NULL AMMO FOR UNIT [" .. unit:getName() .. "] with type [" .. unit:getTypeName() .. "]")
        return false
    end
    local pilotPoints = WeaponPoints.PointsForAmmo(ammo)
    local maxPoints = WeaponPoints.GetMaxPoints(unit)
    local comparedAmmo = WeaponPoints.ComparePoints(pilotPoints, maxPoints)
    local isOverPowered = false
    for _, points in pairs(comparedAmmo) do
        if points < 0 then isOverPowered = true end
    end
    return isOverPowered
end

WeaponPoints.WEIGHT_FUNCTION = function(unit)
    local name = unit:getName()
    trigger.action.setUnitInternalCargo(name, 1000000)
end

WeaponPoints.PunishFunction = WeaponPoints.WEIGHT_FUNCTION
-- We'll call this when a unit has exceeded their warn time and is not dealing with it.
WeaponPoints.Punish = function(unit)
    logToUnit(unit, "You are being punished for having too many points loaded.")
    WeaponPoints.PunishFunction(unit)
    WeaponPoints.WarnedInAir[unit:getName()] = nil
end

-- Function that runs periodically to check for players
-- That are punishable. Players that are in the WarnedInAir
-- are stored there with their warned time. If that time
-- exceeds {{WeaponPoints.WARN_TIME}} seconds, then we will
-- Punish that unit.
-- TODO: We should remove units from this list when they take their warning seriously.
-- So Probably based on them landing again.
WeaponPoints.PollWarnedPlayers = function()
    local warned = {}
    local now = timer.getTime()
    for name, warnTime in pairs(WeaponPoints.WarnedInAir) do
        local unit = Unit.getByName(name)
        if unit then
            if WeaponPoints.IsOverPowered(unit) and unit:inAir() then
                if now - warnTime > WeaponPoints.WARN_TIME then
                    WeaponPoints.Punish(unit)
                else
                    warned[name] = warnTime
                end
            else
                -- No longer overpowered, or they landed.
                warned[name] = nil
            end
        end
    end
    WeaponPoints.WarnedInAir = warned
end

-- Template to use when sending a warning to the unit already airborne.
-- A warning in the air also adds the user to the warning list, and based on
-- The Value of WARN_TIME
WeaponPoints.AirWarningTemplate = function(unit)
    local template = [[
ATTENTION [$username] -- Your aircraft has taken off with a loadout that exceeds your allowed point levels.

You will be punished in $secondsRemaining seconds if you do not land again or safely jettison excess munitions.
]]
    local warnedTime = WeaponPoints.WarnedInAir[unit:getName()] or timer.getTime()
    local remaining = (warnedTime + WeaponPoints.WARN_TIME) - timer.getTime()
    if remaining < 0 then remaining = 0 end
    local data = {
        username = unit:getPlayerName() or "",
        secondsRemaining = remaining
    }
    local pointsOutput = WeaponPoints.GetPointsOutput(unit)
    return WeaponPoints.TemplateApply(template, data) .. pointsOutput
end

-- Warn a player that they are using an overpowered loadout and
-- may risk being punished. This will
WeaponPoints.WarnPlayer = function(unit)
    logToUnit(unit, WeaponPoints.AirWarningTemplate(unit))
    -- If they're already in the list then they're fine.
    if WeaponPoints.WarnedInAir[unit:getName()] then return end
    WeaponPoints.WarnedInAir[unit:getName()] = timer.getTime()
end

 -- Handle a unit that is marked as "In Air"
WeaponPoints.HandleInAir = function(unit)
    if WeaponPoints.IsOverPowered(unit) then
        WeaponPoints.WarnPlayer(unit)
    end
end

-- Template to send to the player when they are using an overpowered
-- loadout but they are still on the ground.
WeaponPoints.GroundWarningTemplate = function(unit)
    local template = [[
ATTENTION [$username] -- Your aircraft loadout has exceeded your allowed point levels.

Please reduce your loadout before taking off, or risk destruction.
]]
    local pointsOutput = WeaponPoints.GetPointsOutput(unit)
    local data = {
        username = unit:getPlayerName() or "nobody"
    }
    return WeaponPoints.TemplateApply(template, data) .. pointsOutput
end


--Handle units that are not airborne yet.
WeaponPoints.HandleOnGround = function(unit)
    if WeaponPoints.IsOverPowered(unit) then
        logToUnit(unit, WeaponPoints.GroundWarningTemplate(unit))
    else
        --TODO: Just for testing
        -- logToUnit(unit, WeaponPoints.GroundWarningTemplate(unit))
    end
end

-- Main Polling function.
-- For each blue plane in the Mission
-- Check if the unit is alive in the world with {{Unit.getByName}}
-- Send the unit to the appropriate handling function if its in the air or not.
WeaponPoints.PollPoints = function()
    WeaponPoints.ResetPoll()
    local planes = WeaponPoints.BluePlanes()
    for _,unitName in pairs(planes) do
        local unit = Unit.getByName(unitName)
        if unit ~= nil and unit:getPlayerName() ~= nil then
            if unit:inAir() then WeaponPoints.HandleInAir(unit) else WeaponPoints.HandleOnGround(unit) end
        end
    end
    WeaponPoints.PollWarnedPlayers() -- Check if any already-warned players need to be dealt with
end

-- Store a reference to this so we can remove the polling function.
WeaponPoints.PollFunction = mist.scheduleFunction(WeaponPoints.PollPoints, {}, timer.getTime() + 1)

-- Resets the polling system with a new function.
WeaponPoints.ResetPoll = function()
    mist.removeFunction(WeaponPoints.PollFunction)
    WeaponPoints.PollFunction = mist.scheduleFunction(WeaponPoints.PollPoints, {}, timer.getTime() + 10)
end

-- Yay modules.
return WeaponPoints
