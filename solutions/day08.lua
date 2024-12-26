local utl = require('solutions.util')

local S = {}

local function num_chars(input)
  local str_len = 0
  local raw_len = 0
  local enc_len = 0
  for _,raw in ipairs(input) do
    raw_len   = raw_len + string.len(raw)
    local str = string.gsub( string.gsub( string.gsub(raw, '\\"','"')
                                        , '\\\\', '%\\' )
                           , '\\x%w%w', 'x' )
    str_len   = str_len + (string.len(str) - 2)
    local enc = string.gsub(
                  string.gsub(
                    string.gsub(
                      string.gsub( string.gsub( raw, '\\\\', 'bbbb')
                                 , '\\"', 'qq\\"' )
                               , '\\x', '\\xx' )
                             , '^"','"q"' )
                           , '"$', 'q""' )
    enc_len   = enc_len + string.len(enc)
  end
  return raw_len, str_len, enc_len
end

function S.solve()
  local input       = utl.read_input('./inputs/day08.txt')
  local raw,str,enc = num_chars(input)
  local silver      = raw - str
  local gold        = enc - raw
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
