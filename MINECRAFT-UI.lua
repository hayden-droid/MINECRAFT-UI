for _, v in pairs(game.CoreGui:GetChildren()) do
	if v.Name == "MinecraftUI" then
		v:Destroy()
	end
end

local MinecraftUI = Instance.new("ScreenGui")

MinecraftUI.Name = "MinecraftUI"
MinecraftUI.Parent = game.CoreGui

local function getNextWindowPos()
	local biggest = 0;
	local ok = nil;
	for i, v in pairs(MinecraftUI:GetChildren()) do
		if v.Position.X.Offset > biggest then
			biggest = v.Position.X.Offset
			ok = v;
		end
	end
	if biggest == 0 then
		biggest = biggest + 5;
	else
		biggest = biggest + ok.Size.X.Offset + 5;
	end
	
	return biggest;
end

local Library = {}

function Library:Window(title, color)
	color = color or Color3.fromRGB(72, 132, 107)
	local visible = true
	local Window = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local Body = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local Arrow = Instance.new("ImageButton")

	Window.Name = "Window"
	Window.Parent = MinecraftUI
	Window.BackgroundColor3 = color
	Window.BorderSizePixel = 0
	Window.Position = UDim2.new(0, getNextWindowPos() + 10, 0, 10)
	Window.Size = UDim2.new(0, 109, 0, 36)
	Window.ZIndex = 2
	Window.Active = true
	Window.Draggable = true

	Title.Name = "Title"
	Title.Parent = Window
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Size = UDim2.new(0.80733943, 0, 1, 0)
	Title.ZIndex = 2
	Title.Font = Enum.Font.SourceSans
	Title.Text = title
	Title.TextColor3 = Color3.fromRGB(244, 244, 244)
	Title.TextScaled = true
	Title.TextSize = 14.000
	Title.TextWrapped = true

	Body.Name = "Body"
	Body.Parent = Window
	Body.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Body.BackgroundTransparency = 1.000
	Body.Size = UDim2.new(1, 0, 1, 0)

	UIListLayout.Parent = Body
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	UIPadding.Parent = Body
	UIPadding.PaddingTop = UDim.new(0, 36)

	Arrow.Name = "Arrow"
	Arrow.Parent = Window
	Arrow.BackgroundTransparency = 1.000
	Arrow.Position = UDim2.new(0.816513717, 0, 0.21282047, 0)
	Arrow.Size = UDim2.new(0.176643878, 0, 0.527777791, 0)
	Arrow.ZIndex = 2
	Arrow.Image = "rbxassetid://3926305904"
	Arrow.ImageRectOffset = Vector2.new(924, 884)
	Arrow.ImageRectSize = Vector2.new(36, 36)
	Arrow.Rotation = 90

	Arrow.MouseButton1Down:connect(function()
		if visible == true then
			Body:TweenSize(UDim2.fromScale(1, 0))
			for _, v in pairs(Body:GetChildren()) do
				if v:IsA("Frame") then
					v:TweenSize(UDim2.new(1, 0, 0, 0))
				end
			end
			game:GetService("TweenService"):Create(Arrow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Rotation = 0
			}):Play();
			wait(0.7)
			Body.Visible = false
			visible = false
		else
			Body:TweenSize(UDim2.fromScale(1, 1))
			for _, v in pairs(Body:GetChildren()) do
				if v:IsA("Frame") then
					v:TweenSize(UDim2.new(1, 0, 0, 36))
				end
			end
			game:GetService("TweenService"):Create(Arrow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Rotation = 90
			}):Play();
			wait(0.1)
			Body.Visible = true
			wait(0.9)
			visible = true
		end
	end)

	local Lib = {}

	function Lib:Button(name, callback)
		local ButtonContainer = Instance.new("Frame")
		local Button = Instance.new("TextButton")

		ButtonContainer.Name = "ButtonContainer"
		ButtonContainer.Parent = Body
		ButtonContainer.BackgroundColor3 = Color3.fromRGB(47, 61, 87)
		ButtonContainer.BackgroundTransparency = 0.250
		ButtonContainer.BorderSizePixel = 0
		ButtonContainer.Size = UDim2.new(1, 0, 0, 36)

		Button.Name = "Button"
		Button.Parent = ButtonContainer
		Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Button.BackgroundTransparency = 1.000
		Button.Size = UDim2.new(1, 0, 1, 0)
		Button.Font = Enum.Font.SourceSans
		Button.Text = name
		Button.TextColor3 = Color3.fromRGB(174, 175, 176)
		Button.TextSize = 24.000

		Button.MouseButton1Down:connect(function()
			callback()
			ButtonContainer.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
		end)

		Button.MouseButton1Up:connect(function()
			ButtonContainer.BackgroundColor3 = Color3.fromRGB(47, 61, 87)
		end)

		Button.MouseEnter:Connect(function()
			ButtonContainer.BackgroundColor3 = Color3.fromRGB(68, 88, 126)
		end)

		Button.MouseLeave:connect(function()
			ButtonContainer.BackgroundColor3 = Color3.fromRGB(47, 61, 87)
		end)

	end

	function Lib:Toggle(name, callback)
		local Enabled = false
		local ToggleContainer = Instance.new("Frame")
		local Toggle = Instance.new("TextButton")
		local ToggleStatus = Instance.new("TextLabel")

		ToggleContainer.Name = "ToggleContainer"
		ToggleContainer.Parent = Body
		ToggleContainer.BackgroundColor3 = Color3.fromRGB(47, 61, 87)
		ToggleContainer.BackgroundTransparency = 0.250
		ToggleContainer.BorderSizePixel = 0
		ToggleContainer.Size = UDim2.new(1, 0, 0, 36)

		Toggle.Name = "Toggle"
		Toggle.Parent = ToggleContainer
		Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Toggle.BackgroundTransparency = 1.000
		Toggle.Size = UDim2.new(1, 0, 1, 0)
		Toggle.Font = Enum.Font.SourceSans
		Toggle.Text = " "..name
		Toggle.TextColor3 = Color3.fromRGB(174, 175, 176)
		Toggle.TextSize = 20.000
		Toggle.TextXAlignment = Enum.TextXAlignment.Left

		ToggleStatus.Name = "ToggleStatus"
		ToggleStatus.Parent = ToggleContainer
		ToggleStatus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleStatus.BackgroundTransparency = 1.000
		ToggleStatus.Position = UDim2.new(0.724770665, 0, 0.138888881, 0)
		ToggleStatus.Size = UDim2.new(0.27431193, 0, 0.694444418, 0)
		ToggleStatus.Font = Enum.Font.SourceSans
		ToggleStatus.Text = "Off"
		ToggleStatus.TextColor3 = Color3.fromRGB(193, 50, 52)
		ToggleStatus.TextSize = 18.000

		Toggle.MouseButton1Down:connect(function()
			Enabled =  not Enabled
			callback(Enabled)
			if Enabled == true then
				ToggleStatus.Text = "On"
				ToggleStatus.TextColor3 = Color3.fromRGB(74, 204, 78)
			else
				if Enabled == false then
					ToggleStatus.Text = "Off"
					ToggleStatus.TextColor3 = Color3.fromRGB(193, 50, 52)
				end
			end
		end)

		Toggle.MouseButton1Down:connect(function()
			callback()
			ToggleContainer.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
		end)

		Toggle.MouseButton1Up:connect(function()
			ToggleContainer.BackgroundColor3 = Color3.fromRGB(47, 61, 87)
		end)

		Toggle.MouseEnter:Connect(function()
			ToggleContainer.BackgroundColor3 = Color3.fromRGB(68, 88, 126)
		end)

		Toggle.MouseLeave:connect(function()
			ToggleContainer.BackgroundColor3 = Color3.fromRGB(47, 61, 87)
		end)

	end

	function Lib:Slider(name, min, max, start, callback)
		local dragging = false
		local SliderContainer = Instance.new("Frame")
		local SliderLabel = Instance.new("TextLabel")
		local SliderValue = Instance.new("TextLabel")
		local SliderBack = Instance.new("Frame")
		local Slider = Instance.new("Frame")

		SliderContainer.Name = "SliderContainer"
		SliderContainer.Parent = Body
		SliderContainer.BackgroundColor3 = Color3.fromRGB(47, 61, 87)
		SliderContainer.BackgroundTransparency = 0.250
		SliderContainer.BorderColor3 = Color3.fromRGB(27, 42, 53)
		SliderContainer.BorderSizePixel = 0
		SliderContainer.Size = UDim2.new(1, 0, 0, 36)

		SliderLabel.Name = "SliderLabel"
		SliderLabel.Parent = SliderContainer
		SliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderLabel.BackgroundTransparency = 1.000
		SliderLabel.Size = UDim2.new(0.577981651, 0, 0.638888896, 0)
		SliderLabel.Font = Enum.Font.SourceSans
		SliderLabel.Text = name
		SliderLabel.TextColor3 = Color3.fromRGB(174, 175, 176)
		SliderLabel.TextSize = 20.000

		SliderValue.Name = "SliderValue"
		SliderValue.Parent = SliderContainer
		SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderValue.BackgroundTransparency = 1.000
		SliderValue.Position = UDim2.new(0.587155938, 0, 0, 0)
		SliderValue.Size = UDim2.new(0.403669715, 0, 0.638888896, 0)
		SliderValue.Font = Enum.Font.SourceSans
		SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0);
		SliderValue.TextColor3 = Color3.fromRGB(174, 175, 176)
		SliderValue.TextSize = 20.000

		SliderBack.Name = "SliderBack"
		SliderBack.Parent = SliderContainer
		SliderBack.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderBack.BackgroundTransparency = 1.000
		SliderBack.Position = UDim2.new(0.0729999989, 0, 0.75, 0)
		SliderBack.Size = UDim2.new(0.852999985, 0, 0.0700000003, 0)

		Slider.Name = "Slider"
		Slider.Parent = SliderBack
		Slider.BackgroundColor3 = Color3.fromRGB(72, 132, 107)
		Slider.BorderSizePixel = 0
		Slider.Size = UDim2.new((start or 0) / max, 0, 1, 0);

		local function slide(input)
			local pos = UDim2.new(math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1), 0, 1, 0);
			Slider:TweenSize(pos, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true);
			local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min);
			SliderValue.Text = tostring(value);
			callback(value);
		end;

		SliderBack.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true;
			end;
		end);
	
		SliderBack.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false;
			end;
		end);
	
		SliderBack.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				slide(input);
			end;
		end);

		game:GetService("UserInputService").InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				slide(input);
			end;
		end);

	end

	return Lib;

end

return Library;
