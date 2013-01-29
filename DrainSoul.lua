-- Author(s)    : Murlocknoise & Crabnab (Ravencrest)
-- Version		: 1.2
-- Create Date 	: 1/22/2013

-----------------------------------------------------------

-- Global Variables
DrainSoul_UpdateInterval = 0.1; -- How often the OnUpdate function will run (in seconds)
DrainSoul_TargetPercent = 20;
DrainSoul_Spell = 'Drain Soul';

-- Functions
SLASH_DRAINSOUL1, SLASH_DRAINSOUL2 = '/ds', '/drainsoul';
local function handler(msg, editbox)
	if msg == '0' then
		DrainSoulFrame:Hide()
	elseif msg == '1' then
		DrainSoulFrame:Show()
	else
		print("/ds 1 -- Show DrainSoul window")
		print("/ds 0 -- Hide DrainSoul window")
	end
end
SlashCmdList["DRAINSOUL"] = handler;

function DrainSoul_OnLoad()
	FontString1:SetTextHeight(13)
	FontString2:SetTextHeight(10)
	DrainSoulFrame:SetAlpha(0.65)
end

function DrainSoul_TestHP()
	DrainSoul_TargetHP = UnitHealth("target");
	DrainSoul_TargetMax = UnitHealthMax("target");
	
	DrainSoul_TargetPercentage = ceil((DrainSoul_TargetHP / DrainSoul_TargetMax) * 100);
	if (DrainSoul_TargetPercentage <= DrainSoul_TargetPercent) then return true; else return false; end
end

function DrainSoul_OnUpdate(self, elapsed)
	self.TimeSinceLastUpdate = self.TimeSinceLastUpdate + elapsed;
	if (self.TimeSinceLastUpdate > DrainSoul_UpdateInterval) then
		DS_TargetName = UnitName("target");
		
		if UnitIsDeadOrGhost("target") then 
			FontString1:SetTextColor(1,0.82,0,1)
			FontString1:SetText("DEAD");
			FontString2:SetText("No Target");
		elseif UnitExists("target") then
			FontString1:SetText(ceil((UnitHealth("target")/UnitHealthMax("target")) * 100) .. "%");
			FontString2:SetText(UnitName("target"));
			if DrainSoul_TestHP() then
				ActionButton_ShowOverlayGlow(ActionButton8);
				FontString1:SetTextColor(1,0,0,1)
			else
				ActionButton_HideOverlayGlow(ActionButton8);
				FontString1:SetTextColor(1,0.82,0,1)
			end
		else 
			FontString1:SetText("---");
			FontString2:SetText("No Target");
		end
	end
end