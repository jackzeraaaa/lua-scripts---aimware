-- auto max processing time by Jack_#6821
local fps_checker = gui.Slider( gui.Reference('Ragebot', 'Hitscan', 'Performance'), "rbot.hitscan.automaxprocessingtime", "FPS Checker", 50, 10, 144)
local manualvalues = gui.Checkbox( gui.Reference('Ragebot', 'Hitscan', 'Performance'), "rbot.hitscan.manualprocessingtime", "Manual Values", false )
local min_processing = gui.Slider( gui.Reference('Ragebot', 'Hitscan', 'Performance'), "rbot.hitscan.minvalueprocessingtime", "Minimum Processing Time", 25, 5, 75)
local max_processing = gui.Slider( gui.Reference('Ragebot', 'Hitscan', 'Performance'), "rbot.hitscan.maxvalueprocessingtime", "Maximum Processing Time", 75, 5, 75)

local frame_rate = 0.0
local absolutefps = function()
    frame_rate = 0.9 * frame_rate + (1.0 - 0.9) * globals.AbsoluteFrameTime()
    return math.floor((1.0 / frame_rate) + 0.5)
end
callbacks.Register("Draw", function()
	if absolutefps()<=fps_checker:GetValue() then
		gui.SetValue("rbot.hitscan.maxprocessingtime", min_processing:GetValue())
	elseif absolutefps()>fps_checker:GetValue() then
		gui.SetValue("rbot.hitscan.maxprocessingtime", max_processing:GetValue())
	end
	if manualvalues:GetValue() then
		max_processing:SetInvisible(0)
		min_processing:SetInvisible(0)
	else
		max_processing:SetInvisible(1)
		min_processing:SetInvisible(1)
	end
end
)