-- init.lua
local TweenService = game:GetService("TweenService")

-- Main library object
local UILib = {}

-- Function to create a window
function UILib:CreateWindow(title)
    -- Create the ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.Name = "UILibWindow"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false

    -- Create the main Frame (window)
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.Size = UDim2.new(0, 420, 0, 340)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -170)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.Name = "MainUI"

    -- Rounded corners
    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 12)

    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = mainFrame
    titleLabel.Text = title or "My Custom UI"
    titleLabel.Size = UDim2.new(1, 0, 0, 45)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 22
    titleLabel.TextXAlignment = Enum.TextXAlignment.Center
    titleLabel.TextYAlignment = Enum.TextYAlignment.Center

    -- UI List Layout for easy stacking of buttons
    local layout = Instance.new("UIListLayout")
    layout.Parent = mainFrame
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Top

    -- Function to add a button
    function UILib:AddButton(text, callback)
        local button = Instance.new("TextButton")
        button.Parent = mainFrame
        button.Size = UDim2.new(1, -20, 0, 36)
        button.Position = UDim2.new(0, 10, 0, 60)
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 17
        button.AutoButtonColor = false
        button.LayoutOrder = #mainFrame:GetChildren() + 1

        -- Rounded corners for the button
        local btnCorner = Instance.new("UICorner", button)
        btnCorner.CornerRadius = UDim.new(0, 8)

        -- Hover effect
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(80, 80, 80)}):Play()
        end)

        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
        end)

        -- Click callback
        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    -- Function to add a toggle button (on/off)
    function UILib:AddToggle(text, defaultValue, callback)
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Parent = mainFrame
        toggleFrame.Size = UDim2.new(1, -20, 0, 36)
        toggleFrame.Position = UDim2.new(0, 10, 0, 60)
        toggleFrame.BackgroundTransparency = 1
        toggleFrame.LayoutOrder = #mainFrame:GetChildren() + 1

        local button = Instance.new("TextButton")
        button.Parent = toggleFrame
        button.Size = UDim2.new(0, 120, 1, 0)
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 17
        button.AutoButtonColor = false

        -- Rounded corners for the button
        local btnCorner = Instance.new("UICorner", button)
        btnCorner.CornerRadius = UDim.new(0, 8)

        local toggle = defaultValue or false
        button.MouseButton1Click:Connect(function()
            toggle = not toggle
            if callback then callback(toggle) end
            button.BackgroundColor3 = toggle and Color3.fromRGB(70, 120, 70) or Color3.fromRGB(70, 70, 70)
        end)

        -- Initial toggle state
        button.BackgroundColor3 = toggle and Color3.fromRGB(70, 120, 70) or Color3.fromRGB(70, 70, 70)
    end

    return UILib
end

return UILib
