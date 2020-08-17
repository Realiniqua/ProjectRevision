local FerocityManager = {}
FerocityManager.util = {} 
FerocityManager.Combo = {}
FerocityManager.menu = {}
FerocityManager.tar = nil 
function FerocityManager:setTarget(tar)
    if not tar then return end
    self.tar = tar
end



function FerocityManager:getStacks()
    return player.mana 
end

local spells = {["Q"] = 0 , ["W"] = 0 , ["E"] = 0}
local prioSpell
function FerocityManager:getEmpSpell(tar)
    if (player.health / player.maxHealth) < self.menu.ComboManager.W.health:get()  -- we prio that since youre useless if youre dead omegalul
    and self.Combo.W:getPercentageHeal() > self.menu.ComboManager.W.gain:get() and self.Combo.W:usable()
    then return "W" end
    if not tar then return end 
    local dist = player.pos:dist(tar)
    local prio = self.menu.ComboManager.prio:get()
    if prio == 1--[["Killing"]] then   spells.Q = spells.Q + 1 prioSpell = "Q"
    elseif prio == 2 --[["Survival"]] then spells.W = spells.W + 1 prioSpell = "W"
    elseif prio == 3 --[["Utility"]] then spells.W = spells.W + 1 prioSpell = "E"
    end

    if dist < self.Combo.Q.range + player:getAutoAttackRange(player) and self.Combo.Q:empCanKill(tar) and self.Combo.Q:usable() then  spells["Q"] = spells["Q"] + 1 end 

    

    if dist > player:getAutoAttackRange(player) + 350 and self.Combo.E:usable() then 
        spells["E"] = spells["E"] + 1
    end


    local bufferValue = 0 
    local res = nil
    for k, v in pairs(spells) do
       -- print("spell : " , k , " Value : " , v)
        if v > bufferValue then  
            bufferValue = v 
            res = k 
        end 
    end

    for k, v in pairs(spells) do
        if v == bufferValue then 
            if k == prioSpell then 
              res = k 
            end     
        end
    end
    spells = {["Q"] = 0 , ["W"] = 0 , ["E"] = 0}
    return res
end

return FerocityManager