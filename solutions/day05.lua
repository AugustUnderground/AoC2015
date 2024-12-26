local utl = require('solutions.util')

local S = {}

local function has_3_vowels(str)
    local vowels   = 'aeiou'
    local n_vowels = 0
    for i = 1, #str do
        local char = str:sub(i, i)
        if vowels:find(char) then
            n_vowels = n_vowels + 1
        end
        if n_vowels >= 3 then
            return true
        end
    end
    return false
end

local function has_consecutives(str)
    for i = 1, #str - 1 do
        if str:sub(i, i) == str:sub(i + 1, i + 1) then return true end
    end
    return false
end

local function has_naughties(str)
    for i = 1, #str - 1 do
      local letters = str:sub(i, i + 1)
        if letters == 'ab' or letters == 'cd' or
           letters == 'pq' or letters == 'xy' then
          return true
        end
    end
    return false
end

local function is_nice(str)
  local vowels       = has_3_vowels(str)
  local consectuvies = has_consecutives(str)
  local naughties    = has_naughties(str)
  return vowels and consectuvies and not naughties
end

local function has_pair(str)
  local pairs = {}
  for i = 1, #str - 1 do
    local pair = str:sub(i, i + 1)
    if pairs[pair] and pairs[pair] < i - 1 then
      return true
    end
    if not pairs[pair] then pairs[pair] = i end
  end
  return false
end

local function has_repeat(str)
  for i = 1, #str - 2 do
    if str:sub(i, i) == str:sub(i+2, i+2) then
      return true
    end
  end
  return false
end

local function is_nicer(str)
  local pair = has_pair(str)
  local rep  = has_repeat(str)
  return pair and rep
end

function S.solve()
  local input  = utl.read_input('./inputs/day05.txt')
  local silver = 0
  local gold   = 0
  for _,line in ipairs(input) do
    if is_nice(line) then
      silver = silver + 1
    end
    if is_nicer(line) then
      gold = gold + 1
    end
  end
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
