local utl = require('solutions.util')

local S = {}

local function look_and_say(seq, n)
  local res = {}
  local num = 1
  for i = 1, #seq do
    local dig = seq[i]
    local nxt = seq[i + 1]
    if dig == nxt then
      num = num + 1
    else
      table.insert(res, tostring(num))
      table.insert(res, dig)
      num = 1
    end
  end
  if n <= 1 then
    return res
  else
    return look_and_say(res, n - 1)
  end
end

function S.solve()
  local input  = utl.read_input('./inputs/day10.txt')
  local seq    = utl.as_list(input[1])
  local first  = look_and_say(seq, 40)
  local silver = #first
  local second = look_and_say(first, 10)
  local gold   = #second
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
