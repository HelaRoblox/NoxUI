local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- Main UI Library Object
local UILib = {}

-- Function to create a window
function UILib:CreateWindow(title)
    -- Create the main ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.Name = "RayfieldWindow"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false

    -- Main frame (window)
    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    mainFrame.BorderSizePixel = 0
    mainFrame.Name = "MainUI"

    -- Rounded corners for main frame
    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 16)

    -- Title bar
    local titleBar = Instance.new("TextLabel")
    titleBar.Parent = mainFrame
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
    titleBar.Text = title or "Rayfield UI"
    titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleBar.Font = Enum.Font.GothamBold
    titleBar.TextSize = 22
    titleBar.TextXAlignment = Enum.TextXAlignment.Center
    titleBar.TextYAlignment = Enum.TextYAlignment.Center

    -- ListLayout for the content
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
        button.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 18
        button.AutoButtonColor = false
        button.LayoutOrder = #mainFrame:GetChildren() + 1

        -- Rounded corners for the button
        local btnCorner = Instance.new("UICorner", button)
        btnCorner.CornerRadius = UDim.new(0, 8)

        -- Hover effect
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
        end)

        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(63, 63, 63)}):Play()
        end)

        -- Button click callback
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
        button.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
        button.Text = text
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.Gotham
        button.TextSize = 18
        button.AutoButtonColor = false

        -- Rounded corners for the button
        local btnCorner = Instance.new("UICorner", button)
        btnCorner.CornerRadius = UDim.new(0, 8)

        local toggle = defaultValue or false
        button.MouseButton1Click:Connect(function()
            toggle = not toggle
            if callback then callback(toggle) end
            button.BackgroundColor3 = toggle and Color3.fromRGB(44, 185, 44) or Color3.fromRGB(63, 63, 63)
        end)

        -- Initial toggle state
        button.BackgroundColor3 = toggle and Color3.fromRGB(44, 185, 44) or Color3.fromRGB(63, 63, 63)
    end

    -- Function to add a label
    function UILib:AddLabel(text)
        local label = Instance.new("TextLabel")
        label.Parent = mainFrame
        label.Size = UDim2.new(1, -20, 0, 36)
        label.Position = UDim2.new(0, 10, 0, 60)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.Gotham
        label.TextSize = 18
        label.LayoutOrder = #mainFrame:GetChildren() + 1
    end

    -- Optional: More components like sliders, dropdowns, etc.

    return UILib
end

return UILib
