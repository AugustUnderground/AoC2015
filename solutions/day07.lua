local utl = require('solutions.util')
local bit = require('bit32')

local S = {}

local signals = {}

local function value(str)
  local num = tonumber(str, 10)
  if num then return num else return signals[str] end
end

local function instruction(str)
  local re_sig = '^(%w+)%s+->%s+(%a+)$'
  local re_and = '^(%w+)%s+AND%s+(%w+)%s+->%s+(%a+)$'
  local re_or  = '^(%w+)%s+OR%s+(%w+)%s+->%s+(%a+)$'
  local re_ls  = '^(%a+)%s+LSHIFT%s+(%d+)%s+->%s+(%a+)$'
  local re_rs  = '^(%a+)%s+RSHIFT%s+(%d+)%s+->%s+(%a+)$'
  local re_not = '^NOT%s+(%a+)%s+->%s+(%a+)$'

  local a,b,q,n = '','','',''
  a,q = str:match(re_sig)
  if a and q then
    if value(a) then
      signals[q] = value(a)
      return true
    end
  end
  a,b,q = str:match(re_and)
  if a and b and q then
    if value(a) and value(b) then
      signals[q] = bit.band(value(a),value(b))
      return true
    end
  end
  a,b,q = str:match(re_or)
  if a and b and q then
    if value(a) and value(b) then
      signals[q] = bit.bor(value(a),value(b))
      return true
    end
  end
  a,n,q = str:match(re_ls)
  if a and n and q then
    if value(a) then
      signals[q] = bit.lshift(value(a),tonumber(n))
      return true
    end
  end
  a,n,q = str:match(re_rs)
  if a and n and q then
    if value(a) then
      signals[q] = bit.rshift(value(a),tonumber(n))
      return true
    end
  end
  a,q = str:match(re_not)
  if a and q then
    if value(a) then
      signals[q] = (-1 - value(a)) % 2^16
      return true
    end
  end
  return false
end

local function simulate(input)
  local n = #input

  while utl.any(input) do
    for i = 1,n do
      if input[i] and instruction(input[i]) then
        input[i] = nil
      end
    end
  end
  for k,v in pairs(signals) do
    if k == 'a' then
      return v
    end
  end
  return 0
end

local function override(input,val)
  signals = {}
  local re_sig = '^(%d+)%s+->%s+(%a+)$'
  local n = #input
  for i = 1,n do
    local a,q = input[i]:match(re_sig)
    if a and q then
      if q == 'b' and tonumber(a,10) then
        input[i] = tostring(val) .. ' -> b'
      end
    end
  end
  return input
end

function S.solve()
  local input  = utl.read_input('./inputs/day07.txt')
  local silver = simulate(input)
  input        = utl.read_input('./inputs/day07.txt')
  local gold   = simulate(override(input, silver))
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
