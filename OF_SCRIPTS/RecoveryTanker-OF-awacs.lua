awacsGeorge = RECOVERYTANKER:New(
    UNIT:FindByName("honestabe"),
    "Wizard"
)
-- Debug the issue with arco
-- awacsGeorge:SetDebugModeON()
awacsGeorge:SetAWACS()
awacsGeorge:SetCallsign(CALLSIGN.AWACS.Wizard,1)
awacsGeorge:SetTakeoffAir() -- Start her in the air
awacsGeorge:SetAltitude(25000)
--awacsGeorge:SetRadio(133.5)
awacsGeorge:SetRadio(245.0)

awacsGeorge:SetTACAN(2, "WIZ")
awacsGeorge:SetRespawnOn()

awacsGeorge:Start()



--133.5
-- Start the F-14s over the carrier
