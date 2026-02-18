--// LMR MOBILE (Delta Optimized) - Muscle Legends

if not game:IsLoaded() then
    game.Loaded:Wait()
end

repeat task.wait() until game.Players.LocalPlayer.Character

-- =========================
-- SERVICIOS
-- =========================
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
end)

-- =========================
-- UI LIB
-- =========================
local Lib = loadstring(game:HttpGet("https://pastebin.com/raw/GaRF4FDA"))()
local Main = Lib:Category("LMR Mobile")

-- =========================
-- VARIABLES GLOBALES
-- =========================
getgenv().LMR_Strength = false
getgenv().LMR_Rebirth = false
getgenv().LMR_Chests = false

-- =========================
-- FUNCIONES SEGURAS
-- =========================
local function EquipTrainingTools()
    if not Character then return end

    for _,v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") then
            if v.Name == "Handstands"
            or v.Name == "Situps"
            or v.Name == "Pushups"
            or v.Name == "Weight" then
                v.Parent = Character
            end
        end
    end
end

-- =========================
-- AUTO STRENGTH (ANTI LAG)
-- =========================
Main:Toggle("Auto Strength", function(state)
    getgenv().LMR_Strength = state

    task.spawn(function()
        while getgenv().LMR_Strength do
            task.wait(1.2) -- optimizado para móvil

            pcall(function()
                LocalPlayer.muscleEvent:FireServer("rep")
                EquipTrainingTools()
            end)
        end
    end)
end)

-- =========================
-- AUTO REBIRTH
-- =========================
Main:Toggle("Auto Rebirth", function(state)
    getgenv().LMR_Rebirth = state

    task.spawn(function()
        while getgenv().LMR_Rebirth do
            task.wait(0.6)

            pcall(function()
                ReplicatedStorage.rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            end)
        end
    end)
end)

-- =========================
-- AUTO CHESTS (LOW CPU)
-- =========================
local ChestList = {
    "Magma Chest",
    "Golden Chest",
    "Mythical Chest",
    "Enchanted Chest",
    "Legends Chest"
}

Main:Toggle("Auto Chests", function(state)
    getgenv().LMR_Chests = state

    task.spawn(function()
        while getgenv().LMR_Chests do
            task.wait(2)

            for _,chest in ipairs(ChestList) do
                pcall(function()
                    ReplicatedStorage.rEvents.checkChestRemote:InvokeServer(chest)
                end)
                task.wait(0.3)
            end
        end
    end)
end)

-- =========================
-- PLAYER MODS
-- =========================
Main:Slider("WalkSpeed",16,16,120,function(val)
    if Character and Character:FindFirstChild("Humanoid") then
        Character.Humanoid.WalkSpeed = val
    end
end)

Main:Slider("JumpPower",50,50,150,function(val)
    if Character and Character:FindFirstChild("Humanoid") then
        Character.Humanoid.JumpPower = val
    end
end)

-- =========================
-- SIZE SMALL
-- =========================
Main:Button("Turn Small",function()
    pcall(function()
        ReplicatedStorage.rEvents.changeSpeedSizeRemote:InvokeServer("changeSize",1)
    end)
end)

-- =========================
-- TELEPORTS (SEGUROS)
-- =========================
local TP = Lib:Category("LMR Teleports")

local function SafeTP(cf)
    if Character and Character:FindFirstChild("HumanoidRootPart") then
        Character.HumanoidRootPart.CFrame = cf
    end
end

TP:Button("Legends Gym",function()
    SafeTP(CFrame.new(4298.60,1121.89,-3898.68))
end)

TP:Button("Mythical Gym",function()
    SafeTP(CFrame.new(2386.89,139.60,1094.26))
end)

TP:Button("Frost Gym",function()
    SafeTP(CFrame.new(-2752.56,125.82,-386.73))
end)

TP:Button("Tiny Island",function()
    SafeTP(CFrame.new(-4.25,220.99,1963.60))
end)

print("✅ LMR MOBILE Loaded (Delta Ready)")
