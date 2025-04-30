local NoxUI = {}
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local function CreateInstance(class, props)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		inst[k] = v
	end
	return inst
end

local function Tween(obj, goal, time)
	TweenService:Create(obj, TweenInfo.new(time or 0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
end

function NoxUI:CreateWindow(title)
	local ScreenGui = CreateInstance("ScreenGui", { Name = "NoxUI", Parent = game:GetService("CoreGui"), ResetOnSpawn = false })
	local Shadow = CreateInstance("Frame", {
		BackgroundColor3 = Color3.fromRGB(30, 30, 30),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 500, 0, 320),
		Position = UDim2.new(0.5, -250, 0.5, -160),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = ScreenGui
	})

	local UICorner = CreateInstance("UICorner", { CornerRadius = UDim.new(0, 12), Parent = Shadow })
	local Title = CreateInstance("TextLabel", {
		Text = title or "Nox UI",
		Font = Enum.Font.GothamBold,
		TextSize = 20,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 40),
		Parent = Shadow
	})

	local TabHolder = CreateInstance("Frame", {
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 40),
		Size = UDim2.new(1, 0, 0, 30),
		Parent = Shadow
	})

	local Pages = CreateInstance("Frame", {
		Position = UDim2.new(0, 0, 0, 70),
		Size = UDim2.new(1, 0, 1, -70),
		BackgroundTransparency = 1,
		ClipsDescendants = true,
		Parent = Shadow
	})

	local tabs = {}

	function tabs:CreateTab(tabName)
		local TabButton = CreateInstance("TextButton", {
			Text = tabName,
			Font = Enum.Font.Gotham,
			TextSize = 16,
			TextColor3 = Color3.new(1, 1, 1),
			BackgroundColor3 = Color3.fromRGB(40, 40, 40),
			Size = UDim2.new(0, 100, 1, 0),
			Parent = TabHolder
		})
		local Page = CreateInstance("ScrollingFrame", {
			Visible = false,
			Size = UDim2.new(1, 0, 1, 0),
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ScrollBarThickness = 6,
			BackgroundTransparency = 1,
			Parent = Pages
		})

		local Layout = Instance.new("UIListLayout", Page)
		Layout.Padding = UDim.new(0, 6)
		Layout.SortOrder = Enum.SortOrder.LayoutOrder

		TabButton.MouseButton1Click:Connect(function()
			for _, child in ipairs(Pages:GetChildren()) do
				if child:IsA("ScrollingFrame") then child.Visible = false end
			end
			Page.Visible = true
		end)

		local elements = {}

		function elements:AddButton(text, callback)
			local btn = CreateInstance("TextButton", {
				Text = text,
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextColor3 = Color3.new(1, 1, 1),
				BackgroundColor3 = Color3.fromRGB(60, 60, 60),
				Size = UDim2.new(1, -10, 0, 30),
				Parent = Page
			})
			CreateInstance("UICorner", { CornerRadius = UDim.new(0, 6), Parent = btn })
			btn.MouseButton1Click:Connect(callback)
		end

		function elements:AddToggle(text, default, callback)
			local on = default or false
			local toggle = CreateInstance("TextButton", {
				Text = text .. ": OFF",
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextColor3 = Color3.new(1, 1, 1),
				BackgroundColor3 = Color3.fromRGB(60, 60, 60),
				Size = UDim2.new(1, -10, 0, 30),
				Parent = Page
			})
			CreateInstance("UICorner", { CornerRadius = UDim.new(0, 6), Parent = toggle })
			toggle.MouseButton1Click:Connect(function()
				on = not on
				toggle.Text = text .. ": " .. (on and "ON" or "OFF")
				if callback then callback(on) end
			end)
		end

		function elements:AddSlider(name, min, max, default, callback)
			local slider = CreateInstance("Frame", {
				BackgroundColor3 = Color3.fromRGB(60, 60, 60),
				Size = UDim2.new(1, -10, 0, 40),
				Parent = Page
			})
			CreateInstance("UICorner", { CornerRadius = UDim.new(0, 6), Parent = slider })

			local label = CreateInstance("TextLabel", {
				Text = name .. ": " .. tostring(default),
				Font = Enum.Font.Gotham,
				TextSize = 14,
				TextColor3 = Color3.new(1, 1, 1),
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 20),
				Parent = slider
			})

			local bar = CreateInstance("Frame", {
				BackgroundColor3 = Color3.fromRGB(100, 100, 100),
				Position = UDim2.new(0, 5, 0, 22),
				Size = UDim2.new(1, -10, 0, 10),
				Parent = slider
			})
			local fill = CreateInstance("Frame", {
				BackgroundColor3 = Color3.fromRGB(0, 150, 255),
				Size = UDim2.new((default - min)/(max - min), 0, 1, 0),
				Parent = bar
			})

			bar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					local conn
					conn = game:GetService("RunService").RenderStepped:Connect(function()
						local mouseX = game:GetService("UserInputService"):GetMouseLocation().X
						local rel = math.clamp((mouseX - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
						fill.Size = UDim2.new(rel, 0, 1, 0)
						local value = math.floor(min + (max - min) * rel)
						label.Text = name .. ": " .. tostring(value)
						if callback then callback(value) end
					end)
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							conn:Disconnect()
						end
					end)
				end
			end)
		end

		Page.Visible = #Pages:GetChildren() == 1
		return elements
	end

	return tabs
end

return NoxUI
