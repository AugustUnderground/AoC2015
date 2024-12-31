local io = require('io')
local ins = require('inspect')

local U = {}

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
    table.insert(r, {table.unpack(list)})
  else
    for i = 1,n do
      list[i], list[n] = list[n], list[i]
      U.permutations(list, n - 1, r)
      list[i], list[n] = list[n], list[i]
    end
  end
  return r
end

function U.cyclic_permuations(list)
  local perms = {}
  local n = #list
  for j = 0,(n - 1) do
    local combo = {}
    for i = 0,(n - 1) do
      combo[i + 1] = list[((i-j)%n)+1]
    end
    perms[j + 1] = combo
  end
  return perms
end

function U.no_cyclic_permuations(list)
  local head = table.remove(list, 1)
  local perms = U.permutations(list)
  for i = 1,#perms do
    local perm = perms[i]
    table.insert(perm, 1, head)
    perms[i] = perm
  end
  table.insert(list, 1, head)
  return perms
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

function U.sum(xs)
  local s = 0
  for _,x in ipairs(xs) do
    if type(x) == 'number' then
      s = s + x
    end
  end
  return s
end

function U.as_list(str)
  local tbl = {}
  for i = 1, #str do
    tbl[i] = str:sub(i, i)
  end
  return tbl
end

function U.is_array(tbl)
  local i = 1
  for _ in pairs(tbl) do
    if tbl[i] == nil then return false end
    i = i + 1
  end
  return true
end

function U.max_keys(tbl)
  local max  = nil
  local keys = {}
  for _,v in pairs(tbl) do
    if max == nil or v > max then
      max = v
    end
  end
  for k, v in pairs(tbl) do
    if v == max then
      table.insert(keys, k)
    end
  end
  return keys, max
end

function U.copy_mtx(mtx)
  local new = {}
  for r = 1,#mtx do
    new[r] = {}
    for c = 1,#mtx do
      new[r][c] = mtx[r][c]
    end
  end
  return new
end

function U.num_divisors(n)
  local num = 2
  local div = 2
  while (div ^ 2) < n do
    if n % div == 0 then
      num = num + 2
    end
    div = div + 1
  end
  if (div ^ 2) == n then
    num = num + 1
  end
  return num
end

function U.sum_divisors(n)
  if n <= 0 then return 0 end
  local sum = 0
  for d = 1,math.floor(math.sqrt(n)) do
    if n % d == 0 then
      sum = sum + d + math.floor(n / d)
      if d == (n / d) then
        sum = sum - d
      end
    end
  end
  return sum
end

return U
