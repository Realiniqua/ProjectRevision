---@class vec2
---@field public x number
---@field public y number
local _a = {}

---@return vec2
function _a:clone() end

---@return boolean
function _a:valid() end

---@return number
function _a:len() end

---@return number
function _a:lenSqr() end

---@return vec2
function _a:norm() end

---@param vecType vec2
---@param delta number
---@overload fun(vecType:vec3, delta:number):vec2
---@return vec2
function _a:lerp(vecType, delta) end

---@param vecType vec2
---@param dist number
---@overload fun(vecType:vec3, dist:number):vec2
---@return vec2
function _a:extend(vecType, dist) end

---@param vecType vec2
---@param dist number
---@overload fun(vecType:vec3, dist:number):vec2
---@return vec2
function _a:shorten(vecType, dist) end

---@param angle number
---@return vec2
function _a:rotate(angle) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:dist(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:distSqr(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:dot(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:angle(vecType) end

---@return vec2
function _a:perp1() end

---@return vec2
function _a:perp2() end

---@param vecType vec2
---@param range number
---@overload fun(vecType:vec3, dist:number):boolean
---@return boolean
function _a:isInRange(vecType, range) end

---@return boolean
function _a:isOnScreen() end

---@class vec3
---@field public x number
---@field public y number
---@field public z number
local _a = {}

---@return vec3
function _a:clone() end

---@return boolean
function _a:valid() end

---@return number
function _a:len() end

---@return number
function _a:lenSqr() end

---@return number
function _a:lenSqr() end

---@param vecType vec3
---@param delta number
---@overload fun(vecType:vec2, delta:number):vec3
---@return vec3
function _a:lerp(vecType, delta) end

---@param vecType vec3
---@param dist number
---@overload fun(vecType:vec2, dist:number):vec3
---@return vec3
function _a:extend(vecType, dist) end

---@param vecType vec3
---@param dist number
---@overload fun(vecType:vec2, dist:number):vec3
---@return vec3
function _a:shorten(vecType, dist) end

---@param angle number
---@return vec3
function _a:rotate(angle) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:dist(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:distSqr(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:dot(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3):number
---@return number
function _a:angle(vecType) end

---@return vec3
function _a:perp1() end

---@return vec3
function _a:perp2() end

---@param vecType vec3
---@param range number
---@overload fun(vecType:vec2, range:number):boolean
---@return boolean
function _a:isInRange(vecType, range) end

---@return boolean
function _a:isOnScreen() end

---@param delta number
---@return vec3
function _a:randomize(delta) end

---@param min number
---@param max number
---@overload fun(max:number):vec3
---@return vec3
function _a:clamp(min, max) end

---@return boolean
function _a:isZero() end

---@param tolerance number
---@overload fun():boolean
---@return boolean
function _a:isUnderEnemyTurret(tolerance) end

---@param tolerance number
---@overload fun():boolean
---@return boolean
function _a:isUnderAllyTurret(tolerance) end

---@return vec2
function _a:to2D() end

---@return vec2
function _a:toScreen() end

---@return vec3
function _a:to3DWorld() end

---@return vec3
function _a:to3DPlayer() end

---@return boolean
function _a:isWall() end

---@return boolean
function _a:isGrass() end

---@return boolean
function _a:isInJungle() end

---@class path
---@field public active boolean
---@field public index number
---@field public startPos vec3
---@field public endPos vec3
---@field public serverPos vec3
---@field public point vec3[]
---@field public point2D vec2[]
---@field public count number
---@field public dashSpeed number
---@field public isDashing boolean
---@field public serverVelocity vec3
---@field public serverVelocity2D vec2
local _a = {}

---@class rune
---@field public ID number
---@field public name string
---@field public displayName string
local _a = {}

---@class runeManager
---@field public rune rune
local _a = {}

---@class avatar
---@field public hasRunes boolean
---@field public runes runeManager[]
local _a = {}

---@class spellData
---@field public displayName string
---@field public castRangeGrowInterval boolean
---@field public cantCancelWhileWindingUp boolean
---@field public cantcancelWhileChanneling boolean
---@field public channelIsInterruptedByAttacking boolean
---@field public projectTargetToCastRange boolean
---@field public castRangeUseBoundingBoxes boolean
---@field public canMoveWhileChanneling boolean
---@field public isToggleSpell boolean
---@field public castConeAngle number
---@field public castConeDistance number
---@field public missileUpdateDistanceInterval number
---@field public castType number
---@field public missileSpeed number
---@field public lineWidth number
local _a = {}

---@class spell
---@field public name string
---@field public nameHash number
---@field public endTime number
---@field public castEndTime number
---@field public static spellData
---@field public counter number
---@field public level number
---@field public startPos vec3
---@field public endPos vec3
---@field public startPos2D vec2
---@field public endPos2D vec2
---@field public castPosition vec3
---@field public hasTarget boolean
---@field public owner gameobject
---@field public ownerID number
---@field public target gameobject
---@field public targetID number
---@field public windUpTime number
---@field public animationTime number
---@field public clientWindUpTime number
---@field public animationWindUpTime number
---@field public isBasicAttack boolean
---@field public isSpecialAttack boolean
---@field public isChannelSpell boolean
---@field public isInstantCast boolean
---@field public spellWasCast boolean
---@field public slot number
local _a = {}

---@class spellCastData
---@field public casterID number
---@field public targetID number
---@field public pos vec3
---@field public endPos vec3
---@field public startPos vec3
---@field public castPos vec3
local _a = {}

---@class spellSlot
---@field public name string
---@field public level number
---@field public cooldownEndTime number
---@field public ammo number
---@field public stacks number
---@field public rechargeEndTime number
---@field public toggleState number
---@field public slot number
---@field public state number
---@field public ammoCurrentCooldown number
---@field public castData spellCastData
---@field public static spellData
---@field public cooldown number
local _a = {}

---@class item
---@field public stacks number
---@field public ammo number
---@field public id number
---@field public maxStacks number
---@field public name number
local _a = {}

---@class heroInventory
local _a = {}

---@param index number
---@return item
function _a:getSlot(index) end

---@class gameobject
---@field public valid boolean
---@field public name string
---@field public charName string
---@field public recallName string
---@field public pos vec3
---@field public dir vec3
---@field public pos2D vec2
---@field public dir2D vec2
---@field public velocity vec3
---@field public barPos vec2
---@field public path path[]
---@field public activeSpell spell
---@field public type number
---@field public index number
---@field public team number
---@field public x number
---@field public y number
---@field public z number
---@field public isOnScreen boolean
---@field public isDead boolean
---@field public isVisible boolean
---@field public isRecalling boolean
---@field public isTargetable boolean
---@field public parEnabled boolean
---@field public sarEnabled boolean
---@field public isCampAlive boolean
---@field public isUntargetableToEnemies boolean
---@field public isUntargetableToAllies boolean
---@field public isZombie boolean
---@field public isStructure boolean
---@field public isAlly boolean
---@field public isEnemy boolean
---@field public isNeutral boolean
---@field public isMonster boolean
---@field public isBaseAI boolean
---@field public isMinion boolean
---@field public isHero boolean
---@field public isTurret boolean
---@field public isBuilding boolean
---@field public isAttackableUnit boolean
---@field public isParticleEmitter boolean
---@field public isMissile boolean
---@field public isInvulnerable boolean
---@field public isMagicImmune boolean
---@field public isPhysicalImmune boolean
---@field public willReviveOnDeath boolean
---@field public isImmovable boolean
---@field public isStealthed boolean
---@field public isTaunted boolean
---@field public isFeared boolean
---@field public isFleeing boolean
---@field public isSupressed boolean
---@field public isAsleep boolean
---@field public isGhosted boolean
---@field public isCharmed boolean
---@field public isSlowed boolean
---@field public isDisarmed boolean
---@field public isRooted boolean
---@field public isSilenced boolean
---@field public isStunned boolean
---@field public isBaseTurret boolean
---@field public isLaneMinion boolean
---@field public isSuperMinion boolean
---@field public isSiegeMinion boolean
---@field public isPet boolean
---@field public isWard boolean
---@field public isTrap boolean
---@field public isPlant boolean
---@field public isLargeMonster boolean
---@field public isEpicMonster boolean
---@field public isDragon boolean
---@field public isMoving boolean
---@field public isDashing boolean
---@field public isMe boolean
---@field public isMelee boolean
---@field public isRanged boolean
---@field public isHardCCd boolean
---@field public isHardMoveCCd boolean
---@field public deathTime number
---@field public boundingRadius number
---@field public networkID number
---@field public health number
---@field public maxHealth number
---@field public allShield number
---@field public physicalShield number
---@field public magicalShield number
---@field public champSpecificHealth number
---@field public isTargetableToTeamFlags number
---@field public mana number
---@field public maxMana number
---@field public baseAttackDamage number
---@field public armor number
---@field public spellBlock number
---@field public attackSpeedMod number
---@field public flatPhysicalDamageMod number
---@field public percentPhysicalDamageMod number
---@field public physicalDamagePercentageMod number
---@field public flatMagicDamageMod number
---@field public percentMagicDamageMod number
---@field public magicalDamagePercentageMod number
---@field public healthRegenRate number
---@field public bonusArmor number
---@field public bonusSpellBlock number
---@field public moveSpeed number
---@field public scaleSkinCoef number
---@field public gold number
---@field public goldTotal number
---@field public minimumGold number
---@field public evolvePoints number
---@field public evolveFlag number
---@field public inputLocks number
---@field public skillUpLevelDeltaReplicate number
---@field public manaCost number
---@field public manaCost0 number
---@field public manaCost1 number
---@field public manaCost2 number
---@field public manaCost3 number
---@field public baseAbilityDamage number
---@field public dodge number
---@field public crit number
---@field public totalAttackDamage number
---@field public totalAbilityPower number
---@field public totalBaseAttackDamage number
---@field public totalBonusAttackDamage number
---@field public totalBaseAbilityPower number
---@field public totalBonusAbilityPower number
---@field public parRegenRate number
---@field public attackRange number
---@field public flatMagicReduction number
---@field public percentMagicReduction number
---@field public flatCastRangeMod number
---@field public percentCooldownMod number
---@field public passiveCooldownEndTime number
---@field public passiveCooldownTotalTime number
---@field public flatArmorPenetration number
---@field public percentArmorPenetration number
---@field public flatMagicPenetration number
---@field public percentMagicPenetration number
---@field public percentLifeStealMod number
---@field public percentSpellVampMod number
---@field public percentBonusArmorPenetration number
---@field public percentBonusMagicPenetration number
---@field public percentCritBonusArmorPenetration number
---@field public percentCritTotalArmorPenetration number
---@field public physicalLethality number
---@field public baseHealthRegenRate number
---@field public primaryARBaseRegenRateRep number
---@field public secondaryARRegenRateRep number
---@field public secondaryARBaseRegenRateRep number
---@field public percentCooldownCapMod number
---@field public percentEXPBonus number
---@field public flatBaseAttackDamageMod number
---@field public percentBaseAttackDamageMod number
---@field public baseAttackDamageSansPercentScale number
---@field public exp number
---@field public par number
---@field public maxPar number
---@field public sar number
---@field public maxSar number
---@field public levelRef number
---@field public campID number
---@field public statusFlags number
---@field public teleportType number
---@field public teleportName string
---@field public actionState number
---@field public actionState2 number
---@field public dampenerState number
---@field public percentDamageToBarracksMinionMod number
---@field public flatDamageReductionFromBarracksMinionMod number
---@field public percentBonusAttackDamageMod number
---@field public percentMultiplicativeAttackSpeedMod number
---@field public critDamageMultiplier number
---@field public tenacity number
---@field public petId number
---@field public combatType number
---@field public upgradePoints number
---@field public lastTargetNetworkID number
---@field public respawnTimer number
---@field public serverPos vec3
---@field public pathPos vec3
---@field public currentPathIndex number
---@field public pathEndPos vec3
---@field public pathStartPos vec3
---@field public nextPathPos vec3
---@field public buffManager buffManager
---@field public buff buff[]
---@field public attacksInfo spell[]
---@field public heroInventory heroInventory
---@field public owner gameobject
---@field public cloneOf gameobject
---@field public avatar avatar
---@field public startPos vec3
---@field public endPos vec3
---@field public startPos2D vec3
---@field public endPos2D vec3
---@field public spell spell
local _a = {}

--if isBaseAI
---@param slot number
---@return spellSlot
function _a:basicAttack(slot) end

--if isHero
---@param slot number
---@return spellSlot
function _a:spellSlot(slot) end

---@param slot number
---@return number
function _a:spellState(slot) end

---@return number
function _a:timerExpiry() end

---@return number
function _a:attackCastDelay() end

---@param slot number
---@return number
function _a:attackCastDelayEx(slot) end

---@return number
function _a:attackDelay() end

---@param runeID number
---@return number
function _a:findRune(runeID) end

---@return number
function _a:hardCCdTime() end

---@return number
function _a:hardMoveCCdTime() end

---@return boolean
function _a:canDie() end

---@return boolean
function _a:canAttack() end

---@return boolean
function _a:canCrit() end

---@return boolean
function _a:canCast() end

---@return boolean
function _a:canMove() end

---@return boolean
function _a:canAttack() end

---@return number
function _a:totalHealth() end

---@return number
function _a:totalMaxHealth() end

---@return number
function _a:totalShield() end

---@param target gameobject
---@return number
function _a:getAutoAttackRange(target) end

---@param target gameobject
---@param range number
---@return boolean
function _a:isInAutoAttackRange(target, range) end

---@param target gameobject
---@return boolean
function _a:isFacing(target) end

---@param name string
---@return buff
function _a:findBuffByName(name) end

---@param buffType number
---@return buff
function _a:findBuffOfType(buffType) end

---@param itemID number
---@return item
function _a:findItem(itemID) end

---@overload fun(vec:vec2):number
---@overload fun(vec:vec3):number
---@return number
function _a:dist() end

--if isMe
---@param itemID number
---@return boolean
function _a:buyItem(itemID) end

---@param slot number
---@return boolean
function _a:levelSpell(slot) end

---@param mode string
---@param slot number
---@return boolean
function _a:levelSpell(mode, slot) end

---@class buff
---@field public type number
---@field public name string
---@field public startTime number
---@field public endTime number
---@field public counter number
---@field public valid boolean
---@field public source gameobject
---@field public stacks number
---@field public stacks2 number
local _a = {}

---@class buffManager
---@field public count number
local _a = {}

---@param index number
---@return buff
function _a:get(index) end

---@class zenbot
local _a = {}

---@return boolean
function _a.isPrivilegedUser() end

---@class cb
---@field public draw number
---@field public draw2 number
---@field public pre_tick number
---@field public tick number
---@field public issueorder number
---@field public delete_object number
---@field public create_object number
---@field public load number
---@field public path number
---@field public destroy number
---@field public castspell number
---@field public wndproc number
---@field public keydown number
---@field public keyup number
---@field public cancelattack number
---@field public teleport number
---@field public spell number
---@field public evade number
local _a = {}

---@param eventId number
---@param func function
---@return nil
function _a.add(eventId, func) end

---@param func function
---@return nil
function _a.remove(func) end

---@class chat
---@field public isOpen boolean
local _a = {}

---@param message string
---@return nil
function _a.send(message) end

---@param message string
---@return nil
function _a.print(message) end

---@class consoleType
---@field public title string
---@field public pos vec2
---@field public size vec2
---@field public height number
---@field public shouldClose boolean
local _a = {}

---@param message string
---@return nil
function _a:print(message) end

---@class console
---@field public default consoleType
local _a = {}

---@param message string
---@return nil
function _a.print(message) end

---@param title string
---@overload fun()
---@return consoleType
function _a.new(title) end

---@class hash
local _a = {}

---@param name string
---@return number
function _a.FNV1a(name)
end

---@param name string
---@return string
function _a.translate(name)
end

---@class minimap
---@field public x number
---@field public y number
---@field public width number
---@field public height number
---@field public bounds vec2
local _a = {}

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return vec2 @screen position on minimap
function _a.world_to_map(vecType)
end

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return boolean @true if screen position is over minimap
function _a.on_map(vecType)
end

---@param x number
---@param y number
---@return boolean @true if screen position is over minimap
function _a.on_map_xy(x, y) end

---@param vecType number
---@param radius number
---@param line_width number
---@param color number
---@return nil
function _a.draw_circle(vecType, radius, line_width, color) end

---@class navmesh
local _a = {}

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return number
function _a.flagsAt(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return number
function _a.heightAt(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return boolean
function _a.isWall(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return boolean
function _a.isGrass(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return boolean
function _a.isStructure(vecType) end

---@param vecType vec2
---@overload fun(vecType:vec3)
---@return vec3
function _a.nearestPassableCenter(vecType) end

---@class game
---@field public mousePos vec3
---@field public mousePos2D vec2
---@field public cursorPos vec2
---@field public time number
---@field public selectedTarget gameobject
---@field public hoveredTarget gameobject
---@field public mapID number
---@field public isMatchmade boolean
---@field public mode string
---@field public isWindowFocused boolean
local _a = {}

---@class graphics
---@field public width number
---@field public height number
---@field public res vec2
---@field public anchor_n number
---@field public anchor table
local _a = {}

---@param a number
---@param r number
---@param g number
---@param b number
---@return number
function _a.argb(a, r, g, b) end

---@param vecType vec2
---@overload fun(vecType:vec2)
---@return vec2
function _a.world_to_screen(vecType) end

---@param x number
---@param y number
---@param z number
---@return vec2
function _a.world_to_screen_xyz(x, y, z) end

---@param text string
---@param size number
---@param x number
---@param y number
---@param z number
---@return nil
function _a.draw_text_2D(text, size, x, y, z) end

---@param x1 number
---@param y1 number
---@param x2 number
---@param y2 number
---@param width number
---@param color number
---@return nil
function _a.draw_line_2D(x1, y1, x2, y2, width, color) end

---@param vecType1 vec2
---@param vecType2 vec2
---@param width number
---@param color number
---@overload fun(vecType1:vec3, vecType2:vec2, width:number, color:number):nil
---@overload fun(vecType1:vec2, vecType2:vec3, width:number, color:number):nil
---@overload fun(vecType1:vec3, vecType2:vec3, width:number, color:number):nil
---@return nil
function _a.draw_line(vecType1, vecType2, width, color) end

---@param v1 vec2
---@param radius number
---@param width number
---@param color number
---@overload fun(v1:vec3, radius:number, width:number, color:number):nil
---@return nil
function _a.draw_circle(v1, radius, width, color) end

---@param x number
---@param y number
---@param z number
---@param radius number
---@param width number
---@param color number
---@return nil
function _a.draw_circle_xyz(x, y, z, radius, width, color) end

---@param x number
---@param y number
---@param radius number
---@param width number
---@param color number
---@return nil
function _a.draw_circle_2D(x, y, radius, width, color) end

---@param str string
---@param size number
---@param n number
---@return nil
function _a.text_area(str, size, n) end

---@param points vec2[]
---@param width number
---@param color number
---@param n number
---@param closed boolean
---@overload fun(points:vec3[], width:number, color:number, n:number, closed:boolean)
---@return nil
function _a.draw_line_strip(points, width, color, n, closed) end

---@param points vec2[]
---@param width number
---@param color number
---@param n number
---@param closed boolean
---@overload fun(points:vec3[], width:number, color:number, n:number, closed:boolean)
---@return nil
function _a.draw_line_strip_2D(points, width, color, n, closed) end

---@param object gameobject
---@param damage number
---@param color number
---@param end_color number
---@return nil
function _a.draw_damage(object, damage, color, end_color) end

---@param object gameobject
---@param healing number
---@param color number
---@param end_color number
---@return nil
function _a.draw_healing(object, healing, color, end_color) end

---@param object gameobject
---@param shielding number
---@param color number
---@param end_color number
---@return nil
function _a.draw_shielding(object, shielding, color, end_color) end

---@class objManager
---@field public player gameobject
---@field public iturrets function
---@field public iheroes function
---@field public ibouldings function
---@field public iminions function
---@field public nexus gameobject[]
local _a = {}

---@param f function
---@return nil
function _a.loop(f) end

---@class keyboard
local _a = {}

---@param key number
---@return boolean
function _a.isKeydown(key) end

---@class network
---@field latency number
local _a = {}

---@param host string
---@param request string
---@param port number
---@return string
function _a.request(host, request, port) end

---@class module
local _a = {}

---@param id string
---@return any
function _a.internal(id) end

---@param id string
---@return any
function _a.lib(id) end

---@param id string
---@param name string
---@return any
function _a.load(id, name) end

---@param id string
---@return any
function _a.seek(id) end

---@class SpellSlot
---@field public Q number
---@field public W number
---@field public E number
---@field public R number
---@field public Summoner1 number
---@field public Summoner2 number
---@field public Item1 number
---@field public Item2 number
---@field public Item3 number
---@field public Item4 number
---@field public Item5 number
---@field public Item6 number
---@field public Trinket number
---@field public Recall number
---@field public SpecialAttack number
---@field public P number
---@field public BasicAttack number
local _a = {}

---@class OrbwalkingMode
---@field public None number
---@field public Combo number
---@field public Mixed number
---@field public LastHit number
---@field public LaneClear number
---@field public PanicLaneClear number
---@field public Flee number
local _a = {}

---@class SpellState
---@field public Ready number
---@field public NotAvailable number
---@field public NotLearned number
---@field public Supressed number
---@field public Disabled number
---@field public Cooldown number
---@field public NoMana number
local _a = {}

---@class ToggleState
---@field public None number
---@field public NotToggled number
---@field public Toggled number
local _a = {}

---@class TeleportStatus
---@field public Unknown number
---@field public Idle number
---@field public Start number
---@field public Abort number
---@field public Finish number
local _a = {}

---@class TeleportType
---@field public Unknown number
---@field public Recall number
---@field public Teleport number
---@field public Gate number
---@field public Shen number
local _a = {}

---@class Buff
---@field public Internal number
---@field public Aura number
---@field public CombatEnhancer number
---@field public CombatDehancer number
---@field public SpellShield number
---@field public Stun number
---@field public Invisibility number
---@field public Silence number
---@field public Taunt number
---@field public Polymorph number
---@field public Slow number
---@field public Snare number
---@field public Damage number
---@field public Heal number
---@field public Haste number
---@field public SpellImmunity number
---@field public PhysicalImmunity number
---@field public Invulnerability number
---@field public AttackSpeedSlow number
---@field public NearSight number
---@field public Currency number
---@field public Fear number
---@field public Charm number
---@field public Poison number
---@field public Suppression number
---@field public Blind number
---@field public Counter number
---@field public Shred number
---@field public Flee number
---@field public Knockup number
---@field public Knockback number
---@field public Disarm number
---@field public Grounded number
---@field public Drowsy number
---@field public Asleep number
local _a = {}

---@class SpellType
---@field public Line number
---@field public MissileLine number
---@field public Cone number
---@field public MissileCone number
---@field public Circle number
---@field public Ring number
---@field public Arc number
---@field public LucianW number
---@field public PykeR number
---@field public None number
local _a = {}

---@class GameState
---@field public PreGame number
---@field public Spawn number
---@field public GameLoop number
---@field public SoftReconnect number
---@field public EndGame number
---@field public PreExit number
---@field public Exit number
local _a = {}

---@class GameExitCode
---@field public None number
---@field public Win number
---@field public Lose number
---@field public Leave number
local _a = {}

---@class Global
---@field public zenbot zenbot
---@field public cb cb
---@field public chat chat
---@field public console console
---@field public hash hash
---@field public minimap minimap
---@field public navmesh navmesh
---@field public game game
---@field public graphics graphics
---@field public objManager objManager
---@field public keyboard keyboard
---@field public network network
---@field public module module
---@field public player gameobject
---@field public mousePos vec3
---@field public mousePos2D vec2
---@field public TEAM_ALLY number
---@field public TEAM_ENEMY number
---@field public TEAM_NEUTRAL number
---@field public TYPE_TROY number
---@field public TYPE_HERO number
---@field public TYPE_MINION number
---@field public TYPE_MISSILE number
---@field public TYPE_TURRET number
---@field public TYPE_INHIB number
---@field public TYPE_NEXUS number
---@field public TYPE_SPAWN number
---@field public TYPE_SHOP number
---@field public TYPE_CAMP number
---@field public SpellSlot SpellSlot
---@field public OrbwalkingMode OrbwalkingMode
---@field public SpellState SpellState
---@field public ToggleState ToggleState
---@field public TeleportStatus TeleportStatus
---@field public TeleportType TeleportType
---@field public Buff Buff
---@field public SpellType SpellType
---@field public GameState GameState
---@field public GameExitCode GameExitCode
local _a = {}

---@param message string
---@return nil
function _a._msgbox(message) end


---@overload fun(x:number):vec2
---@overload fun(x:number, y:number):vec2
---@overload fun(vecType:vec2):vec2
---@overload fun(vecType:vec3):vec2
---@return vec2
function _a.vec2() end

---@overload fun(x:number):vec3
---@overload fun(x:number, y:number):vec3
---@overload fun(x:number, y:number, z:number):vec3
---@overload fun(vecType:vec2):vec3
---@overload fun(vecType:vec3):vec3
---@return vec3
function _a.vec3() end

---@class menu

---@param id string
---@param display string
---@return menu
function _a.menu(id, display) end

---@type Global
_G = _G