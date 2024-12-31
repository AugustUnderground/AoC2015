local utl = require('solutions.util')

local S = {}

local function parse(input)
  local row,col = string.match(input[1], 'row%s+(%d+),%s+column%s+(%d+)')
  return tonumber(row),tonumber(col)
end

local function pirate(row, col)
  local code = 1
  for c = 2,col do
    code = code + c
  end
  for r = col,col+row-2 do
    code = code + r
  end
  local num = 20151125
  for _ = 0,code-2 do
    num = num * 252533 % 33554393
  end
  return num
end

function S.solve()
  local input    = utl.read_input('./inputs/day25.txt')
  local row,col = parse(input)
  local silver   = pirate(row,col)
  local gold     = 'Weather machine started'
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
