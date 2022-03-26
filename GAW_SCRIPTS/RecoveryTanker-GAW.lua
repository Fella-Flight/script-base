ArcoStennis = RECOVERYTANKER:New(
    UNIT:FindByName("CVN-71 Theodore Roosevelt"),
    "Arco"
)
-- Debug the issue with arco
-- ArcoStennis:SetDebugModeON()
ArcoStennis:SetTACAN(13, "ARC")
ArcoStennis:SetRadio(130)
ArcoStennis:SetRespawnOn()
ArcoStennis:Start()
