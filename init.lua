local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local UILib = {}

function UILib:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.Name = "RayfieldWindow"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Parent = screenGui
    mainFrame.Size = UDim2.new(0, 600, 0, 400)
    mainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    mainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    mainFrame.BorderSizePixel = 0
    mainFrame.Name = "MainUI"
    local corner = Instance.new("UICorner", mainFrame)
    corner.CornerRadius = UDim.new(0, 16)

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

    local layout = Instance.new("UIListLayout")
    layout.Parent = mainFrame
    layout.Padding = UDim.new(0, 10)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.VerticalAlignment = Enum.VerticalAlignment.Top

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
        local btnCorner = Instance.new("UICorner", button)
        btnCorner.CornerRadius = UDim.new(0, 8)

        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(90, 90, 90)}):Play()
        end)

        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(63, 63, 63)}):Play()
        end)

        button.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

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
        local btnCorner = Instance.new("UICorner", button)
        btnCorner.CornerRadius = UDim.new(0, 8)

        local toggle = defaultValue or false
        button.MouseButton1Click:Connect(function()
            toggle = not toggle
            if callback then callback(toggle) end
            button.BackgroundColor3 = toggle and Color3.fromRGB(44, 185, 44) or Color3.fromRGB(63, 63, 63)
        end)

        button.BackgroundColor3 = toggle and Color3.fromRGB(44, 185, 44) or Color3.fromRGB(63, 63, 63)
    end

    function UILib:AddSlider(text, minValue, maxValue, defaultValue, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Parent = mainFrame
        sliderFrame.Size = UDim2.new(1, -20, 0, 36)
        sliderFrame.Position = UDim2.new(0, 10, 0, 60)
        sliderFrame.BackgroundTransparency = 1
        sliderFrame.LayoutOrder = #mainFrame:GetChildren() + 1

        local sliderLabel = Instance.new("TextLabel")
        sliderLabel.Parent = sliderFrame
        sliderLabel.Size = UDim2.new(0, 150, 1, 0)
        sliderLabel.BackgroundTransparency = 1
        sliderLabel.Text = text
        sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        sliderLabel.Font = Enum.Font.Gotham
        sliderLabel.TextSize = 18

        local slider = Instance.new("Frame")
        slider.Parent = sliderFrame
        slider.Size = UDim2.new(1, -170, 0, 5)
        slider.Position = UDim2.new(0, 160, 0, 16)
        slider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        local sliderFill = Instance.new("Frame")
        sliderFill.Parent = slider
        sliderFill.Size = UDim2.new(0, 0, 1, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(44, 185, 44)

        local dragging = false
        local function updateSlider(input)
            local newX = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
            sliderFill.Size = UDim2.new(newX / slider.AbsoluteSize.X, 0, 1, 0)
            local value = math.floor(minValue + ((newX / slider.AbsoluteSize.X) * (maxValue - minValue)))
            if callback then callback(value) end
        end

        slider.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        slider.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging then
                updateSlider(input)
            end
        end)

        updateSlider({Position = UDim2.new(0, math.floor((defaultValue - minValue) / (maxValue - minValue) * slider.AbsoluteSize.X), 0, 0)})
    end

    function UILib:AddInputField(placeholder, callback)
        local inputFrame = Instance.new("Frame")
        inputFrame.Parent = mainFrame
        inputFrame.Size = UDim2.new(1, -20, 0, 36)
        inputFrame.Position = UDim2.new(0, 10, 0, 60)
        inputFrame.BackgroundTransparency = 1
        inputFrame.LayoutOrder = #mainFrame:GetChildren() + 1

        local inputBox = Instance.new("TextBox")
        inputBox.Parent = inputFrame
        inputBox.Size = UDim2.new(1, 0, 0, 36)
        inputBox.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
        inputBox.Text = ""
        inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        inputBox.PlaceholderText = placeholder
        inputBox.Font = Enum.Font.Gotham
        inputBox.TextSize = 18
        local btnCorner = Instance.new("UICorner", inputBox)
        btnCorner.CornerRadius = UDim.new(0, 8)

        inputBox.FocusLost:Connect(function(enterPressed)
            if enterPressed and callback then callback(inputBox.Text) end
        end)
    end

    return UILib
end

return UILib
