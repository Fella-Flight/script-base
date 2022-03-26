ArcoStennis = RECOVERYTANKER:New(
    UNIT:FindByName("George"),
    "Arco"
)
-- Debug the issue with arco
-- ArcoStennis:SetDebugModeON()
ArcoStennis:SetTACAN(3, "ARC")
ArcoStennis:SetRadio(130)
ArcoStennis:SetRespawnOn()
ArcoStennis:Start()
