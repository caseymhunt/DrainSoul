-- Author(s)    : Murlocknoise & Crabnab (Ravencrest)
-- Version		: 1.2
-- Create Date 	: 1/22/2013

-----------------------------------------------------------

-- Global Variables
DrainSoul_UpdateInterval = 0.05; -- How often the OnUpdate function will run (in seconds)
DrainSoul_TriggerPercent = 20; -- At what percent (of target health) should we trigger?

-- Functions
SLASH_DRAINSOUL1, SLASH_DRAINSOUL2 = '/ds', '/drainsoul';
local function handler(msg, editbox)
	if msg == '0' then
		Frame1:Hide()
	elseif msg == '1' then
		Frame1:Show()
	else
		print("/ds 1 -- Show DrainSoul window")
		print("/ds 0 -- Hide DrainSoul window")
	end
end
SlashCmdList["DRAINSOUL"] = handler;


function DrainSoul_OnLoad()
	FontString1:SetTextHeight(13)
	FontString2:SetTextHeight(10)
	Frame1:SetAlpha(0.65)
end

function DrainSoul_OnUpdate(self, elapsed)	
	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
	
	if (self.TimeSinceLastUpdate > DrainSoul_UpdateInterval) then
		if (UnitHealth("target") == 0 or nil) then
			FontString1:SetText("---")
			FontString2:SetText("No Target")
		else
			FontString1:SetText( (ceil((UnitHealth("target")/UnitHealthMax("target"))) * 100 ) .. "%" )
			FontString2:SetText(UnitName("target"))
			if ( DrainSoul_IsPercent() ) then
				FontString1:SetTextColor(1,0,0,1)
				ActionButton_ShowOverlayGlow(ActionButton8)
			else
				FontString1:SetTextColor(1,0.82,0,1)
				ActionButton_HideOverlayGlow(ActionButton8)
			end
		end
	self.TimeSinceLastUpdate = 0;
	end
end

function DrainSoul_IsPercent ()
	return ( (ceil((UnitHealth("target")/UnitHealthMax("target"))) * 100 ) <= DrainSoul_TriggerPercent )
end

-- function DrainSoul_CalculateHealth ()
	-- ( ceil((UnitHealth("target")/UnitHealthMax("target"))) * 100 )
-- end