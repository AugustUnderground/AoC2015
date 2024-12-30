local utl = require('solutions.util')

local S = {}

local containres = {}
local nog        = 150
local combos     = {}

local function parse(input)
  for i,line in ipairs(input) do
    containres[i] = tonumber(line)
  end
end

local function combinations(idx, combo, sum)
  if sum == nog then
    table.insert(combos, { table.unpack(combo) })
    return
  end
  if sum > nog or idx > #containres then
    return
  end
  table.insert(combo, containres[idx])
  combinations(idx + 1, combo, sum + containres[idx])
  table.remove(combo)
  combinations(idx + 1, combo, sum)
end

local function min_combos()
  local min = math.huge
  local num = 0
  for _,combo in ipairs(combos) do
    if #combo < min then
      min = #combo
      num = 1
    elseif #combo == min then
      num = num + 1
    end
  end
  return num
end

function S.solve()
  local input      = utl.read_input('./inputs/day17.txt')
  parse(input)
  combinations(1, {}, 0)
  local silver = #combos
  local gold   = min_combos()
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
