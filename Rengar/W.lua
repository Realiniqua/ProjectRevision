local orb = module.internal("orb")
local ts = module.internal("TS")
local pred = module.internal("pred")
local dmg = module.internal("damage")

local W = {}
W.range = 450 + player.boundingRadius
W.slot = SpellSlot.W
W.type = "self"
W.tar = nil

W.filter = function (res, tar, dist)
if dist > W.range then return false end
res.obj = tar
end


function W:makeMenu()
    self.menu:header("W_combo","Combo")
    self.menu:boolean("ks", "Use to KS", false)
    self.menu:slider("Health", "Use  under X% HP",40,0,100,1)
    self.menu:slider("Gain", "Use if HP gain is over X% HP",10,0,100,1)
end


function W:bindToMenu(menu)
    self.slotname = ({"W","E","R",[0]="Q"})[self.slot]
    self.menu = menu:menu(self.slotname, self.slotname)
    if (self.makeMenu) then
        self:makeMenu()
    end
    return self;
end



function W:dmg(tar)
    local res = 0
if player:spellSlot(self.slot).state ~= SpellState.Ready then return res end
res = res + dmg.spell(player,tar,self.slot)
return res
end

function W:canKill(tar)
if W:dmg(tar) > tar.health then return true end
return false
end

function W:getPercentageHeal()
    return (100 - ((dmg.predict(player,1.5)/player.maxHealth) * 100))
end

function W:usable()
    if player:spellSlot(self.slot).state ~= SpellState.Ready then return false end
    return true
end

function W:use()
    if player:castSpell(self.type,self.slot) then return true end
end

function W:shouldUse(tar)
    local dist = player.pos:dist(tar.pos)
    if dist > self.range then return false end
    if self.menu.ks:get() and self:canKill(tar) then return true end 
    return false
end

local countTick = 0
function W:onTick()
    local tar = self:updateTarget()
if not tar then return false end 
if self:shouldUse(tar) and self:use() then return true end 
if countTick % 15 == 0 then  -- reset target every half second
    self.tar = nil 
end
end

function W:updateTarget()
    local res = ts.get_result(self.filter)
    if res.obj then self.tar = res.obj end
    return res.obj
end

return W