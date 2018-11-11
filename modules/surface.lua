
function enterPlanet(i)
  surface = {planet = i, x = 4, y = 4, zoneX = 1, zoneY = 1, shipx = 4, shipy = 4, shipZX = 1, shipZY = 1, selX = 1, selY = 1, sel = false}
--  for i = 1, planet[i]
  game.planet[i].visited = true
  phase = "surface"
  uncoverFog()
end

function drawSurface()
  for x = 1, 13 do
    for y = 1, 6 do
      local pi = planetImg[game.planet[surface.planet].img]
      love.graphics.setColor(pi.r, pi.g, pi.b)
      love.graphics.draw(surfaceImg[game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].type],(x-1)*24,(y-1)*24)
      if game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unit then
        love.graphics.setColor(1,1,1)
        if unitImg[game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unit] then
          love.graphics.draw(unitImg[game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unit],(x-1)*24,(y-1)*24)
        elseif raceImg[game.race[game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unit].img].idle then
          love.graphics.draw(raceImg[game.race[game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unit].img].idle,(x-1)*24,(y-1)*24)
        end
        if game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unitCount then
          love.graphics.setColor(0,0,0,0.2)
          love.graphics.rectangle("fill",(x-1)*24,(y-1)*24,24,8)
          love.graphics.setColor(1,1,1,1)
          love.graphics.setFont(tFont)
          love.graphics.printf(game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unitCount,(x-1)*24,(y-1)*24,24,"left")
        end
        love.graphics.setFont(font)
      end
      love.graphics.setColor(0,0,0,game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].fog)
      love.graphics.rectangle("fill",(x-1)*24,(y-1)*24,24,24)

      love.graphics.setColor(1,1,1,1)
      if surface.shipx == x and surface.shipy == y and surface.shipZX == surface.zoneX and surface.shipZY == surface.zoneY then love.graphics.draw(vehicleImg["ship1"],(surface.shipx-1)*24,(surface.shipy-1)*24)   if surface.shipx == x and surface.shipy == y and surface.x == x and surface.y == y then drawMessageBox("Press <"..KEY_LAND.."> to leave planet",180-32) end end
      if surface.x == x and surface.y == y then love.graphics.draw(raceImg["human"].player,(surface.x-1)*24,(surface.y-1)*24) end

      if getUnit() == "miner" then
        drawMessageBox("Press <space> to start assignment",180-16)
      elseif getUnit() == "flag" then
        drawMessageBox("Press <1> to build miner (1r)",180-64)
        drawMessageBox("Press <2> to build research center (3r)",180-48)
        drawMessageBox("Press <3> to build barracks (10r)",180-32)
        drawMessageBox("Press <4> to build turret (20r)",180-16)
      elseif player.res > 0 then
        drawMessageBox("Press <"..KEY_SCAN.."> to claim this territory.",180-16)
      end

      if surface.selX == x and surface.selY == y and surface.sel then love.graphics.setColor(1,0,0) love.graphics.rectangle("line",(x-1)*24,(y-1)*24, 24, 24) end
    end
  end
end

function updateSurface(dt)
  if love.keyboard.isDown(KEY_LEFT) then
    player.nextMove = player.nextMove - 1*dt
    if player.nextMove < 0 then movePlayer(KEY_LEFT) player.nextMove = 0.2 end
  elseif love.keyboard.isDown(KEY_RIGHT) then
    player.nextMove = player.nextMove - 1*dt
    if player.nextMove < 0 then movePlayer(KEY_RIGHT) player.nextMove = 0.2 end
  elseif love.keyboard.isDown(KEY_UP) then
      player.nextMove = player.nextMove - 1*dt
      if player.nextMove < 0 then movePlayer(KEY_UP) player.nextMove = 0.2 end
  elseif love.keyboard.isDown(KEY_DOWN) then
    player.nextMove = player.nextMove - 1*dt
    if player.nextMove < 0 then movePlayer(KEY_DOWN) player.nextMove = 0.2 end
  else
    player.nextMove = 0
  end
end

function getUnit() -- returns the unit on the current player tile
  if game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y] and game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit then
    return game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][surface.x][surface.y].unit
  else
    return false
  end
end

