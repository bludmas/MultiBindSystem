--[[
## MULTI-BIND SYSTEM ##
-> CREATED BY @WindowUser2

Copyright: MIT

Documentation: https://github.com/bludmas/MultiBindSystem

Version: 1.0.0

]]

--// MODULE

local SYSTEM = {
	__debug = false;
	__canbegameprocessed = false; -- HIGHLY RECOMMENDED TO SET THIS TO FALSE
}

SYSTEM.__index = SYSTEM

--// SERVICES

local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

--// VARIABLES

local locked, lock, Insert, FindArray = table.isfrozen, table.freeze, table.insert, table.find
local HandleDelay = task.delay
local DefaultSettings = {
	FunctionCallDelay = 0.05;
}

--// PRIVATE

local function Output(Func, Msg)
	local IsError = Func == error
	local PreMsg = IsError and "Multi-Bind error: " or "Multi-Bind: "

	if IsError or not IsError and SYSTEM.__debug then Func(PreMsg..Msg) end
end

local function CheckArray(Array: {any})
	local Valid = true

	for _, v in pairs(Array) do
		if v and typeof(v) == "EnumItem" and v.EnumType and v.EnumType == Enum.KeyCode then
			continue
		else
			Valid = false
		end
	end

	return Valid
end

local function CheckEverythingBehind(Table, Last)
	local i=0
	for _, v in pairs(Table) do
		i += 1
		if i >= Last then
			break
		end
		if v == false then return false else continue end
	end
	return true
end

local function Init(self)
	if self and not self._initialized and self._binds and self._triggered then
		self._initialized = true

		for _, v in pairs(self._binds) do
			if v and typeof(v) == "EnumItem" then
				local Name = v.Name
				if Name and not self._triggered[Name] then
					Insert(self._triggered, false)
					Insert(self._t2, Name)
				end
			end
		end

		self._max = #self._triggered+1

		UIS.InputBegan:Connect(function(input, gameProcessedEvent)
			if gameProcessedEvent and not SYSTEM.__canbegameprocessed or not self._enabled then return end

			if input and input.KeyCode then
				local Key = input.KeyCode
				local CanSet = false

				if self._current == 1 and FindArray(self._binds, Key) and FindArray(self._t2, Key.Name) then
					CanSet = true
				elseif self._current > 1 and FindArray(self._t2, Key.Name) and FindArray(self._binds, Key) and self._binds[self._current] == Key then
					local AllPreviousHeld = true
					for i = 1, self._current - 1 do
						if not self._triggered[i] or not UIS:IsKeyDown(self._binds[i]) then
							AllPreviousHeld = false
							break
						end
					end

					if AllPreviousHeld then
						local ET = CheckEverythingBehind(self._triggered, self._current)
						CanSet = ET
					end
				end

				if CanSet and self._current < self._max then
					if self._current < self._max then self._triggered[self._current] = true end
					self._current += 1

					if self._current >= self._max and self._cancall then
						self._cancall = false
						self._func()
						Output(print, "Call")
						for i = 1, self._max do
							if self._triggered[i] then
								self._triggered[i] = false
							end
						end
						self._current = 1
						HandleDelay(self._settings.FunctionCallDelay or 0.05, function()
							self._cancall = true
						end)
					end
				end
			end
		end)

		UIS.InputEnded:Connect(function(input, gameProcessedEvent)
			if gameProcessedEvent and not SYSTEM.__canbegameprocessed then return end
			if input and input.KeyCode and FindArray(self._t2, input.KeyCode.Name) and self._t2[self._current-1] == input.KeyCode.Name then
				Output(print, "Yes Removal")
				if self._current > 0 and self._current < self._max then self._triggered[self._current-1] = false end
				self._current -= 1
				if self._current < 1 then
					self._current = 1
				end
			end
		end)
	end
end

local function CheckSetting(Table)
	for n, v in pairs(Table) do
		if not Table[n] then
			return false
		end
	end

	return true
end

--// PUBLIC

--[[
    Constructor for Multi-Bind.

    See Documentation: https://github.com/bludmas/MultiBindSystem
]]
function SYSTEM.new(Binds: {Enum.KeyCode}, Func, NewSettings: {any})
	if not Binds or not CheckArray(Binds) then
		Output(error, "Invalid/Unexistent table!")
		return
	elseif not Func or type(Func) ~= "function" then
		Output(error, "Invalid Function.")
		return
	elseif not RunService:IsClient() then
		Output(error, "This must be running client-side to work.")
		return
	elseif NewSettings and not CheckSetting(NewSettings) then
		Output(error, "Invalid Settings.")
		return
	end

	local self = setmetatable({
		_binds = Binds;
		_triggered = {};
		_t2 = {};
		_func = Func;
		_cancall = true;

		_enabled = false;
		_initialized = false;

		_settings = NewSettings or DefaultSettings;

		_current = 1;
	}, SYSTEM)

	Init(self)

	return self
end

--[[
    Enable the multi-bind system.
]]
function SYSTEM:Enable()
	if self then
		self._enabled = true
	else
		Output(warn, "No self found, did you use the constructor?")
	end
end

--[[
    Disable the multi-bind system.
]]
function SYSTEM:Disable()
	if self then
		self._enabled = false
	else
		Output(warn, "No self found, did you use the constructor?")
	end
end

--// RETURN

return locked(SYSTEM) and SYSTEM or lock(SYSTEM)
