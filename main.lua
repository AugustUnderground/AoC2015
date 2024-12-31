local days = {}
local num  = 20
for d = 1,num do
  days[d] = require('solutions.day' .. string.format('%02i', tostring(d)))
end

days[20].solve()

-- for day = 1,num do
--   print("Day " .. tostring(day) .. ":")
--   days[day].solve()
-- end
-- print('✧･ﾟ: *✧･ﾟ:* ' .. tostring(#days - 1)
--                      .. ' solutions for AoC 2015 '
--                      .. ' *:･ﾟ✧*:･ﾟ✧ ')
