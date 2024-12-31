local utl = require('solutions.util')

local S = {}

local a,b,ip
local prog = {}

local function reset(_a, _b, _ip)
  a  = _a  or 0
  b  = _b  or 0
  ip = _ip or 1
end

local function parse(input)
  for _,line in ipairs(input) do
    local i1,r1,o1 = line:match('^(%a+)%s+([ab]+),%s++(%d+)$')
    local i2,o2    = line:match('^(%a+)%s+([+-]%d+)$')
    local i3,r2    = line:match('^(%a+)%s+([ab])$')
    if i1 and r1 and o1 then
      table.insert(prog, {instruction = i1, register = r1, offset = tonumber(o1)})
    elseif i2 and o2 then
      table.insert(prog, {instruction = i2, offset = tonumber(o2)})
    elseif i3 and r2 then
      table.insert(prog, {instruction = i3, register = r2})
    end
  end
end

local function execute(command)
  if command['instruction'] == 'hlf' then
    if command['register'] == 'a' then
      a = math.floor(a / 2)
    elseif command['register'] == 'b' then
      b = math.floor(b / 2)
    end
    ip = ip + 1
  elseif command['instruction'] == 'tpl' then
    if command['register'] == 'a' then
      a = a * 3
    elseif command['register'] == 'b' then
      b = b * 3
    end
    ip = ip + 1
  elseif command['instruction'] == 'inc' then
    if command['register'] == 'a' then
      a = a + 1
    elseif command['register'] == 'b' then
      b = b + 1
    end
    ip = ip + 1
  elseif command['instruction'] == 'jmp' then
    ip = ip + command['offset']
  elseif command['instruction'] == 'jie' then
    local reg = 0
    if command['register'] == 'a' then
      reg = a
    elseif command['register'] == 'b' then
      reg = b
    end
    if reg % 2 == 0 then
      ip = ip + command['offset']
    else
      ip = ip + 1
    end
  elseif command['instruction'] == 'jio' then
    local reg = 0
    if command['register'] == 'a' then
      reg = a
    elseif command['register'] == 'b' then
      reg = b
    end
    if reg == 1 then
      ip = ip + command['offset']
    else
      ip = ip + 1
    end
  end
end

local function run()
  while ip <= #prog do execute(prog[ip]) end
  return b
end

function S.solve()
  local input  = utl.read_input('./inputs/day23.txt')
  parse(input)
  reset(0,0,1)
  local silver = run()
  reset(1,0,1)
  local gold   = run()
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
