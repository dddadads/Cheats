local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local Button = Instance.new("TextButton")
Button.Parent = ScreenGui
Button.Size = UDim2.new(0, 200, 0, 50)
Button.Position = UDim2.new(0.5, -100, 0.9, 0) -- центр внизу экрана
Button.Text = "🔴 Сделать все Part красными"
Button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
Button.TextColor3 = Color3.new(1, 1, 1)
Button.Font = Enum.Font.SourceSansBold
Button.TextSize = 20

local function MakeAllPartsRed()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("BasePart") then
			obj.Color = Color3.fromRGB(255, 0, 0)
		end
	end
	warn("✅ Все Part стали красными (локально)!")
end

Button.MouseButton1Click:Connect(MakeAllPartsRed)
