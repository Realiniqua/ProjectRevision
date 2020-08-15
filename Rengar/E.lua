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

E.filter = function (res, tar, dist)
if dist > E.range then return false end
res.obj = tar
end

function E:makeMenu()
    self.menu:header("Combat", "Combo")
    self.menu:boolean("Ks", "Use To KS", false)
    self.menu:boolean("gapclose","gapclose1", false)

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
if player:spellSlot(self.slot) ~= SPellState.Ready then return false end
res = dmg.spell(player,tar,self.slot) 
return res
end

function E:canKill(tar)
if E:dmg(tar) > tar.health then return true end
return false
end

function E:usable()
if player:spellSlot(self.slot).state ~= SpellState.Ready then return false end
return true
end

function E:use(pos)
    player:castSpell(self.type,self.slot,pos)
end

function E:shouldUse(tar)
if player.pos:dist(tar.pos) >= 726 and ~menu.gapclose:get() then return false end
if self:canKill(tar)  and menu.Ks:get() then return true end
if player.pos:dist(tar.pos) <= E.range  then return true end
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
