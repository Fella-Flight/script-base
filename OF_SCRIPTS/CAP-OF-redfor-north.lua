AG_CAP_Templates = {
    "RedFor CAP Mig29",
    "RedFor CAP Mig 23",
    "RedFor CAP Su 27",
    "RedFor CAP Su 30",
    "RedFor CAP Su 33",
}


-- Spawn_Plane = SPAWN:New("RedForCapNorth"):InitLimit( 2, 0 )
Spawn_Plane = SPAWN:New("RedForCapNorth")
Spawn_Plane:InitLimit(2, 0)
Spawn_Plane:InitRepeat()
Spawn_Plane:InitRandomizeTemplate(AG_CAP_Templates)
-- Repeat on ... (when landed on the airport)
Spawn_Plane:SpawnAtAirbase( AIRBASE:FindByName( AIRBASE.Syria.Aleppo ), SPAWN.Takeoff.Cold )

-- Now SPAWN the GROUPs every 5 minutes
Spawn_Plane:SpawnScheduled(600,0)

local CapPlane = GROUP:FindByName( "RedForCapNorth" )

local PatrolZone = ZONE:New( "Patrol Zone SyriaNorth1" )

AICapZone = AI_CAP_ZONE:New( PatrolZone, 3048, 9100, 555, 740 )

-- EngageZoneGroup = GROUP:FindByName( "Engage Zone SyriaNorth1" )

-- CapEngageZone = ZONE_POLYGON:New( "Engage Zone SyriaNorth1", EngageZoneGroup )

AICapZone:SetControllable( CapPlane )
-- AICapZone:SetEngageZone( CapEngageZone ) -- Set the Engage Zone. The AI will only engage when the bogeys are within the CapEngageZone.

AICapZone:__Start( 1 ) -- They should statup, and start patrolling in the PatrolZone.