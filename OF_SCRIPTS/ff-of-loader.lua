-- Mist
-- We're going to try this moose only baby
-- dofile(lfs.writedir()..[[Scripts\FellaFlight\mist_4_5_98.lua]])

-- Moose 
dofile(lfs.writedir()..[[Scripts\FellaFlight\Moose.lua]])

-- CTLD for troops
-- supposed to be baked into DCMS (but it got yeeted out of the codebase)
-- dofile(lfs.writedir()..[[Scripts\FellaFlight\CTLD\CTLD.lua]])

-- DSMC version of CTLD
dofile(lfs.writedir()..[[Scripts\FellaFlight\DSMC_CTLD_2022.03.19.lua]])


-- load utils
dofile(lfs.writedir()..[[Scripts\FellaFlight\utils.lua]])

-- load fella flight tools
dofile(lfs.writedir()..[[Scripts\FellaFlight\FellaFlight.lua]])

-- Load all of the FF custom work via 1 setup in DCS to make it easy to extend
dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\RecoveryTanker-OF.lua]])
dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\RecoveryTanker-OF-awacs.lua]])

-- Load North Tankers
dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\spawner\shell-north.lua]])
dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\spawner\Texaco-north.lua]])
dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\spawner\overlord-north.lua]])


-- Redfor
dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\spawner\RedFor-MBT-North.lua]])


--Load North Syria CAp
dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\CAP-OF-redfor-north.lua]])

-- IADS
dofile(lfs.writedir()..[[Scripts\FellaFlight\IADS.lua]])



-- export all our stuff to save out
-- TBD get working later
-- dofile(lfs.writedir()..[[Scripts\FellaFlight\OF_SCRIPTS\exporter.lua]])
