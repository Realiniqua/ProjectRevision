-- Get R Buff 
-- if its used and only if leaped - E W TIAMAT Q ( if one shot) else normal combo
local R = {}

function R:activated()
    return player.buffManager["RengarR"]
end

return R 