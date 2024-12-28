local utl  = require('solutions.util')
local JSON = require('JSON')

local S = {}

local function w_red(json)
  local nums = {}
  for num in string.gmatch(json, '[+-]?%d+') do
    table.insert(nums, tonumber(num))
  end
  return utl.sum(nums)
end

local function wo_red(obj)
  if type(obj) == 'string' then
    return 0
  elseif type(obj) == 'number' then
    return obj
  elseif utl.is_array(obj) then
    local sum = 0
    for _,o in ipairs(obj) do
      sum = sum + wo_red(o)
    end
    return sum
  else
    local sum = 0
    for k,v in pairs(obj) do
      if (type(k) == 'string' and k == 'red') or
         (type(v) == 'string' and v == 'red') then
        return 0
      else
        sum = sum + wo_red(v)
      end
    end
    return sum
  end
end

function S.solve()
  local json   = utl.read_input('./inputs/day12.txt')[1]
  local silver = w_red(json)
  local gold   = wo_red(JSON:decode(json))
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
