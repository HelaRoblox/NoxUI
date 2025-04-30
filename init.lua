local NoxUI = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local theme = {
	Background = Color3.fromRGB(248, 249, 255),
	TopBar = Color3.fromRGB(90, 115, 255),
	Sidebar = Color3.fromRGB(230, 233, 255),
	Text = Color3.fromRGB(33, 33, 33),
	Accent = Color3.fromRGB(140, 160, 255),
	Font = Enum.Font.Gotham,
	Round = UDim.new(0, 12)
}

function NoxUI:CreateWindow(config)
	local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
	ScreenGui.Name = config.Name or "NoxUI"
	ScreenGui.ResetOnSpawn = false

	local Main = Instance.new("Frame", ScreenGui)
	Main.Size = UDim2.new(0, 620, 0, 400)
	Main.Position = UDim2.new(0.5, -310, 0.5, -200)
	Main.BackgroundColor3 = theme.Background
	Main.BorderSizePixel = 0
	Main.Name = "MainWindow"

	local UICorner = Instance.new("UICorner", Main)
	UICorner.CornerRadius = theme.Round

	-- Top Bar
	local Top = Instance.new("Frame", Main)
	Top.Size = UDim2.new(1, 0, 0, 45)
	Top.BackgroundColor3 = theme.TopBar
	Top.BorderSizePixel = 0
	Top.Name = "TopBar"

	local Title = Instance.new("TextLabel", Top)
	Title.Text = config.Title or "NoxUI"
	Title.Size = UDim2.new(1, -20, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Font = theme.Font
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 20
	Title.TextXAlignment = Enum.TextXAlignment.Left

	-- Sidebar
	local Sidebar = Instance.new("Frame", Main)
	Sidebar.Size = UDim2.new(0, 140, 1, -45)
	Sidebar.Position = UDim2.new(0, 0, 0, 45)
	Sidebar.BackgroundColor3 = theme.Sidebar
	Sidebar.BorderSizePixel = 0
	Sidebar.Name = "Sidebar"

	local SidebarCorner = Instance.new("UICorner", Sidebar)
	SidebarCorner.CornerRadius = theme.Round

	-- Content Area
	local Content = Instance.new("Frame", Main)
	Content.Size = UDim2.new(1, -140, 1, -45)
	Content.Position = UDim2.new(0, 140, 0, 45)
	Content.BackgroundTransparency = 1
	Content.Name = "Content"

	-- Dragging
	local dragging, dragInput, dragStart, startPos
	Top.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = Main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	return setmetatable({
		Main = Main,
		Content = Content,
		Sidebar = Sidebar
	}, { __index = NoxUI })
end

function NoxUI:CreateButton(ui, text, callback)
	local Button = Instance.new("TextButton", ui.Content)
	Button.Size = UDim2.new(0, 200, 0, 40)
	Button.Position = UDim2.new(0, 20, 0, 20 + #ui.Content:GetChildren() * 50)
	Button.BackgroundColor3 = theme.Accent
	Button.Font = theme.Font
	Button.TextColor3 = Color3.new(1, 1, 1)
	Button.TextSize = 16
	Button.Text = text
	Button.AutoButtonColor = false

	local Corner = Instance.new("UICorner", Button)
	Corner.CornerRadius = theme.Round

	local function animate(color)
		TweenService:Create(Button, TweenInfo.new(0.15), { BackgroundColor3 = color }):Play()
	end

	Button.MouseEnter:Connect(function() animate(Color3.fromRGB(100, 120, 255)) end)
	Button.MouseLeave:Connect(function() animate(theme.Accent) end)
	Button.MouseButton1Click:Connect(callback)
end

return NoxUI
