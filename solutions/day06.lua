local utl = require('solutions.util')

local S = {}

local grid = {}
for r = 1, 1000 do
    grid[r] = {}
    for c = 1, 1000 do
        grid[r][c] = false
    end
end

local gridb = {}
for r = 1, 1000 do
    gridb[r] = {}
    for c = 1, 1000 do
        gridb[r][c] = 0
    end
end

local function switch(r1,c1,r2,c2,inst)
  for r = r1, r2 do
    for c = c1, c2 do
      if inst == 'on' then
        grid[r][c] = true
      elseif inst == 'off' then
        grid[r][c] = false
      else
        grid[r][c] = not grid[r][c]
      end
    end
  end
end

local function dim(r1,c1,r2,c2,inst)
  for r = r1, r2 do
    for c = c1, c2 do
      if inst == "on" then
        gridb[r][c] = gridb[r][c] + 1
      elseif inst == "off" then
        gridb[r][c] = math.max(0, gridb[r][c] - 1)
      else
        gridb[r][c] = gridb[r][c] + 2
      end
    end
  end
end

local function instruction(str,part)
  local regex = '(%a+) (%d+),(%d+) through (%d+),(%d+)'
  for inst,r1,c1,r2,c2 in string.gmatch(str, regex) do
    if part == 1 then
      switch(r1+1,c1+1,r2+1,c2+1,inst)
    else
      dim(r1+1,c1+1,r2+1,c2+1,inst)
    end
  end
end

local function lights()
  local num_lights = 0
  for r = 1, 1000 do
    for c = 1, 1000 do
      if grid[r][c] then
        num_lights = num_lights + 1
      end
    end
  end
  return num_lights
end

local function brightness()
  local bright = 0
  for r = 1, 1000 do
    for c = 1, 1000 do
      bright = bright + gridb[r][c]
    end
  end
  return bright
end

function S.solve()
  local input  = utl.read_input('./inputs/day06.txt')
  for _,line in ipairs(input) do
    instruction(line,1)
    instruction(line,2)
  end
  local silver = lights()
  local gold   = brightness()
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
