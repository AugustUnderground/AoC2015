local utl = require('solutions.util')

local S = {}

local function material(l, w, h)
  local a      = l * w
  local b      = w * h
  local c      = h * l
  local paper  = 2 * a + 2 * b + 2 * c + math.min(a,b,c)
  local v      = l * w * h
  local p      = math.min(2*l + 2*w, 2*l + 2*h, 2*w + 2*h)
  local ribbon = v + p
  return paper, ribbon
end

local function dims(line)
  local l, w, h = string.match(line, "(%d+)x(%d+)x(%d+)")
  return material(l, w, h)
end

function S.solve()
  local input = utl.read_input('./inputs/day02.txt')
  local silver = 0
  local gold   = 0
  for _,line in ipairs(input) do
    local area, ribbon = dims(line)
    silver = silver + area
    gold   = gold + ribbon
  end
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
