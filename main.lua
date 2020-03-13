local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGIN");

function frame:OnEvent(event, arg1)
    if event == "ADDON_LOADED" and arg1 == "PajMinimapArrow" then
        -- Our saved variables are ready at this point. If there are none, both variables will set to nil.
        if Size == nil then
            print("First time running PajMinimapArrow :)")
            Size = 20 -- first time loading addon
        else
            print("PajMinimapArrow loaded")
        end
    elseif event == "PLAYER_LOGIN" then
        updateMinimapArrowTexture()
        coroutine.wrap(waitUpdateMinimapArrowTexture)(1)
        coroutine.wrap(waitUpdateMinimapArrowTexture)(5)
        coroutine.wrap(waitUpdateMinimapArrowTexture)(10)
    end
end
frame:SetScript("OnEvent", frame.OnEvent);

local function updateMinimapArrowTexture()
    Minimap:SetPlayerTexture("Interface\\AddOns\\PajMinimapArrow\\data\\arrow" .. Size)
end

local function waitUpdateMinimapArrowTexture(_d)
    delay(_d)
    updateMinimapArrowTexture()
end

local function SizeUsage()
    print(' /pma size [1-40] - modify the size of the arrow (e.g. /pma size 20)')
end

local function Usage()
    print('PajMinimapArrow usage:')
    print(' /pma help - show this help message')
    SizeUsage()
    print(' /pma flush - re-set the arrow texture')
end

local function PMASize(commands, command_i)
    size_amount = commands[command_i]
    if size_amount == nil then
        print('Missing required [size] parameter')
        SizeUsage()
        return
    end
    size_number = tonumber(size_amount)
    if size_number == nil then
        print('Size parameter must be a valid integer')
        SizeUsage()
        return
    end
    if size_number < 1 or size_number > 40 then
        print('size parameter must be a valid integer between 1 and 40')
        SizeUsage()
        return
    end
    Size = size_amount
    print("Set minimap arrow size to " .. Size)
    updateMinimapArrowTexture()
end

local function PMAFlush(commands, command_i)
    updateMinimapArrowTexture()
end

local function PMADebug(commands, command_i)
    --
end

local function MyAddonCommands(msg, editbox)
    commands = split(msg, " ")
    command_i = 1

    if commands[command_i] == "size" then
        PMASize(commands, command_i + 1)
        return
    end
    if commands[command_i] == "flush" then
        PMAFlush(commands, command_i + 1)
        return
    end
    if commands[command_i] == "debug" then
        PMADebug(commands, command_i + 1)
        return
    end

    Usage()
end

SLASH_PMA1 = '/pma'

SlashCmdList["PMA"] = MyAddonCommands   -- add /hiw and /hellow to command list
