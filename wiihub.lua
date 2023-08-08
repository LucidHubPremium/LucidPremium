if not LPH_OBFUSCATED then
    LPH_JIT_MAX = function(...) return(...) end;
    LPH_NO_VIRTUALIZE = function(...) return(...) end;
end

local CoreGui = game:GetService("CoreGui")
local tbl = {}

for i,v in pairs(CoreGui.GetDescendants(CoreGui)) do
     if v.IsA(v, "ImageLabel") and v.Image:find('rbxasset://') then
            table.insert(tbl, v.Image)
        end
end

local hello;
hello = hookfunction(game:GetService("ContentProvider").PreloadAsync, function(self, ...)
        local Args = {...}
        if not checkcaller() and type(Args[1]) == "table" and table.find(Args[1], CoreGui) then
            Args[1] = tbl
            return hello(self, unpack(Args))
        end
    return hello(self, ...)
end)

local function football(ncm)
     if ncm == "PreloadAsync" or ncm == "preloadAsync" then
          return true
     end
     return false
end

local __namecall;

__namecall = hookmetamethod(game, "__namecall", function(Self, ...)
    local Args = {...}
    local NamecallMethod = getnamecallmethod()
    if not checkcaller() and type(Args[1]) == "table" and table.find(Args[1], CoreGui) and Self == game.GetService(game, "ContentProvider") and football(NamecallMethod) then
        Args[1] = tbl
        return __namecall(Self, unpack(Args))
    end
    return __namecall(Self, ...)
end)

wait(.5)

local Library = {};
local spr = loadstring(game:HttpGet("https://raw.githubusercontent.com/PhoenixxDev/SprForSyn/main/spr.lua"))()

local plr = game:GetService('Players').LocalPlayer
local mouse = plr:GetMouse()
local Camera = workspace.CurrentCamera;
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService");
local RS = game:GetService("RunService");
local TS = game:GetService("TweenService");


local UI = Instance.new("ScreenGui");
if syn then
    syn.protect_gui(UI)
end
if protectgui then
    protectgui(UI)
end
UI.Parent = RS:IsStudio() and plr.PlayerGui or game:GetService("CoreGui");


local components = {}; -- config loading/saving
local Flags = {}
local PrimaryColors = {};
local contents = {};

local LibMeta = {
    PrimaryColor = Color3.fromRGB(0, 110, 255);


    Tabs = {};
    thingsToSet = {};
    thingsToClose = {};
    Sections = {};
};

function LibMeta:Toggle()
    UI.Enabled = not UI.Enabled
end

local toggleBinds = {}
local mainKeybind = "LeftControl"

UIS.InputBegan:Connect(function(key, gp)
    if gp then return end;

    if key.KeyCode == Enum.KeyCode[mainKeybind] then
        LibMeta:Toggle()
    end

    for i,v in ipairs(toggleBinds) do 
        if v.keyBind and Enum.KeyCode[v.keyBind] and Enum.KeyCode[v.keyBind] == key.KeyCode then
            if v.Enabled and v.Disable then 
                v:Disable();
                v.callback(v.Enabled);
            elseif v.Enable then
                v:Enable();
                v.callback(v.Enabled);
            end
        end
    end
end)

local Library = setmetatable({}, { --// Auto change all color things when Library.PrimaryColor is changed
    __newindex = function(table, key, value)
        if key == "PrimaryColor" then
            for item, properties in pairs(PrimaryColors) do
                for _, property in ipairs(properties) do
                    item[property] = value;
                end
            end
        end
        LibMeta[key] = value;
    end,
    __index = function(table, key)
        return LibMeta[key];
    end,
})


local function isHoveringOverObj(obj)
    local tx = obj.AbsolutePosition.X
    local ty = obj.AbsolutePosition.Y
    local bx = tx + obj.AbsoluteSize.X
    local by = ty + obj.AbsoluteSize.Y
    if mouse.X >= tx and mouse.Y >= ty and mouse.X <= bx and mouse.Y <= by then
        return true
    end
end

local function CreateDrag(gui)
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        TS:Create(gui, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}):Play();
    end

    local lastEnd = 0
    local function closeClosables()
        if os.clock() < lastEnd + 0.5 then
            return
        end
        --lastEnd = os.clock()
        for _, item in ipairs(Library.thingsToClose) do
            task.spawn(function()
                if type(item) == 'table' and rawget(item, "Close") then
                    local can = true
                    if item.lastOpened and os.clock() < item.lastOpened + 0.5 then
                        can = false 
                    end
                    for _, asd in ipairs(item.MainFrames) do
                        if isHoveringOverObj(asd) then
                            can = false
                        end 
                    end
                    if can then
                        item:Close();
                    end
                end
            end)
        end 
    end
    local lastMoved = 0
    local con
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = gui.Position

        end
    end)

    UIS.InputEnded:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            closeClosables()
        end
    end)


    gui.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
            lastMoved = os.clock()
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end



--// Main page instances

local BG = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local UIGradient = Instance.new("UIGradient")
local UIGradient2 = Instance.new("UIGradient")
local Tabs = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

BG.Name = "Background"
BG.Parent = UI
BG.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
BG.BorderSizePixel = 0
BG.Position = UDim2.new(0.178, 0, 0.312, 0)
BG.Size = UDim2.new(0, 703, 0, 374)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = BG

UIStroke.Color = Color3.fromRGB(55, 113, 255);
UIStroke.Thickness = 0.8;
UIStroke.Transparency = 0.45;
UIStroke.Parent = BG

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(9,9,9)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(0, 136, 255))}
UIGradient.Parent = BG

UIGradient2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(9, 9, 9)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(9, 9, 9))}
UIGradient2.Parent = UIStroke


--// Header
local Header = Instance.new("Frame")
local Container = Instance.new("Frame")
local _1Icon = Instance.new("ImageLabel")
local _2Title = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding_2 = Instance.new("UIPadding")
local Middleupperline = Instance.new("Frame")
local _3Padding = Instance.new("Frame")
local Underline = Instance.new("Frame")
local CloseButton = Instance.new("ImageButton")
local _1Path = Instance.new("Frame")
local TextLabelPath = Instance.new("TextLabel")
local UIPadding_3 = Instance.new("UIPadding")

Header.Name = "Header"
Header.Parent = BG
Header.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Header.BackgroundTransparency = 1.000
Header.Size = UDim2.new(0.998577535, 0, -0.112299465, 100)

Container.Name = "Container"
Container.Parent = Header
Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Container.BackgroundTransparency = 1.000
Container.Size = UDim2.new(1, 0, 1, 0)

_1Icon.Name = "1Icon"
_1Icon.Parent = Container
_1Icon.BackgroundTransparency = 1.000
_1Icon.BorderSizePixel = 0
_1Icon.ImageColor3 = Color3.fromRGB(55, 113, 188)
_1Icon.Position = UDim2.new(0, 0, 0.103448279, 0)
_1Icon.Size = UDim2.new(0, 31, 0, 31)
_1Icon.Image = "http://www.roblox.com/asset/?id=6031079158"

