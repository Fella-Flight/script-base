-- An array of strings for the templtase
AG_Ground_Templates = {
    "RedFor Template-1",
    "RedFor Template-2",
    "RedFor Template-3",
    "RedFor Template-4",
    "RedFor Template-5",
}

AG_Ground_Attack_templates = {
    "RedFor AttackPlan-1",
    "RedFor AttackPlan-2",
    "RedFor AttackPlan-3",
    "RedFor AttackPlan-4",
    "RedFor AttackPlan-5",
}


-- env.info("FLAG ".._flagNumber.." crates ".._crateCount)
env.info("RedFor-MBT-North spawning...")
local random_Attack_template = AG_Ground_Attack_templates[ math.random( #AG_Ground_Attack_templates ) ] 

AG_Ground_001_Spawn = SPAWN:New(random_Attack_template)

AG_Ground_001_Spawn:InitLimit(20, 0)
AG_Ground_001_Spawn:InitRandomizeTemplate(AG_Ground_Templates)
-- Init the route the unit will take
-- AG_Ground_001_Spawn:InitRandomizeRoute(7, 0, 8000)

-- Spreadem
-- AG_Ground_001_Spawn:InitArray(330, 2, 50, 10)
-- AG_Ground_001_Spawn:SpawnScheduled(10,0)
AG_Ground_001_Spawn:Spawn()
env.info("RedFor-MBT-North spawning...completed")
