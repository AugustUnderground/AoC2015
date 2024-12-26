local utl = require('solutions.util')

local S = {}

local function go(floor_plan)
  local floor = 0
  local base  = 0
  for i = 1, #floor_plan do
    local c = string.sub(floor_plan, i, i)
    if c == '(' then floor = floor + 1
    elseif c == ')' then floor = floor - 1
    end
    if floor < 0 and base == 0 then base = i end
  end
  return floor, base
end

function S.solve()
  local input = utl.read_input('./inputs/day01.txt')
  local silver, gold = go(input[1])
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
