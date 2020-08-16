--RengarQEmp ( Rengar's Empowered Q )
-- TEST


local orb = module.internal("orb")
local ts = module.internal("TS")
local pred = module.internal("pred")
local damage = module.internal("damage")
local menu = menu("Rengo", "Revision Rengar")

local Combo = module.load("ProjectRevision" , "Rengar/ComboManager")
local Ferocity = module.load("ProjectRevision" , "Rengar/FerocityManager")
local util = module.load("ProjectRevision" , "iLLUtility")

Combo.Ferocity = Ferocity 
Ferocity.Combo = Combo 
Ferocity.util = util

menu:header("Combo_header", "Combo")
menu:boolean("Q_Combat", "Use Q", true)
menu:boolean("W_Combat", "Use W", true)
menu:boolean("E_Combat", "Use E", true)
Combo:bindToMenu(menu)
menu:dropdown("EmpPrio", "Empower Prio : ", 3, {"Automatic","Q", "W", "E"})
menu:keybind("One_Shot", "One Shot", "T", "H", true)
--Ferocity.menu = menu 

local q_pred_input = {
    delay = 0,
    range = 125,
    boundingRadiusMod = 1,
    collision = {
        wall = false
    }
}

local w_pred_input = {
    delay = 0,
    range = 450,
    boundingRadiusMod = 1,
    collision = {
        wall = false
    },
    damage = function(m)
        return damage.spell(player, m, 1)
    end
}
local e_pred_input = {
    delay = 0.25,
    speed = 1500,
    width = 140,
    range = 1000,
    boundingRadiusMod = 1,
    collision = {
        hero = true,
        wall = true
    }
}

local active_pred_input

local function trace_filter(seg, obj)
    if seg.startPos:dist(seg.endPos) > active_pred_input.range then
        return false
    end
    if pred.trace.linear.hardlock(active_pred_input, seg, obj) then
        return true
    end
    if pred.trace.linear.hardlockmove(active_pred_input, seg, obj) then
        return true
    end
    if pred.trace.newpath(obj, 0.033, 0.500) then
        return true
    end
end

local function q_combo_target_filter(res, obj, dist)
    if dist > 125 then
        return false
    end
    res.obj = obj
end

local function w_combo_target_filter(res, obj, dist)
    if dist > 450 then
        return false
    end
    res.pos = obj
end

local function e_combo_target_filter(res, obj, dist)
    if dist > 1000 then
        return false
    end
    local seg = pred.linear.get_prediction(active_pred_input, obj)
    if not seg then
        return false
    end
    if not trace_filter(seg, obj) then
        return false
    end
    res.pos = seg.endPos
    return true
end


local function q_combo_logic()
    if player:spellState(SpellSlot.Q) ~= SpellState.Ready then
        return
    end
    active_pred_input = q_pred_input
    local res = ts.get_result(q_combo_target_filter)
    if res.obj then
        player:castSpell("obj", SpellSlot.Q, res.obj)
        return true
    end
end

local function w_combo_logic()
    if player:spellState(SpellSlot.W) ~= SpellState.Ready then
        return
    end
    active_pred_input = w_pred_input
    local res = ts.get_result(w_combo_target_filter)
    if res.pos then
        player:castSpell("self", SpellSlot.W)
        return true
    end
end

local function e_combo_logic()
    if player:spellState(SpellSlot.E) ~= SpellState.Ready then
        return
    end
    active_pred_input = e_pred_input
    local res = ts.get_result(e_combo_target_filter)

    if res.pos then
        player:castSpell("pos", SpellSlot.E, vec3(res.pos.x, mousePos.y, res.pos.y))
        return true
    else
    end
end

local function combo()
end

local function slowTick()
    Combo:updateTarget()
end

local function onTick()
    if orb.menu.combat.key:get() then 
        Combo:nextSpell()
    end
    
end

cb.add(cb.tick, onTick)
cb.add(cb.slow_tick, slowTick)
chat.print("Revision Rengar has been Loaded!")