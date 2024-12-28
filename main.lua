local days = { require('solutions.day01')
             , require('solutions.day02')
             , require('solutions.day03')
             , require('solutions.day04')
             , require('solutions.day05')
             , require('solutions.day06')
             , require('solutions.day07')
             , require('solutions.day08')
             , require('solutions.day09')
             , require('solutions.day10')
             , require('solutions.day11')
             , require('solutions.day12')
             }

days[12].solve()

-- for day = 1, #days - 1 do
--   print("Day " .. tostring(day) .. ":")
--   days[day].solve()
-- end
-- print('✧･ﾟ: *✧･ﾟ:* ' .. tostring(#days - 1)
--                      .. ' solutions for AoC 2015 '
--                      .. ' *:･ﾟ✧*:･ﾟ✧ ')
