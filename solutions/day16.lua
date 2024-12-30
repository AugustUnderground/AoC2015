local utl = require('solutions.util')

local S = {}

local attributes = { 'children', 'cats', 'samoyeds', 'pomeranians', 'akitas'
                   , 'vizslas', 'goldfish', 'trees', 'cars', 'perfumes' }

local sue = { children    = function (x) return x == 3 end
            , cats        = function (x) return x == 7 end
            , samoyeds    = function (x) return x == 2 end
            , pomeranians = function (x) return x == 3 end
            , akitas      = function (x) return x == 0 end
            , vizslas     = function (x) return x == 0 end
            , goldfish    = function (x) return x == 5 end
            , trees       = function (x) return x == 3 end
            , cars        = function (x) return x == 2 end
            , perfumes    = function (x) return x == 1 end }

local real_sue = { children    = function (x) return x == 3 end
                 , cats        = function (x) return x  > 7 end
                 , samoyeds    = function (x) return x == 2 end
                 , pomeranians = function (x) return x  < 3 end
                 , akitas      = function (x) return x == 0 end
                 , vizslas     = function (x) return x == 0 end
                 , goldfish    = function (x) return x  < 5 end
                 , trees       = function (x) return x  > 3 end
                 , cars        = function (x) return x == 2 end
                 , perfumes    = function (x) return x == 1 end }

local aunts = {}

local function parse(input)
  for id,line in ipairs(input) do
    local atts = {}
    for _,att in ipairs(attributes) do
      local has = line:match(att .. ':%s+(%d+)')
      if has then
        atts[att] = tonumber(has)
      end
    end
    aunts[id] = atts
  end
end

local function find_sue()
  local giver = {}
  local real  = {}
  for id,atts in ipairs(aunts) do
    local is = true
    for att,pred in pairs(sue) do
      if atts[att] and not pred(atts[att]) then
        is = false
        break
      end
    end
    if is then
      table.insert(giver, id)
    end
    is = true
    for att,pred in pairs(real_sue) do
      if atts[att] and not pred(atts[att]) then
        is = false
        break
      end
    end
    if is then
      table.insert(real, id)
    end
  end
  return giver[1], real[1]
end

function S.solve()
  local input  = utl.read_input('./inputs/day16.txt')
  parse(input)
  local silver, gold = find_sue()
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
