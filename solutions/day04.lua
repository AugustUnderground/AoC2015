local utl = require('solutions.util')
local md5 = require('md5')

local S = {}

local function find(zeros, input)
  local z = string.rep('0', zeros)
  local x = 1
  while true do
    local sum = md5.sumhexa(input .. x)
    if sum:sub(1,zeros) == z then
      return x, sum
    end
    x = x + 1
  end
end

function S.solve()
  local input    = utl.read_input('./inputs/day04.txt')
  local silver,_ = find(5, input[1])
  local gold,_   = find(6, input[1])
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
