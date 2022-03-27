-- Name: CAP-001 - Combat Air Patrol
-- Author: FlightControl
-- Date Created: 16 January 2017
--
-- # Situation:
-- The Su-27 airplane will patrol in PatrolZone.
-- It will not engage any enemy automatically.
-- 
-- # Test cases:
-- 
-- 1. Observe the Su-27 patrolling.
-- 

Spawn_Plane = SPAWN:New("RedForCapNorth"):InitLimit( 2, 0 )

-- Repeat on ... (when landed on the airport)
Spawn_Plane:InitRepeat()

-- Now SPAWN the GROUPs every 5 minutes
Spawn_Plane:SpawnScheduled(300,0)

local CapPlane = GROUP:FindByName( "RedForCapNorth" )

local PatrolZone = ZONE:New( "Patrol Zone SyriaNorth1" )

AICapZone = AI_CAP_ZONE:New( PatrolZone, 3048, 9100, 555, 740 )

-- EngageZoneGroup = GROUP:FindByName( "Engage Zone SyriaNorth1" )

-- CapEngageZone = ZONE_POLYGON:New( "Engage Zone SyriaNorth1", EngageZoneGroup )

AICapZone:SetControllable( CapPlane )
-- AICapZone:SetEngageZone( CapEngageZone ) -- Set the Engage Zone. The AI will only engage when the bogeys are within the CapEngageZone.

AICapZone:__Start( 1 ) -- They should statup, and start patrolling in the PatrolZone.