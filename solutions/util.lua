local io = require('io')
local U = {}

function U.read_input(path)
  local lines = {}
  local file  = io.open(path)
  if file then
    for line in file:lines() do
      table.insert(lines, line)
    end
    file:close()
  else
    print('Error: Could not open file.')
  end
  return lines
end

function U.encode(x, y)
  return x .. "," .. y
end

function U.numel(dict)
    local num = 0
    for _,_ in pairs(dict) do
      num = num + 1
    end
    return num
end

function U.any(tbl)
  for _,e in pairs(tbl) do
    if e ~= nil then
      return true
    end
  end
  return false
end

function U.all(tbl)
  for _,e in pairs(tbl) do
    if e == nil then
      return false
    end
  end
  return true
end

return U
