local utl = require('solutions.util')

local S = {}

local spells = { MagicMissile = {Cost =  53, Damage = 4}
               , Drain        = {Cost =  73, Damage = 2, Heal = 2}
               , Shield       = {Cost = 113, Turns = 6, Armor = 7}
               , Poison       = {Cost = 173, Turns = 6, DoT = 3}
               , Recharge     = {Cost = 229, Turns = 5, Mana = 101} }

local function init_game(input)
  local game = {}
  game['Player'] = {HitPoints = 50, Mana = 500, Armor = 0}
  game['State']  = { Timer = { Shield = 0, Poison = 0, Recharge = 0 }
                   , SpellsCast = {}, ManaSpent = 0 }
  game['Boss']   = {}
  for _,line in ipairs(input) do
    local k,v = line:match('^(.+):%s+(%d+)$')
    game['Boss'][k:gsub('%s+','')] = tonumber(v)
  end
  return game
end

local function effects(game)
  if game['State']['Timer']['Shield'] > 0 then
    game['State']['Timer']['Shield'] = game['State']['Timer']['Shield'] - 1
    if game['State']['Timer']['Shield'] == 0 then
      game['Player']['Armor'] = 0
    end
  end
  if game['State']['Timer']['Poison'] > 0 then
    game['Boss']['HitPoints'] = game['Boss']['HitPoints'] - spells['Poison']['DoT']
    game['State']['Timer']['Poison'] = game['State']['Timer']['Poison'] - 1
  end
  if game['State']['Timer']['Recharge'] > 0 then
    game['Player']['Mana'] = game['Player']['Mana'] + spells['Recharge']['Mana']
    game['State']['Timer']['Recharge'] = game['State']['Timer']['Recharge'] - 1
  end
  return game
end

local function turn(char, game, spell)
  if char == 'Boss' then
    game['Player']['HitPoints'] = game['Player']['HitPoints']
         - math.max(1, game['Boss']['Damage'] - game['Player']['Armor'])
    return game
  else
    if spell['Damage'] then
      game['Boss']['HitPoints'] = game['Boss']['HitPoints'] - spell['Damage']
    end
    if spell['Heal'] then
      game['Player']['HitPoints'] = game['Player']['HitPoints'] + spell['Heal']
    end
    if spell['Turns'] then
      if spell['Armor'] then
        game['Player']['Armor'] = game['Player']['Armor'] + spell['Armor']
        game['State']['Timer']['Shield'] = spell['Turns']
      elseif spell['DoT'] then
        game['State']['Timer']['Poison'] = spell['Turns']
      elseif spell['Mana'] then
        game['State']['Timer']['Recharge'] = spell['Turns']
      end
    end
    game['Player']['Mana'] = game['Player']['Mana'] - spell['Cost']
  end
  return game
end

local function gameover(game, min_mana)
  if game['Boss']['HitPoints'] <= 0 then
    min_mana = math.min(game['State']['ManaSpent'], min_mana)
    return 1, min_mana
  elseif game['Player']['HitPoints'] <= 0 then
    return 2, min_mana
  else
    return 0, min_mana
  end
end

local function try_spells(game, min_mana, new_games)
  local available = {}
  for name,spell in pairs(spells) do
    if spell['Cost'] <= game['Player']['Mana'] then
      if name == 'Shield' and game['State']['Timer']['Shield'] == 0 then
        available[name] = spell
      elseif name == 'Poison' and game['State']['Timer']['Poison'] == 0 then
        available[name] = spell
      elseif name == 'Recharge' and game['State']['Timer']['Recharge'] == 0 then
        available[name] = spell
      elseif name ~= 'Recharge' and name ~= 'Poison' and name ~= 'Shield' then
        available[name] = spell
      end
    end
  end
  if game['State']['Timer']['Shield'] and available['Shield'] then
    table['Shield'] = nil
  end
  if game['State']['Timer']['Poison'] and available['Poison'] then
    table['Poison'] = nil
  end
  if game['State']['Timer']['Recharge'] and available['Recharge'] then
    table['Recharge'] = nil
  end
  for _,spell in pairs(available) do
    local sub_game = utl.deepcopy(game)
    local cast = sub_game['State']['SpellsCast']
    table.insert(cast, spell)
    sub_game['State']['SpellsCast'] = cast
    sub_game['State']['ManaSpent'] = sub_game['State']['ManaSpent'] + spell['Cost']
    sub_game = turn('Player', sub_game, spell)
    local go
    go,min_mana = gameover(sub_game, min_mana)
    if go == 0 and (sub_game['State']['ManaSpent'] <= min_mana) then
      sub_game = effects(sub_game)
      go,min_mana = gameover(sub_game, min_mana)
      if go == 0 then
        sub_game = turn('Boss', sub_game)
        go,min_mana = gameover(sub_game, min_mana)
        if go == 0 then
          table.insert(new_games, sub_game)
        end
      end
    end
  end
  return new_games,min_mana
end

local function try(games, min_mana, hard)
  local new_games = {}
  for _,game in ipairs(games) do
    if hard then
      game['Player']['HitPoints'] = game['Player']['HitPoints'] - 1
    end
    local go
    go,min_mana = gameover(game, min_mana)
    if go == 0 then
      game = effects(game)
      go,min_mana = gameover(game, min_mana)
      if go == 0 then
        new_games,min_mana = try_spells(game, min_mana, new_games)
      end
    end
  end
  return new_games,min_mana
end

local function play(game, hard)
  local min_mana = math.huge
  local games = { game }
  while #games > 0 do
    games,min_mana = try(games, min_mana, hard)
  end
  return min_mana
end

function S.solve()
  local input  = utl.read_input('./inputs/day22.txt')
  local game   = init_game(input)
  local silver = play(game,false)
  local ngp    = init_game(input)
  local gold   = play(ngp,true)
  print('\tSilver: ', silver)
  print('\tGold:   ', gold)
end

return S
