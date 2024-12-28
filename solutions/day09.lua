local utl = require('solutions.util')

local S = {}

local dist = {}

local function parse(input)
  for _,line in ipairs(input) do
    local a,b,d = line:match('(%a+) to (%a+) = (%d+)')
    dist[a]    = dist[a] or {}
    dist[a][b] = tonumber(d)
    dist[b]    = dist[b] or {}
    dist[b][a] = tonumber(d)
  end
  local locs = utl.keyset(dist)
  return locs
end

local function distance(route)
  local total = 0
  for i = 1, #route - 1 do
    local a = route[i]
    local b = route[i + 1]
    total   = total + dist[a][b]
  end
  return total
end

local function travel(routes)
  local shortest = math.huge
  local longest  = 0
  for _,route in ipairs(routes) do
    local d = distance(route)
    if d < shortest then
      shortest = d
    end
    if d > longest then
      longest = d
    end
  end
  return shortest,longest
end

function S.solve()
  local input       = utl.read_input('./inputs/day09.txt')
  local locs        = parse(input)
  local routes      = utl.permutations(locs)
  local silver,gold = travel(routes)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
