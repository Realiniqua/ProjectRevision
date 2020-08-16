-- Get R Buff 
-- if its used and only if leaped - E W TIAMAT Q ( if one shot) else normal combo
local R = {}

function R:isLeapActive()
    return player.buff["rengarpassivebuff"]
end

function R:isActive()
    return player.buff["RengarR"]
end

return R 