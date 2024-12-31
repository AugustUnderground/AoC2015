local utl = require('solutions.util')

local S = {}

local shop = { Weapons = { Dagger     = {Cost =  8, Damage = 4, Armor = 0}
                         , Shortsword = {Cost = 10, Damage = 5, Armor = 0}
                         , Warhammer  = {Cost = 25, Damage = 6, Armor = 0}
                         , Longsword  = {Cost = 40, Damage = 7, Armor = 0}
                         , Greataxe   = {Cost = 74, Damage = 8, Armor = 0} }
             , Armor   = { Empty      = {Cost =   0, Damage = 0, Armor = 0}
                         , Leather    = {Cost =  13, Damage = 0, Armor = 1}
                         , Chainmail  = {Cost =  31, Damage = 0, Armor = 2}
                         , Splintmail = {Cost =  53, Damage = 0, Armor = 3}
                         , Bandedmail = {Cost =  75, Damage = 0, Armor = 4}
                         , Platemail  = {Cost = 102, Damage = 0, Armor = 5} }
             , Rings   = { Empty1    = {Cost =   0, Damage = 0, Armor = 0}
                         , Empty2    = {Cost =   0, Damage = 0, Armor = 0}
                         , Damage1   = {Cost =  25, Damage = 1, Armor = 0}
                         , Damage2   = {Cost =  50, Damage = 2, Armor = 0}
                         , Damage3   = {Cost = 100, Damage = 3, Armor = 0}
                         , Defense1  = {Cost =  20, Damage = 0, Armor = 1}
                         , Defense2  = {Cost =  40, Damage = 0, Armor = 2}
                         , Defense3  = {Cost =  80, Damage = 0, Armor = 3} } }

local boss = {}

local function spawn_boss(input)
  for _,line in ipairs(input) do
    local k,v = line:match('^(.+):%s+(%d+)$')
    boss[k:gsub('%s+','')] = tonumber(v)
  end
end

local function fight(player)
  local boss_loss   = math.max(1, player['Damage'] - boss['Armor'])
  local player_loss = math.max(1, boss['Damage'] - player['Armor'])
  local n = math.floor(boss['HitPoints'] / boss_loss)
  local r = boss['HitPoints'] % boss_loss
  if r == 0 then n = n - 1 end
  return (player_loss * n) < player['HitPoints']
end

local function play()
  local min_cost = math.huge
  local max_cost = 0
  for _,weapon in pairs(shop['Weapons']) do
    for _,armor in pairs(shop['Armor']) do
      for r1,ring1 in pairs(shop['Rings']) do
        for r2,ring2 in pairs(shop['Rings']) do
          if r1 ~= r2 then
            local player = { HitPoints = 100
                           , Damage    = weapon['Damage'] + ring1['Damage']
                                       + ring2['Damage']
                           , Armor     = armor['Armor'] + ring1['Armor']
                                       + ring2['Armor'] }
            local cost   = weapon['Cost'] + armor['Cost']
                         + ring1['Cost'] + ring2['Cost']
            local win    = fight(player)
            if win then
              min_cost = math.min(min_cost, cost)
            else
              max_cost = math.max(max_cost, cost)
            end
          end
        end
      end
    end
  end
  return min_cost,max_cost
end

function S.solve()
  local input    = utl.read_input('./inputs/day21.txt')
  spawn_boss(input)
  local silver,gold = play()
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
