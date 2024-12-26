local utl = require('solutions.util')

local S = {}

local function coord(x, y, c)
    if c == '^' then
      y = y - 1
    elseif c == 'v' then
      y = y + 1
    elseif c == '<' then
      x = x - 1
    elseif c == '>' then
      x = x + 1
    end
  return x,y
end

local function santa(route)
  local houses = {}
  local x,y = 0,0
  houses[utl.encode(x,y)] = 1

  for i = 1, #route do
    local c = string.sub(route, i, i)
    x,y = coord(x,y,c)
    if houses[utl.encode(x,y)] then
      houses[utl.encode(x,y)] = houses[utl.encode(x,y)] + 1
    else
      houses[utl.encode(x,y)] = 1
    end
  end
  return houses
end

local function robo(route)
  local houses = {}
  local xs,ys,xr,yr = 0,0,0,0
  houses[utl.encode(xs,ys)] = 2

  for i = 1, #route, 2 do
    local cs = string.sub(route, i, i)
    local cr = string.sub(route, i + 1, i + 1)
    xs,ys = coord(xs,ys,cs)
    xr,yr = coord(xr,yr,cr)
    if houses[utl.encode(xs,ys)] then
      houses[utl.encode(xs,ys)] = houses[utl.encode(xs,ys)] + 1
    else
      houses[utl.encode(xs,ys)] = 1
    end
    if houses[utl.encode(xr,yr)] then
      houses[utl.encode(xr,yr)] = houses[utl.encode(xr,yr)] + 1
    else
      houses[utl.encode(xr,yr)] = 1
    end
  end
  return houses
end

function S.solve()
  local input  = utl.read_input('./inputs/day03.txt')
  local silver = utl.numel(santa(input[1]))
  local gold   = utl.numel(robo(input[1]))
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
