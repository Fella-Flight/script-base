ArcoStennis = RECOVERYTANKER:New(
    UNIT:FindByName("honestabe"),
    "Arco"
)
-- Debug the issue with arco
-- Task Force 58
-- honestabe
-- ArcoStennis:SetDebugModeON()
ArcoStennis:SetTACAN(3, "ARC")
ArcoStennis:SetRadio(130)
ArcoStennis:SetRespawnOn()
ArcoStennis:Start()
