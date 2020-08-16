local FerocityManager = {}
FerocityManager.util = {} 
FerocityManager.Combo = {}
FerocityManager.menu = nil
FerocityManager.tar = nil 
function FerocityManager:setTarget(tar)
    if not tar then return end
    self.tar = tar
end

function FerocityManager:getStacks()
    return player.mana 
end

local spells = {["Q"] = 0 , ["W"] = 0 , ["E"] = 0}
function FerocityManager:getEmpSpell(tar)
    if not tar then return end 
    
    if self.menu.ComboManager.prio == "Killing" then   spells["Q"] = spells["Q"] + 1
        elseif self.menu.ComboManager.prio == "Survival" then spells["W"] = spells["W"] + 1
        elseif self.menu.ComboManager.prio == "Utility" then spells["E"] = spells["E"] + 1
    end

    if self.Combo:canKillWithBurst(tar) then  spells["Q"] = spells["Q"] + 1 end 

    if (player.health / player.maxHealth) < self.menu.ComboManager.W.health:get() 
    and (self.Combo.W:getHeal() / player.maxHealth) < self.menu.ComboManager.W.gain:get() 
    then spells["W"] = spells["W"] + 1 end

    table.sort(spells)
    local res = spells[#spells]
    spells = {["Q"] = 0 , ["W"] = 0 , ["E"] = 0}
    return res
end

return FerocityManager