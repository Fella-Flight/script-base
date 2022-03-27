Spawn_Plane = SPAWN:New("Texaco"):InitLimit( 1, 0 )

-- Repeat on ... (when landed on the airport)
Spawn_Plane:InitRepeat()

-- Now SPAWN the GROUPs every 5 minutes
Spawn_Plane:SpawnScheduled(300,0)

-- local CapPlane = GROUP:FindByName( "Texaco" )

-- local PatrolZone = ZONE:New( "Patrol Zone SyriaNorth1" )

-- AICapZone = AI_CAP_ZONE:New( PatrolZone, 5000, 5000, 537.08, 537.08 )

-- EngageZoneGroup = GROUP:FindByName( "Engage Zone SyriaNorth1" )

-- CapEngageZone = ZONE_POLYGON:New( "Engage Zone SyriaNorth1", EngageZoneGroup )

-- AICapZone:SetControllable( CapPlane )
-- AICapZone:SetEngageZone( CapEngageZone ) -- Set the Engage Zone. The AI will only engage when the bogeys are within the CapEngageZone.

-- AICapZone:__Start( 1 ) -- They should statup, and start patrolling in the PatrolZone.