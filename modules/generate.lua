function startGame(seed) -- generates a new game
  game = {}
  game.races = love.math.random(4,settings.races)
  game.planets = love.math.random(20,200)

  game.race = {}
  game.planet = {}

  local takenRaces = {} -- list of races whose images have been taken already

  for i = 1, game.races do
    local newRace = {atk = 0, def = 0, int = 0, img = love.math.random(1, settings.races), name = generateRaceName(), hostility = love.math.random(-5,5)} -- attack, defense, intelligence, diplomacy. Gun and melee attacks deal ATTACK damage, pistol attacks deal ATTACK/2 damage. Attacks against a race will be decreased by 1 to DEFENSE. Learning chance is a d10 and success if lower than INT rating. Diplomacy defines whether a race joins your union, d10.

    local ap = love.math.random(1,10)

    while ap > 0 do -- assign action points
      local k = love.math.random(1, 4) -- attribute to assign to
      if k == 1 then newRace.atk = newRace.atk + 1
      elseif k == 2 then newRace.def = newRace.def + 1
      elseif k == 3 then newRace.int = newRace.int + 1 end
      ap = ap - 1
    end

    while takenRaces[newRace.img] do
        newRace.img = love.math.random(1, settings.races)
    end

    takenRaces[newRace.img] = true

    game.race[i] = newRace
  end

  for i = 1, game.planets do
    local newPlanet = {x = love.math.random(1, 4000), y = love.math.random(1, 4000), img = love.math.random(1, settings.planets), race = love.math.random(1,game.races), zone = {}, life = love.math.random(1, 10), visited = false, actions = {}}
    game.planet[i] = newPlanet

    newPlanet.zone[1] = {}
    newPlanet.zone[1][1] = generateZone(i)

    game.planet[i] = newPlanet
  end

  generateStars()

  phase = "space"
end

function generateZone(i)
  local z = {}
  local zt = "plains"
    if game.planet[i].img == 1 and love.math.random(1,3) == 1 then zt = "mine" end

  if love.math.random(1, 10) > game.planet[i].life then
    if love.math.random(1,4) == 1 then zt = "mine"
    elseif love.math.random(1,2) == 1 then zt = "house"
    elseif love.math.random(1,5) == 1 then zt = "industry"
    elseif love.math.random(1,10) == 1 then zt = "military" end
  end

  for x = 1, 13 do
    z[x] = {}
    for y = 1, 6 do
      z[x][y] = {}
      if zt == "house" and love.math.random(1,8) == 1 then
        z[x][y].type = "house"
      elseif zt == "mine" and love.math.random(1,10) == 1 then
        z[x][y].type = "rock"
      else
        z[x][y].type = "ground"
      end

      --units
      if love.math.random(1,3) == 1 then
        if zt == "house" and z[x][y].type == "ground" and love.math.random(1,10) then
          z[x][y].unit = game.planet[i].race
          z[x][y].unitCount = love.math.random(1,8)
        end
      end

      z[x][y].fog = 1
    end
  end

  return z
end

function generateRaceName()
  local list = {"zer","bler","blart","blast","flar","pa","yu","yak","yik","jordan","maslen","louis","hardcastle","thomas","lock","tom","ager","ryan","grange","dinkie","shy","headleand","harry","jones","-","'"}
  local name = ""
  for i = 1, love.math.random(1,4) do
    name = name..list[love.math.random(1,#list)]
    if i == 1 then
      name = string.upper(string.sub(name,1,1))..string.sub(name,2) -- capitalise first letter
    end
  end

  return name
end
