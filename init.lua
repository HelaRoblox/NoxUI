-- UILib.lua (Rayfield UI style)
local UILib = {}

-- Default settings for components
local defaultSettings = {
    window = {
        title = "Window",
        width = 500,
        height = 300,
        bgColor = Color3.fromRGB(30, 30, 30),
        titleColor = Color3.fromRGB(255, 255, 255),
        borderRadius = 5,
        borderSize = 2
    },
    button = {
        font = Enum.Font.Gotham,
        textSize = 18,
        textColor = Color3.fromRGB(255, 255, 255),
        bgColor = Color3.fromRGB(56, 56, 56),
        hoverColor = Color3.fromRGB(66, 66, 66),
        borderSize = 0,
        cornerRadius = 5
    },
    label = {
        font = Enum.Font.Gotham,
        textSize = 18,
        textColor = Color3.fromRGB(255, 255, 255),
        textAlign = Enum.TextAlignment.Center
    },
    panel = {
        bgColor = Color3.fromRGB(40, 40, 40),
        borderSize = 0,
        cornerRadius = 5
    }
}

-- Helper function to merge default and custom settings
local function mergeSettings(default, custom)
    local result = {}
    for key, value in pairs(default) do
        result[key] = custom[key] or value
    end
    return result
end

-- Create a window with title and other customizable properties
function UILib.createWindow(parent, title, size, position, customSettings)
    local settings = mergeSettings(defaultSettings.window, customSettings or {})

    local window = Instance.new("Frame")
    window.Parent = parent
    window.Position = position
    window.Size = size or UDim2.new(0, settings.width, 0, settings.height)
    window.BackgroundColor3 = settings.bgColor
    window.BorderSizePixel = settings.borderSize
    window.BorderRadius = UDim.new(0, settings.borderRadius)

    -- Create the title bar
    local titleBar = Instance.new("Frame")
    titleBar.Parent = window
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = settings.titleColor
    titleBar.BorderSizePixel = 0

    -- Title label
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = titleBar
    titleLabel.Text = title or settings.title
    titleLabel.Size = UDim2.new(1, 0, 1, 0)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextSize = 22
    titleLabel.TextAlignment = Enum.TextAlignment.Center
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.BackgroundTransparency = 1

    return window
end

-- Create a button with text, size, position, and callback
function UILib.createButton(parent, text, position, size, onClick, customSettings)
    local settings = mergeSettings(defaultSettings.button, customSettings or {})

    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Text = text
    button.Position = position
    button.Size = size
    button.Font = settings.font
    button.TextSize = settings.textSize
    button.TextColor3 = settings.textColor
    button.BackgroundColor3 = settings.bgColor
    button.BorderSizePixel = settings.borderSize
    button.BorderRadius = UDim.new(0, settings.cornerRadius)
    button.AutoButtonColor = false

    -- Hover effects
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = settings.hoverColor
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = settings.bgColor
    end)

    -- Click event
    button.MouseButton1Click:Connect(onClick)

    return button
end

-- Create a label with customizable properties
function UILib.createLabel(parent, text, position, size, customSettings)
    local settings = mergeSettings(defaultSettings.label, customSettings or {})

    local label = Instance.new("TextLabel")
    label.Parent = parent
    label.Text = text
    label.Position = position
    label.Size = size
    label.Font = settings.font
    label.TextSize = settings.textSize
    label.TextColor3 = settings.textColor
    label.TextAlignment = settings.textAlign
    label.BackgroundTransparency = 1

    return label
end

-- Create a panel (frame) with customizable settings
function UILib.createPanel(parent, position, size, customSettings)
    local settings = mergeSettings(defaultSettings.panel, customSettings or {})

    local panel = Instance.new("Frame")
    panel.Parent = parent
    panel.Position = position
    panel.Size = size
    panel.BackgroundColor3 = settings.bgColor
    panel.BorderSizePixel = settings.borderSize
    panel.BorderRadius = UDim.new(0, settings.cornerRadius)

    return panel
end

return UILib
