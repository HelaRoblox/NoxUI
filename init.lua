local UILib = {}

function UILib.createElement(className, properties)
    local element = Instance.new(className)
    for prop, value in pairs(properties) do
        element[prop] = value
    end
    return element
end

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

function UILib.createPanel(parent, position, size, styles)
    local panel = UILib.createElement("Frame", {
        Parent = parent,
        Position = position,
        Size = size,
        BackgroundColor3 = styles.bgColor or Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 0,
        BackgroundTransparency = styles.transparency or 0
    })
    
    return panel
end

function UILib.addGradient(panel, colors, rotation)
    local gradient = UILib.createElement("UIGradient", {
        Parent = panel,
        Color = colors or ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 0, 255)),
        Rotation = rotation or 45
    })
end

function UILib.createCloseButton(window, callback)
    local closeButton = UILib.createButton(window, "Close", UDim2.new(0.95, -50, 0.05, 0), UDim2.new(0, 40, 0, 40), function()
        callback()
    end, {
        bgColor = Color3.fromRGB(255, 0, 0),
        textColor = Color3.fromRGB(255, 255, 255),
        hoverColor = Color3.fromRGB(200, 0, 0),
        font = Enum.Font.GothamBold
    })
    
    return closeButton
end

return UILib