function updatePlanet(dt,i)
  for k, v in pairs(game.planet[i].zone) do
    for h,z in pairs(v) do
      for x = 1, 13 do
        for y = 1, 6 do
          if z[x][y].unit then
              local tu = z[x][y].unit

              if tu == "flag" then
                --if love.math.random(1,50) == 1 then
                --  game.planet[i].zone[k][h][x][y].unit = "miner"
                --end
              end
            end
        end
      end
    end
  end

  for k = 1, #game.planet[i].actions do
    local v = game.planet[i].actions[k]
    if v.type == "mine" and game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].type == "rock"  then
      if love.math.random(1,1500) == 1 then
        if game.planet[i].zone[v.zoneX][v.zoneY][v.x1][v.y1].unitCount and game.planet[i].zone[v.zoneX][v.zoneY][v.x1][v.y1].unitCount < 6 then
          game.planet[i].zone[v.zoneX][v.zoneY][v.x1][v.y1].unitCount = game.planet[i].zone[v.zoneX][v.zoneY][v.x1][v.y1].unitCount + 1
          if love.math.random(1,25) == 1 then
            game.race[game.planet[i].race].hostility = game.race[game.planet[i].race].hostility + 1
          end
        else
          game.planet[i].zone[v.zoneX][v.zoneY][v.x1][v.y1].unitCount = 1
        end
      end
    elseif v.type == "attack" and game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].unitCount  then
      if love.math.random(1,150) == 1 then
        game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].unitCount = game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].unitCount - 1
        if game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].unitCount and  game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].unitCount < 1 then
          game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].unitCount = nil
          game.planet[i].zone[v.zoneX][v.zoneY][v.x2][v.y2].unit = nil
          game.race[game.planet[i].race].hostility = game.race[game.planet[i].race].hostility + 3
        end
        game.race[game.planet[i].race].hostility = game.race[game.planet[i].race].hostility + 1
      end
    end
  end
end

function findNextFreeSpace(z)
  if not z[x+1][y].unit then
    return z[x+1][y]
  elseif not z[x-1][y].unit then
    return z[x-1][y]
  elseif not z[x][y+1].unit then
    return z[x][y+1]
  elseif not z[x][y-1].unit then
    return z[x][y-1]
  end
end

function uncoverFog()
  for x = surface.x-1, surface.x+1 do
    for y = surface.y-1, surface.y+1 do
      if game.planet[surface.planet].zone[surface.zoneX] and game.planet[surface.planet].zone[surface.zoneX][surface.zoneY] and game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x] and game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y] and game.planet then
        game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].fog = 0
      end
    end
  end
end

--addAction("mine",surface.zoneX,surface.zoneY,surface.selX,surface.selY,surface.x,surface.y)

function addAction(type,zoneX,zoneY,x1,y1,x2,y2,i)
  game.planet[i].actions[#game.planet[i].actions+1] = {
    type = type,
    zoneX = zoneX,
    zoneY = zoneY,
    x1 = x1,
    y1 = y1,
    x2 = x2,
    y2 = y2
  }
end

function movePlayer(key)
  if key == KEY_UP then surface.y = surface.y - 1 end
  if key == KEY_DOWN then surface.y = surface.y + 1 end
  if key == KEY_LEFT then surface.x = surface.x - 1 end
  if key == KEY_RIGHT then surface.x = surface.x + 1 end

  if surface.x > 13 then
    surface.x = 1
    surface.zoneX = surface.zoneX + 1
    surface.sel = false
  elseif surface.x < 1 then
    surface.x = 13
    surface.zoneX = surface.zoneX - 1
    surface.sel = false
  elseif surface.y > 6 then
    surface.y = 1
    surface.zoneY = surface.zoneY + 1
    surface.sel = false
  elseif surface.y < 1 then
    surface.y = 6
    surface.zoneY = surface.zoneY - 1
    surface.sel = false
  end

  if not game.planet[surface.planet].zone[surface.zoneX] then game.planet[surface.planet].zone[surface.zoneX] = {} end
  if not game.planet[surface.planet].zone[surface.zoneX][surface.zoneY] then
    game.planet[surface.planet].zone[surface.zoneX][surface.zoneY] = generateZone(surface.planet)
  end
  uncoverFog()
end
