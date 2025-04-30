local NoxUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local theme = {
    Background = Color3.fromRGB(20, 20, 25),
    TopBar = Color3.fromRGB(35, 35, 45),
    Sidebar = Color3.fromRGB(30, 30, 35),
    Text = Color3.fromRGB(220, 220, 220),
    Accent = Color3.fromRGB(85, 170, 255),
    Font = Enum.Font.Gotham,
    Round = UDim.new(0, 10)
}

function NoxUI:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    ScreenGui.Name = config.Name or "NoxUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 620, 0, 400)
    Main.Position = UDim2.new(0.5, -310, 0.5, -200)
    Main.BackgroundColor3 = theme.Background
    Main.BorderSizePixel = 0
    Main.Name = "MainWindow"
    local UICorner = Instance.new("UICorner", Main)
    UICorner.CornerRadius = theme.Round

    local Top = Instance.new("Frame", Main)
    Top.Size = UDim2.new(1, 0, 0, 45)
    Top.BackgroundColor3 = theme.TopBar
    Top.BorderSizePixel = 0
    Top.Name = "TopBar"

    local Title = Instance.new("TextLabel", Top)
    Title.Text = config.Title or "NoxUI"
    Title.Size = UDim2.new(1, -50, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Font = theme.Font
    Title.TextColor3 = theme.Text
    Title.TextSize = 20
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local Close = Instance.new("TextButton", Top)
    Close.Text = "✕"
    Close.Size = UDim2.new(0, 40, 1, 0)
    Close.Position = UDim2.new(1, -40, 0, 0)
    Close.BackgroundTransparency = 1
    Close.Font = theme.Font
    Close.TextColor3 = Color3.fromRGB(255, 80, 80)
    Close.TextSize = 22
    Close.ZIndex = 2
    Close.AutoButtonColor = false
    Close.MouseButton1Click:Connect(function()
        TweenService:Create(Main, TweenInfo.new(0.25), {
            Size = UDim2.new(0, 620, 0, 0),
            Position = UDim2.new(0.5, -310, 0.5, 0)
        }):Play()
        wait(0.25)
        ScreenGui:Destroy()
    end)

    -- Sidebar
    local Sidebar = Instance.new("Frame", Main)
    Sidebar.Size = UDim2.new(0, 150, 1, 0)
    Sidebar.BackgroundColor3 = theme.Sidebar
    Sidebar.BorderSizePixel = 0
    local SidebarUICorner = Instance.new("UICorner", Sidebar)
    SidebarUICorner.CornerRadius = theme.Round

    local Tabs = Instance.new("Frame", Sidebar)
    Tabs.Size = UDim2.new(1, 0, 1, 0)
    Tabs.Position = UDim2.new(0, 0, 0, 0)
    Tabs.BackgroundTransparency = 1
    Tabs.Name = "Tabs"

    -- Tab buttons
    local TabButton1 = Instance.new("TextButton", Tabs)
    TabButton1.Text = "Tab 1"
    TabButton1.Size = UDim2.new(1, 0, 0, 30)
    TabButton1.BackgroundColor3 = theme.Background
    TabButton1.Font = theme.Font
    TabButton1.TextColor3 = theme.Text
    TabButton1.TextSize = 16
    TabButton1.MouseButton1Click:Connect(function()
        -- Handle Tab switching (example)
    end)

    local TabButton2 = Instance.new("TextButton", Tabs)
    TabButton2.Text = "Tab 2"
    TabButton2.Size = UDim2.new(1, 0, 0, 30)
    TabButton2.Position = UDim2.new(0, 0, 0, 30)
    TabButton2.BackgroundColor3 = theme.Background
    TabButton2.Font = theme.Font
    TabButton2.TextColor3 = theme.Text
    TabButton2.TextSize = 16
    TabButton2.MouseButton1Click:Connect(function()
        -- Handle Tab switching (example)
    end)

    -- Main content area
    local ContentArea = Instance.new("Frame", Main)
    ContentArea.Size = UDim2.new(1, -150, 1, -45)
    ContentArea.Position = UDim2.new(0, 150, 0, 45)
    ContentArea.BackgroundColor3 = theme.Background
    ContentArea.BorderSizePixel = 0
    local ContentUICorner = Instance.new("UICorner", ContentArea)
    ContentUICorner.CornerRadius = theme.Round

    -- Toggle Button
    local ToggleButton = Instance.new("TextButton", ContentArea)
    ToggleButton.Text = "Toggle"
    ToggleButton.Size = UDim2.new(0, 100, 0, 30)
    ToggleButton.Position = UDim2.new(0, 10, 0, 10)
    ToggleButton.BackgroundColor3 = theme.Accent
    ToggleButton.Font = theme.Font
    ToggleButton.TextColor3 = theme.Text
    ToggleButton.TextSize = 16
    ToggleButton.MouseButton1Click:Connect(function()
        -- Example Toggle Action
        print("Toggled!")
    end)

    -- Slider
    local Slider = Instance.new("Frame", ContentArea)
    Slider.Size = UDim2.new(0, 300, 0, 30)
    Slider.Position = UDim2.new(0, 10, 0, 50)
    Slider.BackgroundColor3 = theme.Accent
    local SliderUICorner = Instance.new("UICorner", Slider)
    SliderUICorner.CornerRadius = theme.Round
    -- You can add more functionality for sliders here

    -- Notification
    local NotificationButton = Instance.new("TextButton", ContentArea)
    NotificationButton.Text = "Notify"
    NotificationButton.Size = UDim2.new(0, 100, 0, 30)
    NotificationButton.Position = UDim2.new(0, 120, 0, 10)
    NotificationButton.BackgroundColor3 = theme.Accent
    NotificationButton.Font = theme.Font
    NotificationButton.TextColor3 = theme.Text
    NotificationButton.TextSize = 16
    NotificationButton.MouseButton1Click:Connect(function()
        -- Example Notification
        print("Notification triggered!")
    end)

    return ScreenGui
end

return NoxUI
