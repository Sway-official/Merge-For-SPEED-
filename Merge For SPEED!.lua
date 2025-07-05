local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local HttpService = game:GetService("HttpService")

-- Key + Discord Setup
local KEY = "Swaythegoat"
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local Settings = {
    KeySystem = true,
    Key = KEY,
    DiscordLink = "https://discord.gg/DQRsRa2Zqw",
    ScriptName = "Merge For SPEED!",
    FileName = "UniversalHubKeyFile"
}

if not isfolder(Settings.FileName) then
    makefolder(Settings.FileName)
end

local function SaveKey(key)
    writefile(Settings.FileName .. "/key.txt", key)
end

local function LoadSavedKey()
    if isfile(Settings.FileName .. "/key.txt") then
        return readfile(Settings.FileName .. "/key.txt")
    end
    return nil
end

local function ShowDiscordPrompt()
    Rayfield:Notify({
        Title = "Join the Discord",
        Content = "To get your key, join: " .. Settings.DiscordLink,
        Duration = 8,
        Image = 4483362458
    })
end

local function ValidateKey(input)
    return input == Settings.Key
end

-- UI Setup
local Window = Rayfield:CreateWindow({
    Name = Settings.ScriptName,
    LoadingTitle = "",
    LoadingSubtitle = "Loading UI...",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = Settings.FileName,
        FileName = "Config"
    },
    Discord = {
        Enabled = true,
        Invite = Settings.DiscordLink:match("discord.gg/(.+)"),
        RememberJoins = true
    },
    KeySystem = Settings.KeySystem,
    KeySettings = {
        Title = Settings.ScriptName,
        Subtitle = "Key System",
        Note = "https://discord.gg/DQRsRa2Zqw",
        FileName = Settings.FileName .. "_Key",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = Settings.Key
    }
})

-- Main Tab
local MainTab = Window:CreateTab("Main", 4483362458)

-- GetAllItemsFromWheel
MainTab:CreateButton({
    Name = "GetAllItemsFromWheel",
    Callback = function()
        for i = 1, 10 do
            local args = { i }
            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SpinWheelPrizeEvent"):FireServer(unpack(args))
            end)
            if not success then
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Item " .. i .. " failed: " .. tostring(err),
                    Duration = 3,
                    Image = 4483362458
                })
            end
            wait(0.2)
        end
    end
})

-- Get All Upgrades
MainTab:CreateButton({
    Name = "Get All Upgrades",
    Callback = function()
        Rayfield:Notify({
            Title = "Upgrading...",
            Content = "Sending UpgradeEvent calls...",
            Duration = 3,
            Image = 4483362458
        })

        local upgradeData = {
            { "SpawnRateLevel", 30, 0 },
            { "CashRateLevel", 30, 0 },
            { "AutoMergeLevel", 30, 0 },
            { "SpawnTierLevel", 95, 0 },
            { "MaxBlocksLevel", 30, 0 },
            { "LuckyMergeLevel", 30, 0 }
        }

        for _, upgrade in ipairs(upgradeData) do
            local success, err = pcall(function()
                game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UpgradeEvent"):FireServer(unpack(upgrade))
            end)
            if not success then
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Upgrade failed for " .. tostring(upgrade[1]) .. ": " .. tostring(err),
                    Duration = 4,
                    Image = 4483362458
                })
            end
            wait(0.2)
        end
    end
})

-- Get Spin
MainTab:CreateButton({
    Name = "Get Spin",
    Callback = function()
        local success, err = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("FreeSpinEvent"):FireServer()
        end)
        if not success then
            Rayfield:Notify({
                Title = "Error",
                Content = "FreeSpinEvent failed: " .. tostring(err),
                Duration = 4,
                Image = 4483362458
            })
        end
    end
})

-- InfiniteGems
MainTab:CreateButton({
    Name = "InfiniteGems",
    Callback = function()
        local args = { 9999999999999999999999999999 }
        local success, err = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("GemEvent"):FireServer(unpack(args))
        end)
        if not success then
            Rayfield:Notify({
                Title = "Error",
                Content = "GemEvent failed: " .. tostring(err),
                Duration = 4,
                Image = 4483362458
            })
        end
    end
})

-- Inf Money
MainTab:CreateButton({
    Name = "Inf Money",
    Callback = function()
        local args = { "Cash", 9999999999999999999999999999 }
        local success, err = pcall(function()
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("AddValueEvent"):FireServer(unpack(args))
        end)
        if not success then
            Rayfield:Notify({
                Title = "Error",
                Content = "AddValueEvent failed: " .. tostring(err),
                Duration = 4,
                Image = 4483362458
            })
        end
    end
})

-- Auto Rebirth Toggle
local AutoRebirthRunning = false

MainTab:CreateToggle({
    Name = "Auto Rebirth",
    CurrentValue = false,
    Callback = function(Value)
        AutoRebirthRunning = Value

        if AutoRebirthRunning then
            Rayfield:Notify({
                Title = "Auto Rebirth Enabled",
                Content = "Rebirthing every 0.5 seconds...",
                Duration = 4,
                Image = 4483362458
            })

            task.spawn(function()
                while AutoRebirthRunning do
                    local success, err = pcall(function()
                        local args = { 0, 0, 0 }
                        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RebirthConfirmEvent"):FireServer(unpack(args))
                    end)

                    if not success then
                        Rayfield:Notify({
                            Title = "Rebirth Error",
                            Content = tostring(err),
                            Duration = 4,
                            Image = 4483362458
                        })
                    end

                    wait(0.5)
                end
            end)
        else
            Rayfield:Notify({
                Title = "Auto Rebirth Disabled",
                Content = "Stopped rebirthing.",
                Duration = 3,
                Image = 4483362458
            })
        end
    end
})
