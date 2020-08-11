--RengarQEmp ( Rengar's Empowered Q )
-- TEST
local orb = module.internal('orb')
local ts = module.internal('TS')
local pred = module.internal('pred')
local damage = module.internal('damage')

print("Revision Rengar Has Loaded ! ")

local menu = menu("Rengo", "Revision Rengar")
menu:header("Combo_header", "Combo")
menu:boolean("Q_Combat", "Use Q", true)
menu:boolean("W_Combat", "User W", true)
menu:boolean("E_Combat", "Use E", true)
menu:dropdown("EmpPrio", "Empower Prio : ", 2, { "Q", "W", "E"})
menu:keybind("One_Shot", "One Shot", 'T', 'H', true)

local q_pred_input = {
    delay = 0,
    range = 125,
    boundingRadiusMod = 1,
    collision = {
    wall = false,
    },
  }

  local w_pred_input = {
    delay = 0,
    range = 450,
    boundingRadiusMod = 1,
    collision = {
    wall = false,
    },
    damage = function(m)
      return damage.spell(player, m, 1)
    end,
  }
local e_pred_input = {
  delay = 0.25,
  speed = 1500,
  width = 140,
  range = 1000,
  boundingRadiusMod = 1,
  collision = {
    hero = true,
    wall = true,
  },
}

local active_pred_input

local function trace_filter(seg, obj)
if seg.startPos:dist(seg.endPos) > active_pred_input.range then return false end
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
if dist > 125 then return false end
res.obj = obj
end

local function w_combo_target_filter(res, obj, dist)
if dist > 450 then return false end
res.pos = obj
end

local function e_combo_target_filter(res, obj, dist)
if dist > 1000 then return false end
local seg = pred.linear.get_prediction(active_pred_input, obj)
if not seg then return false end 
if not trace_filter(seg, obj) then return false end
res.pos = seg.endPos
return true
end


local function EmpowerPrio()
  -- we need to make an algorithem that uses the Preffered Emp 
  --i think best way is checking if mana/passive idk what it is but if its 4/4 means full stacks
local Rengar_Passive = player.mana
if Rengar_Passive == 4 and menu.EmpPrio:get() == 1 then
  q_combo_logic()
end
if Rengar_Passive == 4 and menu.EmpPrio:get() == 2 then
  w_combo_logic()
end
if Rengar_Passive == 4 and menu.EmpPrio:get() == 3 then
  e_combo_logic()
end
 return EmpowerPrio()
end


local function q_combo_logic()
if player:spellState(SpellSlot.Q) ~= SpellState.Ready then return end
active_pred_input = q_pred_input
local res = ts.get_result(q_combo_target_filter)
if res.obj then
    player:castSpell("obj", SpellSlot.Q, res.obj)
return true end
end

local function w_combo_logic()
if player:spellState(SpellSlot.W) ~= SpellState.Ready then return end
active_pred_input = w_pred_input
local res = ts.get_result(w_combo_target_filter)
if res.pos then
player:castSpell("self", SpellSlot.W) return true end
end

local function e_combo_logic()
if player:spellState(SpellSlot.E) ~= SpellState.Ready then return end
active_pred_input = e_pred_input
local res = ts.get_result(e_combo_target_filter)
 
if res.pos then
player:castSpell('pos', SpellSlot.E, vec3(res.pos.x, mousePos.y, res.pos.y)) 
    return true 
else
 end
end



local function combo() 
    if  (menu.EmpPrio:get() == 1 and EmpowerPrio()) then
      return true
    end
    if  (menu.EmpPrio:get() == 2 and EmpowerPrio()) then
      return true
    end
    if  (menu.EmpPrio:get() == 3 and EmpowerPrio()) then
      return true
    end
    if(menu.Q_Combat:get() and not EmpowerPrio() and q_combo_logic()) then
      return true
    end
    if(menu.W_Combat:get() and not EmpowerPrio() and w_combo_logic()) then
        return true
    end
    if(menu.E_Combat:get() and not EmpowerPrio() and e_combo_logic()) then
        return true
    end
    
end

local function on_tick()
   
    if (not orb.core.can_action()) then
      return
    end
    if orb.menu.combat.key:get() then
      combo()
    elseif orb.menu.combat.key:get() then
      harass()
    else
      --farm()
      --auto_harass()
    end
  end

cb.add(cb.tick, on_tick)
cb.add(cb.draw, on_draw)
cb.add(cb.tick, EmpowerPrio)