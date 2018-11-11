function enterPlanet(i)
  surface = {planet = i, x = 4, y = 4, zoneX = 1, zoneY = 1, shipx = 4, shipy = 4, shipZX = 1, shipZY = 1}
--  for i = 1, planet[i]
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
        love.graphics.draw(raceImg[game.race[game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unit].img].idle,(x-1)*24,(y-1)*24)
        love.graphics.setColor(0,0,0,0.2)
        love.graphics.rectangle("fill",(x-1)*24,(y-1)*24,24,8)
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf("x"..game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].unitCount,(x-1*24),(y-1)*24,"right",24)
      end
      love.graphics.setColor(0,0,0,game.planet[surface.planet].zone[surface.zoneX][surface.zoneY][x][y].fog)
      love.graphics.rectangle("fill",(x-1)*24,(y-1)*24,24,24)

      love.graphics.setColor(1,1,1,1)
      if surface.shipx == x and surface.shipy == y and surface.shipZX == surface.zoneX and surface.shipZY == surface.zoneY then love.graphics.draw(vehicleImg["ship1"],(surface.shipx-1)*24,(surface.shipy-1)*24)   if surface.shipx == x and surface.shipy == y and surface.x == x and surface.y == y then drawMessageBox("Press <"..KEY_LAND.."> to leave planet",180-32) end end
      if surface.x == x and surface.y == y then love.graphics.draw(raceImg["human"].player,(surface.x-1)*24,(surface.y-1)*24) end
    end
  end

  for x = 1, 14 do
    for y = 1, 6 do
      love.graphics.setColor(1,1,1,1)
      if player.res > 0 then drawMessageBox("Press <"..KEY_SCAN.."> to claim this territory",180-16) end
    end
  end
end

function updateSurface(dt)

end

function updatePlanet(dt)

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
