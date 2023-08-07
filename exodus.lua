--[Message to Users]--

-- Script updated to 1.0.7


--[Library Prerequisites]--
for _,v in next, game:GetService("CoreGui"):GetChildren() do
	if v.Name == "ScreenGui" then
		v:Destroy()
	end
end

if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game:GetService("AssetService") then
	local PlaceList = {}
	for _,v in next, game:GetService("AssetService"):GetGamePlacesAsync():GetCurrentPage() do
		table.insert(PlaceList, v.PlaceId)
	end
	if not table.find(PlaceList, 4752917845) then
		return
	end
else
	return game:GetService("Players").LocalPlayer:Kick("Error: AssetService")
end

for _,v in next, getconnections(game:GetService("Players").LocalPlayer.Idled) do
	v:Disable()
end

function GetExploit()
	local Exploit =
		(syn and not is_sirhurt_closure and not pebcexectue and "Synapse X") or
		(secure_load and "Sirhurt") or
		(pebcexectue and "ProtoSmasher") or
		(KNRL_LOADED and "Krnl") or
		(isvm and "Proxo") or
		(OXYGEN_LOADED and "Oxygen") or
		("Unknown")
	return Exploit
end

local function Reverse(i)
	local Name = i:gsub("_", " "):split(" 1")[1]

	local LowerCased = {}

	for e,r in next, Name:split(" ") do
		if tonumber(r) then
			LowerCased = Name:split(" ")
			break
		end
		table.insert(LowerCased, (string.gsub(r, "^%u", function(str) return string.lower(str) end)))
	end

	return table.concat(LowerCased, "_")
end

