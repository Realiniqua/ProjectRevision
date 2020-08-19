local orb = module.internal("orb")
local ts = module.internal("TS")

local ComboManager = {}
ComboManager.Q = module.load("ProjectRevision", "Rengar/Q")
ComboManager.W = module.load("ProjectRevision", "Rengar/W")
ComboManager.E = module.load("ProjectRevision", "Rengar/E")
ComboManager.R = module.load("ProjectRevision", "Rengar/R")
ComboManager.tar = nil
ComboManager.canLeap = false
ComboManager.selected = false
ComboManager.Ferocity = {}

function ComboManager:makeMenu()
    self.menu:header("gfsitg", "General")
    self.menu:dropdown("prio", "Prioritize : ", 1, {"Killing", "Survival", "Utility"})
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
    local res = getTar(self.filter,false,true)
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
ComboManager.canLeap = false
ComboManager.QActive = false

function ComboManager:confirmedW(tar)
    if player.pos:dist(tar) < self.W.range and self.Ferocity:getStacks() < 4 then 
        self.W:use()
        return true 
    end 
    return false
end

function ComboManager:burstLogic(tar)
    if tar then
        self.canLeap = self.R:isActive() or self.R:isLeapActive()
        self.QActive = self.Q:isActive()
        ::finisher:: --huheuehuehuehuehue spaghetti ueheuheuhuehuehuheuhueuehue

        --[[if self.bursting then                           -- i personally dont think its needed
            if self:confirmedW(tar) then 
                self.bursting = false
            else 
                return 
            end
        end]]

        if self.afterBurst then
            if self.Q:use() and player:attack(tar) then
                print("Burst Complete")
                self.afterBurst = false
                self.bursting = false
                self.selected = nil
            end
        elseif not self.afterBurst then
            

            self.canLeap = self.R:isActive() or self.R:isLeapActive()
            if not self.bursting and self.canLeap then
                orb.core.set_pause_attack(0.1)
            end
            if self.canLeap then
                if not self.QActive then
                    if player:isInAutoAttackRange(tar) then
                        self.Q:use()
                        print("Activated First Q")
                        self.QActive  = true 
                        
                    end
                    return
                end
                self.bursting = true

                if player:attack(tar) and self.QActive then
                    print("Leaping")
                    if self.E:use(tar.pos) and self.W:use() then -- add tiamat
                        print("Bursting... ")
                        self.afterBurst = true
                        goto finisher
                    end
                end
            end
        end
    end
end

function ComboManager:getUsableSpells(tar)
    local res = {}
    if not tar then
        return
    end
    for _, v in pairs({self.Q, self.W, self.E}) do
        if v:shouldUse(tar) then
            res[#res + 1] = v
        end
    end
    return res
end
local stacks
ComboManager.blockTillNextCast = false
function ComboManager:nextSpell()
    stacks = self.Ferocity:getStacks()
    if not self.tar then
        return
    end
    if self:shouldBurst() then
        self:burstLogic(self.selected)
    elseif not self.blockTillNextCast and self.tar and not orb.core.is_paused() and stacks < 4 then
        for _, v in pairs({self.Q, self.W, self.E}) do
            if v:usable() and v:shouldUse(self.tar) then
                stacks = self.Ferocity:getStacks()
                if stacks >= 4 then 
                    self.blockTillNextCast = true 
                end 
                if v.type == "pos" then
                    local pos = v:getPos(self.tar)
                    v:use(pos)
                else
                    v:use()
                end
                orb.core.set_server_pause()
            end
        end
    elseif self.tar and stacks == 4 then 
       local spell = self.Ferocity:getEmpSpell(self.tar)
       if spell then 
            if self[spell].type == "pos" then 
                local pos = self[spell]:getPos(self.tar)
                if pos then self[spell]:use(pos) return end 
            else
                self[spell]:use() 
                
            end
            self.blockTillNextCast = false
        end 
    end
end

local QCancelAuto = function(lastTarget)
    if ComboManager.menu.Q.aaCancel:get() and ComboManager.Ferocity:getStacks() < 4 and orb.menu.combat.key:get() and lastTarget and lastTarget.isHero then
        if (player:spellState(SpellSlot.Q) == SpellState.Ready) then
            return ComboManager.Q:use()
        end
    end
end
cb.add(cb.after_attack, QCancelAuto)

return ComboManager
