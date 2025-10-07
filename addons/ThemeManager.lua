local cloneref = (cloneref or clonereference or function(instance: any) return instance end)
local httpService = cloneref(game:GetService('HttpService'))
local httprequest = (syn and syn.request) or request or http_request or (http and http.request)
local getassetfunc = getcustomasset or getsynasset
local isfolder, isfile, listfiles = isfolder, isfile, listfiles;

if typeof(copyfunction) == "function" then
	-- Fix is_____ functions for shitsploits, those functions should never error, only return a boolean.

	local
	isfolder_copy,
	isfile_copy,
	listfiles_copy = copyfunction(isfolder), copyfunction(isfile), copyfunction(listfiles);

	local isfolder_success, isfolder_error = pcall(function()
		return isfolder_copy("test" .. tostring(math.random(1000000, 9999999)))
	end);

	if isfolder_success == false or typeof(isfolder_error) ~= "boolean" then
		isfolder = function(folder)
			local success, data = pcall(isfolder_copy, folder)
			return (if success then data else false)
		end;

		isfile = function(file)
			local success, data = pcall(isfile_copy, file)
			return (if success then data else false)
		end;

		listfiles = function(folder)
			local success, data = pcall(listfiles_copy, folder)
			return (if success then data else {})
		end;
	end
end

local ThemeManager = {} do
	ThemeManager.Folder = 'LinoriaLibSettings'
	-- if not isfolder(ThemeManager.Folder) then makefolder(ThemeManager.Folder) end

	ThemeManager.Library = nil
