local dmg = module.internal("damage")
local utility = {}
utility.summs = {}

--local aaRangeSqr = player.attackRange * player.attackRange
local sFind = string.find 


function utility:BindToMenu(menu)
    self.menu = menu:menu("iLLUtility", "iLLUtility")
    self.menu:header("gdfsg", "Damage calculation")
    self.menu:slider("includedAAs", "Include X AA's", 1, 0, 10, 1)
end

utility.additionalDmgFuncs = {}
function utility:addExtraDmgCalcFunction(f)
    self.additionalDmgFuncs[#self.additionalDmgFuncs + 1] = f
end

utility.blackListedSpells = {} -- needed for spells like Rengar Q where you need a "special" calculation
function utility:addBlackList(spellslot)
    utility.blackListSpell[spellslot] = true
end

function utility:getAADmg(n, tar)
    if n == 0 then
        return 0
    end
    local res = 0
    for i = 0, n - 1, 1 do
        --[[if i == 0 then 
            res = dmg.autoattack(player,tar,true)
        end ]]
        res = res + dmg.autoattack(player, tar, false)
    end
    return res
end
function utility:allAvailableDmg(tar)
    local alldmg = 0
    if not tar then
        return
    end
    for i = 0, 3, 1 do -- loop through all spell slots
        if self.blackListedSpells[i] then
        else
            local curSlot = player:spellSlot(i)
            if curSlot and curSlot.state == SpellState.Ready then
                alldmg = alldmg + dmg.spell(player, tar, i)
            end
        end
    end
    alldmg = alldmg + utility:getAADmg(self.menu.includedAAs:get(), tar)
    for i = 1, #self.additionalDmgFuncs do
        local f = self.additionalDmgFuncs[i]
        if not f then
            break
        end
        alldmg = alldmg + f(tar)
    end
    return alldmg
end

function utility:findItem(name)
    local inv = self:getInv()
    local res
    local slot 
    if inv then 
        for i = 1, #inv do
            local item = inv[i] 
            if item and sFind(item.name,name) then 
                res = item
                slot = i + 5 -- +5 because itemslots start at 6
                break 
            end
        end
    end
    return ({res,slot})
end

function utility:getInv()
    local res = {}
    for i = 6, 12, 1 do
        local t = player:spellSlot(i)
        if t then
            res[#res + 1] = t
        end
    end
    return res
end

function utility:getSumms()
    if not self.summs then
        self.summs[player:spellSlot(SpellSlot.Summoner1).name] = player:spellSlot(SpellSlot.Summoner1)
        self.summs[player:spellSlot(SpellSlot.Summoner2).name] = player:spellSlot(SpellSlot.Summoner2)
    end
    return self.summs
end

function utility:isKillable(tar)
    return self:allAvailableDmg(tar) > tar.health
end

function utility:getDirection(obj)
    return obj.pos + (obj.dir * 100)
end

function utility:drawDmg()
    for tar in objManager.iheroes do
        if tar.isEnemy and tar.pos:isOnScreen() then
            graphics.draw_damage(tar, self:allAvailableDmg(tar), 0xfff0B500)
        end
    end
end
function utility:getSelectedTarget(range)
    local selected = game.selectedTarget
    if selected and selected.type == TYPE_HERO and selected.team == TEAM_ENEMY and player.pos:dist(selected.pos) < range then
        return selected
    else
        return nil
    end
end

function utility:isInAARange(tar)
    if tar and tar.pos then
        return player:isInAutoAttackRange(tar)
    end
end

return utility
