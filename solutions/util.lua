local io = require('io')
local inspect = require('inspect')

local U = {}
local unpack = table.unpack or unpack

function U.read_input(path)
  local lines = {}
  local file  = io.open(path)
  if file then
    for line in file:lines() do
      table.insert(lines, line)
    end
    file:close()
  else
    print('Error: Could not open file.')
  end
  return lines
end

function U.encode(x, y)
  return x .. "," .. y
end

function U.numel(dict)
    local num = 0
    for _,_ in pairs(dict) do
      num = num + 1
    end
    return num
end

function U.any(tbl)
  for _,e in pairs(tbl) do
    if e ~= nil then
      return true
    end
  end
  return false
end

function U.all(tbl)
  for _,e in pairs(tbl) do
    if e == nil then
      return false
    end
  end
  return true
end

function U.keyset(tbl)
  local keyset = {}
  local n      = 0
  for k,_ in pairs(tbl) do
    n = n + 1
    keyset[n] = k
  end
  return keyset
end

function U.permutations(list, num, res)
  local n = num or #list
  local r = res or {}
  if n == 1 then
    table.insert(r, {unpack(list)})
  else
    for i = 1,n do
      list[i], list[n] = list[n], list[i]
      U.permutations(list, n - 1, r)
      list[i], list[n] = list[n], list[i]
    end
  end
  return r
end

function U.reverse(list)
  local rev = {}
  for i = #list, 1, -1 do
      rev[#rev+1] = list[i]
  end
  return rev
end

function U.contains(xs, x)
  if xs then
    for _, v in ipairs(xs) do
      if v == x then return true end
    end
  end
  return false
end

function U.equal(xs, ys)
  local n = #xs
  local m = #ys
  if n ~= m then return false end
  for i = 1,n do
    if xs[i] ~= ys[i] then return false end
  end
  return true
end

function U.as_list(str)
  local tbl = {}
  for i = 1, #str do
    tbl[i] = str:sub(i, i)
  end
  return tbl
end

return U
