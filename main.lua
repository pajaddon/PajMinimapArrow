local function delay(tick)
    local th = coroutine.running()
    C_Timer.After(tick, function() coroutine.resume(th) end)
    coroutine.yield()
end

local function updateMinimapArrowTexture()
    Minimap:SetPlayerTexture("Interface\\AddOns\\PajMinimapArrow\\arrow20")
end

local function waitUpdateMinimapArrowTexture(_d)
    delay(_d)
    updateMinimapArrowTexture()
end

local frame=CreateFrame("Frame");
frame:RegisterEvent("PLAYER_LOGIN");
frame:SetScript("OnEvent",function(self,event,...)
    print("PajMinimapArrow loaded")
    updateMinimapArrowTexture()
    coroutine.wrap(waitUpdateMinimapArrowTexture)(1)
    coroutine.wrap(waitUpdateMinimapArrowTexture)(5)
    coroutine.wrap(waitUpdateMinimapArrowTexture)(10)
end);
