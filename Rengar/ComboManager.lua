local orb = module.internal("orb")
local ts = module.internal("TS")
local Ferocity = module.load("ProjectRevision" , "Rengar/FerocityManager")
local ComboManager = {}
ComboManager.tar = nil
ComboManager.selected = false
ComboManager.Q = module.load("ProjectRevision", "Rengar/Q")
ComboManager.W = module.load("ProjectRevision", "Rengar/W")
ComboManager.E = module.load("ProjectRevision", "Rengar/E")
ComboManager.R = module.load("ProjectRevision", "Rengar/R")

function ComboManager:makeMenu()
    self.menu:header("gfsitg", "General")
    self.menu:dropdown("prio", "Prioritize : ", 3, {"Killing", "Survival", "Utility"})
    self.menu:header("gfgfd", "Spells")
    self.Q:bindToMenu(self.menu)
    self.W:bindToMenu(self.menu)
    self.menu:header("hjfs", "Target Selector")
    self.menu:boolean("swapTarget", "prio empowered E and Swap Target", false)
    self.menu:menu("ts", "More Targetselector settings")
    self.menu.ts:header("hjgfdfs", "Swapping conditions")
    self.menu.ts:boolean("killable", "if killable with Q-EW(tiamat)", false)
    self.menu.ts:slider("extraAAs", "^add extra auto attacks", 1, 0, 3, 1)
end

function ComboManager:bindToMenu(menu)
    self.menu = menu:menu("ComboManager", "Advanced Settings")
    if (self.makeMenu) then
        self:makeMenu()
    end
    return self
end

function ComboManager:getBurstDmg(tar)
    local res = 0
    res = res + self.Q:dmg(tar) + self.Q:empDmg(tar) + self.E:dmg(tar) + self.W:dmg(tar)
    return res
end

function ComboManager:canKillWithBurst(tar)
    if not tar then
        return false
    end
    return self:getBurstDmg(tar) > tar.health
end

ComboManager.filter = function(res, tar, dist)
    if game.selectedTarget and game.selectedTarget.ptr == tar.ptr then
        res.obj = tar
        ComboManager.selected = tar
        return true
    end
    if dist > 500 --[[idk what to put here for now its just a placeholder]] then
        return false
    end

    res.obj = tar
    ComboManager.selected = nil
end

local getTar = ts.get_result
function ComboManager:updateTarget()
    local res = getTar(self.filter)
    if res.obj then
        self.tar = res.obj
    end
end

function ComboManager:shouldBurst()
    if self.selected then
        return self.selected
    else
        return false
    end
end

ComboManager.bursting = false
ComboManager.afterBurst = false
function ComboManager:burstLogic(tar)
    if tar then
        if not self.afterBurst and self.R:activated() then
            if not self.bursting then
                orb.core.set_pause_attack(1)
            end
            if player:isInAutoAttackRange(tar) and self.Q:use() then
                self.bursting = true
                if player:attack(tar) then
                    if self.W:use() and self.E:use() then
                        self.afterBurst = true
                    end
                end
            end
        elseif self.afterBurst then
            local empSpell = Ferocity:getEmpSpell()
            if empSpell then 
                empSpell:use(tar)
            end
        end
    end
end

function ComboManager:nextSpell()
    if not self.tar then
        return
    end
    if self:shouldBurst() then
        self:burstLogic(self.tar)
    end
end

local QCancelAuto = function(last_target)
    if ComboManager.menu.Q.aaCancel:get() and orb.menu.combat.key:get() and last_target and last_target.isHero then
        if (player:spellState(SpellSlot.Q) == SpellState.Ready) then
            return ComboManager.Q:use()
        end
    end
end
cb.add(cb.after_attack, QCancelAuto)

return ComboManager