ThemeManager.BuiltInThemes = {
    ['Default']       = { 1,  httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1c1c1c","AccentColor":"0055ff","BackgroundColor":"141414","OutlineColor":"323232"}') },
    ['Aurora']        = { 2,  httpService:JSONDecode('{"FontColor":"e6eef3","MainColor":"202634","AccentColor":"6ad3ff","BackgroundColor":"151a24","OutlineColor":"2b3344"}') },
    ['Velvet Storm']  = { 3,  httpService:JSONDecode('{"FontColor":"efe9ff","MainColor":"221a2b","AccentColor":"9a6bff","BackgroundColor":"171223","OutlineColor":"372b45"}') },
    ['Tokyo Night']   = { 4,  httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"191925","AccentColor":"6759b3","BackgroundColor":"16161f","OutlineColor":"323232"}') },
    ['Oceanic Next']  = { 5,  httpService:JSONDecode('{"FontColor":"d8dee9","MainColor":"1b2b34","AccentColor":"6699cc","BackgroundColor":"16232a","OutlineColor":"343d46"}') },
    ['Obsidian']      = { 6,  httpService:JSONDecode('{"FontColor":"eaeaea","MainColor":"1b1b1f","AccentColor":"6f8cff","BackgroundColor":"141417","OutlineColor":"2f2f37"}') },
    ['Neon Glass']    = { 7,  httpService:JSONDecode('{"FontColor":"e6eef3","MainColor":"161a22","AccentColor":"3ddc84","BackgroundColor":"0f1317","OutlineColor":"2a303c"}') },
    ['Cobalt Edge']   = { 8,  httpService:JSONDecode('{"FontColor":"e8f0ff","MainColor":"1f2433","AccentColor":"3b82f6","BackgroundColor":"131827","OutlineColor":"2b3246"}') },
    ['Forest Mist']   = { 9,  httpService:JSONDecode('{"FontColor":"e9f7ef","MainColor":"1f2824","AccentColor":"4caf50","BackgroundColor":"141c18","OutlineColor":"2a352f"}') },
    ['Dracula']       = { 10, httpService:JSONDecode('{"FontColor":"f8f8f2","MainColor":"44475a","AccentColor":"ff79c6","BackgroundColor":"282a36","OutlineColor":"6272a4"}') },
    ['Quartz']        = { 11, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"232330","AccentColor":"426e87","BackgroundColor":"1d1b26","OutlineColor":"27232f"}') },
    ['Mauve Noir']    = { 12, httpService:JSONDecode('{"FontColor":"eee7f7","MainColor":"2a2430","AccentColor":"c39bd3","BackgroundColor":"1c1724","OutlineColor":"3a3342"}') },
    ['Gruvbox']       = { 13, httpService:JSONDecode('{"FontColor":"ebdbb2","MainColor":"3c3836","AccentColor":"fb4934","BackgroundColor":"282828","OutlineColor":"504945"}') },
    ['Catppuccin']    = { 14, httpService:JSONDecode('{"FontColor":"d9e0ee","MainColor":"302d41","AccentColor":"f5c2e7","BackgroundColor":"1e1e2e","OutlineColor":"575268"}') },
    ['Polar Night']   = { 15, httpService:JSONDecode('{"FontColor":"e6effa","MainColor":"212838","AccentColor":"8fb9ff","BackgroundColor":"171c28","OutlineColor":"2d3650"}') },
    ['Mint']          = { 16, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"242424","AccentColor":"3db488","BackgroundColor":"1c1c1c","OutlineColor":"373737"}') },
    ['Auric Ember']   = { 17, httpService:JSONDecode('{"FontColor":"fff6e5","MainColor":"2b241c","AccentColor":"ffb84a","BackgroundColor":"1a1611","OutlineColor":"3a3127"}') },
    ['Monokai']       = { 18, httpService:JSONDecode('{"FontColor":"f8f8f2","MainColor":"272822","AccentColor":"f92672","BackgroundColor":"1e1f1c","OutlineColor":"49483e"}') },
    ['Solarized']     = { 19, httpService:JSONDecode('{"FontColor":"839496","MainColor":"073642","AccentColor":"cb4b16","BackgroundColor":"002b36","OutlineColor":"586e75"}') },
    ['Cyberpunk']     = { 20, httpService:JSONDecode('{"FontColor":"f9f9f9","MainColor":"262335","AccentColor":"00ff9f","BackgroundColor":"1a1a2e","OutlineColor":"413c5e"}') },
    ['Teal Aura']     = { 21, httpService:JSONDecode('{"FontColor":"e8fbfb","MainColor":"1f2a2d","AccentColor":"2dd4bf","BackgroundColor":"131c1e","OutlineColor":"2b383c"}') },
    ['Midnight Mint'] = { 22, httpService:JSONDecode('{"FontColor":"dff7ea","MainColor":"1e2522","AccentColor":"45c49a","BackgroundColor":"131a17","OutlineColor":"2c3632"}') },
    ['Amber Dawn']    = { 23, httpService:JSONDecode('{"FontColor":"fff3d6","MainColor":"2b241c","AccentColor":"ffa62b","BackgroundColor":"1d1812","OutlineColor":"3a3127"}') },
    ['Nord']          = { 24, httpService:JSONDecode('{"FontColor":"eceff4","MainColor":"3b4252","AccentColor":"88c0d0","BackgroundColor":"2e3440","OutlineColor":"4c566a"}') },
    ['BBot']          = { 25, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1e1e","AccentColor":"7e48a3","BackgroundColor":"232323","OutlineColor":"141414"}') },
    ['Dusk Rose']     = { 26, httpService:JSONDecode('{"FontColor":"fff5f8","MainColor":"2a1f26","AccentColor":"ff6b8f","BackgroundColor":"1b1419","OutlineColor":"3a2c34"}') },
    ['Fatality']      = { 27, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"1e1842","AccentColor":"c50754","BackgroundColor":"191335","OutlineColor":"3c355d"}') },
    ['Jade Stone']    = { 28, httpService:JSONDecode('{"FontColor":"e8fff3","MainColor":"1f2a26","AccentColor":"2ecc71","BackgroundColor":"15201c","OutlineColor":"26332e"}') },
    ['One Dark']      = { 29, httpService:JSONDecode('{"FontColor":"abb2bf","MainColor":"282c34","AccentColor":"c678dd","BackgroundColor":"21252b","OutlineColor":"5c6370"}') },
    ['Ubuntu']        = { 30, httpService:JSONDecode('{"FontColor":"ffffff","MainColor":"3e3e3e","AccentColor":"e2581e","BackgroundColor":"323232","OutlineColor":"191919"}') },
    ['Material']      = { 31, httpService:JSONDecode('{"FontColor":"eeffff","MainColor":"212121","AccentColor":"82aaff","BackgroundColor":"151515","OutlineColor":"424242"}') },
    ['Crimson Void']  = { 32, httpService:JSONDecode('{"FontColor":"ffecec","MainColor":"2a1f23","AccentColor":"ef4444","BackgroundColor":"1a1417","OutlineColor":"3a2c31"}') },
    ['Slate Sky']     = { 33, httpService:JSONDecode('{"FontColor":"e6edf5","MainColor":"242a34","AccentColor":"7aa2f7","BackgroundColor":"171c24","OutlineColor":"313847"}') },
    ['Royal Velvet']  = { 34, httpService:JSONDecode('{"FontColor":"efe9ff","MainColor":"241b2f","AccentColor":"a276ff","BackgroundColor":"1a1426","OutlineColor":"3a2d47"}') },
    ['Indigo Wave']   = { 35, httpService:JSONDecode('{"FontColor":"eaf0ff","MainColor":"1b2030","AccentColor":"597aff","BackgroundColor":"121626","OutlineColor":"2a3248"}') },
    ['Copper Leaf']   = { 36, httpService:JSONDecode('{"FontColor":"ffeedd","MainColor":"2c231a","AccentColor":"d9822b","BackgroundColor":"19150f","OutlineColor":"3a2f23"}') },
    ['Orchid Dream']  = { 37, httpService:JSONDecode('{"FontColor":"f3e9ff","MainColor":"272033","AccentColor":"b784e7","BackgroundColor":"1a1526","OutlineColor":"3a2f4a"}') },
    ['Sapphire Flux'] = { 38, httpService:JSONDecode('{"FontColor":"eaf6ff","MainColor":"1a2432","AccentColor":"2aa7ff","BackgroundColor":"101822","OutlineColor":"2a3446"}') },
    ['Charcoal Lime'] = { 39, httpService:JSONDecode('{"FontColor":"eaffea","MainColor":"232a23","AccentColor":"78d35b","BackgroundColor":"151a15","OutlineColor":"2e382e"}') },
    ['Arctic Breeze'] = { 40, httpService:JSONDecode('{"FontColor":"e9f4ff","MainColor":"202a35","AccentColor":"8bd5ff","BackgroundColor":"141c24","OutlineColor":"2b3746"}') },
}


	function ApplyBackgroundVideo(videoLink)
		if
			typeof(videoLink) ~= "string" or
			not (getassetfunc and writefile and readfile and isfile) or
			not (ThemeManager.Library and ThemeManager.Library.InnerVideoBackground)
		then return; end;

		--// Variables \\--
		local videoInstance = ThemeManager.Library.InnerVideoBackground;
		local extension = videoLink:match(".*/(.-)?") or videoLink:match(".*/(.-)$"); extension = tostring(extension);
		local filename = string.sub(extension, 0, -6);
		local _, domain = videoLink:match("^(https?://)([^/]+)"); domain = tostring(domain); -- _ is protocol

		--// Check URL \\--
		if videoLink == "" then
			videoInstance:Pause();
			videoInstance.Video = "";
			videoInstance.Visible = false;
			return
		end
		if #extension > 5 and string.sub(extension, -5) ~= ".webm" then return; end;

		--// Fetch Video Data \\--
		local videoFile = ThemeManager.Folder .. "/themes/" .. string.gsub(domain .. filename, 0, 249) .. ".webm";
		if not isfile(videoFile) then
			local success, requestRes = pcall(httprequest, { Url = videoLink, Method = 'GET' })
			if not (success and typeof(requestRes) == "table" and typeof(requestRes.Body) == "string") then return; end;

			writefile(videoFile, requestRes.Body)
		end

		--// Play Video \\--
		videoInstance.Video = getassetfunc(videoFile);
		videoInstance.Visible = true;
		videoInstance:Play();
	end

	function ThemeManager:SetLibrary(library)
		self.Library = library
	end

	--// Folders \\--
	function ThemeManager:GetPaths()
		local paths = {}

		local parts = self.Folder:split('/')
		for idx = 1, #parts do
			paths[#paths + 1] = table.concat(parts, '/', 1, idx)
		end

		paths[#paths + 1] = self.Folder .. '/themes'

		return paths
	end

	function ThemeManager:BuildFolderTree()
		local paths = self:GetPaths()

		for i = 1, #paths do
			local str = paths[i]
			if isfolder(str) then continue end
			makefolder(str)
		end
	end

	function ThemeManager:CheckFolderTree()
		if isfolder(self.Folder) then return end
		self:BuildFolderTree()

		task.wait(0.1)
	end

	function ThemeManager:SetFolder(folder)
		self.Folder = folder;
		self:BuildFolderTree()
	end

	--// Apply, Update theme \\--
	function ThemeManager:ApplyTheme(theme)
		local customThemeData = self:GetCustomTheme(theme)
		local data = customThemeData or self.BuiltInThemes[theme]

		if not data then return end

		-- custom themes are just regular dictionaries instead of an array with { index, dictionary }
		if self.Library.InnerVideoBackground ~= nil then
			self.Library.InnerVideoBackground.Visible = false
		end

		local scheme = data[2]
		for idx, col in next, customThemeData or scheme do
			if idx == "VideoLink" then
				self.Library[idx] = col

				if self.Library.Options[idx] then
					self.Library.Options[idx]:SetValue(col)
				end

				ApplyBackgroundVideo(col)
			else
				self.Library[idx] = Color3.fromHex(col)

				if self.Library.Options[idx] then
					self.Library.Options[idx]:SetValueRGB(Color3.fromHex(col))
				end
			end
		end

		self:ThemeUpdate()
	end

	function ThemeManager:ThemeUpdate()
		-- This allows us to force apply themes without loading the themes tab :)
		if self.Library.InnerVideoBackground ~= nil then
			self.Library.InnerVideoBackground.Visible = false
		end

		local options = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "VideoLink" }
		for i, field in next, options do
			if self.Library.Options and self.Library.Options[field] then
				self.Library[field] = self.Library.Options[field].Value

				if field == "VideoLink" then
					ApplyBackgroundVideo(self.Library.Options[field].Value)
				end
			end
		end

		self.Library.AccentColorDark = self.Library:GetDarkerColor(self.Library.AccentColor);
		self.Library:UpdateColorsUsingRegistry()
	end

	--// Get, Load, Save, Delete, Refresh \\--
	function ThemeManager:GetCustomTheme(file)
		local path = self.Folder .. '/themes/' .. file .. '.json'
		if not isfile(path) then
			return nil
		end

		local data = readfile(path)
		local success, decoded = pcall(httpService.JSONDecode, httpService, data)

		if not success then
			return nil
		end

		return decoded
	end

	function ThemeManager:LoadDefault()
		local theme = 'Default'
		local content = isfile(self.Folder .. '/themes/default.txt') and readfile(self.Folder .. '/themes/default.txt')

		local isDefault = true
		if content then
			if self.BuiltInThemes[content] then
				theme = content
			elseif self:GetCustomTheme(content) then
				theme = content
				isDefault = false;
			end
		elseif self.BuiltInThemes["Default"] then
			theme = self.BuiltInThemes["Default"]
		end

		if isDefault then
			self.Library.Options.ThemeManager_ThemeList:SetValue(theme)
		else
			self:ApplyTheme(theme)
		end
	end

	function ThemeManager:SaveDefault(theme)
		writefile(self.Folder .. '/themes/default.txt', theme)
	end

	function ThemeManager:SaveCustomTheme(file)
		if file:gsub(' ', '') == '' then
			return self.Library:Notify('Invalid file name for theme (empty)', 3)
		end

		local theme = {}
		local fields = { "FontColor", "MainColor", "AccentColor", "BackgroundColor", "OutlineColor", "VideoLink" }

		for _, field in next, fields do
			if field == "VideoLink" then
				theme[field] = self.Library.Options[field].Value
			else
				theme[field] = self.Library.Options[field].Value:ToHex()
			end
		end

		writefile(self.Folder .. '/themes/' .. file .. '.json', httpService:JSONEncode(theme))
	end

	function ThemeManager:Delete(name)
		if (not name) then
			return false, 'no config file is selected'
		end

		local file = self.Folder .. '/themes/' .. name .. '.json'
		if not isfile(file) then return false, 'invalid file' end

		local success = pcall(delfile, file)
		if not success then return false, 'delete file error' end

		return true
	end

	function ThemeManager:ReloadCustomThemes()
		local list = listfiles(self.Folder .. '/themes')

		local out = {}
		for i = 1, #list do
			local file = list[i]
			if file:sub(-5) == '.json' then
				-- i hate this but it has to be done ...

				local pos = file:find('.json', 1, true)
				local start = pos

				local char = file:sub(pos, pos)
				while char ~= '/' and char ~= '\\' and char ~= '' do
					pos = pos - 1
					char = file:sub(pos, pos)
				end

				if char == '/' or char == '\\' then
					table.insert(out, file:sub(pos + 1, start - 1))
				end
			end
		end

		return out
	end

	--// GUI \\--
	function ThemeManager:CreateThemeManager(groupbox)
		groupbox:AddLabel('Background color'):AddColorPicker('BackgroundColor', { Default = self.Library.BackgroundColor });
		groupbox:AddLabel('Main color')	:AddColorPicker('MainColor', { Default = self.Library.MainColor });
		groupbox:AddLabel('Accent color'):AddColorPicker('AccentColor', { Default = self.Library.AccentColor });
		groupbox:AddLabel('Outline color'):AddColorPicker('OutlineColor', { Default = self.Library.OutlineColor });
		groupbox:AddLabel('Font color')	:AddColorPicker('FontColor', { Default = self.Library.FontColor });
		groupbox:AddInput('VideoLink', { Text = '.webm Video Background (Link)', Default = self.Library.VideoLink });

		local ThemesArray = {}
		for Name, Theme in next, self.BuiltInThemes do
			table.insert(ThemesArray, Name)
		end

		table.sort(ThemesArray, function(a, b) return self.BuiltInThemes[a][1] < self.BuiltInThemes[b][1] end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_ThemeList', { Text = 'Theme list', Values = ThemesArray, Default = 1 })
		groupbox:AddButton('Set as default', function()
			self:SaveDefault(self.Library.Options.ThemeManager_ThemeList.Value)
			self.Library:Notify(string.format('Set default theme to %q', self.Library.Options.ThemeManager_ThemeList.Value))
		end)

		self.Library.Options.ThemeManager_ThemeList:OnChanged(function()
			self:ApplyTheme(self.Library.Options.ThemeManager_ThemeList.Value)
		end)

		groupbox:AddDivider()

		groupbox:AddInput('ThemeManager_CustomThemeName', { Text = 'Custom theme name' })
		groupbox:AddButton('Create theme', function() 
			self:SaveCustomTheme(self.Library.Options.ThemeManager_CustomThemeName.Value)

			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		groupbox:AddDivider()

		groupbox:AddDropdown('ThemeManager_CustomThemeList', { Text = 'Custom themes', Values = self:ReloadCustomThemes(), AllowNull = true, Default = 1 })
		groupbox:AddButton('Load theme', function()
			local name = self.Library.Options.ThemeManager_CustomThemeList.Value

			if not name or string.len(name) < 1 then
				self.Library:Notify(string.format('No theme has been selected.'))
				return
			end
			self:ApplyTheme(name)
			self.Library:Notify(string.format('Loaded theme %q', name))
		end)
		groupbox:AddButton('Overwrite theme', function()
			local name = self.Library.Options.ThemeManager_CustomThemeList.Value

			if not name or string.len(name) < 1 then
				self.Library:Notify(string.format('No theme has been selected.'))
				return
			end
			self:SaveCustomTheme(name)
			self.Library:Notify(string.format('Overwrote config %q', name))
		end)
		groupbox:AddButton('Delete theme', function()
			local name = self.Library.Options.ThemeManager_CustomThemeList.Value

			if not name or string.len(name) < 1 then
				self.Library:Notify(string.format('No theme has been selected.'))
				return
			end
			local success, err = self:Delete(name)
			if not success then
				return self.Library:Notify('Failed to delete theme: ' .. err)
			end

			self.Library:Notify(string.format('Deleted theme %q', name))
			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)
		groupbox:AddButton('Refresh list', function()
			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)
		groupbox:AddButton('Set as default', function()
			local name = self.Library.Options.ThemeManager_CustomThemeList.Value
			if not name or string.len(name) < 1 then
				self.Library:Notify(string.format('No theme has been selected.'))
				return
			end
			if self.Library.Options.ThemeManager_CustomThemeList.Value ~= nil and self.Library.Options.ThemeManager_CustomThemeList.Value ~= '' then
				self:SaveDefault(self.Library.Options.ThemeManager_CustomThemeList.Value)
				self.Library:Notify(string.format('Set default theme to %q', self.Library.Options.ThemeManager_CustomThemeList.Value))
			end
		end)
		groupbox:AddButton('Reset default', function()
			local success = pcall(delfile, self.Folder .. '/themes/default.txt')
			if not success then 
				return self.Library:Notify('Failed to reset default: delete file error')
			end

			self.Library:Notify('Set default theme to nothing')
			self.Library.Options.ThemeManager_CustomThemeList:SetValues(self:ReloadCustomThemes())
			self.Library.Options.ThemeManager_CustomThemeList:SetValue(nil)
		end)

		

		local function UpdateTheme() self:ThemeUpdate() end
		self.Library.Options.BackgroundColor:OnChanged(UpdateTheme)
		self.Library.Options.MainColor:OnChanged(UpdateTheme)
		self.Library.Options.AccentColor:OnChanged(UpdateTheme)
		self.Library.Options.OutlineColor:OnChanged(UpdateTheme)
		self.Library.Options.FontColor:OnChanged(UpdateTheme)
		
		self:LoadDefault()
	end

	function ThemeManager:CreateGroupBox(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		return tab:AddLeftGroupbox('Themes')
	end

	function ThemeManager:ApplyToTab(tab)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		local groupbox = self:CreateGroupBox(tab)
		self:CreateThemeManager(groupbox)
	end

	function ThemeManager:ApplyToGroupbox(groupbox)
		assert(self.Library, 'Must set ThemeManager.Library first!')
		self:CreateThemeManager(groupbox)
	end

	ThemeManager:BuildFolderTree()
end

getgenv().LinoriaThemeManager = ThemeManager
return ThemeManager