local function AddComma(amount)
	local Formatted = amount
	local k
	while true do  
		Formatted, k = string.gsub(Formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return Formatted
end

--[Library]--

local Repository = "https://raw.githubusercontent.com/QuantumPsyche/Libraries/main/"

local Library = loadstring(game:HttpGet(Repository .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(Repository .. "Addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(Repository .. "Addons/SaveManager.lua"))()

local ScriptVersion = "4.2.1"
local LastUpdate = "the day!!"
local Game = "Reroll.gg | System Sexodus | " .. ScriptVersion .. " | practisedd ur pin sucks"

--[Locals]--

local HttpService = game:GetService("HttpService")
local Request = syn and syn.request or request
local LocalPlayer = game:GetService("Players").LocalPlayer
local Remotes = game:GetService("ReplicatedStorage").Remotes
local Events = game:GetService("ReplicatedFirst").Client.Events
local Data = LocalPlayer.Data
local Main = LocalPlayer.PlayerGui.UserInterface.Main
local Holder = Main.Windows.Settings.Settings.Holder
local Skins = Data.Inventory.Skins


--[Module Scripts]--

local CasesModule = require(game:GetService("ReplicatedStorage").Modules.Cases)

--[Tables]--

local CasesTable = {}
local CaseRowsTable = {}
local RarityTable = {}
local BlacklistTable = {}

for i,v in next, CasesModule do
	local Name = i:gsub("_", " "):split(" 1")[1]

	local UpperCased = {}

	for _,a in next, Name:split(" ") do
		table.insert(UpperCased, (string.gsub(a, "^%l", function(str) return string.upper(str) end)))
	end

	if v[8] or i == "booster_case" then
		table.insert(CasesTable, table.concat(UpperCased, " "))
	end
end

table.sort(CasesTable, function(a,b)
	return CasesModule[Reverse(a)][1] > CasesModule[Reverse(b)][1]
end)

for _,v in next, Skins:GetChildren() do
	table.insert(RarityTable, v.Name)
end

for i = 1, Remotes.GetCaseAmount:InvokeServer() do
	table.insert(CaseRowsTable, i)
end

--[UI]--

local Window = Library:CreateWindow({
	Title = Game,
	Center = true,
	AutoShow = true
})


local HomeTab = Window:AddTab("Home")
local MainTab = Window:AddTab("Main")
local SettingsTab = Window:AddTab("Settings")
local CreditsTab = Window:AddTab("Credits")

local CasesGroup = MainTab:AddLeftGroupbox("Case Opening")
local CaseInfoGroup = MainTab:AddRightGroupbox("Case Information")
local RarityGroup = MainTab:AddRightGroupbox("Rarities")

local InformationGroup = HomeTab:AddLeftGroupbox("Information")
local ChangelogsGroup = HomeTab:AddRightGroupbox("Changelogs")
local MusicGroup = HomeTab:AddLeftGroupbox("Music Toggle")

local MenuGroup = SettingsTab:AddLeftGroupbox("Menu")
local DeveloperGroup = CreditsTab:AddLeftGroupbox("Developers")
local UILibraryGroup = CreditsTab:AddRightGroupbox("UI Library")
local SponserGroup = CreditsTab:AddRightGroupbox("Sponsers")
--[]--

CasesGroup:AddToggle("BuyCase", {
	Text = "Buy Cases",
	default = false
})

CasesGroup:AddToggle("OpenCase", {
	Text = "Open Cases",
	default = false
})

CasesGroup:AddToggle("SellSkins", {
	Text = "Sell Skins",
	default = false
})

CasesGroup:AddDivider()

CasesGroup:AddDropdown("CaseSelection", {
	Text = "Case Selection",
	Values = CasesTable,
	Default = "Breakout Case",
	Multi = false
})

CasesGroup:AddDropdown("AmountSelection", {
	Text = "Case Amount Selection",
	Values = CaseRowsTable,
	Default = 3,
	Multi = false
})

CasesGroup:AddDropdown("BlacklistSelection", {
	Text = "Sell Blacklist Selection",
	Values = RarityTable,
	Default = {"Melee", "Valentine", "Unobtainable", "Diamond", "Gold", "Silver", "Bronze", "Contraband"},
	Multi = true
})

--[Extra UI]--

Library:SetWatermarkVisibility(true)
Library:SetWatermark("System Exodus | Reroll.gg | " .. ScriptVersion)

Library.KeybindFrame.Visible = false;

MenuGroup:AddButton("Unload", function()
	Library:Unload()
end)

MenuGroup:AddLabel("Menu Bind"):AddKeyPicker("MenuKeybind", {
	Text = "Meny Keybind",
	Default = "RightShift",
	NoUI = true
})

Library.ToggleKeybind = Options.MenuKeybind

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes({
	"Menu Keybind"
})

ThemeManager:SetFolder("SystemExodus")
SaveManager:SetFolder("SystemExodus/Reroll.gg")

SaveManager:BuildConfigSection(SettingsTab)
ThemeManager:ApplyToTab(SettingsTab)

--[]--

local CaseCost = 0
local CasesLeft = 0
local KeysLeft = 0
pcall(function()
	CasesLeft = Data.Inventory.Cases[Reverse(Options.CaseSelection.Value)].Value
	KeysLeft = Data.Inventory["Case Keys"][Reverse(Options.CaseSelection.Value) .. "_key"].Value
end)
local CasesOpened = 0
local StartBalance = Data.Balance.Value
local Profit = 0

local CasesLeftLabel = CaseInfoGroup:AddLabel("Cases Left: " .. AddComma(CasesLeft))
local KeysLeftLabel = CaseInfoGroup:AddLabel("Keys Left: " .. AddComma(KeysLeft))

local CasesOpenedLabel = CaseInfoGroup:AddLabel("Cases Opened: " .. AddComma(CasesOpened)) -- if type(Remotes.OpenCase:InvokeServer(args)) then CasesOpened += 1 end

CaseInfoGroup:AddDivider()

local CaseCostLabel = CaseInfoGroup:AddLabel("Case Cost: B$" .. AddComma(CaseCost))
local ProfitLabel = CaseInfoGroup:AddLabel("Session Profit: B$" .. AddComma(Profit))

local sound = Instance.new("Sound")
sound.Parent = workspace
sound.SoundId = "rbxassetid://1840684208"

sound.Looped = true;
sound:Play();
sound.Volume = 0.5;

--[]--

RarityGroup:AddLabel("Consumer", false, Color3.fromRGB(145, 145, 145))
RarityGroup:AddLabel("Industrial", false, Color3.fromRGB(153, 204, 255))
RarityGroup:AddLabel("Mil-Spec", false, Color3.fromRGB(17, 85, 221))
RarityGroup:AddLabel("Restricted", false, Color3.fromRGB(136, 71, 255))
RarityGroup:AddLabel("Classified", false, Color3.fromRGB(211, 44, 230))
RarityGroup:AddLabel("Covert", false, Color3.fromRGB(235, 75, 75))
RarityGroup:AddLabel("Valentine", false, Color3.fromRGB(255, 52, 140))
RarityGroup:AddLabel("Melee", false, Color3.fromRGB(202, 171, 5))
RarityGroup:AddLabel("Contraband", false, Color3.fromRGB(202, 110, 4))
RarityGroup:AddLabel("Bronze", false, Color3.fromRGB(147, 68, 0))
RarityGroup:AddLabel("Silver", false, Color3.fromRGB(149, 149, 149))
RarityGroup:AddLabel("Gold", false, Color3.fromRGB(181, 132, 8))
RarityGroup:AddLabel("Diamond", false, Color3.fromRGB(16, 175, 206))
RarityGroup:AddLabel("Unobtainable", false, Color3.fromRGB(15, 15, 15))

--[Credits]--
MusicGroup:AddToggle("MusicToggle", {
	Text = "Music OFF/ON",
	default = true
})

InformationGroup:AddLabel("Executor: " .. GetExploit())
InformationGroup:AddLabel("Premium: Yes")
InformationGroup:AddLabel("Script Version: " .. ScriptVersion)
InformationGroup:AddLabel("Last Updated: " .. LastUpdate)

ChangelogsGroup:AddLabel("[+] Added Case Information", false, Color3.fromRGB(0, 255, 0))
ChangelogsGroup:AddLabel("[/] Moved to a UI Library")
ChangelogsGroup:AddLabel("[/] Improved Performance")
ChangelogsGroup:AddDivider()
ChangelogsGroup:AddLabel("[+] Added Rarity Refrence", false, Color3.fromRGB(0, 255, 0))
ChangelogsGroup:AddLabel("[/] Fixed Buy Cases")
ChangelogsGroup:AddLabel("[/] Fixed Blacklist Defaults")
ChangelogsGroup:AddDivider()
ChangelogsGroup:AddLabel("[+] Added Booster Case Opening", false, Color3.fromRGB(0, 255, 0))
ChangelogsGroup:AddLabel("[/] Increased Opening Speed")
ChangelogsGroup:AddLabel("[/] Added Color")
ChangelogsGroup:AddLabel("[/] Updated UI Library")
ChangelogsGroup:AddDivider()
ChangelogsGroup:AddLabel("[-] Removed Claim Presents", false, Color3.fromRGB(255, 0, 0))
ChangelogsGroup:AddDivider()
ChangelogsGroup:AddLabel("[/] Fixed Script (Thx Alyssa <3)")
ChangelogsGroup:AddDivider()
ChangelogsGroup:AddLabel("[+] Now Premium Only", false, Color3.fromRGB(0, 255, 0))
ChangelogsGroup:AddLabel("[/] UI Improvements")
ChangelogsGroup:AddLabel("[/] Small Trading Menu Bug Fixes")
ChangelogsGroup:AddLabel("[-] Removed Useless UI Features", false, Color3.fromRGB(255, 0, 0))

DeveloperGroup:AddLabel("Created By: Quantum & Alyssa")
DeveloperGroup:AddButton("Join Discord", function()
	Request {
		["Url"] = "http://127.0.0.1:6463/rpc?v=1",
		["Method"] = "POST",
		["Headers"] = {
			["Content-Type"] = "application/json",
			["Origin"] = "https://discord.com"
		},
		["Body"] = HttpService:JSONEncode {
			["cmd"] = "INVITE_BROWSER",
			["nonce"] = ".",
			["args"] = { code = "kwWvWaU5uj" }
		}
	};
end)
DeveloperGroup:AddButton("Copy Discord Link", function()
	setclipboard("https://discord.gg/kwWvWaU5uj")
end)

DeveloperGroup:AddDivider()

DeveloperGroup:AddLabel("Discord: Quantum#0005")
DeveloperGroup:AddLabel("Discord (Don't DM): alyssa#2303")

UILibraryGroup:AddLabel("Created By: Inori")
UILibraryGroup:AddDivider()
UILibraryGroup:AddLabel("Maintained By: Wally")
UILibraryGroup:AddLabel("Edited By: Quantum")

SponserGroup:AddLabel("Sponsered By: Lumos Stunt Drone")
SponserGroup:AddLabel("Sponsered By: IHeartRadio")

--[Functions]--

Events.SettingEdited:Fire("BareMode", Holder.ButtonList.BareMode)

local OldCaseCost
local OldCasesLeft
local OldKeysLeft
local OldProfit

CaseCost = CasesModule[Reverse(Options.CaseSelection.Value)][1]
CasesLeft = (Data.Inventory.Cases:FindFirstChild(Reverse(Options.CaseSelection.Value)) and Data.Inventory.Cases:FindFirstChild(Reverse(Options.CaseSelection.Value)).Value) or 0
KeysLeft = (Data.Inventory["Case Keys"]:FindFirstChild(Reverse(Options.CaseSelection.Value).."_key") and Data.Inventory["Case Keys"]:FindFirstChild(Reverse(Options.CaseSelection.Value).."_key").Value) or 0
Profit = Data.Balance.Value - StartBalance

task.spawn(function()
	repeat task.wait() until Options and Options.CaseSelection and Options.CaseSelection.Value

	while task.wait() do
		CaseCost = CasesModule[Reverse(Options.CaseSelection.Value)][1]
		if CaseCost ~= OldCaseCost then
			CaseCostLabel:SetText("Case Cost: B$" .. AddComma(CaseCost))
			OldCaseCost = CaseCost
		end

		CasesLeft = (Data.Inventory.Cases:FindFirstChild(Reverse(Options.CaseSelection.Value)) and Data.Inventory.Cases:FindFirstChild(Reverse(Options.CaseSelection.Value)).Value) or 0
		if CasesLeft ~= OldCasesLeft then
			CasesLeftLabel:SetText("Cases Left: " .. AddComma(CasesLeft))
			OldCasesLeft = CasesLeft
		end

		KeysLeft = (Data.Inventory["Case Keys"]:FindFirstChild(Reverse(Options.CaseSelection.Value).."_key") and Data.Inventory["Case Keys"]:FindFirstChild(Reverse(Options.CaseSelection.Value).."_key").Value) or 0
		if KeysLeft ~= OldKeysLeft then
			KeysLeftLabel:SetText("Keys Left: " .. AddComma(KeysLeft))
			OldKeysLeft = KeysLeft
		end

		Profit = Data.Balance.Value - StartBalance
		if Profit ~= OldProfit then
			ProfitLabel:SetText("Session Profit: B$" .. AddComma(Profit))
			OldProfit = Profit
		end

		for _,v in next, Options.BlacklistSelection.Value do
			if not table.find(BlacklistTable, _) then
				table.insert(BlacklistTable, _)
			end
		end

		for _,v in next, BlacklistTable do
			if not Options.BlacklistSelection.Value[v] then
				table.remove(BlacklistTable, table.find(BlacklistTable, v))
			end
		end

		local CurrentSetting = Holder.ButtonList.BareMode.Text
		local SelectedOption = true
		local WantedSetting = tostring(SelectedOption)..")"

		if not CurrentSetting:find(WantedSetting) then
			game:GetService("ReplicatedFirst").Client.Events.SettingEdited:Fire("BareMode", Holder.ButtonList.BareMode)
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if Toggles.BuyCase.Value then
			local CaseName = Reverse(Options.CaseSelection.Value)

			if not Data.Inventory.Cases:FindFirstChild(CaseName) then
				for i = 1, Options.AmountSelection.Value do
					Remotes.BuyCase:FireServer(CaseName)
					Remotes.BuyKey:FireServer(CaseName)
				end
				task.wait(1)
			end
		end
	end
end)

task.spawn(function()
	while task.wait() do
		if Toggles.OpenCase.Value then
			local CaseName = Reverse(Options.CaseSelection.Value)

			if Data.Inventory.Cases:FindFirstChild(CaseName) then
				local Open = Remotes.OpenCase:InvokeServer(CaseName, Options.AmountSelection.Value)
				if Open and type(Open) == "table" then
					CasesOpened = CasesOpened + Options.AmountSelection.Value
					CasesOpenedLabel:SetText("Cases Opened: " .. AddComma(CasesOpened))
					Data.Experience.Changed:Wait()
				end
			end
		end
	end
end)
task.spawn(function()
	while task.wait() do
		if Toggles.MusicToggle.Value then
			game.Workspace.Sound.Volume = 0.5
		else
			game.Workspace.Sound.Volume = 0
		end
	end
end)

Toggles.SellSkins:OnChanged(function()
	if Toggles.SellSkins.Value then
		local SkinsFound = 0

		while task.wait() do
			for _,v in next, Skins:GetDescendants() do
				if v:IsA("NumberValue") and not table.find(BlacklistTable, v.Parent.Name) then
					Remotes.SellSkin:FireServer(v.Name, "Factory New")
					SkinsFound = SkinsFound + 1
				end
			end

			if SkinsFound == 0 then
				break
			end

			SkinsFound = 0
		end
	end
end)

for _,v in next, Skins:GetChildren() do
	if not table.find(BlacklistTable, v.Name) then
		v.ChildAdded:Connect(function(Child)
			if Toggles.SellSkins.Value and not table.find(BlacklistTable, v.Name) then
				repeat
					Remotes.SellSkin:FireServer(v:FindFirstChildOfClass("NumberValue").Name, "Factory New")
					task.wait()
				until #v:GetChildren() == 0
			end
		end)
	end
end


