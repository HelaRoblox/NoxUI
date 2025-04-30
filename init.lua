local NoxUI = {}

-- Theme Colors
local theme = {
	Background = Color3.fromRGB(240, 240, 255),
	TopBar = Color3.fromRGB(80, 100, 255),
	Text = Color3.fromRGB(30, 30, 30),
	Button = Color3.fromRGB(200, 200, 255),
	ButtonHover = Color3.fromRGB(180, 180, 255),
	Rounded = UDim.new(0, 10),
	Font = Enum.Font.Gotham
}

-- Create NoxUI Window
function NoxUI:CreateWindow(config)
	local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
	ScreenGui.Name = config.Name or "NoxUI"
	ScreenGui.ResetOnSpawn = false

	local MainFrame = Instance.new("Frame", ScreenGui)
	MainFrame.Size = UDim2.new(0, 500, 0, 350)
	MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
	MainFrame.BackgroundColor3 = theme.Background
	MainFrame.BorderSizePixel = 0
	MainFrame.ClipsDescendants = true
	MainFrame.Name = "MainFrame"

	local UICorner = Instance.new("UICorner", MainFrame)
	UICorner.CornerRadius = theme.Rounded

	local TopBar = Instance.new("Frame", MainFrame)
	TopBar.Size = UDim2.new(1, 0, 0, 40)
	TopBar.BackgroundColor3 = theme.TopBar
	TopBar.BorderSizePixel = 0

	local Title = Instance.new("TextLabel", TopBar)
	Title.Text = config.Title or "NoxUI"
	Title.Font = theme.Font
	Title.TextSize = 20
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(1, -20, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.TextXAlignment = Enum.TextXAlignment.Left

	return setmetatable({Main = MainFrame}, {
		__index = function(self, method)
			return NoxUI[method]
		end
	})
end

-- Create Button
function NoxUI:CreateButton(window, text, callback)
	local Button = Instance.new("TextButton", window.Main)
	Button.Size = UDim2.new(0, 200, 0, 40)
	Button.Position = UDim2.new(0.5, -100, 0, 60 + (#window.Main:GetChildren() * 45))
	Button.BackgroundColor3 = theme.Button
	Button.Font = theme.Font
	Button.TextSize = 16
	Button.TextColor3 = theme.Text
	Button.Text = text
	Button.AutoButtonColor = false
	Button.Name = "NoxButton"

	local ButtonCorner = Instance.new("UICorner", Button)
	ButtonCorner.CornerRadius = theme.Rounded

	Button.MouseEnter:Connect(function()
		Button.BackgroundColor3 = theme.ButtonHover
	end)
	Button.MouseLeave:Connect(function()
		Button.BackgroundColor3 = theme.Button
	end)
	Button.MouseButton1Click:Connect(callback)
end

return NoxUI
