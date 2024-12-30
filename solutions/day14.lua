local utl = require('solutions.util')
local ins = require('inspect')

local S = {}

local reindeer = {}

local function parse(input)
  for _,line in ipairs(input) do
    local regex = '^(%a+).+%s(%d+).+%s(%d+).+%s+(%d+).+%.$'
    local name,slope,flight,rest = line:match(regex)
    local s = tonumber(slope)
    local f = tonumber(flight)
    local r = tonumber(rest)
    reindeer[name] = function (x)
      local c = math.floor(x / (f + r))
      local p = x % (f + r)
      local b = c * s * f
      if p < f then
        return b + s * p
      else
        return b + (s * f)
      end
    end
  end
end

local function race(t)
  local dist = 0
  for _,v in pairs(reindeer) do
    if v(t) > dist then dist = v(t) end
  end
  return dist
end

local function score(t)
  local scr = {}
  for k,_ in pairs(reindeer) do
    scr[k] = 0
  end
  for s = 1,t do
    local l = ''
    local q = 0
    for k,v in pairs(reindeer) do
      if v(s) > q then
        q = v(s)
        l = k
      end
    end
    scr[l] = scr[l] + 1
  end
  local lead = 0
  for _,v in pairs(scr) do
    if v > lead then lead = v end
  end
  return lead
end

function S.solve()
  local input  = utl.read_input('./inputs/day14.txt')
  parse(input)
  local silver = race(2503)
  local gold   = score(2503)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
