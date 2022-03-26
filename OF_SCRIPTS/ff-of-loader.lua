-- Mist
-- We're going to try this moose only baby
-- dofile(lfs.writedir()..[[Scripts\FellaFlight\mist_4_5_98.lua]])

-- Moose 
dofile(lfs.writedir()..[[Scripts\FellaFlight\Moose.lua]])

-- CTLD for troops
-- supposed to be baked into DCMS
-- dofile(lfs.writedir()..[[Scripts\FellaFlight\MAW_SCRIPTS\CTLD.lua]])

-- load utils
dofile(lfs.writedir()..[[Scripts\FellaFlight\utils.lua]])

-- load fella flight tools
dofile(lfs.writedir()..[[Scripts\FellaFlight\FellaFlight.lua]])

-- Load all of the FF custom work via 1 setup in DCS to make it easy to extend
dofile(lfs.writedir()..[[Scripts\FellaFlight\MAW_SCRIPTS\RecoveryTanker-MAW.lua]])
dofile(lfs.writedir()..[[Scripts\FellaFlight\MAW_SCRIPTS\RecoveryTanker-MAW-awacs.lua]])




-- export all our stuff to save out
dofile(lfs.writedir()..[[Scripts\FellaFlight\MAW_SCRIPTS\exporter.lua]])
