local utl = require('solutions.util')

local S = {}

local function house(target)
  local presents = 0
  local num      = 1
  while presents < target do
    presents = 10 * utl.sum_divisors(num)
    num      = num + 1
  end
  return num - 1
end

local function deliver(target)
  local num    = 0
  local houses = {}
  local limit  = 1000000
  for i = 1,limit do houses[i] = 0 end
  for i = 1,limit do
    for j = i,(i)*50,i do
      if j <= limit then
        houses[j] = houses[j] + 11 * i
      end
    end
  end
  for i,p in ipairs(houses) do
    if p >= target then
      num = i
      break
    end
  end
  return num
end

function S.solve()
  local input    = utl.read_input('./inputs/day20.txt')
  local presents = tonumber(input[1])
  local silver   = house(presents)
  local gold     = deliver(presents)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
