local orb = module.internal("orb")
local ts = module.internal("TS")


local ComboManager = {}
ComboManager.Q = module.load("ProjectRevision", "Rengar/Q")
ComboManager.W = module.load("ProjectRevision", "Rengar/W")
ComboManager.E = module.load("ProjectRevision", "Rengar/E")
ComboManager.R = module.load("ProjectRevision", "Rengar/R")
ComboManager.tar = nil
ComboManager.selected = false
ComboManager.Ferocity = {}

function ComboManager:makeMenu()
    self.menu:header("gfsitg", "General")
    self.menu:dropdown("prio", "Prioritize : ", 3, {"Killing", "Survival", "Utility"})
    self.menu:header("gfgfd", "Spells")
    self.Q:bindToMenu(self.menu)
    self.W:bindToMenu(self.menu)
    self.E:bindToMenu(self.menu)
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
    if dist > 1000 --[[idk what to put here for now its just a placeholder]] then
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
        if self.afterBurst then 
            if self.Q:use() and player:attack(tar) then 
                print("BURST DAT BITCH")
                self.afterBurst = false
                self.bursting = false
                self.selected = nil
            end
        end
        if not self.bursting and self.R:isActive() or self.R:isLeapActive() then 
            orb.core.set_pause_attack(0.1)
        end
        if self.R:isActive() or self.R:isLeapActive() then
          
            if not self.Q:isActive() then
                if player:isInAutoAttackRange(tar) then 
                    self.Q:use()
                end
                return 
            end
            self.bursting = true
            
            if player:attack(tar) then
                if self.E:use(tar.pos) and self.W:use() then -- add tiamat
                    self.afterBurst = true
                    return
                end
            end
        end
        
    end
end


function ComboManager:getUsableSpells(tar)
    local res = {}
    if not tar then return end 
    for _,v in pairs({self.Q,self.W,self.E}) do 
        if v:shouldUse(tar) then 
            res[#res+1] = v 
        end 
    end 
    return res 
end

function ComboManager:nextSpell()
   local stacks = self.Ferocity:getStacks()
    if not self.tar then
        return
    end
    if self:shouldBurst() then
        
        self:burstLogic(self.selected)
        
    elseif self.tar and not orb.core.is_paused() and stacks < 3 then 
        for _,v in pairs({self.Q,self.W,self.E}) do 
            --print( v.slot,"||||", v:shouldUse(self.tar))
            if v:usable() and v:shouldUse(self.tar) then
                if v.type == "pos" then 
                    local pos = v:getPos(self.tar)
                    v:use(pos)
                end
                v:use()
                orb.core.set_server_pause()
                if stacks == 3 then 
                    orb.core.set_pause(0.5)
                end
            end 
        end 
    end  
end

local QCancelAuto = function(lastTarget)
    if ComboManager.menu.Q.aaCancel:get() and orb.menu.combat.key:get() and lastTarget and lastTarget.isHero then
        if (player:spellState(SpellSlot.Q) == SpellState.Ready) then
            return ComboManager.Q:use()
        end
    end
end
cb.add(cb.after_attack, QCancelAuto)

return ComboManager
