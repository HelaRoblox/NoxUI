local NoxUI = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function create(class, props)
	local inst = Instance.new(class)
	for prop, val in pairs(props) do
		inst[prop] = val
	end
	return inst
end

local function tween(obj, goal, time)
	TweenService:Create(obj, TweenInfo.new(time or 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
end

function NoxUI:CreateWindow(windowTitle)
	local gui = create("ScreenGui", {
		Name = "NoxUI",
		ResetOnSpawn = false,
		Parent = game:GetService("CoreGui"),
	})

	local main = create("Frame", {
		Size = UDim2.new(0, 540, 0, 350),
		Position = UDim2.new(0.5, -270, 0.5, -175),
		BackgroundColor3 = Color3.fromRGB(245, 245, 255),
		BorderSizePixel = 0,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = gui,
	})
	create("UICorner", { CornerRadius = UDim.new(0, 16), Parent = main })
	create("UIStroke", { ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Thickness = 1, Color = Color3.fromRGB(220, 220, 230), Parent = main })

	local header = create("TextLabel", {
		Text = windowTitle or "NoxUI",
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = Color3.fromRGB(60, 60, 90),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 40),
		Parent = main
	})

	local tabHolder = create("Frame", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 30),
		Position = UDim2.new(0, 0, 0, 45),
		Parent = main
	})

	local tabLayout = create("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 8),
		Parent = tabHolder
	})

	local contentFrame = create("Frame", {
		Size = UDim2.new(1, -20, 1, -90),
		Position = UDim2.new(0, 10, 0, 80),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = main
	})

	local pages = {}
	local activePage = nil

	local api = {}

	function api:CreateTab(name)
		local button = create("TextButton", {
			Text = name,
			Size = UDim2.new(0, 100, 1, 0),
			BackgroundColor3 = Color3.fromRGB(230, 230, 255),
			TextColor3 = Color3.fromRGB(70, 70, 90),
			Font = Enum.Font.GothamMedium,
			TextSize = 14,
			AutoButtonColor = false,
			Parent = tabHolder,
		})
		create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = button })

		local page = create("ScrollingFrame", {
			Visible = false,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 1, 0),
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 4,
			Parent = contentFrame
		})

		local layout = create("UIListLayout", {
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
			Parent = page
		})

		button.MouseButton1Click:Connect(function()
			if activePage then activePage.Visible = false end
			page.Visible = true
			activePage = page
		end)

		if not activePage then
			page.Visible = true
			activePage = page
		end

		local elements = {}

		function elements:AddButton(text, callback)
			local btn = create("TextButton", {
				Text = text,
				Size = UDim2.new(1, -10, 0, 32),
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextColor3 = Color3.fromRGB(50, 50, 80),
				BackgroundColor3 = Color3.fromRGB(215, 230, 255),
				Parent = page
			})
			create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = btn })
			btn.MouseButton1Click:Connect(callback)
		end

		function elements:AddToggle(text, default, callback)
			local toggle = create("TextButton", {
				Text = text .. ": OFF",
				Size = UDim2.new(1, -10, 0, 32),
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextColor3 = Color3.fromRGB(50, 50, 80),
				BackgroundColor3 = Color3.fromRGB(230, 230, 255),
				Parent = page
			})
			create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = toggle })

			local state = default or false
			toggle.MouseButton1Click:Connect(function()
				state = not state
				toggle.Text = text .. ": " .. (state and "ON" or "OFF")
				if callback then callback(state) end
			end)
		end

		function elements:AddDropdown(name, items, callback)
			local open = false
			local selected = items[1]

			local container = create("Frame", {
				Size = UDim2.new(1, -10, 0, 32),
				BackgroundColor3 = Color3.fromRGB(225, 230, 255),
				Parent = page
			})
			create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = container })

			local label = create("TextButton", {
				Text = name .. ": " .. selected,
				Size = UDim2.new(1, 0, 1, 0),
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextColor3 = Color3.fromRGB(50, 50, 80),
				BackgroundTransparency = 1,
				Parent = container
			})

			local dropdown = create("Frame", {
				BackgroundColor3 = Color3.fromRGB(240, 245, 255),
				Position = UDim2.new(0, 0, 1, 4),
				Size = UDim2.new(1, 0, 0, 0),
				Visible = false,
				Parent = container
			})
			create("UICorner", { CornerRadius = UDim.new(0, 8), Parent = dropdown })

			for _, item in ipairs(items) do
				local option = create("TextButton", {
					Text = item,
					Font = Enum.Font.Gotham,
					TextSize = 14,
					TextColor3 = Color3.fromRGB(50, 50, 80),
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundColor3 = Color3.fromRGB(240, 245, 255),
					Parent = dropdown
				})
				option.MouseButton1Click:Connect(function()
					selected = item
					label.Text = name .. ": " .. item
					dropdown.Visible = false
					dropdown.Size = UDim2.new(1, 0, 0, 0)
					open = false
					if callback then callback(item) end
				end)
			end

			label.MouseButton1Click:Connect(function()
				open = not open
				dropdown.Visible = open
				tween(dropdown, { Size = open and UDim2.new(1, 0, 0, #items * 30 + 5) or UDim2.new(1, 0, 0, 0) }, 0.25)
			end)
		end

		page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
		end)

		return elements
	end

	return api
end

return NoxUI
