local utl = require('solutions.util')

local S = {}

local function enc(str)
  local lst = {}
  for i = 1,#str do
    lst[i] = string.byte(string.sub(str, i, i + 1))
  end
  return lst
end

local function dec(lst)
  local str = ''
  for i = 1,#lst do
    str = str .. string.char(lst[i])
  end
  return str
end

local function seq(lst)
  for i = 1,#lst - 2 do
    if (lst[i] + 2) == (lst[i + 1] + 1) and
       (lst[i + 1] + 1) == lst[i + 2] then
      return true
    end
  end
  return false
end

local function prs(lst)
  local pairs = {}
  local count = 0
  for i = 1, #lst do
    local a = lst[i]
    if pairs[a] and pairs[a] == i - 1 then
      count = count + 1
      pairs[a] = nil
    else
      pairs[a] = i
    end
    if count == 2 then
      return true
    end
  end
  return false
end

local function inc(lst)
  local ill = {105, 108, 111}
  for i = #lst,1, -1 do
    if lst[i] == 122 then
      lst[i] = 97
    else
      lst[i] = lst[i] + 1
      break
    end
  end
  for i = 1,#lst do
    if utl.contains(ill, lst[i]) then
      lst[i] = lst[i] + 1
      for j = (i + 1),#lst do
        lst[j] = 97
      end
      break
    end
  end
  return lst
end

local function next(psw)
  local nxt = inc(psw)
  if seq(nxt) and prs(nxt) then
    return psw
  else
    return next(nxt)
  end
end

function S.solve()
  local input  = utl.read_input('./inputs/day11.txt')
  local psw    = enc(input[1])
  local silver = dec(next(psw))
  local gold   = dec(next(enc(silver)))
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
