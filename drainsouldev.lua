--[[

  ]]--

local DS_ButtonPrefix = "ActionButton"
local DSFrame = CreateFrame("Frame", "DSFrame", UIParent)
DSFrame:SetScript("OnUpdate", function(self, elapsed) 
	if ( DS_IsTwentyPercent() ) then
		DS_Glow('Drain Soul')
	else
		DS_Dim('Drain Soul')
	end
end)
function DS_IsTwentyPercent()
	return ( (UnitHealth("target") / UnitHealthMax("target")) <= 0.2 )
end
function DS_Glow(spell)
	for i = 1, 72 do
		local btn = _G[DS_ButtonPrefix .. i];
		if ( btn ~= nil ) then 
			if ( DS_Triggers(i, spell) ) then 
				ActionButton_ShowOverlayGlow(btn)
			end 
		end
	end
	ActionButton_ShowOverlayGlow(ActionButton8)
end
function DS_Dim(spell)
	for i = 1, 72 do
		local btn = _G[DS_ButtonPrefix .. i];
		if ( btn ~= nil ) then if ( DS_Triggers(i, spell) ) then ActionButton_HideOverlayGlow(btn) end end
	end
end
function DS_Triggers(id, ability)
	local button = _G[DS_ButtonPrefix .. id];
	local a_type, a_id, _ = GetActionInfo(id)
	if ( a_type == 'spell' ) then
		local s_name = select(1, GetSpellInfo(a_id))
		-- local s_name, _, _, _, _, _, _, _, _ = GetSpellInfo(a_id)
		return ( s_name == ability )
	end
	return false
end
