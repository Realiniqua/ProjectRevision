local orb = module.internal("orb")
local ts = module.internal("TS")
local pred = module.internal("pred")
local dmg = module.internal("damage")

local Q = {}
Q.range = 25
Q.slot = SpellSlot.Q 
Q.type = "self"
Q.tar = nil 
Q.forceTarget = false

Q.filter = function (res, tar, dist)
    if dist > Q.range + player.attackRange then return false end
    res.obj = tar
end

function Q:makeMenu()
    self.menu:header("hjfs","Combo")
    self.menu:boolean("ks", "Use to KS")
    self.menu:boolean("aaCancel", "Use AA Cancel")
end

function Q:bindToMenu(menu)
    self.slotname = ({"W","E","R",[0]="Q"})[self.slot]
    self.menu = menu:menu(self.slotname, self.slotname)
    if (self.makeMenu) then
        self:makeMenu()
    end
    return self
end



function Q:dmg(tar)
    local res = 0
    if player:spellSlot(self.slot).state ~= SpellState.Ready then return res end
    res = dmg.spell(player,tar,self.slot) + dmg.autoattack(player,tar,false)
    return res
end

function Q:canKill(tar)
    if Q:dmg(tar) > tar.health then return true end 
    return false 
end
function Q:usable()
    if player:spellSlot(self.slot).state ~= SpellState.Ready then return false end
    return true
end

function Q:use()
    player:castSpell(self.type,self.slot)
end

function Q:shouldUse(tar)
    if not player:isInAutoAttackRange(tar,300) then return false end
    if self:canKill(tar) then return true end
   -- if orb.core.can_spell_after_attack() then return true end  -- Add to a new cunction (Use AA Cancel)
    return false
end

local QCancleAuto = function(last_target)
    if (last_target and last_target.isHero and player:isInAutoAttackRange(last_target, 25+player.attackRange)) then
        if (player:spellState(SpellSlot.Q) == SpellState.Ready) then
            return player:castSpell("self", SpellSlot.Q) 
        end
    end
end
cb.add(cb.after_attack, QCancleAuto)

local countTick = 0
function Q:onTick()
    local tar = self:updateTarget()
if not tar then return false end 
if self:shouldUse(tar) and self:use() then return true end 
if countTick % 15 == 0 then  -- reset target every half second
    self.tar = nil 
end
end

function Q:updateTarget()
    local res = ts.get_result(Q.filter)
    if res.obj then self.tar = res.obj end
    return res.obj
end

return Q