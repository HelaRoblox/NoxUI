-- UILib: A Simple UI Library for Roblox

local UILib = {}

-- Utility function to create UI elements
function UILib.createElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

-- Function to create a window
function UILib.createWindow(parent, title, size, position)
    local window = UILib.createElement("Frame", {
        Name = title,
        Parent = parent,
        Size = size,
        Position = position,
        BackgroundColor3 = Color3.fromRGB(30, 30, 30),
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })

    -- Title Label
    local titleLabel = UILib.createElement("TextLabel", {
        Parent = window,
        Size = UDim2.new(1, 0, 0, 40),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        Text = title,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 20,
        TextStrokeTransparency = 0.6,
        TextFont = Enum.Font.GothamBold,
        TextAlignment = Enum.TextAlignment.Center,
        TextXAlignment = Enum.TextXAlignment.Center
    })

    return window
end

-- Function to create a button
function UILib.createButton(parent, text, position, size, callback, styles)
    local button = UILib.createElement("TextButton", {
        Parent = parent,
        Size = size,
        Position = position,
        BackgroundColor3 = styles.bgColor or Color3.fromRGB(50, 50, 50),
        Text = text,
        TextColor3 = styles.textColor or Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        Font = styles.font or Enum.Font.Gotham,
        BorderSizePixel = 0,
        AutoButtonColor = true,
    })

    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = styles.hoverColor or Color3.fromRGB(70, 70, 70)
    end)

    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = styles.bgColor or Color3.fromRGB(50, 50, 50)
    end)

    button.MouseButton1Click:Connect(function()
        callback()
    end)

    return button
end

-- Function to create a label
function UILib.createLabel(parent, text, position, size, styles)
    local label = UILib.createElement("TextLabel", {
        Parent = parent,
        Size = size,
        Position = position,
        BackgroundColor3 = styles.bgColor or Color3.fromRGB(255, 255, 255),
        Text = text,
        TextColor3 = styles.textColor or Color3.fromRGB(255, 255, 255),
        TextSize = styles.textSize or 14,
        Font = styles.font or Enum.Font.Gotham,
        TextStrokeTransparency = styles.textStrokeTransparency or 0.6,
        TextAlignment = Enum.TextAlignment.Center,
        TextXAlignment = Enum.TextXAlignment.Center
    })
    return label
end

-- Function to create a close button
function UILib.createCloseButton(window, callback)
    local closeButton = UILib.createButton(window, "Close", UDim2.new(0.95, -50, 0.05, 0), UDim2.new(0, 40, 0, 40), function()
        window:Destroy()
    end, {
        bgColor = Color3.fromRGB(255, 0, 0),
        textColor = Color3.fromRGB(255, 255, 255),
        hoverColor = Color3.fromRGB(200, 0, 0),
        font = Enum.Font.GothamBold
    })

    return closeButton
end

-- Example usage of the UILib
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a window with title
local window = UILib.createWindow(screenGui, "Example Window", UDim2.new(0, 400, 0, 300), UDim2.new(0.5, -200, 0.5, -150))

-- Create a label inside the window
UILib.createLabel(window, "Welcome to the UI!", UDim2.new(0.5, -100, 0.2, 0), UDim2.new(0, 200, 0, 50), {
    textSize = 18,
    textColor = Color3.fromRGB(255, 255, 255),
    font = Enum.Font.GothamBold
})

-- Create a button that shows a message when clicked
UILib.createButton(window, "Click Me", UDim2.new(0.5, -50, 0.4, 0), UDim2.new(0, 100, 0, 40), function()
    print("Button clicked!")
end, {
    bgColor = Color3.fromRGB(0, 128, 255),
    textColor = Color3.fromRGB(255, 255, 255),
    hoverColor = Color3.fromRGB(0, 100, 200)
})

-- Create a close button for the window
UILib.createCloseButton(window)

return UILib
