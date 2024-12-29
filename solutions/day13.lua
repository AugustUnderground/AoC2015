local utl  = require('solutions.util')

local S = {}

local happy = {}

local function parse(input)
  for _,line in ipairs(input) do
    local a,s,n,b = line:match('^(%a+).+%s(%a+)%s(%d+).+%s+(%a+).$')
    local h = (s == 'gain') and tonumber(n) or tonumber('-' .. n)
    if happy[a] then
      happy[a][b] = tonumber(h)
    else
      happy[a] = {[b] = tonumber(h)}
    end
  end
  local people = {}
  for neighbors in pairs(happy) do
    table.insert(people, neighbors)
  end
  return people
end

local function happiness(arrangement)
  local score = 0
  local n = #arrangement
  for i = 0,n-1 do
    local a = arrangement[i % n + 1]
    local b = arrangement[(i + 1) % n + 1]
    score = score + happy[a][b] + happy[b][a]
  end
  return score
end

local function max_happy(arrangements)
  local score = 0
  for _,arrangement in ipairs(arrangements) do
    local hs = happiness(arrangement)
    if hs > score then
      score = hs
    end
  end
  return score
end

local function seat_myself()
  local myself = {}
  for a,h in pairs(happy) do
    h['Me']   = 0
    happy[a]  = h
    myself[a] = 0
  end
  happy['Me'] = myself
end

function S.solve()
  local input        = utl.read_input('./inputs/day13.txt')
  local attendees    = parse(input)
  local arrangements = utl.no_cyclic_permuations(attendees)
  local silver       = max_happy(arrangements)
  seat_myself()
  table.insert(attendees, 1, 'Me')
  local apathetic    = utl.no_cyclic_permuations(attendees)
  local gold         = max_happy(apathetic)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
