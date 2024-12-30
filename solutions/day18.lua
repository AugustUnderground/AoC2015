local utl = require('solutions.util')

local S = {}

local grid = {}

local function parse(input)
  for r,line in ipairs(input) do
    grid[r] = {}
    for c = 1, #line do
      local l =line:sub(c,c)
      if l == '#' then
        grid[r][c] = 1
      else
        grid[r][c] = 0
      end
    end
  end
end

local function neighbors(r,c)
  local ns = {}
  for rr = -1,1 do
    for cc = -1,1 do
      if rr ~= 0 or cc ~= 0 then
        if grid[rr + r] and grid[rr + r][cc + c] then
          table.insert(ns, grid[rr + r][cc + c])
        end
      end
    end
  end
  return ns
end

local function fix()
  grid[1][1] = 1
  grid[#grid][1] = 1
  grid[#grid][#grid] = 1
  grid[1][#grid] = 1
end

local function animate(steps, fixed)
  if fixed then fix() end
  if steps == 0 then
    local sum = 0
    for r = 1,#grid do
      sum = sum + utl.sum(grid[r])
    end
    return sum
  end
  local new = utl.copy_mtx(grid)
  for r = 1,#grid do
    for c = 1,#grid do
      local ns = neighbors(r,c)
      local sm = utl.sum(ns)
      if grid[r][c] == 1 and not (sm == 2 or sm == 3) then
        new[r][c] = 0
      elseif grid[r][c] == 0 and sm == 3 then
        new[r][c] = 1
      end
    end
  end
  grid = new
  return animate(steps - 1, fixed)
end

function S.solve()
  local input  = utl.read_input('./inputs/day18.txt')
  parse(input)
  local silver = animate(100, false)
  parse(input)
  local gold   = animate(100, true)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
