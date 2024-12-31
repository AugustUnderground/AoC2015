local utl = require('solutions.util')
local ins = require('inspect')

local S = {}

local map = {}
local pam = {}

local function parse(input)
  for i,line in ipairs(input) do
    if line ~= '' then
      local k,v = line:match('^(%a+)%s+=>%s+(%a+)$')
      if map[k] then
        map[k][#map[k] + 1] = v
      else
        map[k] = { v }
      end
      pam[v] = k
    else
      return input[i + 1]
    end
  end
end

local function rep(s, pattern, repl)
  local res = {}
  local idx = 1

  while true do
    local start, stop = string.find(s, pattern, idx)
    if not start then
      break
    else
      local before = string.sub(s, 1, start - 1)
      local behind = string.sub(s, stop + 1)
      table.insert(res, before .. repl .. behind)
      idx = stop + 1
    end
  end

  return res
end

local function calibrate(molecule)
  local molecules = {}
  for k,ps in pairs(map) do
    for _,p in ipairs(ps) do
      local reps = rep(molecule, k, p)
      for _,r in ipairs(reps) do
        if molecules[r] ~= nil then
          molecules[r] = molecules[r] + 1
        else
          molecules[r] = 1
        end
      end
    end
  end
  return molecules
end

local function fabricate(molecule)
  local step      = 0
  local patterns  = utl.keyset(pam)
  table.sort(patterns, function(a, b) return a:upper() > b:upper() end)
  while molecule ~= 'e' and step < 201 do
    for _,l in ipairs(patterns) do
      local r = pam[l]
      if (r == 'e' and molecule == l) or (r ~= 'e') then
        if molecule:find(l, 1, true) then
          molecule = molecule:gsub(l, r, 1)
          step = step + 1
          break
        end
      end
    end
  end
  return step
end

function S.solve()
  local input        = utl.read_input('./inputs/day19.txt')
  local molecule     = parse(input)
  local replacements = calibrate(molecule)
  local silver       = utl.numel(replacements)
  local gold         = fabricate(molecule)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