_2Title.Name = "2Title"
_2Title.Parent = Container
_2Title.AnchorPoint = Vector2.new(0, 0.5)
_2Title.BackgroundColor3 = Color3.fromRGB(55, 113, 188)
_2Title.BackgroundTransparency = 1.000
_2Title.Position = UDim2.new(0.0725462288, 0, 0.5, 0)
_2Title.Size = UDim2.new(-0.136259779, 200, 1, 0)
_2Title.Font = Enum.Font.Gotham
_2Title.Text = "OnyxHub.exe"
_2Title.TextColor3 = Color3.fromRGB(197, 197, 197)
_2Title.TextSize = 18.000

UIPadding.Parent = _2Title
UIPadding.PaddingLeft = UDim.new(0, 20)

UIListLayout.Parent = Container
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

UIPadding_2.Parent = Container
UIPadding_2.PaddingLeft = UDim.new(0, 20)

Middleupperline.Name = "Middleupperline"
Middleupperline.Parent = Container
Middleupperline.AnchorPoint = Vector2.new(0.5, 0.5)
Middleupperline.BackgroundColor3 = Color3.fromRGB(15, 14, 14)
Middleupperline.BackgroundTransparency = 0.550
Middleupperline.BorderSizePixel = 0
Middleupperline.Position = UDim2.new(0.375533313, 0, 0.0802138224, 0)
Middleupperline.Size = UDim2.new(0, 1, 0.5, 0)

_3Padding.Name = "3Padding"
_3Padding.Parent = Container
_3Padding.AnchorPoint = Vector2.new(0.5, 0.5)
_3Padding.BackgroundColor3 = Color3.fromRGB(15, 14, 14)
_3Padding.BackgroundTransparency = 1.000
_3Padding.BorderSizePixel = 0
_3Padding.Position = UDim2.new(0.248644039, 0, 0.5, 0)
_3Padding.Size = UDim2.new(0.0468542725, 1, 0.5, 0)

Underline.Name = "Underline"
Underline.Parent = Header
Underline.AnchorPoint = Vector2.new(0.5, 0.5)
Underline.BackgroundColor3 = Color3.fromRGB(15, 14, 14)
Underline.BackgroundTransparency = 0.550
Underline.BorderSizePixel = 0
Underline.Position = UDim2.new(0.5, 0, 1, 0)
Underline.Size = UDim2.new(1, 0, 0, 1)

CloseButton.Name = "CloseButton"
CloseButton.Parent = Header
CloseButton.Active = false
CloseButton.AnchorPoint = Vector2.new(0, 0.5)
CloseButton.BackgroundTransparency = 1.000
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.939999998, 0, 0.5, 0)
CloseButton.Selectable = false
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.AutoButtonColor = false
CloseButton.Image = "http://www.roblox.com/asset/?id=6031094678"
CloseButton.ImageColor3 = Color3.fromRGB(15, 14, 14)

_1Path.Name = "1Path"
_1Path.Parent = Header
_1Path.BackgroundColor3 = Color3.fromRGB(55, 113, 1885)
_1Path.BackgroundTransparency = 1.000
_1Path.Position = UDim2.new(0.294871807, 0, 0.0344827585, 0)
_1Path.Size = UDim2.new(0.646723628, 0, 0.356067389, 36)

TextLabelPath.Parent = _1Path
TextLabelPath.BackgroundColor3 = Color3.fromRGB(55, 113, 1885)
TextLabelPath.BackgroundTransparency = 1.000
TextLabelPath.Position = UDim2.new(-0.0110132154, 0, 0, 0)
TextLabelPath.Size = UDim2.new(1.01101327, 0, 1, 0)
TextLabelPath.Font = Enum.Font.Gotham
TextLabelPath.RichText = true
TextLabelPath.Text = "Lucid / <font color=\"#3771ff\">  Selected Tab</font>"
TextLabelPath.TextColor3 = Color3.fromRGB(116, 116, 116)
TextLabelPath.TextSize = 12.000
TextLabelPath.TextXAlignment = Enum.TextXAlignment.Left

UIPadding_3.Parent = TextLabelPath
UIPadding_3.PaddingLeft = UDim.new(0.0299999993, 0)


--// Footer

local Footer = Instance.new("Frame")
local Container = Instance.new("Frame")
local _3Title = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local UICorner = Instance.new("UICorner")
local Avatar = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local UIStroke_2 = Instance.new("UIStroke")
local InnerBG = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local Underline = Instance.new("Frame")

Footer.Name = "Footer"
Footer.Parent = BG
Footer.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Footer.BackgroundTransparency = 1.000
Footer.Position = UDim2.new(0, 0, 0.842245996, 0)
Footer.Size = UDim2.new(0.998577535, 0, -0.109625645, 100)

Container.Name = "Container"
Container.Parent = Footer
Container.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Container.BackgroundTransparency = 1.000
Container.Position = UDim2.new(0, 0, 0.0931247547, 0)
Container.Size = UDim2.new(1, 0, 0.906873763, 0)

_3Title.Name = "2Title"
_3Title.Parent = Container
_3Title.AnchorPoint = Vector2.new(0, 0.5)
_3Title.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
_3Title.BackgroundTransparency = 1.000
_3Title.Position = UDim2.new(0.0013210373, 0, 0.453275919, 0)
_3Title.Size = UDim2.new(1, 0, 1.09344828, 0)
_3Title.Font = Enum.Font.Gotham
_3Title.Text = "Welcome, OnlyTwentyCharacters"
_3Title.TextColor3 = Color3.fromRGB(55, 113, 2557)
_3Title.TextSize = 14.000
_3Title.TextXAlignment = Enum.TextXAlignment.Left

UIPadding.Parent = _3Title
UIPadding.PaddingLeft = UDim.new(0, 20)

UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = Container

Avatar.Name = "Avatar"
Avatar.Parent = Container
Avatar.AnchorPoint = Vector2.new(0, 0.5)
Avatar.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Avatar.BackgroundTransparency = 1.000
Avatar.Position = UDim2.new(0.921179473, 0, 0.443931043, 0)
Avatar.Size = UDim2.new(0, 38, 0, 38)

UICorner_2.CornerRadius = UDim.new(0, 200)
UICorner_2.Parent = Avatar

UIStroke_2.Color = Color3.fromRGB(85, 0, 255);
UIStroke_2.Thickness = 1;
UIStroke_2.Transparency = 0;
UIStroke_2.Parent = Avatar

InnerBG.Name = "InnerBG"
InnerBG.Parent = Avatar
InnerBG.AnchorPoint = Vector2.new(0.5, 0.5)
InnerBG.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
InnerBG.Position = UDim2.new(0.5, 0, 0.5, 0)
InnerBG.Size = UDim2.new(1, -4, 1, -4)

local avImg = Instance.new("ImageLabel")
avImg.BackgroundTransparency = 1
avImg.Size = UDim2.fromScale(1,1)
local userId = plr.UserId
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size420x420
local content, isReady = game:GetService('Players'):GetUserThumbnailAsync(userId, thumbType, thumbSize)
avImg.Image = content
avImg.Parent = InnerBG
UICorner_2:Clone().Parent = avImg

UICorner_3.CornerRadius = UDim.new(0, 200)
UICorner_3.Parent = InnerBG

