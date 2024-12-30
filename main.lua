local days = {}
for d = 1,15 do
  days[d] = require('solutions.day' .. string.format('%02i', tostring(d)))
end

days[15].solve()

-- for day = 1, #days - 1 do
--   print("Day " .. tostring(day) .. ":")
--   days[day].solve()
-- end
-- print('✧･ﾟ: *✧･ﾟ:* ' .. tostring(#days - 1)
--                      .. ' solutions for AoC 2015 '
--                      .. ' *:･ﾟ✧*:･ﾟ✧ ')
