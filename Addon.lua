-- Addon.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 8/29/2018, 2:31:42 PM

local Addon = {}

function Addon:OnLoad()
    self:SetSize(128, 128)
    self:SetPoint('CENTER', 0, 250)
    self:Hide()
    -- self:SetAlpha(0.6)

    self.unit = 'player'
    self.powerType = Enum.PowerType.HolyPower
    self.coords = {
        [1] = {0, 0.25, 0, 0.5},
        [2] = {0.25, 0.5, 0, 0.5},
        [3] = {0.5, 0.75, 0, 0.5},
        [4] = {0.75, 1, 0, 0.5},
        [5] = {0, 0.25, 0.5, 1}
    }

    self.texture = self:CreateTexture(nil, 'OVERLAY')
    self.texture:SetAllPoints(self)
    self.texture:SetTexture([[Interface\AddOns\tdHolyPower\HolyPower.blp]])

    self:SetScript('OnEvent', self.OnEvent)

    self:RegisterUnitEvent('UNIT_POWER_FREQUENT', self.unit)
    self:RegisterEvent('UNIT_DISPLAYPOWER')
    self:UpdatePower()
end

function Addon:OnEvent(event, ...)
    if event == 'UNIT_POWER_FREQUENT' then
        local unit, powerType = ...
        if unit ~= self.unit then
            return
        end
    end
    self:UpdatePower()
end

function Addon:UpdatePower()
    local power = UnitPower(self.unit, self.powerType)
    if not self.coords[power] then
        self:Hide()
    else
        self:Show()
        self.texture:SetTexCoord(unpack(self.coords[power]))
    end
end

Mixin(CreateFrame('Frame', nil, UIParent, 'SpellActivationOverlayTemplate'), Addon):OnLoad()
