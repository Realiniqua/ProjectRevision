local orb = module.internal("orb")
local ts = module.internal("TS")
local pred = module.internal("pred")
local dmg = module.internal("damage")

local E = {}
E.range = 1000
E.slot = SpellSlot.E
E.type = 'pos'
E.tar = nil 
E.forceTarget = false


E.pred = {}
    E.range = 1000
    E.delay = 0.25
    E.speed = 1500
    E.width = 140
    E.collision = {
    wall = true,
    hero = true,
    minion = true,
}



E.filter = function (res, tar, dist)
if dist > E.range then return false end
res.obj = tar
end

function E:makeMenu()
    self.menu:header("Combat", "Combo")
    self.menu:boolean("ks", "Use To KS", true)
    self.menu:boolean("gapclose","gapcloses", true)

end

function E:bindToMenu(menu)
    self.slotname = ({"W","E","R",[0]="Q"})[self.slot]
    self.menu = menu:menu(self.slotname, self.slotname)
    if (self.makeMenu) then
        self:makeMenu()
    end
    return self
end

function E:dmg(tar)
    local res = 0
    if player:spellSlot(self.slot).state ~= SpellState.Ready then return res end
    res = res + dmg.spell(player,tar,self.slot)
    return res
end

function E:canKill(tar)
    if E:dmg(tar) > tar.health then return true 
    else return false end 
end

function E:usable()
    if player:spellSlot(self.slot).state ~= SpellState.Ready then return false end
return true
end

function E:getPos(tar)
    local seg = pred.linear.get_prediction(E.pred, tar)
     if seg.endPos then return seg.endPos end 
   end
function E:use(pos)
    if pos then 
        if player:castSpell(self.type,self.slot,pos) then return true end 
    end 
    return false
end

function E:shouldUse(tar)
    local dist = player.pos:dist(tar.pos)
    if dist > self.range then return false end
    if self.menu.ks:get() and self:canKill(tar) then return true end
    if self.menu.gapclose:get() and dist <= self.range and dist > player.attackRange + player.boundingRadius and player.pos:dist(tar.pathEndPos) > dist then return true end
    return false 
end

local countTick = 0
function E:onTick()
    local tar = self:updateTarget()
if not tar then return false end 
if self:shouldUse(tar) and self:use() then return true end 
if countTick % 15 == 0 then  -- reset target every half second
    self.tar = nil 
end
end

function E:updateTarget()
    local res = ts.get_result(self.filter)
    if res.obj then self.tar = res.obj end
    return res.obj
end

return E
