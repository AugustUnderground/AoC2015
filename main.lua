local days = {}
local num  = 25
for d = 1,num do
  days[d] = require('solutions.day' .. string.format('%02i', tostring(d)))
end

-- days[25].solve()

for day = 1,num do
  print("Day " .. string.format('%02i', tostring(day)) .. ":")
  days[day].solve()
end
print('✧･ﾟ: *✧･ﾟ:* ' .. tostring(#days)
                     .. ' solutions for AoC 2015 '
                     .. ' *:･ﾟ✧*:･ﾟ✧ ')
