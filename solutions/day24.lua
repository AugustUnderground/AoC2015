local utl = require('solutions.util')

local S = {}

local function parse(input)
  local packages = {}
  for _,line in ipairs(input) do
    table.insert(packages, tonumber(line))
  end
  return packages
end

local function find_qmin(packages, set, target)
  local qmin   = math.huge
  local combos = utl.combinations(packages, set)
  for _,presents in ipairs(combos) do
    if utl.sum(presents) == target then
      qmin = math.min(utl.prod(presents),qmin)
    end
  end
  return qmin
end

function S.solve()
  local input    = utl.read_input('./inputs/day24.txt')
  local packages = parse(input)
  local target1  = math.floor(utl.sum(packages) / 3)
  local silver   = find_qmin(packages, 6, target1)
  local target2  = math.floor(utl.sum(packages) / 4)
  local gold     = find_qmin(packages, 5, target2)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