Underline.Name = "Underline"
Underline.Parent = Footer
Underline.AnchorPoint = Vector2.new(0.5, 0.5)
Underline.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Underline.BackgroundTransparency = 0.550
Underline.BorderSizePixel = 0
Underline.Position = UDim2.new(0.5, 0, 0, 0)
Underline.Size = UDim2.new(1, 0, 0, 1)


--// Sidebar / Navbar
local Sidebar = Instance.new("ScrollingFrame")
local Underline = Instance.new("Frame")
local Container = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")
local UIPadding = Instance.new("UIPadding")



Sidebar.Name = "Sidebar"
Sidebar.Parent = BG
Sidebar.Active = true
Sidebar.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Sidebar.BackgroundTransparency = 1.000
Sidebar.Position = UDim2.new(0, 0, 0.155080214, 0)
Sidebar.Size = UDim2.new(0.106685631, 118, 0.687165797, 0)
Sidebar.ScrollBarThickness = 0

Underline.Name = "Underline"
Underline.Parent = Sidebar
Underline.AnchorPoint = Vector2.new(1, 0.5)
Underline.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Underline.BackgroundTransparency = 0.550
Underline.BorderSizePixel = 0
Underline.Position = UDim2.new(0.99000001, 0, 0.5, 0)
Underline.Size = UDim2.new(0, 1, 1, 0)
Underline.ZIndex = 3

Container.Name = "Container"
Container.Parent = Sidebar
Container.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Container.BackgroundTransparency = 1.000
Container.Size = UDim2.new(1, 0, 1, 0)

UIListLayout.Parent = Container
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

UIPadding.Parent = Container
UIPadding.PaddingTop = UDim.new(0, 15)



local Canvas = Instance.new("Frame")
local UIListLayout_2 = Instance.new("UIListLayout")


Canvas.Name = "Canvas"
Canvas.Parent = BG
Canvas.BackgroundColor3 = Color3.fromRGB(55, 113, 255)
Canvas.BackgroundTransparency = 1.000
Canvas.Position = UDim2.new(0.273115218, 0, 0.155080214, 0)
Canvas.Size = UDim2.new(0.726884782, 0, 0.5775401, 100)

UIListLayout_2.Parent = Canvas
UIListLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center


CreateDrag(BG)

CloseButton.MouseButton1Click:Connect(function()
    Library:Toggle(false)
end)

local entered = {}
local function closeAllTipsExcept(tab)
    for _, tooltip in ipairs(entered) do
        if tooltip ~= tab and tooltip.isOpen then
            tooltip:Close(true)
        end
    end
end

UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if not isHoveringOverObj(BG) then
            closeAllTipsExcept()
        else
            for _, tooltip in ipairs(entered) do
                if tooltip.isOpen and not isHoveringOverObj(tooltip.HoverObj) then
                    tooltip:Close(true)
                end
            end
        end
    end
end)


function Library:SetTitle(title)
    _2Title.Text = title
end

function Library:SetFooter(text)
    _3Title.Text = text
end




