local utl = require('solutions.util')

local S = {}

local ingredients = {}

local function parse(input)
  local regex = '^(%a+):%s+capacity%s+([+-]?%d+),%s+durability%s+([+-]?%d+)'
              .. ',%s+flavor%s+([+-]?%d+),%s+texture%s+([+-]?%d+)'
              .. ',%s+calories%s+([+-]?%d+)$'
  local capacity   = {}
  local durability = {}
  local flavor     = {}
  local texture    = {}
  local calories   = {}
  for _,line in ipairs(input) do
    local _,c,d,f,t,k = line:match(regex)
    table.insert(capacity, tonumber(c))
    table.insert(durability, tonumber(d))
    table.insert(flavor, tonumber(f))
    table.insert(texture, tonumber(t))
    table.insert(calories, tonumber(k))
  end
  ingredients = { capacity   = capacity
                , durability = durability
                , flavor     = flavor
                , texture    = texture
                , calories   = calories }
end

local function score()
  local total  = 0
  local caltot = 0
  for i = 0, 100 do
    for j = 0, 100 - i do
      for k = 0, 100 - i - j do
        local l = 100 - i - j - k
        local vals = {i, j, k, l}
        local cap, dur, fla, tex, cal = 0, 0, 0, 0, 0
        for c,v in ipairs(vals) do
            cap = cap + v * ingredients['capacity'][c]
            dur = dur + v * ingredients['durability'][c]
            fla = fla + v * ingredients['flavor'][c]
            tex = tex + v * ingredients['texture'][c]
            cal = cal + v * ingredients['calories'][c]
        end
        local prod = math.max(cap,0) * math.max(dur,0)
                    * math.max(fla,0) * math.max(tex,0)
        if prod > total then total = prod end
        if cal == 500 and prod > caltot then caltot = prod end
      end
    end
  end
  return total, caltot
end

function S.solve()
  local input  = utl.read_input('./inputs/day15.txt')
  parse(input)
  local silver, gold = score()
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