function Library:NewTab(Title)

    local Funcs = {
        isOpen = false;	
        tweenTime = 0.2;
        LeftTabs = {};
        RightTabs = {};
        cooldown = 0.5;
        lastChanged = 0;
        connections = {};
    };
    
    --// left tab button
    local ButtonContainer = Instance.new("Frame") -- TODO: Slide in child of ButtonContainer when loaded
    local TabButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIGradient = Instance.new("UIGradient")
    local TextLabel = Instance.new("TextLabel")
    local UIPadding = Instance.new("UIPadding")
    
    ButtonContainer.Name = "ButtonContainer"
    ButtonContainer.Parent = Container
    ButtonContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ButtonContainer.BackgroundTransparency = 1.000
    ButtonContainer.Size = UDim2.new(1, -25, 0, 25)
    ButtonContainer.ZIndex = -1

    TabButton.Name = "TabButton"
    TabButton.Parent = ButtonContainer
    TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Size = UDim2.new(1, -25, 0, 25)
    TabButton.AutoButtonColor = false
    TabButton.Font = Enum.Font.Gotham
    TabButton.BackgroundTransparency = 1
    TabButton.Text = ""
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 14.000
    TabButton.TextXAlignment = Enum.TextXAlignment.Left

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = TabButton

    UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(85, 0, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(42, 0, 139))}
    UIGradient.Parent = TabButton

    TextLabel.Parent = TabButton
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.Font = Enum.Font.Gotham
    TextLabel.Text = Title
    TextLabel.TextColor3 = Color3.fromRGB(118, 118, 118)
    TextLabel.TextSize = 14.000
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    UIPadding.Parent = TextLabel
    UIPadding.PaddingLeft = UDim.new(0.100000001, 0)
    
    
    --// Page / canvas

    local Container = Instance.new("ScrollingFrame")
    local UIListLayout = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")

    Container.Name = "Container"
    Container.Parent = Canvas
    Container.Active = true
    Container.Visible = false
    Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Container.BackgroundTransparency = 1.000
    Container.Size = UDim2.new(1, 0, 0.813291132, 0)
    Container.ScrollBarThickness = 0
    Container.CanvasPosition = Vector2.new(0, 0)
    Container.AutomaticCanvasSize = Enum.AutomaticSize.Y

    UIListLayout.Parent = Container
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 10)

    UIPadding.Parent = Container
    UIPadding.PaddingTop = UDim.new(0, 15)
    
    
    
    --// Component Functions
    function Funcs:NewToggle(Title, default, Callback)
        local toggleFuncs = {
            Enabled = default;
            toggle_key = nil,
            tweenTime = 0.1;
            keyBind = nil,
            callback = Callback
        };
        
        

        local Toggle = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        local UIStroke1 = Instance.new("UIStroke")
        local UIStroke2 = Instance.new("UIStroke")
        local FeatureTitle = Instance.new("TextLabel")
        local UIPadding = Instance.new("UIPadding")
        local ToggleBtn = Instance.new("ImageButton")
        local UICorner_2 = Instance.new("UICorner")
        local Checkmark = Instance.new("ImageButton")
        local ImageLabel = Instance.new("ImageLabel")
        local UIGradient = Instance.new("UIGradient")
        
        Toggle.Name = "Toggle"
        Toggle.Parent = Container
        Toggle.AutoButtonColor = false
        Toggle.ImageTransparency = 1
        Toggle.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
        Toggle.BackgroundTransparency = 0.900
        Toggle.Size = UDim2.new(0, 485, 0, 38)

        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = Toggle
        
        UIStroke1.Color = Color3.fromRGB(255, 255, 255);
        UIStroke1.Thickness = 1;
        UIStroke1.Transparency = 1; -- enabled: 0
        UIStroke1.Parent = Toggle
        
        local UIGradientS = Instance.new("UIGradient")
        UIGradientS.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(5, 4, 25)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(85, 0, 255))}
        UIGradientS.Rotation = 180
        UIGradientS.Parent = UIStroke1
        UIGradientS.Offset = Vector2.new(-1,0)

        FeatureTitle.Name = "FeatureTitle"
        FeatureTitle.Parent = Toggle
        FeatureTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FeatureTitle.BackgroundTransparency = 1.000
        FeatureTitle.Position = UDim2.new(0.104999967, 0, 0, 0)
        FeatureTitle.Size = UDim2.new(0.0947574526, 100, 1, 0)
        FeatureTitle.Font = Enum.Font.Gotham
        FeatureTitle.Text = Title
        FeatureTitle.TextColor3 = Color3.fromRGB(91, 91, 91)--Color3.fromRGB(162, 162, 162)
        FeatureTitle.TextSize = 14.000
        FeatureTitle.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding.Parent = FeatureTitle

        ToggleBtn.Name = "ToggleBtn"
        ToggleBtn.Parent = Toggle
        ToggleBtn.AnchorPoint = Vector2.new(0, 0.5)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
        ToggleBtn.Position = UDim2.new(0.0199999996, 0, 0.5, 0)
        ToggleBtn.Size = UDim2.new(0, 20, 0, 20)
        ToggleBtn.AutoButtonColor = false
        ToggleBtn.ImageColor3 = Color3.fromRGB(165, 165, 165)

        UIStroke2.Color = Color3.fromRGB(35, 35, 35);
        UIStroke2.Thickness = 1;
        UIStroke2.Transparency = 0; -- enabled: 1
        UIStroke2.Parent = ToggleBtn

        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = ToggleBtn

        Checkmark.Name = "Checkmark"
        Checkmark.Parent = ToggleBtn
        Checkmark.AnchorPoint = Vector2.new(0.5, 0.5)
        Checkmark.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
        Checkmark.BackgroundTransparency = 1.000
        Checkmark.Position = UDim2.new(0.5, 0, 0.5, 0)
        Checkmark.Size = UDim2.new(0, 18, 0, 18)
        Checkmark.ZIndex = 2
        Checkmark.AutoButtonColor = false
        Checkmark.Image = "http://www.roblox.com/asset/?id=6031094667"
        Checkmark.ImageColor3 = Color3.fromRGB(247, 247, 247)
        

        ImageLabel.Parent = ToggleBtn
        ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ImageLabel.BackgroundTransparency = 1.000
        ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
        ImageLabel.Size = UDim2.new(0, 23, 0, 23)
        ImageLabel.Image = "http://www.roblox.com/asset/?id=6906809185"
        ImageLabel.ImageColor3 = Color3.fromRGB(85, 0, 255)
        
        
        
        
        
        

        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(153, 175, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(153, 175, 255))}
        UIGradient.Rotation = 180
        UIGradient.Parent = Toggle
        
        
        
        function toggleFuncs:Enable()
            toggleFuncs.Enabled = true;
            
            spr.target(Checkmark, 1, 3, {
                ImageTransparency = 0;
            })
            spr.target(ToggleBtn, 1, 3, {
                BackgroundTransparency = 0;
            })
            spr.target(ImageLabel, 1, 3, {
                ImageTransparency = 0;
            })
            spr.target(FeatureTitle, 1, 3, {
                TextColor3 = Color3.fromRGB(162, 162, 162);
            })
            spr.target(UIStroke2, 1, 3, {
                Transparency = 1;
            })
            
            spr.target(UIStroke1, 1, 3, {
                Transparency = 0;
            })
            spr.target(UIGradientS, .7, 1, {
                Offset = Vector2.new(0,0)
            })
            
        end

        function toggleFuncs:Disable()
            toggleFuncs.Enabled = false;
            
            spr.target(Checkmark, 1, 3, {
                ImageTransparency = 1;
            })
            spr.target(ToggleBtn, 1, 3, {
                BackgroundTransparency = 1;
            })
            spr.target(ImageLabel, 1, 3, {
                ImageTransparency = 1;
            })
            spr.target(FeatureTitle, 1, 3, {
                TextColor3 = Color3.fromRGB(91, 91, 91);
            })
            spr.target(UIStroke2, 1, 3, {
                Transparency = 0;
            })
            spr.target(UIStroke1, 1, 3, {
                Transparency = 1;
            })
            spr.target(UIGradientS, .7, .5, {
                Offset = Vector2.new(-1,0)
            })

        end
        

        if type(Callback) == "function" then
            Callback(default);

            if default == true then
                toggleFuncs:Enable()
            else
                toggleFuncs:Disable()
            end
        end


        table.insert(Funcs.connections, Toggle.MouseButton1Down:Connect(function()
            if toggleFuncs.Enabled then
                toggleFuncs:Disable();
            else
                toggleFuncs:Enable();
            end
            Callback(toggleFuncs.Enabled);
        end))
        
        
        function toggleFuncs:AddToolTip(Text)
            --Library:AddToolTip(ScrollingFrame, ToggleBG, toggleFuncs.tweenTime, Text)
        end
        
        function toggleFuncs:Set(val)
            Callback(val)
            if val then
                toggleFuncs:Enable()
            else
                toggleFuncs:Disable()
            end
            components[Title] = {
                component_name = Title;
                component_default = default;
                component_callback = Callback;
                component_type = "Toggle";
                component_table = toggleFuncs;
            }
        end

        toggleFuncs.Toggle = toggleFuncs.Set

        table.insert(Library.thingsToSet, {functions = toggleFuncs})
        components[Title] = {
            component_name = Title;
            component_default = default;
            component_callback = Callback;
            component_type = "Toggle";
            component_table = toggleFuncs;
        }
        table.insert(Flags, {
            name = Title, 
            tb = toggleFuncs
        })

        return toggleFuncs

    end
    
    function Funcs:NewSlider(Title, min, max, default, Callback)
        local toggleFuncs = {	
            tweenTime = 0.2;
            current_value = default;
        };
        
        local Slider = Instance.new("ImageButton")
        local UICorner = Instance.new("UICorner")
        local UIGradient = Instance.new("UIGradient")
        local SliderBG = Instance.new("Frame")
        local UICorner_2 = Instance.new("UICorner")
        local box = Instance.new("Frame")
        local UICorner_3 = Instance.new("UICorner")
        local ColoredLine = Instance.new("Frame")
        local UICorner_4 = Instance.new("UICorner")
        local FeatureTitle = Instance.new("TextLabel")
        local UIPadding = Instance.new("UIPadding")
        local InputValue = Instance.new("Frame")
        local UICorner_5 = Instance.new("UICorner")
        local TextLabel = Instance.new("TextBox")
        
        Slider.Name = "Slider"
        Slider.ImageTransparency = 1
        Slider.AutoButtonColor = false
        Slider.Parent = Container
        Slider.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
        Slider.BackgroundTransparency = 0.900
        Slider.Size = UDim2.new(0, 485,0, 38)

        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = Slider

        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(153, 175, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(153, 175, 255))}
        UIGradient.Rotation = 180
        UIGradient.Parent = Slider

        SliderBG.Name = "SliderBG"
        SliderBG.Parent = Slider
        SliderBG.AnchorPoint = Vector2.new(0, 0.5)
        SliderBG.BackgroundColor3 = Color3.fromRGB(91, 91, 91)
        SliderBG.Position = UDim2.new(0.338999987, 0, 0.5, 0)
        SliderBG.Size = UDim2.new(0, 299, 0, 4)

        UICorner_2.CornerRadius = UDim.new(0, 240)
        UICorner_2.Parent = SliderBG

        box.Name = "box"
        box.Parent = SliderBG
        box.AnchorPoint = Vector2.new(0.5, 0.5)
        box.BackgroundColor3 = Color3.fromRGB(214, 220, 235)
        box.Position = UDim2.new(0.819999993, 0, 0.5, 0)
        box.Size = UDim2.new(0, 12, 0, 12)
        box.ZIndex = 2

        UICorner_3.CornerRadius = UDim.new(0, 240)
        UICorner_3.Parent = box

        ColoredLine.Name = "ColoredLine"
        ColoredLine.Parent = SliderBG
        ColoredLine.AnchorPoint = Vector2.new(0, 0.5)
        ColoredLine.BackgroundColor3 = Color3.fromRGB(85, 0, 255)
        ColoredLine.Position = UDim2.new(0, 0, 0.5, 0)
        ColoredLine.Size = UDim2.new(0.819999993, 4, 0, 4)

        UICorner_4.CornerRadius = UDim.new(0, 24)
        UICorner_4.Parent = ColoredLine

        FeatureTitle.Name = "FeatureTitle"
        FeatureTitle.Parent = Slider
        FeatureTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        FeatureTitle.BackgroundTransparency = 1.000
        FeatureTitle.Position = UDim2.new(0.104999967, 0, 0, 0)
        FeatureTitle.Size = UDim2.new(0.0949999988, 0, 1, 0)
        FeatureTitle.Font = Enum.Font.Gotham
        FeatureTitle.Text = Title
        FeatureTitle.TextColor3 = Color3.fromRGB(162, 162, 162)
        FeatureTitle.TextSize = 14.000
        FeatureTitle.TextXAlignment = Enum.TextXAlignment.Left

        UIPadding.Parent = FeatureTitle
        UIPadding.PaddingRight = UDim.new(0, 10)

        InputValue.Name = "InputValue"
        InputValue.Parent = Slider
        InputValue.Active = true
        InputValue.AnchorPoint = Vector2.new(0, 0.5)
        InputValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        InputValue.BackgroundTransparency = 1.000
        InputValue.Position = UDim2.new(0.0199999996, 0, 0.5, 0)
        InputValue.Selectable = true
        InputValue.Size = UDim2.new(0, 25, 0, 25)

        UICorner_5.CornerRadius = UDim.new(0, 4)
        UICorner_5.Parent = InputValue

        TextLabel.Parent = InputValue
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.Size = UDim2.new(1, 0, 1, 0)
        TextLabel.Font = Enum.Font.Gotham
        TextLabel.Text = default or "0"
        TextLabel.TextColor3 = Color3.fromRGB(162, 162, 162)
        TextLabel.TextSize = 14.000
        TextLabel.TextWrapped = true
        
        local Value = 0

        local Connection;
        table.insert(Funcs.connections, UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                if(Connection) then
                    TS:Create(TextLabel, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(81, 84, 90)}):Play();
                    TS:Create(FeatureTitle, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(81, 84, 90)}):Play();
                    TS:Create(box, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(99, 105, 113)}):Play();
                    TS:Create(ColoredLine, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundTransparency = 0.65}):Play();
                    --TS:Create(Accent, ti(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundTransparency = 0.65}):Play();
                    Connection:Disconnect();
                    Connection = nil;
                end;
            end;
        end));

        table.insert(Funcs.connections, Slider.MouseButton1Down:Connect(function()
            if(Connection) then
                Connection:Disconnect();
            end;
            TS:Create(TextLabel, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play();
            TS:Create(FeatureTitle, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play();
            TS:Create(box, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play();
            TS:Create(ColoredLine, TweenInfo.new(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundTransparency = 0}):Play();
            --TS:Create(Accent, ti(toggleFuncs.tweenTime, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {BackgroundTransparency = 0}):Play();

            Connection = RS.Heartbeat:Connect(function()
                local mouse = UIS:GetMouseLocation();
                local percent = math.clamp((mouse.X - SliderBG.AbsolutePosition.X) / (SliderBG.AbsoluteSize.X), 0, 1);
                local Value = min + (max - min) * percent;

                local NewValue = percent * 99.9
                ColoredLine:TweenSize(UDim2.new(NewValue/100, 4, 1, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1,true,nil)
                box:TweenPosition(UDim2.new(NewValue/100, 0, 0.5, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1,true,nil)

                
                

                TextLabel.Text = math.round(Value)
                toggleFuncs.current_value = Value
                pcall(Callback, Value) 
            end);
        end));

        function toggleFuncs:Set(val)
            local percval = val
            if math.abs(min) ~= min then
                percval = val + math.abs(min)
            elseif min ~= 0 then
                percval = val - math.abs(min)
            end
            local percent = (percval/(max-min));
            local Value = val;

            local NewValue = percent * 99.9
            ColoredLine:TweenSize(UDim2.new(NewValue/100, 4, 1, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1,true,nil)
            box:TweenPosition(UDim2.new(NewValue/100, 0, 0.5, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.1,true,nil)

            TextLabel.Text = math.round(Value)
            toggleFuncs.current_value = Value
            pcall(Callback, Value) 
        end

        TextLabel.FocusLost:Connect(function()
            local toNum 
            pcall(function()
                toNum = tonumber(TextLabel.Text)
            end)
            if toNum then
                toNum = math.clamp(toNum, min, max)
                toggleFuncs:Set(toNum)
            end
        end)

        function toggleFuncs:AddToolTip(Text)
            --Library:AddToolTip(ScrollingFrame, ToggleBG, toggleFuncs.tweenTime, Text)
        end

        toggleFuncs:Set(default or 0)

        table.insert(Library.thingsToSet, {functions = toggleFuncs})

        components[Title] = {
            component_name = Title;
            component_minimum = min;
            component_maximium = max;
            component_default = default;
            component_callback = Callback;
            component_table = toggleFuncs;
            component_type = "Slider";
        }

        table.insert(Flags, {
            name = Title, 
            tb = toggleFuncs
        })

        return toggleFuncs;
        
    end
    
    

    function Funcs:Open()
        Funcs.isOpen = true;
        Container.Visible = true;
        TextLabel.TextColor3 = Color3.fromRGB(255,255,255);
        TabButton.BackgroundTransparency = 0;
        TextLabelPath.Text = "Lucid  / <font color=\"#3771ff\">  "..Title.."</font>"
        --PrimaryColors[TabButton] = {"TextColor3"};
        
        Container.CanvasSize = UDim2.new(0, 0,0,Container.AbsoluteCanvasSize.Y)
        


        for _, tab in ipairs(Library.Tabs) do
            if tab.TabButton ~= TabButton then
                tab.Funcs:Close();
            end
        end

    end

    function Funcs:Close()
        Funcs.isOpen = false;
        Container.Visible = false;
        
        TextLabel.TextColor3 = Color3.fromRGB(118, 118, 118);
        TabButton.BackgroundTransparency = 1;
        --PrimaryColors[TabButton] = nil;

    end
    
    
    
    table.insert(Funcs.connections, TabButton.MouseButton1Down:Connect(function()
        if not Funcs.isOpen and Funcs.lastChanged + Funcs.cooldown <= os.time() then
            Funcs.lastChanged = os.time();
            Funcs:Open();
        end
    end))

    table.insert(Library.Tabs, {
        Title = Title,
        TabButton = TabButton;
        ContentBG = Container,
        Funcs = Funcs;
    })

    return Funcs
end

function Library:Init(tab)
    if tab and type(tab) == 'table' and rawget(tab, "Funcs") then
        tab.Funcs:Open();
    end
end

local wiihub = {
	pv = true,
	unitoggle = true,
	blatoggle = true,
	block = true,
	blockslider = 1.5,
	AutoFollowQb = true,
	tprange = 0,
	autocatchv = 0,
   }

   local blatant = 0
   local universal = 0

-- Functions

local Players = game:GetService("Players")
local Mouse = Players.LocalPlayer:GetMouse()
local numTeleports = 30 -- Define the number of teleports
local tooggleEnabled = false -- Variable to track the toggle state

local function universalcatch()
    if tooggleEnabled then
    local catchRight = Players.LocalPlayer.Character:FindFirstChild("CatchRight")

    if not catchRight then
        return
    end

    local closestFootball = nil
    local closestDistance = math.huge

    for i, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name == "Football" and v:IsA("BasePart") then
            local distance = (v.Position - catchRight.Position).Magnitude
            if distance < closestDistance and distance <= universal then
                v.CanCollide = false
                closestDistance = distance
                closestFootball = v
            end
        end
    end
    
    if closestFootball then
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 0)
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 0)
        task.wait()
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 1)
        firetouchinterest(game.Players.LocalPlayer.Character["CatchRight"], closestFootball, 1)
            wait()
            end
        end
    end

local function beamProjectile(g, v0, x0, t1)
    -- calculate the bezier points
    local c = 0.5 * 0.5 * 0.5;
    local p3 = 0.5 * g * t1 * t1 + v0 * t1 + x0;
    local p2 = p3 - (g * t1 * t1 + v0 * t1) / 3;
    local p1 = (c * g * t1 * t1 + 0.5 * v0 * t1 + x0 - c * (x0 + p3)) / (3 * c) - p2;

    -- the curve sizes
    local curve0 = (p1 - x0).magnitude;
    local curve1 = (p2 - p3).magnitude;

    -- build the world CFrames for the attachments
    local b = (x0 - p3).unit;
    local r1 = (p1 - x0).unit;
    local u1 = r1:Cross(b).unit;
    local r2 = (p2 - p3).unit;
    local u2 = r2:Cross(b).unit;
    b = u1:Cross(r1).unit;

    local cf1 = CFrame.new(
        x0.x, x0.y, x0.z,
        r1.x, u1.x, b.x,
        r1.y, u1.y, b.y,
        r1.z, u1.z, b.z
    )

    local cf2 = CFrame.new(
        p3.x, p3.y, p3.z,
        r2.x, u2.x, b.x,
        r2.y, u2.y, b.y,
        r2.z, u2.z, b.z
    )

    return curve0, -curve1, cf1, cf2;
end

local enabled = false
local leadDistance = 10
task.spawn(function()
    --// qb gui initalization
    local gui; do

        local WiiGenCards = Instance.new("ScreenGui")
        local AngleCard = Instance.new("Frame")
        local AngleLabel = Instance.new("TextLabel")
        local UIGradient = Instance.new("UIGradient")
        local AngleNumber = Instance.new("TextLabel")
        local UICorner = Instance.new("UICorner")
    
        --Properties:
    
        WiiGenCards.Name = "WiiGenCards"
        WiiGenCards.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
        AngleCard.Name = "AngleCard"
        AngleCard.Parent = WiiGenCards
        AngleCard.BackgroundColor3 = Color3.fromRGB(25, 23, 32)
        AngleCard.BackgroundTransparency = 0.100
        AngleCard.Position = UDim2.new(0.465230167, 0, 0.134912729, 0)
        AngleCard.Size = UDim2.new(0, 100, 0, 100)
    
        AngleLabel.Name = "AngleLabel"
        AngleLabel.Parent = AngleCard
        AngleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AngleLabel.BackgroundTransparency = 1.000
        AngleLabel.BorderSizePixel = 0
        AngleLabel.Position = UDim2.new(0.049999997, 0, 0.5, 0)
        AngleLabel.Size = UDim2.new(0, 90, 0, 50)
        AngleLabel.SizeConstraint = Enum.SizeConstraint.RelativeXX
        AngleLabel.ZIndex = 3
        AngleLabel.Font = Enum.Font.GothamBold
        AngleLabel.Text = "Angle"
        AngleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        AngleLabel.TextScaled = true
        AngleLabel.TextSize = 14.000
        AngleLabel.TextWrapped = true
    
        UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(79, 86, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 73, 128))}
        UIGradient.Rotation = 31
        UIGradient.Parent = AngleLabel
    
        AngleNumber.Name = "AngleNumber"
        AngleNumber.Parent = AngleCard
        AngleNumber.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        AngleNumber.BackgroundTransparency = 1.000
        AngleNumber.BorderSizePixel = 0
        AngleNumber.Position = UDim2.new(0.049999997, 0, 0.159999996, 0)
        AngleNumber.Size = UDim2.new(0, 90, 0, 50)
        AngleNumber.SizeConstraint = Enum.SizeConstraint.RelativeXX
        AngleNumber.ZIndex = 3
        AngleNumber.Font = Enum.Font.GothamBold
        AngleNumber.Text = "45"
        AngleNumber.TextColor3 = Color3.fromRGB(255, 255, 255)
        AngleNumber.TextScaled = true
        AngleNumber.TextSize = 14.000
        AngleNumber.TextWrapped = true
    
        UICorner.CornerRadius = UDim.new(0.100000001, 0)
        UICorner.Parent = AngleCard
        
        gui = WiiGenCards
    end
    --// main

    local players = game:GetService("Players")
    local runService = game:GetService("RunService")
    local userInputService = game:GetService("UserInputService")
    local replicatedStorage = game:GetService("ReplicatedStorage")
    local player = players.LocalPlayer
    local angle = 40
    local target = nil
    local locked = false
    local realpower = 0
    local camera = workspace.CurrentCamera
    local highlight = Instance.new("Highlight")
    local sphere = Instance.new("Part")
    local upower, udirection = 0, Vector3.new(0, 0, 0)
    local mouse = loadstring(game:HttpGet("https://raw.githubusercontent.com/devdoroz/better-roblox-mouse/main/main.lua"))()
    local mouseRaycastParams = RaycastParams.new()	
    local usePart = Instance.new("Part")
    usePart.Anchored = true
    usePart.CanCollide = false
    usePart.Size = Vector3.new(2048, 1, 2048)
    usePart.Transparency = 1
    usePart.Parent = workspace
    usePart.Position = player.Character.HumanoidRootPart.Position - Vector3.new(0, 2, 0)
    mouseRaycastParams.FilterType = Enum.RaycastFilterType.Include
    mouseRaycastParams.FilterDescendantsInstances = {usePart}
    mouse:SetRaycastParams(mouseRaycastParams)

    local function getMoveDirection(target)
        if players:GetPlayerFromCharacter(target) then
            return target.Humanoid.MoveDirection
        else
            return (target.Humanoid.WalkToPoint - target.Head.Position).Unit
        end
    end

    local function findPower(pos)
        local powerTable = {
            [10] = 55,
            [20] = 60,
            [30] = 65,
            [35] = 70,
            [40] = 75,
            [50] = 80,
            [60] = 85,
            [70] = 90,
            [80] = 95,
        }
        local distance = (player.Character.Head.Position - pos).Magnitude
        local lDiff = math.huge
        local power = 0
        local pdistance = nil
        local reachedDis = 0
        local nextDis = 0
        local naturalPower = 0
        for dis, pwr in pairs(powerTable) do
            dis *= 3
            if distance > dis and dis > reachedDis then
                power = pwr
                naturalPower = pwr
                pdistance = dis
                reachedDis = dis
                if dis == 90 then nextDis = dis + 15 else nextDis = dis + 30 end
            end
        end
        local diff = math.clamp(nextDis - distance, 0, math.huge)
        local required = (nextDis - reachedDis)
        local nextPower = powerTable[nextDis / 3] or 75
        local percentage = diff / required
        --print(diff, required, nextPower, power, percentage, (nextPower - power) - ((nextPower - power) * percentage))
        power += math.clamp((nextPower - power) - ((nextPower - power) * percentage), 0, 100)
        if power ~= power then
            power = 50
        end
        return power - 5, naturalPower - 5
    end

    local function calculateVelocity(x0, d0, t)
        local g = Vector3.new(0, -28, 0)
        local v0 = (d0 - x0 - 0.5*g*t*t)/t;
        local dir = ((x0 + v0) - x0).Unit
        local power = v0.Y / dir.Y
        return v0, dir, power
    end

    local function findtarget()
        local np = nil
        local nm = math.huge
        local s = {workspace}
        if workspace:FindFirstChild("npcwr") then
            table.insert(s, workspace.npcwr.a)
            table.insert(s, workspace.npcwr.b)
        end
        for i, p in pairs(s) do
            for i, c in pairs(p:GetChildren()) do
                if c:FindFirstChildWhichIsA("Humanoid") and c:FindFirstChild("HumanoidRootPart") then
                    local plr = players:GetPlayerFromCharacter(c)
                    if plr == player then continue end
                    if not plr and game.PlaceId ~= 8206123457 then continue end
                    if not player.Neutral then
                        if plr.Team ~= player.Team then
                            continue
                        end
                    end
                    local d = (c.HumanoidRootPart.Position - mouse.Hit.Position).Magnitude
                    if d < nm then
                        nm = d
                        np = c
                    end	
                end
            end
        end
        return np
    end

    local function methodIsA(self, method)
        return string.lower(self) == string.lower(method)
    end

    local remotes = {Fake = {}}

    local function spoofRemote(remote, funcOnFire)
        local fakeSelf = remote:Clone()
        fakeSelf.Parent = remote.Parent
        remote.Name = ""
        remotes[remote] = funcOnFire
        remotes.Fake[fakeSelf] = remote
    end

    local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...)
        local method = getnamecallmethod()
        if methodIsA(method, "FireServer") and not checkcaller() and remotes.Fake[self]  then
            remotes.Fake[self]:FireServer(remotes[remotes.Fake[self]](...))
        end
        return __namecall(self, ...)
    end)

    local function hookFootball(fb)
        local ls = fb.Handle:WaitForChild("LocalScript", 1)
        if ls then
            ls.Enabled = false
            local remoteEvent = fb.Handle:FindFirstChild("RemoteEvent")
            if remoteEvent then
                spoofRemote(remoteEvent, function(old)
                    local args = {old}
                    if args[1] == "Clicked" then
                        if enabled then
                            return unpack({"Clicked", player.Character.Head.Position, player.Character.Head.Position + (udirection * 10000), (game.PlaceId == 8206123457 and upower) or 60, (game.PlaceId ~= 8206123457 and upower) or nil})
                        else
                            local direction = (player:GetMouse().Hit.Position - camera.CFrame.Position).Unit
                            return unpack({"Clicked", player.Character.Head.Position, player.Character.Head.Position + (direction * 10000), (game.PlaceId == 8206123457 and realpower) or 60, realpower})
                        end
                    else
                        return old
                    end
                end)
                fb:WaitForChild("Handle"):WaitForChild("LocalScript").Enabled = true
            end
            ls.Enabled = true
        end
    end

    player.Character.ChildAdded:Connect(function(fb)
        if fb:IsA("Tool") then
            fb:WaitForChild("Handle")
            hookFootball(fb)
        end
    end)

    userInputService.InputBegan:Connect(function(input, gp)
        if not gp then
            if input.KeyCode == Enum.KeyCode.R then
                while userInputService:IsKeyDown(Enum.KeyCode.R) do
                    angle += 5
                    angle = math.clamp(angle, 5, 90)
                    task.wait(1 / 6)
                end
            elseif input.KeyCode == Enum.KeyCode.F then
                while userInputService:IsKeyDown(Enum.KeyCode.F) do
                    angle -= 5
                    angle = math.clamp(angle, 5, 90)
                    task.wait(1 / 6)
                end
            elseif input.KeyCode == Enum.KeyCode.Q then
                locked = not locked
            end
        end
    end)

    local function calculateLanding(power, direction)
        local vel = power * direction
        local origin = player.Character.Head.Position + direction * 5
        local peakTime = vel.Y / 28
        return origin + Vector3.new(vel.X * peakTime * 2, 0, vel.Z * peakTime * 2)	
    end

    local line = Drawing.new("Line")
    line.Visible = false
    line.Color = Color3.fromRGB(255, 255, 255)
    line.Thickness = 1

    sphere.Size = Vector3.new(3, 3, 3)
    sphere.Shape = Enum.PartType.Ball
    sphere.Material = Enum.Material.Neon
    sphere.Anchored = true
    sphere.CanCollide = false
    sphere.Color = Color3.fromRGB(255, 255, 255)
    sphere.Parent = workspace
    highlight.FillColor = Color3.fromRGB(255, 255, 255)

    player.PlayerGui.ChildAdded:Connect(function(child)
        if child.Name == "BallGui" then
            local disp = child:WaitForChild("Frame"):WaitForChild("Disp")
            disp.Changed:Connect(function()
                realpower = tonumber(disp.Text)
            end)
        end
    end)

    while true do
        runService.RenderStepped:Wait()
        pcall(function()
            if not locked then
                target = findtarget()
            end
            gui.Enabled = player.PlayerGui:FindFirstChild("BallGui") and enabled
            if target and enabled and player.PlayerGui:FindFirstChild("BallGui") then
                local position, onScreen = workspace.CurrentCamera:WorldToViewportPoint(target.HumanoidRootPart.Position)
                local power = findPower(target.Head.Position)
                local moveDirection = getMoveDirection(target)
                local assumedDirection = (target.Head.Position - player.Character.Head.Position).Unit
                local speed = (assumedDirection * power).Magnitude
                local t = ((target.Head.Position - player.Character.Head.Position).Magnitude / speed) * (angle / 22)
                local velocity, dir, pwr = calculateVelocity(player.Character.Head.Position + assumedDirection * 5, target.Head.Position + (moveDirection * 20 * t) + moveDirection * leadDistance, t)
                highlight.Parent = target
                upower = math.clamp(pwr, 0, 95)
                udirection = dir
                sphere.Transparency = 0
                gui.AngleCard.AngleNumber.Text = angle
                sphere.Position = calculateLanding(upower, udirection)
                if onScreen then
                    line.Visible = true
                    line.From = workspace.CurrentCamera:WorldToViewportPoint(player.Character.Football.Handle.Position)
                    line.To = Vector2.new(position.X, position.Y)
                else
                    line.Visible = false
                end
            else
                line.Visible = false
                highlight.Parent = nil
                sphere.Transparency = 1
            end
        end)
    end
end)

Library:SetTitle("Lucid")
Library:SetFooter("Welcome, "..(plr.DisplayName or plr.Name))

                                    -- Start

                                    local plr = game.Players.LocalPlayer
                                    local uis = game:GetService("UserInputService")
                                    local rs = game:GetService("RunService")
                                    
                                    Library:SetTitle("WiiHub")
                                    Library:SetFooter("Welcome, "..(plr.DisplayName or plr.Name))
                                    
                                    local t1 = Library:NewTab("Catching/Physics")
                                    local t2 = Library:NewTab("QB")
                                    
                                    local t4 = Library:NewTab("Visuals")
                                   
                                   
                                    
				    t1:NewToggle("Adjustable Mags", false, function(v)
                                        tooggleEnabled = v
                                        while tooggleEnabled == true do
                                            task.wait()
                                            universalcatch()
                                        end
                                    end)
                                    
                                    t1:NewSlider("Mag Distance", .1, 30, 0, function(v)
                                        universal = v
                                    end)

                                    t2:NewToggle("QB Aimbot", false, function(v)
                                        enabled = v
                                    end)

                                    t2:NewSlider("Lead Distance", .1, 40, 0, function(v)
                                        leadDistance = v
                                    end)

                                    -- Physics

                                    t2:NewToggle("Football Predictions", false, function(v)
                                        if v and not toggleActive then
                                            toggleActive = true
                                            eventConnection = workspace.ChildAdded:Connect(function(b)
                                                if b.Name == "Football" and b:IsA("BasePart") then
                                                    task.wait()
                                                    local vel = b.Velocity
                                                    local pos = b.Position
                                                    local c0, c1, cf1, cf2 = beamProjectile(Vector3.new(0, -28, 0), vel, pos, 10)
                                                    local beam = Instance.new("Beam")
                                                    local a0 = Instance.new("Attachment")
                                                    local a1 = Instance.new("Attachment")
                                                    beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
                                                    beam.Transparency = NumberSequence.new(0, 0)
                                                    beam.Segments = 10 * 300
                                                    beam.CurveSize0 = c0
                                                    beam.CurveSize1 = c1
                                                    beam.Name = "Hitbox"
                                                    beam.Parent = workspace.Terrain
                                                    a0.Parent = workspace.Terrain
                                                    a1.Parent = workspace.Terrain
                                                    a0.CFrame = a0.Parent.CFrame:Inverse() * cf1
                                                    a1.CFrame = a1.Parent.CFrame:Inverse() * cf2
                                                    beam.Attachment0 = a0
                                                    beam.Attachment1 = a1
                                                    beam.Width0 = 0.5
                                                    beam.Width1 = 0.5
                                                    repeat task.wait() until b.Parent ~= workspace
                                                    a0:Destroy()
                                                    a1:Destroy()
                                                end
                                            end)
                                        elseif not Value and toggleActive then
                                            toggleActive = false
                                            if eventConnection then
                                                eventConnection:Disconnect()
                                            end
                                        end
                                    end)

local qbaimpred = false



-- Defense

local swatreachmain = false
local player = game.Players.LocalPlayer
local swatDistance = math.huge
local swatted = false
local userInputService = game:GetService("UserInputService")

local function isFootball(fb)
    return fb and fb:FindFirstChildWhichIsA("RemoteEvent")
end

local function getNearestBall(checkFunc)
    local lowestDistance = math.huge
    local lowestFB = nil
    for index, part in pairs(workspace:GetChildren()) do
        if isFootball(part) and not part.Anchored then
            if checkFunc then
                if not checkFunc(part) then
                    continue
                end
            end
            local distance = (player.Character.HumanoidRootPart.Position - part.Position).Magnitude
            if distance < lowestDistance then
                lowestFB = part
                lowestDistance = distance
            end
        end
    end
    return lowestFB, lowestDistance
end

local function getNearestPartToPartFromParts(parts, part)
    local lowestMagnitude = math.huge
    local lowestPart = nil
    for index, p in pairs(parts) do
        local dis = (part.Position - p.Position).Magnitude
        if dis < lowestMagnitude then
            lowestMagnitude = dis
            lowestPart = p
        end
    end
    return lowestPart
end

local function initCharacter(char)
    while swatreachmain do
        task.wait()
        local ball = getNearestBall()
        if ball and swatted then
            local distance = (player.Character.HumanoidRootPart.Position - ball.Position).Magnitude
            if distance < swatDistance then
                local catch = getNearestPartToPartFromParts({player.Character["CatchLeft"], player.Character["CatchRight"]}, ball)
                firetouchinterest(ball, catch, 0)
                firetouchinterest(ball, catch, 1)
            end
        end
    end
end

userInputService.InputBegan:Connect(function(input, gp)
    if not gp then
        if input.KeyCode == Enum.KeyCode.R and not swatted then
            swatted = true
            task.wait(1.5)
            swatted = false
        end
    end
end)

local function updateCharacter(character)
    if swatreachmain then
        initCharacter(character)
    end
end

player.CharacterAdded:Connect(updateCharacter)

t1:NewToggle("Swat Reach", swatreachmain, function(value)
    swatreachmain = value
    if value then
        updateCharacter(player.Character) 
    end
end)

if swatreachmain then
    initCharacter(player.Character)
end

-- Auto Swat

local autoswatv = 0

 local enabledd = false

 local function autoswatfunction()
    if enabledd then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local RunService = game:GetService("RunService")

        local function checkDistance(part)
            local distance = (part.Position - humanoidRootPart.Position).Magnitude
            if distance <= autoswatv then
                keypress(0x52)
                keyrelease(0x52)
                task.wait()
            end
        end
        local function updateDistances()
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Football" and v:IsA("BasePart") then
                    checkDistance(v)
                end
            end
        end
        connection = RunService.Heartbeat:Connect(updateDistances)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

t1:NewToggle("Auto Swat", false, function(v)
    enabledd = v
    autoswatfunction()
end)

t1:NewSlider("Auto Swat Range", 1, 45, 0, function(v)
    autoswatv = v
end)






t4:NewToggle("ChatSpy", false, function(v)
enabledd = v
loadstring(game:HttpGet('https://raw.githubusercontent.com/LucidHubPremium/LucidPremium/main/Lucid-Premium-ChatSpy.lua'))()
	end)



	


